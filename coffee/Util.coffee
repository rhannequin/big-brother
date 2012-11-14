define [
  'Facebook',
  'handlebars',
  'underscore',
  'jquery',
  'fb-sdk',
  'bootstrap'
], (Facebook, Handelbars, _) ->

  class Util

    medals =
      average:
        gold: 10
        silver: 8
        bronze: 2
      nbLikes:
        gold: 50
        silver: 35
        bronze: 20
      famousPictures:
        gold: 50
        silver: 35
        bronze: 20

    getTwoBestLikeCategories: (likes) ->
      likesCategories = {}
      likes = likes.data

      for like in likes
        category = like.category
        @increment likesCategories, category
      @getTwoBest likesCategories


    getStatusesStats: (statuses) ->

      # TwoBestStatuses
      statusesObj = {}
      # TwoBestLikers
      likers = {}
      # Average
      nbLikes = 0
      nbStatuses = 0

      for status in statuses

        # Average
        nbStatuses++

        likes = status.likes
        if likes?

          # Common
          likesLength = likes.data.length

          # TwoBestStatuses
          statusesObj[status.message] = likesLength

          # Average
          nbLikes += likesLength

          # TwoBestLikers
          for liker in likes.data
            @increment likers, liker.name

      result =
        twoBestStatuses: @getTwoBest(statusesObj)
        average:         parseFloat(nbLikes / nbStatuses).toPrecision(3)
        twoBestLikers: @getTwoBest(likers)


    getPhotosStats: (albums, photos, userId) ->

      # Common
      photos = photos.data
      albums = albums.data

      for album in albums
        if album.photos?
          tmpPhotos = album.photos.data
          photos = photos.concat tmpPhotos if tmpPhotos?

      # Taggers
      taggers = {}

      # TwoMostFamousPics
      photosObj = {}

      for photo in photos
        if photo?
          likes = photo.likes

          # TwoMostFamousPics
          photosObj[photo.picture] = likes.data.length if likes? and likes.data?

          # Taggers
          from = photo.from
          id = parseInt(from.id)
          continue if id is userId
          name = from.name
          @increment taggers, name

      result =
        twoBestTaggers:    @getTwoBest taggers
        twoMostFamousPics: @getTwoBest photosObj

    getHourPost: (posts) ->
      myTimes = {}
      posts = posts.data
      for post in posts
        time = post.created_time
        splitter = time.split('T')
        splitter = splitter[1].split(':')
        @increment myTimes, splitter[0]
      @getTwoBest(myTimes)

    getTwoBest: (arr) ->
      first = second = ''
      firstValue = secondValue = 0

      for single of arr
        value = arr[single]
        if value > firstValue
          secondValue = firstValue
          second = first
          firstValue = value
          first = single
        else if value > secondValue
          secondValue = value
          second = single
      result =
        first:
          name: first
          value: firstValue
        second:
          name: second
          value: secondValue
      result

    increment: (arr, key) ->
      arr[key] = if arr[key]? then arr[key] + 1 else 1
      arr

    hasMedal: (name, value) ->
      reward = null
      if medals[name]?
        reward = @addMedal(name, 'bronze') if value >= medals[name].bronze
        reward = @addMedal(name, 'silver') if value >= medals[name].silver
        reward = @addMedal(name, 'gold') if value >= medals[name].gold
      reward



    addMedal: (name,type) ->
      #Add animation for adding a medal
      0

    getAllStatuses: (deferred, offset = 0, result = []) ->
      self = @
      Facebook.api('me/statuses', 'get',
        offset: offset
        limit: 1000
      )
      .done((res) ->
        statuses = res.data
        if statuses? and statuses.length isnt 0
          result = result.concat statuses
          if statuses.length is 100
            offset += 100
            self.getAllStatuses(deferred, offset, result)
          else
            deferred.resolve result
        else
          deferred.resolve result

      )


  new Util
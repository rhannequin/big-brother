define [
  'Facebook',
  'handlebars',
  'underscore',
  'jquery',
  'fb-sdk',
  'bootstrap'
], (Facebook, Handelbars, _) ->

  class Util

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

      # Average
      nbLikes = 0
      nbStatuses = 0

      # TwoGreatestLikers
      likers = {}

      # Date of first status
      currentDate = new Date()
      firstStatusDate = new Date(_.last(statuses).updated_time)

      nbDays = (currentDate-firstStatusDate)/(1000*60*60*24)

      for status in statuses

        # Average
        nbStatuses++

        likes = status.likes
        if likes?

          # Common
          likes = likes.data
          likesLength = likes.length

          # TwoBestStatuses
          statusesObj[status.message] = likesLength

          # Average
          nbLikes += likesLength

          # TwoGreatestLikers
          @increment(likers, like.name) for like in likes

      result =
        twoBestStatuses:   @getTwoBest(statusesObj)
        average:           parseFloat(nbLikes / nbStatuses).toPrecision(3)
        statusesPerDay:    parseFloat(nbStatuses/nbDays).toPrecision(2)
        TwoGreatestLikers: @getTwoBest(likers)


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

      # nbPics
      nbPics = photos.length

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
        numberOfPics:      nbPics

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
define [
  'Facebook', 'handlebars', 'underscore', 'jquery', 'scrollTo', 'fb-sdk', 'bootstrap'
], (Facebook, Handelbars, _) ->

  class Util

    #medals =
      #average:        gold: 10, silver: 8,  bronze: 2
      #nbLikes:        gold: 50, silver: 35, bronze: 20
      #famousPictures: gold: 50, silver: 35, bronze: 20

    addScore: (value, that) =>
      if value == 3
        color = 'gold'
        text = 'Wow !'
      else if value == 2
        color = 'silver'
        text = 'Nice.'
      else if value == 1
        color = 'bronze'
        text = 'Good.'
      $(that).find('.medal').addClass(color).html(text + '<br>+' + value).fadeIn 'fast'

    getScoreResult: (score) =>
      console.log(score)

      activityScore = score.activity
      averageActivityScore = 0
      averageActivityScore = @getAverageScore(averageActivityScore,activityScore)

      popularityScore = score.popularity
      averagePopularityScore = 0
      averagePopularityScore = @getAverageScore(averagePopularityScore,popularityScore)

      contentScore = score.content
      averageContentScore = 0
      averageContentScore = @getAverageScore(averageContentScore,contentScore)

      utilityScore = score.utility
      averageUtilityScore = 0
      averageUtilityScore = @getAverageScore(averageUtilityScore,utilityScore)

      console.log averageActivityScore
      console.log averagePopularityScore
      console.log averageContentScore
      console.log averageUtilityScore

      @fadeIn $('#summary')
      $('#summary').append activityScore

    getAverageScore: (averageScore, categoryScore) =>
      averageScore +=  point for point in categoryScore
      averageScore = averageScore/categoryScore.length
      averageScore

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
      nbComments = 0

      # TwoGreatestLikers
      likers = {}

      # Date of first status
      currentDate = new Date()
      firstStatusDate = new Date(_.last(statuses).updated_time)

      nbDays = (currentDate-firstStatusDate)/(1000*60*60*24)

      for status in statuses

        # Average likes
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

        # Average comments
        comments = status.comments
        if comments?
          comments = comments.data
          commentsLength = comments.length
          nbComments += commentsLength


      result =
        twoBestStatuses:   @getTwoBest(statusesObj)
        averageLikes:      parseFloat(nbLikes / nbStatuses).toPrecision(3)
        averageComments:   parseFloat(nbComments / nbStatuses).toPrecision(3)
        statusesPerDay:    parseFloat(nbStatuses / nbDays).toPrecision(2)
        totalOfStatuses:   nbStatuses
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
          photosObj[photo.source] = likes.data.length if likes? and likes.data?

          # Taggers
          from = photo.from
          id = ~~from.id
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
        first:  name: first,  value: firstValue
        second: name: second, value: secondValue
      result

    increment: (arr, key) ->
      arr[key] = if arr[key]? then arr[key] + 1 else 1
      arr

    #hasMedal: (name, value) ->
      #reward = null
      #medal = medals[name]
      #if medal?
        #reward = @addMedal(name, 'bronze') if value >= medal.bronze
        #reward = @addMedal(name, 'silver') if value >= medal.silver
        #reward = @addMedal(name, 'gold')   if value >= medal.gold
      #reward


    #ddMedal: (name,type) ->
      #Add animation for adding a medal
      #0

    getAllStatuses: (deferred, offset = 0, result = []) ->
      self = @
      Facebook.api('me/statuses', 'get', offset: offset, limit: 1000).done((res) ->
        statuses = res.data
        if statuses? and statuses.length isnt 0
          result = result.concat statuses
          if statuses.length is 100
            offset += 100
            self.getAllStatuses(deferred, offset, result)
          else deferred.resolve result
        else deferred.resolve result
      )

    getFavoritePlaces: (places) ->
      console.log places
      placesNames = {}
      places = places.data

      for place in places
        name = place.place.name
        @increment placesNames, name
      @getTwoBest placesNames

    renderTemplate: (id, target, data) ->
      template = $('#' + id).text()
      compiled = _.template template
      target.html compiled(data)

    setThisDone: (that) =>
      $(that).parents().eq(3).addClass 'done'

    scrollTo: (that) =>
      target = $(that).parents().eq(3)
      $.scrollTo( target, 1000 );

    getResultDiv: (that) =>
      $(that).find '.result'

    #setThisDoneOut = (that) =>
      #$(that).parents().eq(3).addClass 'done-out'

    displayErrorMsg: (div) =>
      div.html 'Can\'t resolve this request. Please try again.'

    displayAjaxLoader: (div) =>
      div.html 'Chargement...'

    displayProgressBar: (div, progress = 33) =>
      div.html '
        <div class="progress progress-striped active">
          <div class="bar" style="width: ' + progress + '%;"></div>
        </div>'

    fadeIn: (selector, duration = 1000) ->
      selector.fadeIn 1000


  new Util
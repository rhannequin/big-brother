define ['Util', 'Facebook', 'fancybox', 'scrollTo'], (Util, Facebook) ->

  class AfterPhotos

    do: (photos, albums, userId, score, $result) ->

      self = @
      self.photosStats = Util.getPhotosStats albums, photos, userId
      Util.renderTemplate('tpl-step-7', $result, photos: self.photosStats.twoBestTaggers)
      Util.setThisDone $result
      Util.scrollTo $result
      Util.fadeIn $('.need-photos')

      # How many photos do you have ?
      $('.step-8').click ->
        step = @
        if self.photosStats.numberOfPics>300
          point = 3
        else if self.photosStats.numberOfPics>200
          point = 2
        else if self.photosStats.numberOfPics>100
          point = 1
        else
          point = 0
        if point!=0
          Util.addScore point, step
          score.content.push point
        $result = Util.getResultDiv @
        Util.displayProgressBar $result
        $result.html 'You have ' + self.photosStats.numberOfPics + ' pictures'
        Util.setThisDone $result
        Util.scrollTo $result

      # Your 2 best photos
      $('.step-9').click ->
        step = @
        if self.photosStats.twoMostFamousPics.first.value>30
          point = 3
        else if self.photosStats.twoMostFamousPics.first.value>20
          point = 2
        else if self.photosStats.twoMostFamousPics.first.value>10
          point = 1
        else
          point = 0
        if point!=0
          Util.addScore point, step
          score.popularity.push point
        $result = Util.getResultDiv this
        Util.displayAjaxLoader $result
        Util.renderTemplate('tpl-step-9', $result, photos: self.photosStats.twoMostFamousPics)
        $(".fancybox").live "click", ->
          $(this).fancybox().trigger "click"
          false
        require ['after-places'], (afterPlaces) ->
          afterPlaces.do userId, score, $result

  new AfterPhotos
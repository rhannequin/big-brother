define ['Util', 'Facebook', 'fancybox', 'scrollTo'], (Util, Facebook) ->

  class AfterPhotos

    do: (photos, albums, userId, score, $result) ->

      console.log score

      self = @
      self.photosStats = Util.getPhotosStats albums, photos, userId
      Util.renderTemplate('tpl-step-7', $result, photos: self.photosStats.twoBestTaggers)
      Util.setThisDone $result
      Util.scrollTo $result
      Util.fadeIn $('.need-photos')

      # How many photos do you have ?
      $('.step-8').click ->
        $result = Util.getResultDiv @
        Util.displayProgressBar $result
        $result.html 'You have ' + self.photosStats.numberOfPics + ' pictures'
        Util.setThisDone $result
        Util.scrollTo $result

      # Your 2 best photos
      $('.step-9').click ->
        $result = Util.getResultDiv this
        Util.displayAjaxLoader $result
        Util.renderTemplate('tpl-step-9', $result, photos: self.photosStats.twoMostFamousPics)
        $(".fancybox").live "click", ->
          $(this).fancybox().trigger "click"
          false
        require ['after-places'], (afterPlaces) ->
          afterPlaces.do userId, $result

  new AfterPhotos
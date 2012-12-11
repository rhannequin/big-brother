define ['Util', 'Facebook'], (Util, Facebook) ->

  class AfterPhotos

    do: (photos, albums, userId, $result) ->

      self = @
      self.photosStats = Util.getPhotosStats albums, photos, userId
      Util.renderTemplate('tpl-step-7', $result, photos: self.photosStats.twoBestTaggers)
      Util.setThisDone $result
      Util.fadeIn $('.need-photos')

      # How many photos do you have ?
      $('.step-8').click ->
        $result = Util.getResultDiv @
        Util.displayProgressBar $result
        $result.html 'You have ' + self.photosStats.numberOfPics + ' pictures'
        Util.setThisDone $result

      # Your 2 best photos
      $('.step-9').click ->
        $result = Util.getResultDiv this
        Util.displayAjaxLoader $result
        Util.renderTemplate('tpl-step-9', $result, photos: self.photosStats.twoMostFamousPics)
        Util.setThisDone $result

  new AfterPhotos
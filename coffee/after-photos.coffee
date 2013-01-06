define ['Util', 'Facebook', 'fancybox', 'scrollTo'], (Util, Facebook) ->

  class AfterPhotos

    do: (photos, albums, userId, $result) ->

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
        Util.setThisDone $result
        Util.renderTemplate('tpl-step-9', $result, photos: self.photosStats.twoMostFamousPics)
        $(".fancybox").live "click", ->
          $(this).fancybox().trigger "click"
          false
        Util.scrollTo $result
        Util.fadeIn $('.need-best-photos')

      # Do you like to go out ?
      $('.step-10').click ->
        $result = Util.getResultDiv @
        Util.displayAjaxLoader $result
        Util.setThisDone $result

        events = Facebook.api 'me/events', 'get', limit: 1000, type: 'attending'
        checkins  = Facebook.api 'me/checkins',  'get', limit: 1000

        $.when(events, checkins).done((events, checkins) ->
          Util.renderTemplate('tpl-step-10', $result, events: events.data.length, checkins: checkins.data.length)
          Util.scrollTo $result
          Util.fadeIn $('.need-places')
        ).fail -> Util.displayErrorMsg $result

      # What are your favourite spots ?
      $('.step-11').click ->
        console.log 'wait for it'

  new AfterPhotos
define ['Util', 'Facebook', 'fancybox', 'scrollTo'], (Util, Facebook) ->

  class AfterPlaces

    do: (userId, $result) ->

      Util.fadeIn $('.need-best-photos')
      Util.setThisDone $result
      Util.scrollTo $result

      # Do you like to go out ?
      $('.step-10').click ->
        $result = Util.getResultDiv @
        Util.displayAjaxLoader $result
        Util.setThisDone $result

        events = Facebook.api 'me/events', 'get', limit: 1000, type: 'attending', until: 1356980400

        $.when(events).done((events) ->
          Util.renderTemplate('tpl-step-10', $result, events: events.data.length)
          Util.scrollTo $result
          Util.fadeIn $('.need-places')
        ).fail -> Util.displayErrorMsg $result

      # What are your favourite spots ?
      $('.step-11').click ->
        $result = Util.getResultDiv @
        Util.displayAjaxLoader $result
        Util.setThisDone $result

        checkins  = Facebook.api 'me/checkins',  'get', limit: 1000

        $.when(checkins).done((checkins) ->
          twoFavoritePlaces = Util.getFavoritePlaces(checkins)
          Util.renderTemplate('tpl-step-11', $result, places: twoFavoritePlaces, checkins: checkins.data.length)
          Util.scrollTo $result
          Util.fadeIn $('#summary')
        ).fail -> Util.displayErrorMsg $result

  new AfterPlaces
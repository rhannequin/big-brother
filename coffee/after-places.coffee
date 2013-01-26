define ['Util', 'Facebook', 'fancybox', 'scrollTo'], (Util, Facebook) ->

  class AfterPlaces

    do: (places, userId, $result) ->

      Util.fadeIn $('.need-best-photos')
      Util.setThisDone $result
      Util.scrollTo $result

      # Do you like to go out ?
      $('.step-10').click ->
        $result = Util.getResultDiv @
        Util.displayAjaxLoader $result
        Util.setThisDone $result

        events = Facebook.api 'me/events', 'get', limit: 1000, type: 'attending', until: 1356980400
        checkins  = Facebook.api 'me/checkins',  'get', limit: 1000

        $.when(events, checkins).done((events, checkins) ->
          Util.renderTemplate('tpl-step-10', $result, events: events.data.length, checkins: checkins.data.length)
          Util.scrollTo $result
          Util.fadeIn $('.need-places')
        ).fail -> Util.displayErrorMsg $result

      # What are your favourite spots ?
      $('.step-11').click ->
        console.log 'wait for it'

  new AfterPlaces
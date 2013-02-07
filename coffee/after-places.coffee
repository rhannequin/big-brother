define ['Util', 'Facebook', 'fancybox', 'scrollTo'], (Util, Facebook) ->

  class AfterPlaces

    do: (userId, score, $result) ->

      Util.fadeIn $('.need-best-photos')
      Util.setThisDone $result
      Util.scrollTo $result

      # Do you like to go out ?
      $('.step-10').click ->
        step = @
        $result = Util.getResultDiv @
        Util.displayAjaxLoader $result
        Util.setThisDone $result

        events = Facebook.api 'me/events', 'get', limit: 1000, type: 'attending', until: 1359763200

        $.when(events).done((events) ->
          totalEvents = events.data.length
          if totalEvents>40
            point = 3
          else if totalEvents>30
            point = 2
          else if totalEvents>10
            point = 1
          else
            point = 0
          if point!=0
            Util.addScore point, step
          score.utility.push point
          Util.renderTemplate('tpl-step-10', $result, events: totalEvents)
          Util.scrollTo $result
          Util.fadeIn $('.need-places')
        ).fail -> Util.displayErrorMsg $result

      # What are your favourite spots ?
      $('.step-11').click ->
        step = @
        $result = Util.getResultDiv @
        Util.displayAjaxLoader $result
        Util.setThisDone $result

        checkins  = Facebook.api 'me/checkins',  'get', limit: 1000

        $.when(checkins).done((checkins) ->
          totalCheckins = checkins.data.length
          if totalCheckins>30
            point = 3
          else if totalCheckins>15
            point = 2
          else if totalCheckins>5
            point = 1
          else
            point = 0
          if point!=0
            Util.addScore point, step
          score.content.push point
          twoFavoritePlaces = Util.getFavoritePlaces(checkins)
          Util.renderTemplate('tpl-step-11', $result, places: twoFavoritePlaces, checkins: totalCheckins)
          Util.scrollTo $result
          Util.getScoreResult score

          # Share link
          $('#share-score').click (e) ->
            e.preventDefault()
            self = $(@)
            self.html "Publishing"
            params = {}
            params["message"] = "Activity score : " + $("#activity-score .score").html() + "\nPopularity score : " + $("#popularity-score .score").html() + "\nContent score : " + $("#content-score .score").html() + "\nUtility score : " + $("#utility-score .score").html()
            params["name"] = "My Big Brother Score"
            params["description"] = "Rate your profil with this amazing app !"
            params["link"] = "http://big-brother-esgi.herokuapp.com/"
            params["picture"] = "http://big-brother-esgi.herokuapp.com/img/Who-are-you.jpg"
            params["caption"] = "http://big-brother-esgi.herokuapp.com/"

            publication = Facebook.api '/me/feed', 'post', params

            $.when(publication).done((response) ->
              if not response or response.error
                self.html "Error, try again"
              else
                self.html "Published !"
            ).fail -> Util.displayErrorMsg $result

        ).fail -> Util.displayErrorMsg $result

  new AfterPlaces
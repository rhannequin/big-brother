define ['Util', 'Facebook'], (Util, Facebook) ->

  class AfterMe

    do: (user, $result) ->

      #init score
      score =
        activity: [3,2,1,3]
        popularity: [2,3,1]
        content: [3,3,3]
        utility: [2,2,1]

      Util.getScoreResult score

      Util.fadeIn $('.need-me')
      self.userId = ~~user.idy
      Util.renderTemplate('tpl-step-1', $result, username: user.username)
      Util.setThisDone $result
      Util.scrollTo $result

      # Are you social ?
      $('.step-2').click ->
        step = @
        $result = Util.getResultDiv @
        Util.displayAjaxLoader $result
        Util.setThisDone $result
        friends = Facebook.api 'me/friends', 'get', limit: 1000
        groups  = Facebook.api 'me/groups',  'get', limit: 1000

        $.when(friends, groups).done((friends, groups) ->
          totalActiveFriends = friends.data.length
          totalGroups = groups.data.length
          if totalActiveFriends>300
            point = 3
          else if totalActiveFriends>200
            point = 2
          else if totalActiveFriends>100
            point = 1
          else
            point = 0
          if point!=0
            Util.addScore point, step
          score.popularity.push point
          Util.renderTemplate('tpl-step-2', $result, friends: totalActiveFriends, groups: totalGroups)
          Util.scrollTo $result
          Util.fadeIn $('.need-are-you-social')
        ).fail -> Util.displayErrorMsg $result

      # What are your passions ?
      $('.step-3').click ->
        $result = Util.getResultDiv @
        Util.displayAjaxLoader $result
        Util.setThisDone $result
        Facebook.api('me/likes', 'get', limit: 1000).done((res) ->
          twoBestLikeCategories = Util.getTwoBestLikeCategories(res)
          Util.renderTemplate('tpl-step-3', $result, likes: twoBestLikeCategories)
          Util.scrollTo $result
        ).fail -> Util.displayErrorMsg $result

      # Are you active ?
      $('.step-4').click ->
        step = @
        $result = Util.getResultDiv @
        Util.displayAjaxLoader $result
        Util.setThisDone $result
        deferred = $.Deferred()
        deferred.done (statuses) ->
          require ['after-statuses'], (afterStatuses) -> afterStatuses.do(statuses, step, score, $result)
          Util.scrollTo $result
        Util.getAllStatuses(deferred)

      # Your 2 best taggers ?
      $('.step-7').click ->
        $result = Util.getResultDiv @
        Util.displayAjaxLoader $result
        Util.setThisDone $result
        albums = Facebook.api 'me/albums', 'get', limit: 1000, fields: 'photos'
        photos = Facebook.api 'me/photos', 'get', limit: 1000
        $.when(albums, photos).done((albums, photos) ->
          Util.scrollTo $result
          require ['after-photos'], (afterPhotos) ->
            afterPhotos.do photos, albums, self.userId, score, $result
        ).fail -> Util.displayErrorMsg $result

  new AfterMe
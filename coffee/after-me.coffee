define ['Util', 'Facebook'], (Util, Facebook) ->

  class AfterMe

    do: (user, $result) ->

      Util.fadeIn $('.need-me')
      self.userId = ~~user.idy
      Util.renderTemplate('tpl-step-1', $result, username: user.username)
      Util.setThisDone $result

      # Are you social ?
      $('.step-2').click ->
        $result = Util.getResultDiv @
        Util.displayAjaxLoader $result
        friends = Facebook.api 'me/friends', 'get', limit: 1000
        groups  = Facebook.api 'me/groups',  'get', limit: 1000

        $.when(friends, groups).done((friends, groups) ->
          Util.renderTemplate('tpl-step-2', $result, friends: friends.data.length, groups: groups.data.length)
          Util.setThisDone $result
          Util.fadeIn $('.need-are-you-social')
        ).fail -> Util.displayErrorMsg $result

      # What are your passions ?
      $('.step-3').click ->
        $result = Util.getResultDiv @
        Util.displayAjaxLoader $result
        Facebook.api('me/likes', 'get', limit: 1000).done((res) ->
          Util.setThisDone $result
          twoBestLikeCategories = Util.getTwoBestLikeCategories(res)
          Util.renderTemplate('tpl-step-3', $result, likes: twoBestLikeCategories)
          Util.setThisDone $result
        ).fail -> Util.displayErrorMsg $result

      # Are you active ?
      $('.step-4').click ->
        $result = Util.getResultDiv @
        Util.displayAjaxLoader $result
        deferred = $.Deferred()
        deferred.done (statuses) ->
          require ['after-statuses'], (afterStatuses) -> afterStatuses.do(statuses, $result)
        Util.getAllStatuses(deferred)

      # Your 2 best taggers ?
      $('.step-7').click ->
        $result = Util.getResultDiv @
        Util.displayAjaxLoader $result
        albums = Facebook.api 'me/albums', 'get', limit: 1000, fields: 'photos'
        photos = Facebook.api 'me/photos', 'get', limit: 1000
        $.when(albums, photos).done((albums, photos) ->
          require ['after-photos'], (afterPhotos) ->
            afterPhotos.do photos, albums, self.userId, $result
        ).fail -> Util.displayErrorMsg $result

  new AfterMe
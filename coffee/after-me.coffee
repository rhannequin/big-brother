define ['Util', 'Facebook'], (Util, Facebook) ->

  class AfterMe

    do: (user, $result) ->

      Util.fadeIn $('.need-me')
      self.userId = parseInt user.id
      $result.html '<img src="http://graph.facebook.com/' + user.username + '/picture" id="user-picture" alt="" height="50" /><br/>' + user.name + ''
      Util.setThisDone $result

      # Are you social ?
      $('.step-2').click ->
        $result = Util.getResultDiv @
        Util.displayAjaxLoader $result
        friends = Facebook.api 'me/friends', 'get', limit: 1000
        groups  = Facebook.api 'me/groups',  'get', limit: 1000

        $.when(friends, groups).done((friends, groups) ->
          $result.html '
            You have ' + friends.data.length + ' active friends<br />
            You have ' + groups.data.length + ' groups'
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
          $result.html '
            You like :<br>
              ' + twoBestLikeCategories.first.name + '<br>
              &amp; ' + twoBestLikeCategories.second.name + ''
          Util.setThisDone $result
        ).fail -> Util.displayErrorMsg $result

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
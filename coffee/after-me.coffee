define ['Util', 'Facebook'], (Util, Facebook) ->

  class AfterMe

    do: (user, $result) ->

      # Are you social ?
      $('.step-2').click ->
        $result = Util.getResultDiv @
        Util.displayAjaxLoader $result

        Facebook.api('me/friends', 'get', limit: 1000)
          .fail(->
            Util.displayErrorMsg $result
          )
          .done (res) ->
            $result.html 'You have ' + res.data.length + ' active friends'
            Util.setThisDone $result
            $('.need-are-you-social').fadeIn 1000

      # What are your passions ?
      $('.step-3').click ->
        $result = Util.getResultDiv @
        Util.displayAjaxLoader $result

        Facebook.api('me/likes', 'get',
            limit: 1000
          )
          .fail(->
            Util.displayErrorMsg $result
          )
          .done((res) ->
            Util.setThisDone $result
            twoBestLikeCategories = Util.getTwoBestLikeCategories(res)
            $result.html '
              You like :<br>
                ' + twoBestLikeCategories.first.name + '<br>
                &amp; ' + twoBestLikeCategories.second.name + ''
            Util.setThisDone $result
          )

      $('.need-me').fadeIn 1000
      self.userId = parseInt user.id
      $result.html '<img src="http://graph.facebook.com/' + user.username + '/picture" id="user-picture" alt="" height="50" /><br/>' + user.name + ''
      Util.setThisDone $result
      #$('.req-me').mouseleave ->
        #setThisDoneOut $result
        #stepMouseLeave = true
      #setThisDone $result if typeof stepMouseLeave is 'undefined'


      ###$('.req-pic').click ->
        $result = Util.getResultDiv @
        Util.displayProgressBar $result

        # Get all albums with pictures
        Facebook.api('me/albums', 'get',
            limit: 1000
            fields: 'photos'
          )
          .done((albums) ->
            Util.displayProgressBar $result, 66
            # Get all tagged-in pictures
            Facebook.api('me/photos', 'get',
              limit: 1000
            )
            .done((photos) ->
              self.photosStats = Util.getPhotosStats albums, photos, self.userId
              $('.need-pics').show()
              $result.html '
                <ul>
                  <li>' + self.photosStats.twoBestTaggers.first.name + '</li>
                  <li>' + self.photosStats.twoBestTaggers.second.name + '</li>
                </ul>'
            )
            .fail(->
              Util.displayErrorMsg $result
            )
          )
          .fail(->
            Util.displayErrorMsg $result
          )

      $('.req-nb-pics').click ->
        $result = Util.getResultDiv @
        Util.displayProgressBar $result
        $result.html '
          <p>You have ' + self.photosStats.numberOfPics + ' pictures</p>
        '

      $('.req-most-famous-pics').click ->
        $result = Util.getResultDiv @
        Util.displayAjaxLoader $result
        $result.html '
          <div class="span2">
            <p><img src="' + self.photosStats.twoMostFamousPics.first.name + '" alt="First most famous picture" /><br />' + self.photosStats.twoMostFamousPics.first.value + ' likes</p>
          </div>
          <div class="span2">
            <p><img src="' + self.photosStats.twoMostFamousPics.second.name + '" alt="Second most famous picture" /><br />' + self.photosStats.twoMostFamousPics.second.value + ' likes</p>
          </div>
        '###

  new AfterMe
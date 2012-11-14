require [
  'Facebook',
  'handlebars',
  'underscore',
  'Util',
  'jquery',
  'fb-sdk',
  'bootstrap'
], (Facebook, Handelbars, _, Util) ->

  self = @

  $('.req-me').click ->

    $result = getResultDiv @
    displayAjaxLoader $result

    Facebook.login()
    .fail(->
      displayErrorMsg $result
    )
    .done((user) ->
      $('.need-me').show()
      self.userId = parseInt user.id
      $result.html '<p><img src="http://graph.facebook.com/' + user.username + '/picture" atl="" height="40" /> ' + user.name + '</p>'


      $('.req-pic').click ->
        $result = getResultDiv @
        displayProgressBar $result

        # Get all albums with pictures
        Facebook.api('me/albums', 'get',
            limit: 1000
            fields: 'photos'
          )
          .done((albums) ->
            displayProgressBar $result, 66
            # Get all tagged-in pictures
            Facebook.api('me/photos', 'get',
              limit: 1000
            )
            .done((photos) ->
              self.photosStats = Util.getPhotosStats albums, photos, self.userId
              console.log(self.photosStats)
              $('.need-pics').show()
              $result.html '
                <ul>
                  <li>' + self.photosStats.twoBestTaggers.first.name + '</li>
                  <li>' + self.photosStats.twoBestTaggers.second.name + '</li>
                </ul>'
            )
            .fail(->
              displayErrorMsg $result
            )
          )
          .fail(->
            displayErrorMsg $result
          )

      $('.req-nb-pics').click ->
        $result = getResultDiv @
        displayProgressBar $result
        $result.html '
          <p>You have ' + self.photosStats.numberOfPics + ' pictures</p>
        '

      $('.req-most-famous-pics').click ->
        $result = getResultDiv @
        displayAjaxLoader $result
        $result.html '
          <div class="span2">
            <p><img src="' + self.photosStats.twoMostFamousPics.first.name + '" alt="First most famous picture" /><br />' + self.photosStats.twoMostFamousPics.first.value + ' likes</p>
          </div>
          <div class="span2">
            <p><img src="' + self.photosStats.twoMostFamousPics.second.name + '" alt="Second most famous picture" /><br />' + self.photosStats.twoMostFamousPics.second.value + ' likes</p>
          </div>
        '

    )


  $('.req-like').click ->

    $result = getResultDiv @
    displayAjaxLoader $result

    Facebook.api('me/likes', 'get',
        limit: 100
      )
      .fail(->
        displayErrorMsg $result
      )
      .done((res) ->
        twoBestLikeCategories = Util.getTwoBestLikeCategories(res)
        $result.html '
          <ul>
            <li>' + twoBestLikeCategories.first.name + '</li>
            <li>' + twoBestLikeCategories.second.name + '</li>
          </ul>'
      )
  $('.req-hour-post').click ->

    $result = getResultDiv @
    displayAjaxLoader $result

    Facebook.api('me/posts?fields=created_time', 'get',
        limit: 100
      )
      .fail(->
        displayErrorMsg $result
      )
      .done((res) ->
        hourPost = Util.getHourPost(res)
        console.log hourPost
        hourPostEnd = parseInt(hourPost.first.name)+1;
        $result.html '
          <ul>
            <li>Between ' + hourPost.first.name + 'h and ' + hourPostEnd + 'h</li>
          </ul>'
      )


  $('.req-best-status').click ->

    $result = getResultDiv @
    displayAjaxLoader $result

    deferred = $.Deferred()
    deferred.done (statuses) ->

      self.statusesStats = Util.getStatusesStats statuses
      $result.html '
        <ul>
          <li>"' + self.statusesStats.twoBestStatuses.first.name + '" (' + self.statusesStats.twoBestStatuses.first.value + ' likes)</li>
          <li>"' + self.statusesStats.twoBestStatuses.second.name + '" (' + self.statusesStats.twoBestStatuses.second.value + ' likes)</li>
        </ul>'
      $('.need-statuses').show()

      $('.req-average-like-status').click ->
        $result = getResultDiv @
        displayAjaxLoader $result
        $result.html '<ul><li>Average : ' + self.statusesStats.average + ' likes per status</li></ul>'

      $('.req-greatest-likers-status').click ->
        $result = getResultDiv @
        displayAjaxLoader $result
        $result.html '
          <ul>
            <li>"' + self.statusesStats.TwoGreatestLikers.first.name + '" (' + self.statusesStats.TwoGreatestLikers.first.value + ' likes)</li>
            <li>"' + self.statusesStats.TwoGreatestLikers.second.name + '" (' + self.statusesStats.TwoGreatestLikers.second.value + ' likes)</li>
          </ul>'

    Util.getAllStatuses(deferred)



  getResultDiv = (that) =>
    $(that).parent().find '.result'

  displayErrorMsg = (div) =>
    div.html 'Can\'t resolve this request. Please try again.'

  displayAjaxLoader = (div) =>
    div.html '<img src="img/ajax-loader.gif" alt="Loading..." />'

  displayProgressBar = (div, progress = 33) =>
    div.html '
      <div class="progress progress-striped active">
        <div class="bar" style="width: ' + progress + '%;"></div>
      </div>
    '

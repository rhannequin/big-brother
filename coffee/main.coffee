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
      self.userId = user.id
      $result.html '<p><img src="http://graph.facebook.com/' + user.username + '/picture" atl="" height="40" /> ' + user.name + '</p>'
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
        $result.html '<ul><li>' + twoBestLikeCategories.first.name + '</li><Li>' + twoBestLikeCategories.second.name + '</li></ul>'
      )


  $('.req-best-status').click ->

    $result = getResultDiv @
    displayAjaxLoader $result

    Facebook.api('me/statuses', 'get',
      limit: 1000
      )
      .done((res) ->
        twoBestStatuses = Util.getTwoBestStatuses res
        $result.html '<ul><li>"' + twoBestStatuses.first.name + '" (' + twoBestStatuses.first.value + ' likes)</li><li>"' + twoBestStatuses.second.name + '" (' + twoBestStatuses.second.value + ' likes)</li></ul>'
      )


  $('.req-pic').click ->

    $result = getResultDiv @
    displayAjaxLoader $result

    Facebook.api('me/photos', 'get',
        limit: 1000
      )
      .fail(->
        displayErrorMsg $result
      )
      .done((res) ->
        twoBestTaggers = Util.getTwoBestTaggers res, self.userId
        $result.html '<ul><li>' + twoBestTaggers.first.name + '</li><Li>' + twoBestTaggers.second.name + '</li></ul>'
      )


  getResultDiv = (that) =>
    $(that).parent().find '.result'

  displayErrorMsg = (div) =>
    div.html 'Can\'t resolve this request. Please try again.'

  displayAjaxLoader = (div) =>
    div.html '<img src="img/ajax-loader.gif" alt="Loading..." />'
require [
  'Facebook',
  'handlebars',
  'underscore',
  'Util',
  'jquery',
  'fancybox',
  'scrollTo',
  'fb-sdk',
  'bootstrap'
], (Facebook, Handelbars, _, Util) ->

  self = @

  # Who are you ?
  $('.step-1').click ->

    $result = Util.getResultDiv @
    Util.displayAjaxLoader $result

    Facebook.login().done((user) ->
      require ['after-me'], (afterMe) -> afterMe.do user, $result
    ).fail -> Util.displayErrorMsg $result

  ###$('.req-hour-post').click ->

    $result = Util.getResultDiv @
    Util.displayAjaxLoader $result

    Facebook.api('me/posts?fields=created_time', 'get',
        limit: 100
      )
      .fail(->
        Util.displayErrorMsg $result
      )
      .done((res) ->
        hourPost = Util.getHourPost(res)
        hourPostEnd = parseInt(hourPost.first.name)+1;
        hour = 'am'
        hourEnd = 'am'
        if hourPost > 12
         hourPost-= 12
         hour = 'pm'
        if hourPostEnd > 12
         hourPostEnd-= 12
         hourEnd = 'pm'

        $result.html '
          <ul>
            <li>Between ' + hourPost.first.name + ' ' + hour + ' and ' + hourPostEnd + ' ' + hourEnd + '</li>
          </ul>'
      )

  $('.req-best-status').click ->

    $result = Util.getResultDiv @
    Util.displayAjaxLoader $result

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
        $result = Util.getResultDiv @
        Util.displayAjaxLoader $result
        Util.hasMedal('average',self.statusesStats.average)
        $result.html '<ul><li>Average : ' + self.statusesStats.average + ' likes per status</li></ul>'

	    $('.req-greatest-likers-status').click ->
        $result = Util.getResultDiv @
        Util.displayAjaxLoader $result
        $result.html '
          <ul>
            <li>"' + self.statusesStats.TwoGreatestLikers.first.name + '" (' + self.statusesStats.TwoGreatestLikers.first.value + ' likes)</li>
            <li>"' + self.statusesStats.TwoGreatestLikers.second.name + '" (' + self.statusesStats.TwoGreatestLikers.second.value + ' likes)</li>
          </ul>'

      # Are you active ?
      $('.......').click ->
        $result = Util.getResultDiv @
        Util.displayAjaxLoader $result
        $result.html 'You post ' + self.statusesStats.statusesPerDay + ' statuses a day'


    #Util.getAllStatuses(deferred)###

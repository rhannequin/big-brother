define ['Util', 'Facebook'], (Util, Facebook) ->

  class AfterStatuses

    do: (statuses, $result) ->

      self = @
      self.statusesStats = Util.getStatusesStats statuses
      $result.html 'You post ' + self.statusesStats.statusesPerDay + ' statuses a day'
      Util.setThisDone $result
      Util.fadeIn $('.need-are-you-active')

      # Are you popular
      $('.step-5').click ->
        $result = Util.getResultDiv @
        $result.html 'You have an average of ' + self.statusesStats.averageLikes + ' likes per status'
        $result.append '<br/>You have an average of ' + self.statusesStats.averageComments + ' comments per status'
        Util.setThisDone $result

      # Best Statuses
      $('.step-6').click ->
        $result = Util.getResultDiv @
        $result.html '
            <ul>
              <li>"' + self.statusesStats.twoBestStatuses.first.name + '" (' + self.statusesStats.twoBestStatuses.first.value + ' likes)</li>
              <li>"' + self.statusesStats.twoBestStatuses.second.name + '" (' + self.statusesStats.twoBestStatuses.second.value + ' likes)</li>
            </ul>'
        Util.setThisDone $result
        Util.fadeIn $('.need-best-statuses')

  new AfterStatuses
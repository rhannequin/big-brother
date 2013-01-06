define ['Util', 'Facebook'], (Util, Facebook) ->

  class AfterStatuses

    do: (statuses, $result) ->

      self = @
      self.statusesStats = Util.getStatusesStats statuses
      Util.renderTemplate('tpl-step-4', $result, statuses: self.statusesStats)
      Util.setThisDone $result
      Util.scrollTo $result
      Util.fadeIn $('.need-are-you-active')

      # Are you popular
      $('.step-5').click ->
        $result = Util.getResultDiv @
        Util.renderTemplate('tpl-step-5', $result, statuses: self.statusesStats)
        Util.setThisDone $result
        Util.scrollTo $result

      # Best Statuses
      $('.step-6').click ->
        $result = Util.getResultDiv @
        Util.renderTemplate('tpl-step-6', $result, statuses: self.statusesStats.twoBestStatuses)
        Util.setThisDone $result
        Util.scrollTo $result
        Util.fadeIn $('.need-best-statuses')

  new AfterStatuses
define ['Util', 'Facebook'], (Util, Facebook) ->

  class AfterStatuses

    do: (statuses, step, score, $result) ->

      self = @
      self.statusesStats = Util.getStatusesStats statuses
      if self.statusesStats.totalOfStatuses>300
        point = 3
      else if self.statusesStats.totalOfStatuses>200
        point = 2
      else if self.statusesStats.totalOfStatuses>100
        point = 1
      else
        point = 0
      if point!=0
        Util.addScore point, step
      score.activity.push point
      Util.renderTemplate('tpl-step-4', $result, statuses: self.statusesStats)
      Util.setThisDone $result
      Util.scrollTo $result
      Util.fadeIn $('.need-are-you-active')

      # Are you popular
      $('.step-5').click ->
        step = @
        $result = Util.getResultDiv @
        if self.statusesStats.averageLikes>4 or self.statusesStats.averageComments>4
          point = 3
        else if self.statusesStats.averageLikes>3 or self.statusesStats.averageComments>3
          point = 2
        else if self.statusesStats.averageLikes>2 or self.statusesStats.averageComments>2
          point = 1
        else
          point = 0
        if point!=0
          Util.addScore point, step
        score.popularity.push point
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
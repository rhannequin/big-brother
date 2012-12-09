// Generated by CoffeeScript 1.4.0
(function() {

  define(['Util', 'Facebook'], function(Util, Facebook) {
    var AfterStatuses;
    AfterStatuses = (function() {

      function AfterStatuses() {}

      AfterStatuses.prototype["do"] = function(statuses, $result) {
        var self;
        self = this;
        self.statusesStats = Util.getStatusesStats(statuses);
        $result.html('You post ' + self.statusesStats.statusesPerDay + ' statuses a day');
        Util.setThisDone($result);
        Util.fadeIn($('.need-are-you-active'));
        $('.step-5').click(function() {
          $result = Util.getResultDiv(this);
          Util.renderTemplate('tpl-step-5', $result, {
            statuses: self.statusesStats
          });
          return Util.setThisDone($result);
        });
        return $('.step-6').click(function() {
          $result = Util.getResultDiv(this);
          Util.renderTemplate('tpl-step-6', $result, {
            statuses: self.statusesStats.twoBestStatuses
          });
          Util.setThisDone($result);
          return Util.fadeIn($('.need-best-statuses'));
        });
      };

      return AfterStatuses;

    })();
    return new AfterStatuses;
  });

}).call(this);

// Generated by CoffeeScript 1.4.0
(function() {

  require(['Facebook', 'handlebars', 'underscore', 'Util', 'jquery', 'fb-sdk', 'bootstrap'], function(Facebook, Handelbars, _, Util) {
    var self;
    self = this;
    $("body").off("hover", ".done").on("mouseenter", ".done", function() {
      var question, tooltip;
      question = $(this).find('.front').find("span").html();
      tooltip = $(this).find('.tooltip');
      if (!tooltip.length) {
        $(this).append("<p class=\"tooltip\"></p>");
        $(this).find('.tooltip').html(question);
        return $(this).find('.tooltip').fadeIn(500);
      }
    }).on("mouseleave", ".done", function() {
      var tooltip;
      tooltip = $(this).find('.tooltip');
      if (tooltip.length) {
        return $(this).find('.tooltip').remove();
      }
    });
    return $('.step-1').click(function() {
      var $result;
      $result = Util.getResultDiv(this);
      Util.displayAjaxLoader($result);
      return Facebook.login().done(function(user) {
        return require(['after-me'], function(afterMe) {
          return afterMe["do"](user, $result);
        });
      }).fail(function() {
        return Util.displayErrorMsg($result);
      });
    });
  });

}).call(this);

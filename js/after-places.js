// Generated by CoffeeScript 1.4.0
(function() {

  define(['Util', 'Facebook', 'fancybox', 'scrollTo'], function(Util, Facebook) {
    var AfterPlaces;
    AfterPlaces = (function() {

      function AfterPlaces() {}

      AfterPlaces.prototype["do"] = function(userId, score, $result) {
        Util.fadeIn($('.need-best-photos'));
        Util.setThisDone($result);
        Util.scrollTo($result);
        $('.step-10').click(function() {
          var events, step;
          step = this;
          $result = Util.getResultDiv(this);
          Util.displayAjaxLoader($result);
          Util.setThisDone($result);
          events = Facebook.api('me/events', 'get', {
            limit: 1000,
            type: 'attending',
            until: 1359763200
          });
          return $.when(events).done(function(events) {
            var point, totalEvents;
            totalEvents = events.data.length;
            if (totalEvents > 40) {
              point = 3;
            } else if (totalEvents > 30) {
              point = 2;
            } else if (totalEvents > 10) {
              point = 1;
            } else {
              point = 0;
            }
            if (point !== 0) {
              Util.addScore(point, step);
            }
            score.utility.push(point);
            Util.renderTemplate('tpl-step-10', $result, {
              events: totalEvents
            });
            Util.scrollTo($result);
            return Util.fadeIn($('.need-places'));
          }).fail(function() {
            return Util.displayErrorMsg($result);
          });
        });
        return $('.step-11').click(function() {
          var checkins, step;
          step = this;
          $result = Util.getResultDiv(this);
          Util.displayAjaxLoader($result);
          Util.setThisDone($result);
          checkins = Facebook.api('me/checkins', 'get', {
            limit: 1000
          });
          return $.when(checkins).done(function(checkins) {
            var point, totalCheckins, twoFavoritePlaces;
            totalCheckins = checkins.data.length;
            if (totalCheckins > 30) {
              point = 3;
            } else if (totalCheckins > 15) {
              point = 2;
            } else if (totalCheckins > 5) {
              point = 1;
            } else {
              point = 0;
            }
            if (point !== 0) {
              Util.addScore(point, step);
            }
            score.content.push(point);
            twoFavoritePlaces = Util.getFavoritePlaces(checkins);
            Util.renderTemplate('tpl-step-11', $result, {
              places: twoFavoritePlaces,
              checkins: totalCheckins
            });
            Util.scrollTo($result);
            Util.getScoreResult(score);
            return $('#share-score').click(function(e) {
              var params, publication, self;
              e.preventDefault();
              self = $(this);
              self.html("Publishing");
              params = {};
              params["message"] = "Activity score : " + $("#activity-score .score").html() + "\nPopularity score : " + $("#popularity-score .score").html() + "\nContent score : " + $("#content-score .score").html() + "\nUtility score : " + $("#utility-score .score").html();
              params["name"] = "My Big Brother Score";
              params["description"] = "Rate your profil with this amazing app !";
              params["link"] = "http://big-brother-esgi.herokuapp.com/";
              params["picture"] = "http://big-brother-esgi.herokuapp.com/img/Who-are-you.jpg";
              params["caption"] = "http://big-brother-esgi.herokuapp.com/";
              publication = Facebook.api('/me/feed', 'post', params);
              return $.when(publication).done(function(response) {
                if (!response || response.error) {
                  return self.html("Error, try again");
                } else {
                  return self.html("Published !");
                }
              }).fail(function() {
                return Util.displayErrorMsg($result);
              });
            });
          }).fail(function() {
            return Util.displayErrorMsg($result);
          });
        });
      };

      return AfterPlaces;

    })();
    return new AfterPlaces;
  });

}).call(this);

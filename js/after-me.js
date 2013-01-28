// Generated by CoffeeScript 1.4.0
(function() {

  define(['Util', 'Facebook'], function(Util, Facebook) {
    var AfterMe;
    AfterMe = (function() {

      function AfterMe() {}

      AfterMe.prototype["do"] = function(user, $result) {
        var score;
        score = {
          activity: [],
          popularity: [],
          content: [],
          utility: []
        };
        Util.fadeIn($('.need-me'));
        self.userId = ~~user.idy;
        Util.renderTemplate('tpl-step-1', $result, {
          username: user.username
        });
        Util.setThisDone($result);
        Util.scrollTo($result);
        $('.step-2').click(function() {
          var friends, groups, step;
          step = this;
          $result = Util.getResultDiv(this);
          Util.displayAjaxLoader($result);
          Util.setThisDone($result);
          friends = Facebook.api('me/friends', 'get', {
            limit: 1000
          });
          groups = Facebook.api('me/groups', 'get', {
            limit: 1000
          });
          return $.when(friends, groups).done(function(friends, groups) {
            var point, totalActiveFriends, totalGroups;
            totalActiveFriends = friends.data.length;
            totalGroups = groups.data.length;
            if (totalActiveFriends > 300) {
              point = 3;
            } else if (totalActiveFriends > 200) {
              point = 2;
            } else if (totalActiveFriends > 100) {
              point = 1;
            } else {
              point = 0;
            }
            if (point !== 0) {
              Util.addScore(point, step);
              score.popularity.push(point);
            }
            Util.renderTemplate('tpl-step-2', $result, {
              friends: totalActiveFriends,
              groups: totalGroups
            });
            Util.scrollTo($result);
            return Util.fadeIn($('.need-are-you-social'));
          }).fail(function() {
            return Util.displayErrorMsg($result);
          });
        });
        $('.step-3').click(function() {
          $result = Util.getResultDiv(this);
          Util.displayAjaxLoader($result);
          Util.setThisDone($result);
          return Facebook.api('me/likes', 'get', {
            limit: 1000
          }).done(function(res) {
            var twoBestLikeCategories;
            twoBestLikeCategories = Util.getTwoBestLikeCategories(res);
            Util.renderTemplate('tpl-step-3', $result, {
              likes: twoBestLikeCategories
            });
            return Util.scrollTo($result);
          }).fail(function() {
            return Util.displayErrorMsg($result);
          });
        });
        $('.step-4').click(function() {
          var deferred, step;
          step = this;
          $result = Util.getResultDiv(this);
          Util.displayAjaxLoader($result);
          Util.setThisDone($result);
          deferred = $.Deferred();
          deferred.done(function(statuses) {
            require(['after-statuses'], function(afterStatuses) {
              return afterStatuses["do"](statuses, step, score, $result);
            });
            return Util.scrollTo($result);
          });
          return Util.getAllStatuses(deferred);
        });
        return $('.step-7').click(function() {
          var albums, photos;
          $result = Util.getResultDiv(this);
          Util.displayAjaxLoader($result);
          Util.setThisDone($result);
          albums = Facebook.api('me/albums', 'get', {
            limit: 1000,
            fields: 'photos'
          });
          photos = Facebook.api('me/photos', 'get', {
            limit: 1000
          });
          return $.when(albums, photos).done(function(albums, photos) {
            Util.scrollTo($result);
            return require(['after-photos'], function(afterPhotos) {
              return afterPhotos["do"](photos, albums, self.userId, score, $result);
            });
          }).fail(function() {
            return Util.displayErrorMsg($result);
          });
        });
      };

      return AfterMe;

    })();
    return new AfterMe;
  });

}).call(this);

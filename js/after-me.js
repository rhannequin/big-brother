// Generated by CoffeeScript 1.4.0
(function() {

  define(['Util', 'Facebook'], function(Util, Facebook) {
    var AfterMe;
    AfterMe = (function() {

      function AfterMe() {}

      AfterMe.prototype["do"] = function(user, $result) {
        Util.fadeIn($('.need-me'));
        self.userId = parseInt(user.id);
        $result.html('<img src="http://graph.facebook.com/' + user.username + '/picture" id="user-picture" alt="" height="50" /><br/>' + user.name + '');
        Util.setThisDone($result);
        $('.step-2').click(function() {
          var friends, groups;
          $result = Util.getResultDiv(this);
          Util.displayAjaxLoader($result);
          friends = Facebook.api('me/friends', 'get', {
            limit: 1000
          });
          groups = Facebook.api('me/groups', 'get', {
            limit: 1000
          });
          return $.when(friends, groups).done(function(friends, groups) {
            $result.html('\
            You have ' + friends.data.length + ' active friends<br />\
            You have ' + groups.data.length + ' groups');
            Util.setThisDone($result);
            return Util.fadeIn($('.need-are-you-social'));
          }).fail(function() {
            return Util.displayErrorMsg($result);
          });
        });
        $('.step-3').click(function() {
          $result = Util.getResultDiv(this);
          Util.displayAjaxLoader($result);
          return Facebook.api('me/likes', 'get', {
            limit: 1000
          }).done(function(res) {
            var twoBestLikeCategories;
            Util.setThisDone($result);
            twoBestLikeCategories = Util.getTwoBestLikeCategories(res);
            $result.html('\
            You like :<br>\
              ' + twoBestLikeCategories.first.name + '<br>\
              &amp; ' + twoBestLikeCategories.second.name + '');
            return Util.setThisDone($result);
          }).fail(function() {
            return Util.displayErrorMsg($result);
          });
        });
        $('.step-4').click(function() {
          var deferred;
          $result = Util.getResultDiv(this);
          Util.displayAjaxLoader($result);
          deferred = $.Deferred();
          deferred.done(function(statuses) {
            return require(['after-statuses'], function(afterStatuses) {
              return afterStatuses["do"](statuses, $result);
            });
          });
          return Util.getAllStatuses(deferred);
        });
        return $('.step-7').click(function() {
          var albums, photos;
          $result = Util.getResultDiv(this);
          Util.displayAjaxLoader($result);
          albums = Facebook.api('me/albums', 'get', {
            limit: 1000,
            fields: 'photos'
          });
          photos = Facebook.api('me/photos', 'get', {
            limit: 1000
          });
          return $.when(albums, photos).done(function(albums, photos) {
            return require(['after-photos'], function(afterPhotos) {
              return afterPhotos["do"](photos, albums, self.userId, $result);
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

// Generated by CoffeeScript 1.4.0
(function() {

  require(['Facebook', 'handlebars', 'underscore', 'Util', 'jquery', 'fb-sdk', 'bootstrap'], function(Facebook, Handelbars, _, Util) {
    var displayAjaxLoader, displayErrorMsg, displayProgressBar, getResultDiv, self, setThisDone,
      _this = this;
    self = this;
    $('.req-me').click(function() {
      var $result;
      $result = getResultDiv(this);
      displayAjaxLoader($result);
      return Facebook.login().fail(function() {
        return displayErrorMsg($result);
      }).done(function(user) {
        $('.need-me').fadeIn();
        self.userId = parseInt(user.id);
        $result.html('<img src="http://graph.facebook.com/' + user.username + '/picture" atl="" height="40" /><br/>' + user.name + '');
        setThisDone($result);
        $('.req-pic').click(function() {
          $result = getResultDiv(this);
          displayProgressBar($result);
          return Facebook.api('me/albums', 'get', {
            limit: 1000,
            fields: 'photos'
          }).done(function(albums) {
            displayProgressBar($result, 66);
            return Facebook.api('me/photos', 'get', {
              limit: 1000
            }).done(function(photos) {
              self.photosStats = Util.getPhotosStats(albums, photos, self.userId);
              $('.need-pics').show();
              return $result.html('\
                <ul>\
                  <li>' + self.photosStats.twoBestTaggers.first.name + '</li>\
                  <li>' + self.photosStats.twoBestTaggers.second.name + '</li>\
                </ul>');
            }).fail(function() {
              return displayErrorMsg($result);
            });
          }).fail(function() {
            return displayErrorMsg($result);
          });
        });
        $('.req-nb-pics').click(function() {
          $result = getResultDiv(this);
          displayProgressBar($result);
          return $result.html('\
          <p>You have ' + self.photosStats.numberOfPics + ' pictures</p>\
        ');
        });
        return $('.req-most-famous-pics').click(function() {
          $result = getResultDiv(this);
          displayAjaxLoader($result);
          return $result.html('\
          <div class="span2">\
            <p><img src="' + self.photosStats.twoMostFamousPics.first.name + '" alt="First most famous picture" /><br />' + self.photosStats.twoMostFamousPics.first.value + ' likes</p>\
          </div>\
          <div class="span2">\
            <p><img src="' + self.photosStats.twoMostFamousPics.second.name + '" alt="Second most famous picture" /><br />' + self.photosStats.twoMostFamousPics.second.value + ' likes</p>\
          </div>\
        ');
        });
      });
    });
    $('.req-like').click(function() {
      var $result;
      $result = getResultDiv(this);
      displayAjaxLoader($result);
      return Facebook.api('me/likes', 'get', {
        limit: 100
      }).fail(function() {
        return displayErrorMsg($result);
      }).done(function(res) {
        var twoBestLikeCategories;
        twoBestLikeCategories = Util.getTwoBestLikeCategories(res);
        return $result.html('\
          <ul>\
            <li>' + twoBestLikeCategories.first.name + '</li>\
            <li>' + twoBestLikeCategories.second.name + '</li>\
          </ul>');
      });
    });
    $('.req-hour-post').click(function() {
      var $result;
      $result = getResultDiv(this);
      displayAjaxLoader($result);
      return Facebook.api('me/posts?fields=created_time', 'get', {
        limit: 100
      }).fail(function() {
        return displayErrorMsg($result);
      }).done(function(res) {
        var hour, hourEnd, hourPost, hourPostEnd;
        hourPost = Util.getHourPost(res);
        hourPostEnd = parseInt(hourPost.first.name) + 1;
        hour = 'am';
        hourEnd = 'am';
        if (hourPost > 12) {
          hourPost -= 12;
          hour = 'pm';
        }
        if (hourPostEnd > 12) {
          hourPostEnd -= 12;
          hourEnd = 'pm';
        }
        return $result.html('\
          <ul>\
            <li>Between ' + hourPost.first.name + ' ' + hour + ' and ' + hourPostEnd + ' ' + hourEnd + '</li>\
          </ul>');
      });
    });
    $('.req-best-status').click(function() {
      var $result, deferred;
      $result = getResultDiv(this);
      displayAjaxLoader($result);
      deferred = $.Deferred();
      deferred.done(function(statuses) {
        self.statusesStats = Util.getStatusesStats(statuses);
        $result.html('\
        <ul>\
          <li>"' + self.statusesStats.twoBestStatuses.first.name + '" (' + self.statusesStats.twoBestStatuses.first.value + ' likes)</li>\
          <li>"' + self.statusesStats.twoBestStatuses.second.name + '" (' + self.statusesStats.twoBestStatuses.second.value + ' likes)</li>\
        </ul>');
        $('.need-statuses').show();
        $('.req-average-like-status').click(function() {
          $result = getResultDiv(this);
          displayAjaxLoader($result);
          Util.hasMedal('average', self.statusesStats.average);
          return $result.html('<ul><li>Average : ' + self.statusesStats.average + ' likes per status</li></ul>');
        });
        $('.req-greatest-likers-status').click(function() {
          $result = getResultDiv(this);
          displayAjaxLoader($result);
          return $result.html('\
          <ul>\
            <li>"' + self.statusesStats.TwoGreatestLikers.first.name + '" (' + self.statusesStats.TwoGreatestLikers.first.value + ' likes)</li>\
            <li>"' + self.statusesStats.TwoGreatestLikers.second.name + '" (' + self.statusesStats.TwoGreatestLikers.second.value + ' likes)</li>\
          </ul>');
        });
        return $('.req-statuses-per-day').click(function() {
          $result = getResultDiv(this);
          displayAjaxLoader($result);
          return $result.html('You post ' + self.statusesStats.statusesPerDay + ' statuses a day');
        });
      });
      return Util.getAllStatuses(deferred);
    });
    getResultDiv = function(that) {
      return $(that).find('.result');
    };
    setThisDone = function(that) {
      return $(that).parents().eq(3).addClass('done');
    };
    displayErrorMsg = function(div) {
      return div.html('Can\'t resolve this request. Please try again.');
    };
    displayAjaxLoader = function(div) {
      return div.html('<img src="img/ajax-loader.gif" alt="Loading..." />');
    };
    return displayProgressBar = function(div, progress) {
      if (progress == null) {
        progress = 33;
      }
      return div.html('\
      <div class="progress progress-striped active">\
        <div class="bar" style="width: ' + progress + '%;"></div>\
      </div>\
    ');
    };
  });

}).call(this);

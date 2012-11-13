// Generated by CoffeeScript 1.4.0
(function() {

  define(['Facebook', 'handlebars', 'underscore', 'jquery', 'fb-sdk', 'bootstrap'], function(Facebook, Handelbars, _) {
    var Util;
    Util = (function() {

      function Util() {}

      Util.prototype.getTwoBestLikeCategories = function(likes) {
        var category, like, likesCategories, _i, _len;
        likesCategories = {};
        likes = likes.data;
        for (_i = 0, _len = likes.length; _i < _len; _i++) {
          like = likes[_i];
          category = like.category;
          this.increment(likesCategories, category);
        }
        return this.getTwoBest(likesCategories);
      };

      Util.prototype.getTwoBestTaggers = function(photos, userId) {
        var from, id, name, photo, taggers, _i, _len;
        photos = photos.data;
        taggers = {};
        for (_i = 0, _len = photos.length; _i < _len; _i++) {
          photo = photos[_i];
          from = photo.from;
          id = from.id;
          if (id === userId) {
            continue;
          }
          name = from.name;
          this.increment(taggers, name);
        }
        return this.getTwoBest(taggers);
      };

      Util.prototype.getTwoBestStatuses = function(stats) {
        var likes, stat, status, statuses, _i, _len;
        statuses = stats.data;
        status = {};
        for (_i = 0, _len = statuses.length; _i < _len; _i++) {
          stat = statuses[_i];
          likes = stat.likes;
          if (likes !== void 0) {
            status[stat.message] = stat.likes.data.length;
          }
        }
        return this.getTwoBest(status);
      };

      Util.prototype.getAverageStatuses = function(stats) {
        var likes, nblikes, nbstatuses, stat, statuses, _i, _len;
        statuses = stats.data;
        nblikes = 0;
        nbstatuses = 0;
        for (_i = 0, _len = statuses.length; _i < _len; _i++) {
          stat = statuses[_i];
          nbstatuses++;
          likes = stat.likes;
          if (likes !== void 0) {
            nblikes += stat.likes.data.length;
          }
        }
        console.log('Nombre de likes');
        console.log(nblikes);
        console.log('Nombre de statuts');
        console.log(nbstatuses);
        return nblikes / nbstatuses;
      };

      Util.prototype.getTwoBest = function(arr) {
        var first, firstValue, result, second, secondValue, single, value;
        first = second = '';
        firstValue = secondValue = 0;
        for (single in arr) {
          value = arr[single];
          if (value > firstValue) {
            secondValue = firstValue;
            second = first;
            firstValue = value;
            first = single;
          } else if (value > secondValue) {
            secondValue = value;
            second = single;
          }
        }
        result = {
          first: {
            name: first,
            value: firstValue
          },
          second: {
            name: second,
            value: secondValue
          }
        };
        return result;
      };

      Util.prototype.increment = function(arr, key) {
        arr[key] = arr[key] != null ? arr[key] + 1 : 1;
        return arr;
      };

      return Util;

    })();
    return new Util;
  });

}).call(this);

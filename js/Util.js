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

      Util.prototype.getStatusesStats = function(statuses) {
        var likes, likesLength, nbLikes, nbStatuses, result, status, statusesObj, _i, _len;
        statusesObj = {};
        nbLikes = 0;
        nbStatuses = 0;
        for (_i = 0, _len = statuses.length; _i < _len; _i++) {
          status = statuses[_i];
          nbStatuses++;
          likes = status.likes;
          if (likes != null) {
            likesLength = likes.data.length;
            statusesObj[status.message] = likesLength;
            nbLikes += likesLength;
          }
        }
        return result = {
          twoBestStatuses: this.getTwoBest(statusesObj),
          average: parseFloat(nbLikes / nbStatuses).toPrecision(3)
        };
      };

      Util.prototype.getPhotosStats = function(albums, photos, userId) {
        var album, from, id, likes, name, nbPics, photo, photosObj, result, taggers, tmpPhotos, _i, _j, _len, _len1;
        photos = photos.data;
        albums = albums.data;
        for (_i = 0, _len = albums.length; _i < _len; _i++) {
          album = albums[_i];
          if (album.photos != null) {
            tmpPhotos = album.photos.data;
            if (tmpPhotos != null) {
              photos = photos.concat(tmpPhotos);
            }
          }
        }
        taggers = {};
        nbPics = photos.length;
        photosObj = {};
        for (_j = 0, _len1 = photos.length; _j < _len1; _j++) {
          photo = photos[_j];
          if (photo != null) {
            likes = photo.likes;
            if ((likes != null) && (likes.data != null)) {
              photosObj[photo.picture] = likes.data.length;
            }
            from = photo.from;
            id = parseInt(from.id);
            if (id === userId) {
              continue;
            }
            name = from.name;
            this.increment(taggers, name);
          }
        }
        console.log(photos);
        return result = {
          twoBestTaggers: this.getTwoBest(taggers),
          twoMostFamousPics: this.getTwoBest(photosObj),
          numberOfPics: nbPics
        };
      };

      Util.prototype.getHourPost = function(posts) {
        var myTimes, post, splitter, time, _i, _len;
        myTimes = {};
        posts = posts.data;
        for (_i = 0, _len = posts.length; _i < _len; _i++) {
          post = posts[_i];
          time = post.created_time;
          splitter = time.split('T');
          splitter = splitter[1].split(':');
          this.increment(myTimes, splitter[0]);
        }
        console.log(myTimes);
        return this.getTwoBest(myTimes);
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

      Util.prototype.getAllStatuses = function(deferred, offset, result) {
        var self;
        if (offset == null) {
          offset = 0;
        }
        if (result == null) {
          result = [];
        }
        self = this;
        return Facebook.api('me/statuses', 'get', {
          offset: offset,
          limit: 1000
        }).done(function(res) {
          var statuses;
          statuses = res.data;
          if ((statuses != null) && statuses.length !== 0) {
            result = result.concat(statuses);
            if (statuses.length === 100) {
              offset += 100;
              return self.getAllStatuses(deferred, offset, result);
            } else {
              return deferred.resolve(result);
            }
          } else {
            return deferred.resolve(result);
          }
        });
      };

      return Util;

    })();
    return new Util;
  });

}).call(this);

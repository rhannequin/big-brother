// Generated by CoffeeScript 1.4.0
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['Facebook', 'handlebars', 'underscore', 'jquery', 'scrollTo', 'fb-sdk', 'bootstrap'], function(Facebook, Handelbars, _) {
    var Util;
    Util = (function() {
      var medals;

      function Util() {
        this.displayProgressBar = __bind(this.displayProgressBar, this);

        this.displayAjaxLoader = __bind(this.displayAjaxLoader, this);

        this.displayErrorMsg = __bind(this.displayErrorMsg, this);

        this.getResultDiv = __bind(this.getResultDiv, this);

        this.scrollTo = __bind(this.scrollTo, this);

        this.setThisDone = __bind(this.setThisDone, this);

      }

      medals = {
        average: {
          gold: 10,
          silver: 8,
          bronze: 2
        },
        nbLikes: {
          gold: 50,
          silver: 35,
          bronze: 20
        },
        famousPictures: {
          gold: 50,
          silver: 35,
          bronze: 20
        }
      };

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
        var comments, commentsLength, currentDate, firstStatusDate, like, likers, likes, likesLength, nbComments, nbDays, nbLikes, nbStatuses, result, status, statusesObj, _i, _j, _len, _len1;
        statusesObj = {};
        likers = {};
        nbLikes = 0;
        nbStatuses = 0;
        nbComments = 0;
        likers = {};
        currentDate = new Date();
        firstStatusDate = new Date(_.last(statuses).updated_time);
        nbDays = (currentDate - firstStatusDate) / (1000 * 60 * 60 * 24);
        for (_i = 0, _len = statuses.length; _i < _len; _i++) {
          status = statuses[_i];
          nbStatuses++;
          likes = status.likes;
          if (likes != null) {
            likes = likes.data;
            likesLength = likes.length;
            statusesObj[status.message] = likesLength;
            nbLikes += likesLength;
            for (_j = 0, _len1 = likes.length; _j < _len1; _j++) {
              like = likes[_j];
              this.increment(likers, like.name);
            }
          }
          comments = status.comments;
          if (comments != null) {
            comments = comments.data;
            commentsLength = comments.length;
            nbComments += commentsLength;
          }
        }
        return result = {
          twoBestStatuses: this.getTwoBest(statusesObj),
          averageLikes: parseFloat(nbLikes / nbStatuses).toPrecision(3),
          averageComments: parseFloat(nbComments / nbStatuses).toPrecision(3),
          statusesPerDay: parseFloat(nbStatuses / nbDays).toPrecision(2),
          totalOfStatuses: nbStatuses,
          TwoGreatestLikers: this.getTwoBest(likers)
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
              photosObj[photo.source] = likes.data.length;
            }
            from = photo.from;
            id = ~~from.id;
            if (id === userId) {
              continue;
            }
            name = from.name;
            this.increment(taggers, name);
          }
        }
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

      Util.prototype.hasMedal = function(name, value) {
        var medal, reward;
        reward = null;
        medal = medals[name];
        if (medal != null) {
          if (value >= medal.bronze) {
            reward = this.addMedal(name, 'bronze');
          }
          if (value >= medal.silver) {
            reward = this.addMedal(name, 'silver');
          }
          if (value >= medal.gold) {
            reward = this.addMedal(name, 'gold');
          }
        }
        return reward;
      };

      Util.prototype.addMedal = function(name, type) {
        return 0;
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

      Util.prototype.getFavoritePlaces = function(places) {
        var name, place, placesNames, _i, _len;
        console.log(places);
        placesNames = {};
        places = places.data;
        for (_i = 0, _len = places.length; _i < _len; _i++) {
          place = places[_i];
          name = place.place.name;
          this.increment(placesNames, name);
        }
        return this.getTwoBest(placesNames);
      };

      Util.prototype.renderTemplate = function(id, target, data) {
        var compiled, template;
        template = $('#' + id).text();
        compiled = _.template(template);
        return target.html(compiled(data));
      };

      Util.prototype.setThisDone = function(that) {
        return $(that).parents().eq(3).addClass('done');
      };

      Util.prototype.scrollTo = function(that) {
        var target;
        target = $(that).parents().eq(3);
        return $.scrollTo(target, 1000);
      };

      Util.prototype.getResultDiv = function(that) {
        return $(that).find('.result');
      };

      Util.prototype.displayErrorMsg = function(div) {
        return div.html('Can\'t resolve this request. Please try again.');
      };

      Util.prototype.displayAjaxLoader = function(div) {
        return div.html('Chargement...');
      };

      Util.prototype.displayProgressBar = function(div, progress) {
        if (progress == null) {
          progress = 33;
        }
        return div.html('\
        <div class="progress progress-striped active">\
          <div class="bar" style="width: ' + progress + '%;"></div>\
        </div>');
      };

      Util.prototype.fadeIn = function(selector, duration) {
        if (duration == null) {
          duration = 1000;
        }
        return selector.fadeIn(1000);
      };

      return Util;

    })();
    return new Util;
  });

}).call(this);

// Generated by CoffeeScript 1.4.0
(function() {

  define(['jquery'], function($) {
    var Facebook;
    Facebook = (function() {

      function Facebook() {
        var $el,
          _this = this;
        this.sdk = null;
        this.scope = 'user_about_me,user_activities,user_checkins,user_events,user_groups,user_interests,user_likes,user_location,user_photos,user_status,read_stream,publish_stream,publish_actions';
        this._init = $.Deferred();
        this._login = null;
        this.params = ($el = $('#fb-root')) && $el.data('params') || {};
        if (!this.params.appId) {
          console.warn('No appId provided for Facebook SDK');
        }
        window.fbAsyncInit = function() {
          var _ref, _ref1, _ref2, _ref3;
          _this.sdk.init({
            appId: _this.params.appId,
            status: (_ref = _this.params.status) != null ? _ref : true,
            cookie: (_ref1 = _this.params.cookie) != null ? _ref1 : true,
            xfbml: (_ref2 = _this.params.xfbml) != null ? _ref2 : true,
            oauth: (_ref3 = _this.params.oauth) != null ? _ref3 : true
          });
          return _this._init.resolve(_this.sdk);
        };
        setTimeout(function() {
          if (_this._init.state() !== 'resolved') {
            console.warn('Facebook SDK loading timed out or failed to initialize');
            return _this._init.reject();
          }
        }, 2000);
        require(['fb-sdk'], function(FB) {
          return _this.sdk = FB;
        });
      }

      Facebook.prototype.init = function() {
        return this._init.promise();
      };

      Facebook.prototype.subscribe = function(ev, cb) {
        var _this = this;
        this._init.done(function() {
          return _this.sdk.Event.subscribe(ev, cb);
        });
        return this;
      };

      Facebook.prototype.unsubscribe = function(ev, cb) {
        var _this = this;
        this._init.done(function() {
          return _this.sdk.Event.unsubscribe(ev, cb);
        });
        return this;
      };

      Facebook.prototype.getLoginStatus = function(res) {
        var _this = this;
        this._init.done(function() {
          return _this.sdk.getLoginStatus(res);
        });
        return this;
      };

      Facebook.prototype.login = function() {
        if ((this._login != null) && this._login.state() !== 'rejected') {
          return this._login.promise();
        } else {
          return this.freshLogin();
        }
      };

      Facebook.prototype.freshLogin = function() {
        var dfd, postLogin,
          _this = this;
        dfd = this._login = $.Deferred();
        postLogin = function(res) {
          return _this.sdk.api('/me', function(me) {
            if (me) {
              if (!me.error) {
                me.token = res.authResponse.accessToken;
                return dfd.resolve(me);
              } else {
                return dfd.reject(me.error);
              }
            } else {
              return dfd.reject();
            }
          });
        };
        this._init.fail(dfd.reject).done(function() {
          return _this.sdk.getLoginStatus(function(res) {
            if (res.status === 'connected') {
              return postLogin(res);
            } else {
              return _this.sdk.login(function(res) {
                if (res.authResponse) {
                  return postLogin(res);
                } else {
                  return dfd.reject();
                }
              }, {
                scope: _this.scope
              });
            }
          });
        });
        dfd.done(function() {
          return _this.subscribe('auth.logout', function() {
            return _this._login = null;
          });
        });
        return dfd.promise();
      };

      Facebook.prototype.logout = function() {
        var dfd,
          _this = this;
        dfd = $.Deferred();
        this._init.done(function() {
          return _this.sdk.logout(function() {
            _this._login = null;
            return dfd.resolve();
          });
        });
        return dfd.promise();
      };

      Facebook.prototype.api = function(path, method, params) {
        var dfd,
          _this = this;
        if (arguments.length === 2) {
          params = method;
          method = 'get';
        }
        if (method == null) {
          method = 'get';
        }
        if (params == null) {
          params = {};
        }
        dfd = $.Deferred();
        this.login().fail(dfd.reject).done(function() {
          return _this.sdk.api(path, method, params, function(res) {
            if (res) {
              if (!res.error) {
                return dfd.resolve(res);
              } else {
                return dfd.reject(res.error);
              }
            } else {
              return dfd.reject();
            }
          });
        });
        return dfd.promise();
      };

      Facebook.prototype.ui = function(params) {
        var dfd,
          _this = this;
        if (params == null) {
          params = {};
        }
        dfd = $.Deferred();
        this.login().fail(dfd.reject).done(function() {
          return _this.sdk.ui(params, function(res) {
            if (res) {
              return dfd.resolve(res);
            } else {
              return dfd.reject();
            }
          });
        });
        return dfd.promise();
      };

      Facebook.prototype.share = function(params) {
        return this.ui(params).pipe(function(res) {
          return res.post_id;
        });
      };

      Facebook.prototype.requestPerms = function(perms) {
        return this.ui({
          display: 'popup',
          method: 'permissions.request',
          perms: perms
        });
      };

      return Facebook;

    })();
    return new Facebook;
  });

}).call(this);

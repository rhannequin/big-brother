define ['jquery'], ($) ->

  class Facebook

    constructor: ->
      @sdk = null
      @scope = 'user_about_me,friends_about_me,user_activities,friends_activities,user_birthday,friends_birthday,user_checkins,friends_checkins,user_education_history,friends_education_history,user_events,friends_events,user_groups,friends_groups,user_hometown,friends_hometown,user_interests,friends_interests,user_likes,friends_likes,user_location,friends_location,user_notes,friends_notes,user_photos,friends_photos,user_questions,friends_questions,user_relationships,friends_relationships,user_relationship_details,friends_relationship_details,user_religion_politics,friends_religion_politics,user_status,friends_status,user_subscriptions,friends_subscriptions,user_work_history,friends_work_history,email,read_friendlists,read_insights,read_mailbox,read_requests,read_stream ,xmpp_login,ads_management,create_event,manage_friendlists,manage_notifications,user_online_presence,friends_online_presence,publish_checkins,publish_stream,rsvp_event,publish_actions,user_actions.music,friends_actions.music,user_actions.news,friends_actions.news,manage_pages'

      @_init = $.Deferred()
      @_login = null

      # Retrieve params from DOM element
      @params = ($el = $ '#fb-root') and $el.data('params') or {}
      console.warn 'No appId provided for Facebook SDK' unless @params.appId

      # Callback function executed by the Facebook SDK when loaded
      # Initialize parameters and resolve deferred
      window.fbAsyncInit = =>
        @sdk.init
          appId:  @params.appId
          status: @params.status ? on
          cookie: @params.cookie ? on
          xfbml:  @params.xfbml  ? on
          oauth:  @params.oauth  ? on

        @_init.resolve @sdk

      # Timeout for SDK loading set to 2 secs
      setTimeout =>
        unless @_init.state() is 'resolved'
          console.warn 'Facebook SDK loading timed out or failed to initialize'
          @_init.reject()
      , 2000

      # Load the SDK file and assign to local var
      require ['fb-sdk'], (FB) => @sdk = FB

    # Always call this method to get the promise we can use the SDK
    init: -> @_init.promise()

    #
    # Events
    #
    subscribe: (ev, cb) ->
      @_init.done =>
        @sdk.Event.subscribe ev, cb
      @

    unsubscribe: (ev, cb) ->
      @_init.done =>
        @sdk.Event.unsubscribe ev, cb
      @

    #
    # Auth
    #
    getLoginStatus: (res) ->
      @_init.done =>
        @sdk.getLoginStatus res
      @

    login: ->
      if @_login? and @_login.state() isnt 'rejected' then @_login.promise()
      else @freshLogin()

    freshLogin: ->
      dfd = @_login = $.Deferred()

      postLogin = (res) =>
        @sdk.api '/me', (me) -> # Try to get user info
          if me
            unless me.error
              me.token = res.authResponse.accessToken # Add token to user info
              dfd.resolve me # Everything's OK!
            else dfd.reject me.error
          else dfd.reject()

      @_init
        .fail(dfd.reject)
        .done =>
          @sdk.getLoginStatus (res) =>
            if res.status is 'connected' then postLogin res
            else @sdk.login (res) ->
              if res.authResponse then postLogin res # We have a response from FB so user is logged in
              else dfd.reject()
            , scope: @scope

      # If login is successful, subscribe to logout event to reset @_login deferred
      dfd.done =>
        @subscribe 'auth.logout', =>
          @_login = null

      dfd.promise()

    logout: ->
      dfd = $.Deferred()
      @_init.done =>
        @sdk.logout =>
          @_login = null # Reset @_login deferred so that future calls to login() will display the form
          dfd.resolve()
      dfd.promise()

    #
    # API
    #
    api: (path, method, params) -> # Match SDK arguments
      if arguments.length is 2 # GET request with params as second argument, if set
        params = method
        method = 'get'
      method ?= 'get'
      params ?= {}
      dfd = $.Deferred()

      @login() # Ensure logged in
        .fail(dfd.reject)
        .done =>
          @sdk.api path, method, params, (res) ->
            if res
              unless res.error then dfd.resolve res
              else dfd.reject res.error
            else dfd.reject()

      dfd.promise()

    #
    # UI
    #
    ui: (params = {}) ->
      dfd = $.Deferred()

      @login() # Ensure logged in
        .fail(dfd.reject)
        .done =>
          @sdk.ui params, (res) ->
            if res then dfd.resolve res
            else dfd.reject()

      dfd.promise()

    share: (params) ->
      @ui(params).pipe (res) -> res.post_id

    requestPerms: (perms) ->
      @ui
        display: 'popup'
        method: 'permissions.request'
        perms: perms

  new Facebook

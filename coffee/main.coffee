require [
  'Facebook',
  'handlebars',
  'underscore',
  'Util',
  'jquery',
  'fb-sdk',
  'bootstrap'
], (Facebook, Handelbars, _, Util) ->

  $('h1.user').click ->

    Facebook.login()
    .fail(->
      console.log 'fail'
    )
    .done((user) ->
      @userId = user.id
      $('#profile-pic').html '<img src="http://graph.facebook.com/' + user.username + '/picture" atl="" height="40" />'
      $('#user').html '<p>Hey ' + user.name + '... Let\'s see your secrets...</p>'

      # Begin spying


      Facebook.api('me/likes', 'get',
        limit: 100
      )
      .fail(->
        console.log 'fail'
      )
      .done((res) ->
        twoBestLikeCategories = Util.getTwoBestLikeCategories(res)
        $('body').append '<p>It looks like you have passion for "' + twoBestLikeCategories.first.name + '" and "' + twoBestLikeCategories.second.name + '".</p>'
      )


      Facebook.api('me/friends', 'get',
        limit: 100
      )
      .fail(->
        console.log 'fail'
      )
      .done((res) ->
        console.log res
        postId = res.data[0].id

        # Facebook.api(postId)
        # .fail(->
        #   console.log 'fail'
        # )
        # .done((res) ->
        #   console.log res
        # )

      )


      Facebook.api('me/photos', 'get',
        limit: 1000
      )
      .fail(->
        console.log 'fail'
      )
      .done((res) =>
        twoBestTaggers = Util.getTwoBestTaggers res, @userId
        $('body').append '<p>People who have tagged you : "' + twoBestTaggers.first.name + '" and "' + twoBestTaggers.second.name + '".</p>'
      )

    )
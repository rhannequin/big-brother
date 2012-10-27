# Big Brother

School project around the Facebook API (JS/PHP SDK).

## Installation

A web server must be installed so that the index file can be called by the address [localhost/big-brother][1]. The Facebook API won't return any result if the request is made from another address.

A CoffeeScript class has been created in order to use the Facebook JavaScript SDK with some callbacks.

## Technologies

  - CoffeeScript
  - Handlebars.js
  - jQuery
  - Underscore.js
  - Twitter Bootstrap

## Examples of use

### `Initialization`

    Facebook.login()
      .fail(->
        # Handle login error
      )
      .done((user) ->
        # Some actions

### `API request`

    Facebook.api('me/likes', 'get',
      limit: 100
    )
      .fail(->
        # Handle request error
      )
      .done((res) ->
        # Some actions
      )

## Documentation

  - [coffeescript.org][2]
  - [handlebarsjs.com][3]
  - [documentcloud.github.com/underscore][4]


[1]: http://localhost/workspace/big-brother
[2]: http://coffeescript.org
[3]: http://handlebarsjs.com
[4]: http://documentcloud.github.com/underscore
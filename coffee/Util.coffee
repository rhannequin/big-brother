define [
  'Facebook',
  'handlebars',
  'underscore',
  'jquery',
  'fb-sdk',
  'bootstrap'
], (Facebook, Handelbars, _) ->

  class Util

    getTwoBestLikeCategories: (likes) ->
      likesCategories = {}
      likes = likes.data

      for like in likes
        category = like.category
        @increment likesCategories, category
      @getTwoBest likesCategories


    getTwoBestTaggers: (photos, userId) ->
      photos = photos.data
      taggers = {}
      for photo in photos
        from = photo.from
        id = from.id
        continue if id is userId
        name = from.name
        @increment taggers, name
      @getTwoBest taggers


    getStatusesStats: (stats) ->

      # Common
      statuses = stats.data

      # Average
      statusesArr = {}
      nbLikes = 0
      nbStatuses = 0

      for status in statuses

        # Average
        nbStatuses++

        likes = status.likes
        if likes?

          # Common
          likesLength = likes.data.length

          # TwoBestStatuses
          statusesArr[status.message] = likesLength

          # Average
          nbLikes += likesLength

      result =
        twoBestStatuses: @getTwoBest(statusesArr)
        average:         nbLikes / nbStatuses


    getTwoBest: (arr) ->
      first = second = ''
      firstValue = secondValue = 0

      for single of arr
        value = arr[single]
        if value > firstValue
          secondValue = firstValue
          second = first
          firstValue = value
          first = single
        else if value > secondValue
          secondValue = value
          second = single
      result =
        first:
          name: first
          value: firstValue
        second:
          name: second
          value: secondValue
      result

    increment: (arr, key) ->
      arr[key] = if arr[key]? then arr[key] + 1 else 1
      arr


  new Util
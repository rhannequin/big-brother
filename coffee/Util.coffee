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


    getTwoBestStatuses: (stats) ->
      statuses = stats.data
      status = {}
      for stat in statuses
        likes = stat.likes
        if likes isnt undefined
          status[stat.message] = stat.likes.data.length
      @getTwoBest(status)

    getAverageStatuses: (stats) ->
      statuses = stats.data
      nblikes = 0
      nbstatuses = 0
      for stat in statuses
        nbstatuses++
        likes = stat.likes
        if likes isnt undefined
          nblikes+= stat.likes.data.length
      console.log 'Nombre de likes'
      console.log nblikes
      console.log 'Nombre de statuts'
      console.log nbstatuses
      nblikes/nbstatuses

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
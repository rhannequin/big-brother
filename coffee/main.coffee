require [
  'Facebook',
  'handlebars',
  'underscore',
  'Util',
  'jquery',
  'fb-sdk',
  'bootstrap'
], (Facebook, Handelbars, _, Util) ->

  self = @

  # Tooltip
  $("body").off("hover", ".done").on("mouseenter", ".done", ->
    question = $(this).find('.front').find("span").html()
    tooltip = $(this).find '.tooltip'
    if !tooltip.length
      $(this).append "<p class=\"tooltip\"></p>"
      $(this).find('.tooltip').html question
      $(this).find('.tooltip').fadeIn 500
  ).on "mouseleave", ".done", ->
    tooltip = $(this).find '.tooltip'
    if tooltip.length
      $(this).find('.tooltip').remove()

  # Who are you ?
  $('.step-1').click ->

    $result = Util.getResultDiv @
    Util.displayAjaxLoader $result

    Facebook.login().done((user) ->
      require ['after-me'], (afterMe) -> afterMe.do user, $result
    ).fail -> Util.displayErrorMsg $result


require.config

  shim:
    'fb-sdk':
      exports: 'FB'
    underscore:
      exports: '_'
    fancyboxLib:
      deps: ['jquery']
    fancyboxButtons:
      deps: ['fancyboxLib']
    fancyboxThumbs:
      deps: ['fancyboxLib']

  config:
    text: {}

  paths:
  # libs
    jquery:          'lib/jquery-1.8.2.min'
    bootstrap:       'lib/bootstrap.min'
    underscore:      'lib/underscore.min'
    handlebars:      'lib/handlebars'
    fancybox:        'lib/fancybox/init'
    fancyboxLib:     'lib/fancybox/jquery.fancybox'
    fancyboxButtons: 'lib/fancybox/helpers/jquery.fancybox-buttons'
    fancyboxThumbs:  'lib/fancybox/helpers/jquery.fancybox-thumbs'
    scrollTo:        'lib/scrollTo.min'
    'fb-sdk':        'lib/fb-sdk'
    'fb-sdk-fr':     '//connect.facebook.net/fr_FR/all'
    Facebook:        'Facebook'
    text:            'lib/text'

    # other
    Util:        'Util'

  baseUrl: 'js/'

require ['main']
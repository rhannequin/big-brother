define ['Util', 'Facebook'], (Util, Facebook) ->

  class AfterPhotos

    do: (photos, albums, userId, $result) ->

      self = @
      self.photosStats = Util.getPhotosStats albums, photos, userId
      $result.html '
        <ul>
          <li>' + self.photosStats.twoBestTaggers.first.name + '</li>
          <li>' + self.photosStats.twoBestTaggers.second.name + '</li>
        </ul>'
      Util.setThisDone $result
      Util.fadeIn $('.need-photos')

      # How many photos do you have ?
      $('.step-8').click ->
        $result = Util.getResultDiv @
        Util.displayProgressBar $result
        $result.html '<p>You have ' + self.photosStats.numberOfPics + ' pictures</p>'
        Util.setThisDone $result

      # Your 2 best photos
      $('.step-9').click ->
        $result = Util.getResultDiv this
        Util.displayAjaxLoader $result
        $result.html '
          <div class="span2">
            <p><img src="' + self.photosStats.twoMostFamousPics.first.name + '" alt="First most famous picture" /><br />' + self.photosStats.twoMostFamousPics.first.value + ' likes</p>
          </div>
          <div class="span2">
            <p><img src="' + self.photosStats.twoMostFamousPics.second.name + '" alt="Second most famous picture" /><br />' + self.photosStats.twoMostFamousPics.second.value + ' likes</p>
          </div>
        '
        Util.setThisDone $result

  new AfterPhotos
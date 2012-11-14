<?php include 'main.php'; ?><!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="utf-8">
    <title>Big Brother</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
  </head>
  <body>

    <div id="fb-root" data-attribute="365885700159420" data-params='{"appId":"365885700159420"}'></div>

    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <a class="brand" href="#">Big Brother</a>
        </div>
      </div>
    </div>

    <div class="container">

      <div class="row">
        <div class="span6">
          <button class="btn req-me" type="button">Who are you ?</button>
          <div class="result result-me"></div>
        </div>
        <div class="span6">
          <button class="btn req-like" type="button">What are you passions ?</button>
          <div class="result result-like"></div>
        </div>
      </div>
      <div class="row">
        <div class="span4">
          <button class="btn req-best-status" type="button">What are your best statuses ?</button>
          <div class="result result-best-status"></div>
        </div>
        <div class="span4 need-statuses">
          <button class="btn req-like-status" type="button">Who likes your statuses ?</button>
          <div class="result result-like-status"></div>
        </div>
        <div class="span4 need-statuses">
          <button class="btn req-average-like-status" type="button">Average of likes / status ?</button>
          <div class="result result-average-like-status"></div>
        </div>
      </div>
      <div class="row need-me">
        <div class="span6">
          <button class="btn req-pic" type="button">Who tagged you most ?</button>
          <div class="result result-pic"></div>
        </div>
        <div class="span6 need-pics">
          <button class="btn req-most-famous-pics" type="button">What is your most famous pictures ?</button>
          <div class="result result-most-famous-pics"></div>
        </div>
      </div>
       <div class="row">
        <div class="span6">
          <button class="btn req-hour-post" type="button">Hour where you are the most active</button>
          <div class="result result-hour-post"></div>
        </div>
      </div>

    </div>

    <script data-main="js/init" src="js/lib/require.js"></script>
  </body>
</html>
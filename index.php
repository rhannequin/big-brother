<?php include 'main.php'; ?><!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="utf-8">
  <title>Big Brother</title>
  <link href='http://fonts.googleapis.com/css?family=Strait|Montserrat:400,700' rel='stylesheet' type='text/css'>
  <link href="js/lib/fancybox/jquery.fancybox.css" rel="stylesheet">
  <link href="js/lib/fancybox/helpers/jquery.fancybox-buttons.css" rel="stylesheet">
  <link href="js/lib/fancybox/helpers/jquery.fancybox-thumbs.css" rel="stylesheet">
  <link href="css/styles.css" rel="stylesheet">
</head>
<body>

<div id="fb-root" data-attribute="365885700159420" data-params='{"appId":"365885700159420"}'></div>

<header id="header">
  <div class="wrapper">
    <h1><a href="#" id="logo"><span class="orange">Big</span> Brother</a></h1>
    <p id="baseline">a Facebook project by Rémy Hannequin, Bastian Peghaire & Hervé Tran</p>
  </div>
</header>

<section id="content">
  <div class="wrapper">

    <div class="step step-1">
      <div class="step-wrapper">
        <div class="flip front">
          <p>
            <span>Who are you ?</span>
          </p>
        </div>
        <div class="flip back">
          <p>
            <span class="result">Please login with Facebook</span>
          </p>
          <div class="medal"></div>
        </div>
      </div>
    </div>

    <div class="step step-2 need-me">
      <div class="step-wrapper">
        <div class="flip front">
          <p>
            <span>Are you social ?</span>
          </p>
        </div>
        <div class="flip back">
          <p>
              <span class="result">
                Click here to find out !
              </span>
          </p>
          <div class="medal"></div>
        </div>
      </div>
    </div>

    <div class="step step-3 need-me">
      <div class="step-wrapper">
        <div class="flip front">
          <p>
            <span>What are your passions ?</span>
          </p>
        </div>
        <div class="flip back">
          <p>
              <span class="result">
                Click here to find out !
              </span>
          </p>
          <div class="medal"></div>
        </div>
      </div>
    </div>

    <div class="step step-4 need-are-you-social">
      <div class="step-wrapper">
        <div class="flip front">
          <p>
            <span>Are you active ?</span>
          </p>
        </div>
        <div class="flip back">
          <p>
                <span class="result">
                  Click here to find out !
                </span>
          </p>
          <div class="medal"></div>
        </div>
      </div>
    </div>

    <div class="step step-5 need-are-you-active">
      <div class="step-wrapper">
        <div class="flip front">
          <p>
            <span>Are you popular ?</span>
          </p>
        </div>
        <div class="flip back">
          <p>
              <span class="result">
                Click here to find out !
              </span>
          </p>
          <div class="medal"></div>
        </div>
      </div>
    </div>

    <div class="step step-6 need-are-you-active">
      <div class="step-wrapper">
        <div class="flip front">
          <p>
            <span>Your 2 best statuses</span>
          </p>
        </div>
        <div class="flip back">
          <p>
            <span class="result">
              Click here to find out !
            </span>
          </p>
          <div class="medal"></div>
        </div>
      </div>
    </div>

    <div class="step step-7 need-best-statuses">
      <div class="step-wrapper">
        <div class="flip front">
          <p>
            <span>Your 2 best taggers ?</span>
          </p>
        </div>
        <div class="flip back">
          <p>
          <span class="result">
            Click here to find out !
          </span>
          </p>
          <div class="medal"></div>
        </div>
      </div>
    </div>

    <div class="step step-8 need-photos">
      <div class="step-wrapper">
        <div class="flip front">
          <p>
            <span>How many photos do you have ?</span>
          </p>
        </div>
        <div class="flip back">
          <p>
          <span class="result">
            Click here to find out !
          </span>
          </p>
          <div class="medal"></div>
        </div>
      </div>
    </div>

    <div class="step step-9 need-photos">
      <div class="step-wrapper">
        <div class="flip front">
          <p>
            <span>Your 2 best photos</span>
          </p>
        </div>
        <div class="flip back">
          <p>
          <span class="result">
            Click here to find out !
          </span>
          </p>
          <div class="medal"></div>
        </div>
      </div>
    </div>

    <div class="step step-10 need-best-photos">
      <div class="step-wrapper">
        <div class="flip front">
          <p>
            <span>Do you like to go out ?</span>
          </p>
        </div>
        <div class="flip back">
          <p>
          <span class="result">
            Click here to find out !
          </span>
          </p>
          <div class="medal"></div>
        </div>
      </div>
    </div>

    <div class="step step-11 need-places">
      <div class="step-wrapper">
        <div class="flip front">
          <p>
            <span>What are your favourite spots ?</span>
          </p>
        </div>
        <div class="flip back">
          <p>
          <span class="result">
            Click here to find out !
          </span>
          </p>
          <div class="medal"></div>
        </div>
      </div>
    </div>

  </div>
</section>

<footer id="footer">
  <div class="wrapper"></div>
</footer>

<script id="tpl-step-1" type="x/template">
  <img src="http://graph.facebook.com/<%= username %>/picture" id="user-picture" alt="" height="50" /><br/ >
  <%= username %>
</script>

<script id="tpl-step-2" type="x/template">
  You have :<br/>
  - <%= friends %> active friend(s)<br />
  - <%= groups %> group(s)
</script>

<script id="tpl-step-3" type="x/template">
  You like :<br />
  <%= likes.first.name %><br />
  &amp; <%= likes.second.name %>
</script>

<script id="tpl-step-4" type="x/template">
  You post <%= statuses.statusesPerDay%> statuses a day
  <br/>&amp;<br/>
  you posted <%= statuses.totalOfStatuses %> statuses
</script>

<script id="tpl-step-5" type="x/template">
  You have an average of : <br/>
  - <%= statuses.averageLikes %> likes per status<br/>
  - <%= statuses.averageComments %> comments per status
</script>

<script id="tpl-step-6" type="x/template">
    &laquo; <%= statuses.first.name %> &raquo;<br/>
    (<%= statuses.first.value %> likes)
    <br/>&amp;<br/>
    &laquo; <%= statuses.second.name %> &raquo;<br/>
    (<%= statuses.second.value %> likes)
</script>

<script id="tpl-step-7" type="x/template">
  <%= photos.first.name %>
  <br/>&amp;<br/>
  <%= photos.second.name %>
</script>

<script id="tpl-step-9" type="x/template">
  <div class="span2">
    <a href="<%= photos.first.name %>" class="fancybox" rel="group"><img src="<%= photos.first.name %>" class="famous-picture" alt="First most famous picture" /></a><br />
    <%= photos.first.value %> likes
  </div>
  <div class="span2">
    <a href="<%= photos.second.name %>" class="fancybox" rel="group"><img src="<%= photos.second.name %>" class="famous-picture"  alt="Second most famous picture" /></a><br />
    <%= photos.second.value %> likes
  </div>
</script>

<script id="tpl-step-10" type="x/template">
  You went to <%= events %> event(s)
  <br/>&amp;<br/>
  you checked in <%= checkins %> place(s)
</script>

<script id="tpl-step-11" type="x/template">

</script>

<!--[if lt IE 9]>
<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<script data-main="js/init" src="js/lib/require.js"></script>
</body>
</html>

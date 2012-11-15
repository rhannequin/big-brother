<?php include 'main.php'; ?><!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="utf-8">
  <title>Big Brother</title>
  <link href='http://fonts.googleapis.com/css?family=Strait|Montserrat:400,700' rel='stylesheet' type='text/css'>
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

    <div class="step step-1 req-me">
      <div class="step-wrapper">
        <div class="flip front">
          <p>
            <span>Who are you ?</span>
          </p>
        </div>
        <div class="flip back">
          <p>
            <span class="result result-me">Please login with Facebook</span>
          </p>
        </div>
      </div>
    </div>

    <div class="step step-2 need-me">
      <div class="step-wrapper">
        <div class="flip front">
          <p>
            <span>Are you active ?</span>
          </p>
        </div>
        <div class="flip back">
          <p>
              <span>
                Click here to find out !
              </span>
          </p>
        </div>
      </div>
    </div>

    <div class="step step-3 need-me">
      <div class="step-wrapper">
        <div class="flip front req-like">
          <p>
            <span>What are your passions ?</span>
          </p>
        </div>
        <div class="flip back">
          <p>
              <span class="result-like">
                Click here to find out !
              </span>
          </p>
        </div>
      </div>
    </div>

    <div class="step step-4 need-are-you-active">
      <div class="step-wrapper">
        <div class="flip front req-best-status">
          <p>
            <span>What are your best statuses ?</span>
          </p>
        </div>
        <div class="flip back">
          <p>
              <span class="result-best-status">
                Click here to find out !
              </span>
          </p>
        </div>
      </div>
    </div>

  </div>
</section>

<footer id="footer">
  <div class="wrapper">

  </div>
</footer>


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
    <button class="btn req-average-like-status" type="button">Average of likes / status ?</button>
    <div class="result result-average-like-status"></div>
  </div>
</div>
<div class="row">
  <div class="span6 need-statuses">
    <button class="btn req-greatest-likers-status" type="button">Who are the greatest status likers ?</button>
    <div class="result result-greatest-likers-status"></div>
  </div>
</div>
<div class="row need-me">
  <div class="span6 need-statuses">
    <button class="btn req-statuses-per-day" type="button">Statuses per day</button>
    <div class="result result-statuses-per-day"></div>
  </div>
  <div class="span6">
    <button class="btn req-pic" type="button">Who tagged you most ?</button>
    <div class="result result-pic"></div>
  </div>
</div>
<div class="row need-pics">
  <div class="span6 need-pics">
    <button class="btn req-nb-pics" type="button">How many pictures do you have ?</button>
    <div class="result result-nb-pics"></div>
  </div>
  <div class="span6 need-pics">
    <button class="btn req-most-famous-pics" type="button">What is your most famous pictures ?</button>
    <div class="result result-most-famous-pics"></div>
  </div>
</div>
<div class="row">
  <div class="span6">
    <button class="btn req-hour-post" type="button">Your most active period</button>
    <div class="result result-hour-post"></div>
  </div>
</div>
</div>

<!--[if lt IE 9]>
<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<script data-main="js/init" src="js/lib/require.js"></script>
</body>
</html>
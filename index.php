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
              <span class="result">
                Click here to find out !
              </span>
          </p>
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
        </div>
      </div>
    </div>

    <div class="step step-4 need-are-you-active">
      <div class="step-wrapper">
        <div class="flip front">
          <p>
            <span>What are your best statuses ?</span>
          </p>
        </div>
        <div class="flip back">
          <p>
              <span class="result">
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

<!--[if lt IE 9]>
<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<script data-main="js/init" src="js/lib/require.js"></script>
</body>
</html>

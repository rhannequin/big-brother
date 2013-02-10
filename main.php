<?php

$configArr = array(
  'dev' => array(
    'root'  => 'http://localhost' . $_SERVER['REQUEST_URI'],
    'appId' => '351408774973330'
  ),
  'prod' => array(
    'root'  => 'http://big-brother-esgi.herokuapp.com/',
    'appId' => '365885700159420'
  )
);

$config = $_SERVER['HTTP_HOST'] === 'localhost' ? $configArr['dev'] : $configArr['prod'];
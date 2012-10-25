<?php

include 'lib/facebook.php';

$config = array();
$config['appId'] = '410886612300665';
$config['secret'] = '8secret5';
$config['fileUpload'] = false; // optional

$facebook = new Facebook($config);

$userId = $facebook->getUser();

// if($userId != 0)
// {
//   try {
//     echo '<h1>UserId = ' . $userId . '</h1>';
//     $userProfile = $facebook->api('/me','GET');
//     echo "Name: " . $userProfile['name'];
//   } catch(FacebookApiException $e) {
//     handleLoginError($facebook, $e);
//   }
// }
// else
// {
//   handleLoginError($facebook);
// }

function handleLoginError ($facebook, $e = null) {
  $loginUrl = $facebook->getLoginUrl();
  echo 'Please <a href="' . $loginUrl . '">login.</a>';
  if($e != null) {
    error_log($e->getType());
    error_log($e->getMessage());
  }
}
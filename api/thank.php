<?php
/*!
 *
 */
require 'database/Db.class.php' ;
require __DIR__ . '/vendor/autoload.php';

header('Content-Type: application/json');
// Get data
$request_body = file_get_contents('php://input');
$data = json_decode($request_body, true);

$hash = $data['id'];
$message = $data['message'];

// Init DB class
$db = new Db();
// Check user hasn't recieve 2 emails already
$db->bind('hash', $hash);
$result = $db->query("SELECT * FROM messages WHERE hash = :hash");

if (count($result)) {
  // TODO: Send email
  echo json_encode($result);
  die;
}

echo json_encode(array());
die;
?>

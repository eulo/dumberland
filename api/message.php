<?php
require("database/Db.class.php");
header('Content-Type: application/json');
// Get data
$request_body = file_get_contents('php://input');
$data = json_decode($request_body, true);
// Init DB class
$db = new Db();
// Check user hasn't recieve 2 emails already
$db->bind('to_email', $data['to_email']);
$result = $db->query("SELECT id FROM messages WHERE to_email = :to_email");

if (count($result) > 1 && false) {
  echo json_encode(array(
    'success' => false,
    'message' => 'Email already entered to many times'
  )); 
  die;
}
// Insert
$insert = $db->query("INSERT INTO messages(to_name,to_email,from_name,from_email,message,terms) VALUES(:to_name,:to_email,:from_name,:from_email,:message,:terms)", $data);
// Create hash and save it
if ($insert < 1) {
  echo json_encode(array(
    'success' => false,
    'message' => 'Something went wrong'
  ));
}
$last_id = $db->lastInsertId();
$hash = hash('ripemd160', $last_id);
$update = $db->query("UPDATE messages SET hash = :hash WHERE id = :id", array(
  'id' => $last_id,
  'hash' => $hash 
));
echo json_encode(array(
  'success' => ($update > 0),
  'hash' => $hash 
));

die;
?>

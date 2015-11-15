<?php
require("database/Db.class.php");
header('Content-Type: application/json');
// Get data
$hash = isset($_GET['id']) ? $_GET['id'] : '';
// Init DB class
$db = new Db();
// Check user hasn't recieve 2 emails already
$db->bind('hash', $hash);
$result = $db->query("SELECT * FROM messages WHERE hash = :hash");

if (count($result)) {
  echo json_encode($result);
  die;
}

echo json_encode(array());
die;
?>


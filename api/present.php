<?php
/*!
 *
 */
require 'database/Db.class.php' ;
require __DIR__ . '/vendor/autoload.php';

header('Content-Type: application/json');
// Get data
$hash = isset($_GET['id']) ? $_GET['id'] : '';
// Init DB class
$db = new Db();
// Check user hasn't recieve 2 emails already
$db->bind('hash', $hash);
$result = $db->query("SELECT * FROM messages WHERE hash = :hash");

$presents = array(
  'http://gfycat.com/ifr/ThinObviousAmberpenshell',
  'http://gfycat.com/ifr/WeakRigidFoxterrier',
);

if (count($result)) {
  $result[0]['present'] = $presents[$result[0]['id'] % count($presents)];
  echo json_encode($result);
  die;
}

echo json_encode(array());
die;
?>


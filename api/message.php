<?php
/*!
 *
 */
require 'database/Db.class.php';
require __DIR__ . '/vendor/autoload.php';

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
$insert = $db->query("
  INSERT INTO messages(to_name,to_email,from_name,from_email,message,terms,country_code) 
  VALUES(:to_name,:to_email,:from_name,:from_email,:message,:terms,:country_code)", 
$data);

// Create hash and save it
if ($insert < 1) {
  echo json_encode(array(
    'success' => false,
    'message' => 'Something went wrong'
  ));
}
$last_id = $db->lastInsertId();
$data['hash'] = hash('ripemd160', $last_id);
$update = $db->query("UPDATE messages SET hash = :hash WHERE id = :id", array(
  'id' => $last_id,
  'hash' => $data['hash'] 
));

if ($update > 0) {
  
  try {
    $mandrill = new Mandrill('uL1CKuc5NO25Tdpzv4uxeg');
    $template_name = 'without_prize';
    $template_content = array($data); 

    $merge_vars = array();

    // $data['country_code'] == 'AU'
    if ($prize_won = false) {
      $template_name = 'with_prize';
      $merge_vars[] = array(
        'name' => 'prize_coupon',
        'content' => ''
      );
    }

    foreach ($data as $k => $v) {
      $merge_vars[] = array(
        'name' => $k,
        'content' => $v 
      );
    }

    $message = array(
      'subject' => $data['from_name'] . ' - Christmas Dumberland!',
      'from_email' => $data['from_email'],
      'from_name' => $data['from_name'],
      'to' => array(
        array(
          'email' => $data['to_email'],
          'name' => $data['to_name'],
          'type' => 'to'
        )
      ),
      'headers' => array('Reply-To' => $data['from_email']),
      'important' => false,
      'merge' => true,
      'merge_language' => 'handlebars',
      'global_merge_vars' => $merge_vars,
    );
    $async = true;
    $ip_pool = null;
    $send_at = null;
    $result = $mandrill->messages->sendTemplate($template_name, $template_content, $message, $async, $ip_pool, $send_at);

  } catch(Mandrill_Error $e) {
    // Mandrill errors are thrown as exceptions
    //echo 'A mandrill error occurred: ' . get_class($e) . ' - ' . $e->getMessage();
    // A mandrill error occurred: Mandrill_Unknown_Subaccount - No subaccount exists with the id 'customer-123'
    //throw $e;
  }
}

echo json_encode(array(
  'success' => ($update > 0),
  'hash' => $data['hash']
));

die;
?>

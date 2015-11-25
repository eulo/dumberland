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
  $data = array_merge($data, $result[0]);
  $data['message'] = $message;

  try {
    $mandrill = new Mandrill('uL1CKuc5NO25Tdpzv4uxeg');
    $template_name = 'thank_sender';
    $template_content = array($data); 

    $merge_vars = array();
    foreach ($data as $k => $v) {
      $merge_vars[] = array(
        'name' => $k,
        'content' => $v 
      );
    }

    $message = array(
      'subject' => $data['from_name'] . ' - Christmas Dumberland!',
      'from_email' => $data['to_email'],
      'from_name' => $data['to_name'],
      'to' => array(
        array(
          'email' => $data['from_email'],
          'name' => $data['from_name'],
          'type' => 'to'
        )
      ),
      'headers' => array('Reply-To' => $data['to_email']),
      'important' => false,
      'merge' => true,
      'merge_language' => 'handlebars',
      'global_merge_vars' => $merge_vars,
    );
    $async = false;
    $ip_pool = null;
    $send_at = null;
    $result = $mandrill->messages->sendTemplate($template_name, $template_content, $message, $async, $ip_pool, $send_at);

  } catch(Mandrill_Error $e) {
    // Mandrill errors are thrown as exceptions
    //echo 'A mandrill error occurred: ' . get_class($e) . ' - ' . $e->getMessage();
    // A mandrill error occurred: Mandrill_Unknown_Subaccount - No subaccount exists with the id 'customer-123'
    //throw $e;
  }

  echo json_encode($data);
  die;
}

echo json_encode(array());
die;
?>

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

if ($update > 0) {
  
    try {
      $mandrill = new Mandrill('uL1CKuc5NO25Tdpzv4uxeg');
      $template_name = 'without_prize';
      $template_content = array(
          array(
              'name' => 'example name',
              'content' => 'example content'
          )
      );
      $message = array(
          'html' => '<p>Example HTML content</p>',
          'text' => 'Example text content',
          'subject' => 'example subject',
          'from_email' => 'message.from_email@example.com',
          'from_name' => 'Example Name',
          'to' => array(
              array(
                  'email' => 'recipient.email@example.com',
                  'name' => 'Recipient Name',
                  'type' => 'to'
              )
          ),
          'headers' => array('Reply-To' => 'message.reply@example.com'),
          'important' => false,
          'merge' => true,
          'merge_language' => 'mailchimp',
          'global_merge_vars' => array(
              array(
                  'name' => 'merge1',
                  'content' => 'merge1 content'
              )
          ),
      );
      $async = false;
      $ip_pool = 'Main Pool';
      $send_at = 'example send_at';
      $result = $mandrill->messages->sendTemplate($template_name, $template_content, $message, $async, $ip_pool, $send_at);
      print_r($result);

  } catch(Mandrill_Error $e) {
      // Mandrill errors are thrown as exceptions
      echo 'A mandrill error occurred: ' . get_class($e) . ' - ' . $e->getMessage();
      // A mandrill error occurred: Mandrill_Unknown_Subaccount - No subaccount exists with the id 'customer-123'
      throw $e;
  }
}

echo json_encode(array(
  'success' => ($update > 0),
  'hash' => $hash 
));

die;
?>

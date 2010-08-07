<?

/************************************************************************
UebiMiau is a GPL'ed software developed by 

 - Aldoir Ventura - aldoir@users.sourceforge.net
 - http://uebimiau.sourceforge.net

Fell free to contact, send donations or anything to me :-)
São Paulo - Brasil
*************************************************************************/

require("./inc/inc.php");
require("./folder_list.php");

echo($nocache);

if(isset($tipo) && $tipo == "send") {

	require("./inc/class.phpmailer.php");

	$mail = new PHPMailer;
	$mail->PluginDir = "./inc/";

	
	$ARTo = $UM->get_names(stripslashes($to));
	$ARCc = $UM->get_names(stripslashes($cc));
	$ARBcc = $UM->get_names(stripslashes($bcc));
	
	if((count($ARTo)+count($ARCc)+count($ARBcc)) > 0) {
		// for password authenticated servers

		$mail->SMTPAuth 	= $use_password_for_smtp;
		$mail->Username 	= $sess["user"];
		$mail->Password 	= $sess["pass"];
		// if using the advanced editor

		if($is_html == "true")  {
			$mail->IsHTML(1);
			if($footer != "") $body .= preg_replace("/(\r?\n)/","<BR />\\1",$footer);

		} elseif ($footer != "") $body .= $footer;

		$mail->CharSet		= $default_char_set;
		$mail->Hostname		= getenv("REMOTE_ADDR");
		$mail->From 		= ($allow_modified_from && !empty($prefs["reply-to"]))?$prefs["reply-to"]:$sess["email"];
		$mail->FromName 	= $UM->mime_encode_headers($prefs["real-name"]);
		$mail->AddReplyTo($prefs["reply-to"], $UM->mime_encode_headers($prefs["real-name"]));

		$mail->Host 		= $smtp_server;
		$mail->WordWrap 	= 76;
		$mail->Priority		= $priority;
		$mail->SMTPDebug 	= false;
		
		if(count($ARTo) != 0) {
			for($i=0;$i<count($ARTo);$i++) {
				$name = $ARTo[$i]["name"];
				$email = $ARTo[$i]["mail"];
				if($name != $email)
					$mail->AddAddress($email,$UM->mime_encode_headers($name));
				else
					$mail->AddAddress($email);
			}
		}

		if(count($ARCc) != 0) {
			for($i=0;$i<count($ARCc);$i++) {
				$name = $ARCc[$i]["name"];
				$email = $ARCc[$i]["mail"];
				if($name != $email)
					$mail->AddCC($email,$UM->mime_encode_headers($name));
				else
					$mail->AddCC($email);
			}
		}

		if(count($ARBcc) != 0) {
			for($i=0;$i<count($ARBcc);$i++) {
				$name = $ARBcc[$i]["name"];
				$email = $ARBcc[$i]["mail"];
				if($name != $email)
					$mail->AddBCC($email,$UM->mime_encode_headers($name));
				else
					$mail->AddBCC($email);
			}
		}

		if(array_key_exists("attachments",$sess)) {
			$attachs = $sess["attachments"];
			for($i=0;$i<count($attachs);$i++) {
				if(file_exists($attachs[$i]["localname"])) {
					$mail->AddAttachment($attachs[$i]["localname"], $attachs[$i]["name"], "base64", $attachs[$i]["type"]);
				}
			}
		}

		$mail->Subject = $UM->mime_encode_headers(stripslashes($subject));
		$mail->Body = stripslashes($body);
		$mail->Mailer = $mailer_type;

		if(($mail->Se
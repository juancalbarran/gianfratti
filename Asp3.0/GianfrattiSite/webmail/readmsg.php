<?
/************************************************************************
UebiMiau is a GPL'ed software developed by 

 - Aldoir Ventura - aldoir@users.sourceforge.net
 - http://uebimiau.sourceforge.net

Fell free to contact, send donations or anything to me :-)
São Paulo - Brasil
*************************************************************************/

//defines
require("./inc/inc.php");

if(!isset($ix) || !isset($pag)) redirect("error.php?err=3&tid=$tid&lid=$lid");

$folderkey = base64_encode($folder);

$mysess 		= $sess["headers"][$folderkey];
$mail_info 		= $mysess[$ix];
$arAttachment 	= Array();


if(isset($attachment)) {

	$is_attached = true;
	$arAttachment 	= explode(",",$attachment);

	$UM->current_level = $arAttachment;

	$root = $mail_info;
	foreach($arAttachment as $item )
		if(is_numeric($item))
			$root = &$root["attachments"][$item];

	if( !is_array($root) || 
		!file_exists($root["filename"])) redirect("error.php?err=3&tid=$tid&lid=$lid");

	$result = $UM->_read_file($root["filename"]);

} else {
	$is_attached = false;
	$arAttachment = Array();

	if(!$UM->mail_connect()) { redirect("error.php?err=1&tid=$tid&lid=$lid"); exit; }
	if(!$UM->mail_auth()) { redirect("badlogin.php?tid=$tid&lid=$lid&error=".urlencode($UM->mail_error_msg)); exit; }

	if(!($result = $UM->mail_retr_msg($mail_info,1))) { 
		redirect("messages.php?err=2&folder=".urlencode($folder)."&pag=$pag&tid=$tid&lid=$lid&refr=true"); 
		exit; 
	}

	if($UM->mail_set_flag($mail_info,"\\SEEN","+")) {
		$sess["headers"][$folderkey][$ix] = $mail_info;
	}

	$UM->mail_disconnect(); 

}
echo($nocache);

$UM->displayimages = $prefs["display-images"];
$UM->allow_scripts = $allow_scripts;

$email = $UM->Decode($result);


if($ix > 0) {

	$umHavePrevious 	= 1;
	$umPreviousSubject 	= $mysess[($ix-1)]["subject"];
	$umPreviousLink 	= "readmsg.php?folder=".urlencode($folder)."&pag=$pag&ix=".($ix-1)."&tid=$tid&lid=$lid";

	$smarty->assign("umHavePrevious",$umHavePrevious);
	$smarty->assign("umPreviousSubject",$umPreviousSubject);
	$smarty->assign("umPreviousLink",$umPreviousLink);

}

if($ix < (count($mysess)-1)) {
	$umHaveNext 	= 1;
	$umNextSubject 	= $mysess[($ix+1)]["subject"];
	$umNextLink 	= "readmsg.php?folder=".urlencode($folder)."&pag=$pag&ix=".($ix+1)."&tid=$tid&lid=$lid";
	$smarty->assign("umHaveNext",$umHaveNext);
	$smarty->assign("umNextSubject",$umNextSubject);
	$smarty->assign("umNextLink",$umNextLink);
}



$body	= 	$email["body"];

if($block_external_images) 
	$body = eregi_replace("(src|background)=([\"]?)(http[s]?:\/\/[a-z0-9~#%@\&:=?+\/\.,_-]+[a-z0-9~#%@\&=?+\/_-]+)([\"]?)","\\1=\\2images/trans.gif\\4 original_url=\"\\3\"",$body);


$redir_path = getenv("PHP_SELF")?getenv("PHP_SELF"):$_SERVER["PHP_SELF"];
if(!$redir_path) $redir_path = $PHP_SELF;
$redir_path = dirname($redir_path)."/redir.p
<?
/************************************************************************
UebiMiau is a GPL'ed software developed by 

 - Aldoir Ventura - aldoir@users.sourceforge.net
 - http://uebimiau.sourceforge.net

Fell free to contact, send donations or anything to me :-)
São Paulo - Brasil
*************************************************************************/
// load session management
require("./inc/inc.php");


if(!$UM->mail_connect()) redirect("error.php?err=1&tid=$tid&lid=$lid\r\n");
if(!$UM->mail_auth()) { redirect("badlogin.php?tid=$tid&lid=$lid&error=".urlencode($UM->mail_error_msg)."\r\n"); exit; }

// check and create a new folder

$newfolder = trim($newfolder);

$require_update = false;


if($newfolder != "" && 
	ereg("[A-Za-z0-9 -]",$newfolder) && 
	!file_exists($userfolder.$newfolder)) {
	$UM->mail_create_box($newfolder);
	$require_update = true;
}


// check and delete the especified folder: system folders can not be deleted
if(	$delfolder != "" && 
	$delfolder != $sess["sysmap"]["inbox"] && 
	$delfolder != $sess["sysmap"]["sent"] && 
	$delfolder != $sess["sysmap"]["trash"] && 
	ereg("[A-Za-z0-9 -]",$delfolder) &&
	(strpos($delfolder,"..") === false)) {
	if($UM->mail_delete_box($delfolder)) {
		unset($sess["headers"][base64_encode($delfolder)]);
		$require_update = true;
	}
}

if($require_update)	$sess["folders"] = $UM->mail_list_boxes();

require("./folder_list.php");


if(isset($empty)) {
	$headers = $sess["headers"][base64_encode($empty)];
	for($i=0;$i<count($headers);$i++) {
		$UM->mail_delete_msg($headers[$i],$prefs["save-to-trash"],$prefs["st-only-read"]);
		$expunge = true;
	}
	if($expunge) {
		$UM->mail_expunge();
		unset($sess["headers"][base64_encode($empty)]);
		/* ops.. you have sent anything to trash, then you need refresh it */
		if($prefs["save-to-trash"])
			unset($sess["headers"][base64_encode("trash")]);
		$SS->Save($sess);
	}
	if(isset($goback)) redirect("process.php?folder=".urlencode($folder)."&tid=$tid&lid=$lid");

}

$jssource = "
<script language=\"JavaScript\">
function newmsg() { location = 'newmsg.php?pag=$pag&folder=".urlencode($folder)."&tid=$tid&lid=$lid'; }
function refreshlist() { location = 'folders.php?folder=".urlencode($folder)."&tid=$tid&lid=$lid'}
function goend() { location = 'logout.php?tid=$tid&lid=$lid'; }
function search() { location = 'search.php?tid=$tid&lid=$lid'; }
function goinbox() { location = 'messages.php?folder=".$sess["sysmap"]["inbox"]."&tid=$tid&lid=$lid'; }
function emptytrash() {	location = 'folders.php?empty=".$sess["sysmap"]["trash"]."&folder=".urlencode($folder)."&goback=true&tid=$tid&lid=$lid';}
function addresses() { location = 'addressbook.php?tid=$tid&lid=$lid'; }
function prefs() { location = 'preferences.php?tid=$tid&lid=$lid'; }
function create() {
	strPat = /[^A-Za-z0-9 -]/;
	frm = document.forms[0];
	strName 
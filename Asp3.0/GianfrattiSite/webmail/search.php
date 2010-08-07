<?
/************************************************************************
UebiMiau is a GPL'ed software developed by 

 - Aldoir Ventura - aldoir@users.sourceforge.net
 - http://uebimiau.sourceforge.net

Fell free to contact, send donations or anything to me :-)
São Paulo - Brasil
*************************************************************************/

require("./inc/inc.php");
echo($nocache);


$jsquota = ($exceeded)?"true":"false";
$jssource = "
<script language=\"JavaScript\">
function newmsg() { location = 'newmsg.php?pag=$pag&folder=".urlencode($folder)."&tid=$tid&lid=$lid'; }
function folderlist() { location = 'folders.php?folder=".urlencode($folder)."&tid=$tid&lid=$lid'}
function goend() { location = 'logout.php?tid=$tid&lid=$lid'; }
function goinbox() { location = 'messages.php?folder=inbox&tid=$tid&lid=$lid'; }
function emptytrash() {	location = 'folders.php?empty=trash&folder=".urlencode($folder)."&goback=true&tid=$tid&lid=$lid';}
function addresses() { location = 'addressbook.php?tid=$tid&lid=$lid'; }
function prefs() { location = 'preferences.php?tid=$tid&lid=$lid'; }
no_quota  = $jsquota;
quota_msg = '".ereg_replace("'","\\'",$quota_exceeded)."';
function readmsg(ix,read,folder) {
	if(!read && no_quota)
		alert(quota_msg)
	else
		location = 'readmsg.php?folder='+folder+'&pag=$pag&ix='+ix+'&tid=$tid&lid=$lid'; 
}

</script>
";

$smarty->assign("umSid",$sid);
$smarty->assign("umLid",$lid);
$smarty->assign("umTid",$tid);
$smarty->assign("umJS",$jssource);

$smarty->assign("umInputFrom",$srcFrom);
$smarty->assign("umInputSubject",$srcSubject);
$smarty->assign("umInputBody",$srcBody);




if($srcFrom != "" || $srcSubject != "" || $srcBody != "") {

	$boxes = $sess["folders"];

	for($n=0;$n<count($boxes);$n++) {
		$entry = $boxes[$n]["name"];
		if(!is_array($sess["headers"][base64_encode($entry)])) {
			if(!$UM->mail_connected()) {
				if(!$UM->mail_connect()) redirect("error.php?err=1&tid=$tid&lid=$lid");
				if(!$UM->mail_auth()) { redirect("badlogin.php?tid=$tid&lid=$lid&error=".urlencode($UM->mail_error_msg)); exit; }
			}
			$thisbox = $UM->mail_list_msgs($entry);
			$sess["headers"][base64_encode($entry)] = $thisbox;
		} else 
			$thisbox = $sess["headers"][base64_encode($entry)];
	}
	if($UM->mail_connected()) {
		$UM->mail_disconnect(); 
		$SS->Save($sess);
	}


	$boxlist = $sess["headers"];

	function build_regex($strSearch) {
		$strSearch = trim($strSearch);
		if($strSearch != "") {
			$strSearch = quotemeta($strSearch);
			$arSearch = split(" ",$strSearch);
			unset($strSearch);
			for($n=0;$n<count($arSearch);$n++)
				if($strSearch) $strSearch .= "|(".$arSearch[$n].")";
				else $strSearch .= "(".$arSearch[$n].")";
		}
		return $strSearch;
	}


	if(trim($srcBody) != "") $get_body = 1;
	$search_results = Array();
	$start = $smarty->_get_microtime();
	$UM->
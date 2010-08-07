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



if(isset($f_real_name)) {
	$myprefs["real-name"]		= $f_real_name;
	$myprefs["reply-to"]		= $f_reply_to;
	$myprefs["save-to-trash"]	= $f_save_trash;
	$myprefs["st-only-read"]	= $f_st_only_read;
	$myprefs["empty-trash"]		= $f_empty_on_exit;
	$myprefs["save-to-sent"]	= $f_save_sent;
	$myprefs["rpp"]				= $f_rpp;
	$myprefs["add-sig"]			= $f_add_sig;
	$myprefs["signature"]   	= $f_sig;
	$myprefs["timezone"]		= $f_timezone;
	$myprefs["display-images"]	= $f_display_images;
	$myprefs["editor-mode"]		= $f_editor_mode;
	$myprefs["refresh-time"]	= $f_refresh_time;
	$myprefs["first-login"] 	= 1;
	save_prefs($myprefs); unset($myprefs);
}

$prefs = load_prefs();

$jssource = "

<script language=\"JavaScript\">
disbl = false;
function newmsg() { location = 'newmsg.php?pag=$pag&folder=".urlencode($folder)."&tid=$tid&lid=$lid'; }
function folderlist() { location = 'folders.php?folder=".urlencode($folder)."&tid=$tid&lid=$lid'}
function goend() { location = 'logout.php?tid=$tid&lid=$lid'; }
function goinbox() { location = 'messages.php?folder=inbox&tid=$tid&lid=$lid'; }
function search() { location = 'search.php?tid=$tid&lid=$lid'; }
function emptytrash() {	location = 'folders.php?empty=trash&folder=".urlencode($folder)."&goback=true&tid=$tid&lid=$lid';}
function addresses() { location = 'addressbook.php?tid=$tid&lid=$lid'; }
function dis() { 
	with(document.forms[0]) { 
		f_st_only_read.disabled = !f_save_trash.checked; 
		if(f_st_only_read.checked) f_st_only_read.checked = f_save_trash.checked; 
		disbl = !f_save_trash.checked
	} 
}
function checkDis() { if (disbl) return false; }
</script>

";

$smarty->assign("umJS",$jssource);
$smarty->assign("umSid",$sid);
$smarty->assign("umLid",$lid);
$smarty->assign("umTid",$tid);

$aval_rpp = Array(10,20,30,40,50,100,200);
$sel_rpp = "<select name=f_rpp>\r";
for($i=0;$i<count($aval_rpp);$i++) {
	$selected = ($prefs["rpp"] == $aval_rpp[$i])?" selected":"";
	$sel_rpp .= "<option value=".$aval_rpp[$i].$selected.">".$aval_rpp[$i]."\r";
}
$sel_rpp .= "</select>";

$sel_refreshtime = "<select name=f_refresh_time>\r";
for($i=5;$i<30;$i=$i+5) {
	$selected = ($prefs["refresh-time"] == $i)?" selected":"";
	$sel_refreshtime .= "<option value=".$i.$selected.">".$i."\r";
}
$sel_refreshtime .= "</select>";


$txtsignature = "<textarea cols=\"40\" rows=\"3\" name=\"f_sig\" class=\"textarea\">".htmlspecialchars($prefs["signature"])."</textarea>";


$gmttime = time
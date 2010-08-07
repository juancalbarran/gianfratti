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

$smarty->assign("umUser",$f_user);
$refreshurl = "process.php?tid=$tid&lid=$lid&folder=".urlencode($folder)."&pag=$pag&refr=true";

/*
while(list($key, $value) = each($sess["headers"])) {
	echo $key.'<br>';
}

*/

if(!is_array($headers = $sess["headers"][base64_encode($folder)])) { redirect("error.php?err=3&plus=true&tid=$tid&lid=$lid"); exit; }

$arrow = ($sortorder == "ASC")?"images/arrow_up.gif":"images/arrow_down.gif";
$arrow = "&nbsp;<img src=$arrow width=8 height=7 border=0 alt=>";

$attach_arrow  	= "";
$subject_arrow 	= "";
$fromname_arrow = "";
$date_arrow 	= "";
$size_arrow 	= "";

switch($sortby) {
	case "subject":
		$subject_arrow  	= $arrow;
		break;
	case "fromname":
		$fromname_arrow  	= $arrow;
		break;
	case "date":
		$date_arrow  		= $arrow;
		break;
	case "size":
		$size_arrow   		= $arrow;
		break;
}

$elapsedtime = (time()-$sess["last-update"])/60;
$timeleft = ($prefs["refresh-time"]-$elapsedtime);

if($timeleft > 0) {
	echo("<META HTTP-EQUIV=\"Refresh\" CONTENT=\"".(ceil($timeleft)*60)."; URL=$refreshurl\">");
} elseif ($prefs["refresh-time"]) {
	redirect("$refreshurl");
}

/* load total size */
$totalused = 0;
while(list($box,$info) = each($sess["headers"])) {
	for($i=0;$i<count($info);$i++)
		$totalused += $info[$i]["size"];
}



$smarty->assign("umTotalUsed",ceil($totalused/1024));
$quota_enabled = ($quota_limit)?1:0;
$smarty->assign("umQuotaEnabled",$quota_enabled);
$smarty->assign("umQuotaLimit",$quota_limit);
$usageGraph = get_usage_graphic(($totalused/1024),$quota_limit);
$smarty->assign("umUsageGraph",$usageGraph);

$exceeded = (($quota_limit) && (ceil($totalused/1024) >= $quota_limit));

// sorting arrays..


$smarty->assign("umAttachArrow",$attach_arrow);
$smarty->assign("umSubjectArrow",$subject_arrow);
$smarty->assign("umFromArrow",$fromname_arrow);
$smarty->assign("umDateArrow",$date_arrow);
$smarty->assign("umSizeArrow",$size_arrow);


$nummsg = count($headers);
if(!isset($pag) || !is_numeric(trim($pag))) $pag = 1;

$reg_pp    = $prefs["rpp"];
$start_pos = ($pag-1)*$reg_pp;
$end_pos   = (($start_pos+$reg_pp) > $nummsg)?$nummsg:$start_pos+$reg_pp;

if(($start_pos >= $end_pos) && ($pag != 1)) redirect("messages.php?folder=$folder&pag=".($pag-1)."&tid=$tid&lid=$lid\r\n");

echo($nocache);

$jsquota = ($exceeded)?"true":"false";
$jssource = "
<script language=\"JavaScript\">
no_quota  = $jsquota;
quota_msg = '".ereg_replac
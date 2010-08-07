<html>
	<script language="javascript1.1">

function init() {
	if (typeof(parent.image_loc) == "undefined") {
		parent.image_loc = ipreview.location;
	}
}

function replaceString(oldS,newS,fullS) {
	// Replaces oldS with newS in the string fullS
	for (var i=0; i<fullS.length; i++) {
 		if (fullS.substring(i,i+oldS.length) == oldS) {
			fullS = fullS.substring(0,i)+newS+fullS.substring(i+oldS.length,fullS.length);
		}
	}
 	return fullS;
}

function insert_image() {
	//insert the image into the activedit control '/activedit/demo/images'
	var sImg = replaceString("../../", "", parent.image_loc);
	sImg = replaceString("//", "/", sImg);
	//alert(sImg);
	//eval(parent).opener.onImage(parent.image_loc, 'media' , imgfrm.bdr.value, imgfrm.algn.value, imgfrm.alt.value, 1);
	eval(parent).opener.onImage(sImg, 'media' , imgfrm.bdr.value, imgfrm.algn.value, imgfrm.alt.value, 1);
	val = close();
}
	</script>
	<style type="text/css">
		A { color : 1d039e; text-decoration : none; } A:Hover { text-decoration : 
		underline; }
	</style>
	<body link="#1d039e" vlink="#1d039e" onload="init();" style="border: 1px outset; background: menu;">
		<span style="FONT-FAMILY: Verdana, Geneva, Arial, Helvetica, sans-serif; FONT-SIZE: 14px">
			<br>
			<iframe name="ipreview" id="ipreview" frameborder="0" style="BORDER-BOTTOM: gray 1px solid; BORDER-LEFT: gray 1px solid; BORDER-RIGHT: gray 1px solid; BORDER-TOP: gray 1px solid" height="225" width="320" src="../../media/logo.gif"></iframe>
			<span style="FONT-SIZE: 10px">
				<br>
				<br>
			</span><span style="FONT-SIZE: 12px">
				<form name="imgfrm" style="POSITION: absolute">
					<b>Border: </b><input name="bdr" style="BORDER-BOTTOM: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid" value="0" size="2">
					<b>Align: </b><select name="algn">
						<option value="" selected>
							&nbsp;</option>
						<option value="absmiddle">
							absmiddle</option>
						<option value="middle">
							middle</option>
						<option value="bottom">
							bottom</option>
						<option value="top">
							top</option>
						<option value="left">
							left</option>
						<option value="right">
							right</option>
						<option value="baseline">
							baseline</option>
						<option value="texttop">
							texttop</option>
						<option value="absbottom">
							absbottom</option>
					</select><b>Alt: </b><input name="alt" style="BORDER-BOTTOM: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid" size="5">
			</span>
			<br>
			<BR>
			<center>
				<A href="javascript:insert_image()"><IMG align="absMiddle" alt="" border="0" height="22" src="media/down.gif" width="23"></A>&nbsp;<A href="javascript:insert_image()"><b>Insert 
						Image</b></A> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A href="javascript:parent.close()"><IMG align="absMiddle" alt="Close This window" border="0" height="17" src="media/delete.gif" width="18"></A>&nbsp;<A href="javascript:parent.close()"><B>Cancel</B></A>
			</center>
			</FORM> </span>
		<br>
		<br>
		<br>
		<br>
	</body>
</html>

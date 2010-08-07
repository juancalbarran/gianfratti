// <script>

//Need this function before any cold fusion
function ae_onerror(msg, detail, popup) {
	
	errwin = this;
	if(popup) errwin = window.open("","","scrollbars=yes,width=500,height=400,resizable=yes", true);
	
	
	errwin.document.write("<HR><H3>Error Occurred While Processing Request</H3><P><TABLE BORDER><TR><TD><H4>Error Diagnostic Information</H4><P>");
	errwin.document.write(msg);
	errwin.document.write(detail);
	errwin.document.write("<P><P></TD></TR></TABLE><P><HR>");
}


////////////////////////////
//    global variables    //
////////////////////////////


//debugging parameter
errlevel = 0;

var ae_olddocmd; //saves the old ondocument click function pointer 

aeObjects = new Array(); //needs to be global for spell checker
var aeFieldnames = new Array();
var DHTMLSafe; // This is the active editor
var ae_count;
var ae_hot; //This tells which Activedit the context menu is for
var ae_sourceview=false; //Are we viewing source?
var ae_oldfontfamily=''; //Store the old font family for inline view source 
var ae_oldfontsize=''; //Store the old font size for inline view source
var ae_HTMLMode = new Array(); //true if current control is in html mode


var tableparamobj=new ActiveXObject("DEInsertTableParam.DEInsertTableParam");
tableparamobj.NumRows=3;
tableparamobj.NumCols=3;   
tableparamobj.Caption="";
tableparamobj.TableAttrs="border=0 cellpadding=0 cellspacing=0 width=75%";
tableparamobj.CellAttrs="";


var is_ie4 = ((parseInt(navigator.appVersion)  == 4) && (navigator.userAgent.toLowerCase().indexOf("msie 5")==-1) && (navigator.userAgent.toLowerCase().indexOf("msie 6")==-1) );

////////////////////////////
//initialization function //
////////////////////////////

function ae_initialize(num) {
	//initializes the control
	ae_count=num;


	thisContentItem=eval("document.all.ae_tx_content"+num);
	thisForm=thisContentItem;
	while(thisForm.tagName!="FORM"&&thisForm.tagName!="HTML") {
		thisForm=thisForm.parentElement; 
	}
	
	if(thisForm.tagName!="HTML") {		
		DHTMLSafe = eval("thisForm.DHTMLSafe"+num);
		aeObjects[num] = DHTMLSafe;
		aeObjects[thisContentItem.name] = DHTMLSafe;
		aeFieldnames[num] = thisContentItem.name;		

		//bind onSubmit event to ae_onSubmit()
		thisForm.onsubmit = ae_onSubmit;
	}
	else {
			alert("Editor must be contained in a form.", "", true);
		return;
	}

	DHTMLSafe.NewDocument();
	DHTMLSafe.BaseURL=ae_baseurl[num];
 	set_tbstates(num);
	ae_onLoad(num);
	ae_HTMLMode[num] = false;
}



function ae_onLoad(num) {

	DHTMLSafe=aeObjects[num];

	if(DHTMLSafe.Busy) {
		setTimeout("ae_onLoad("+num+");", 100);	
		return;
	}
	
	if(num==1) window.onunload = ae_onUnload;
	
	if(ae_defaultfont[num].length) 
		DHTMLSafe.DOM.body.style.font=ae_defaultfont[num];

	if(oSel=eval('document.all.oQuickFormat'+num)) { //Populate QuickFormat Box
		var f=new ActiveXObject("DEGetBlockFmtNamesParam.DEGetBlockFmtNamesParam");
	    DHTMLSafe.ExecCommand(DECMD_GETBLOCKFMTNAMES,OLECMDEXECOPT_DODEFAULT,f);

		vbarr = new VBArray(f.Names);
		arr = vbarr.toArray();
		
		for (var i=0;i<arr.length;i++) {
			oOption = document.createElement("OPTION");
			oSel.options.add(oOption);
			oOption.text=arr[i];
			oOption.name=arr[i];
		}

	}
		
	thisContentItem=eval("document.all.ae_tx_content"+num);

	if(thisContentItem.value.length)
		aeObjects[num].DOM.body.innerHTML = thisContentItem.value;	
	else
		aeObjects[num].DOM.body.innerHTML = " ";

	set_tbstates(num);
	if(typeof(aeapi_local_onLoad)=='function')
		aeapi_local_onLoad(DHTMLSafe, aeFieldnames[num]);
	if (typeof(aeapi_onLoad)=='function')
		aeapi_onLoad(DHTMLSafe, aeFieldnames[num]);
		
}

function ae_onUnload() {
	var ae_content = "";
	var i;
	
	for(i=1;i<=ae_count;i++) {
		DHTMLSafe=aeObjects[i];
		thisContentItem = eval("document.all.ae_tx_content"+i);

		if(ae_sourceview) ae_editsourceinline(i,false);
		var content = DHTMLSafe.DOM.body.innerHTML;
		
		thisContentItem.value = content;
	}
}
////////////////////////////
//   event listeners      //
////////////////////////////

function ae_onSubmit() {
	var ae_content = "";
	var i;

	for(i=1;i<=ae_count;i++) {
		DHTMLSafe=aeObjects[i];
		if(ae_sourceview) ae_editsourceinline(i,false);
		thisContentItem = eval("document.all.ae_tx_content"+i);

		if(typeof(aeapi_local_onBeforeSave)=='function')
			ae_content = aeapi_local_onBeforeSave(DHTMLSafe, aeFieldnames[i]);
		else if (typeof(aeapi_onBeforeSave)=='function')
			ae_content = aeapi_onBeforeSave(DHTMLSafe, aeFieldnames[i]);
		else
			ae_content = ae_onBeforeSave(DHTMLSafe, aeFieldnames[i]);
		thisContentItem.value = ae_content;
	}
}

function ae_onkeypress(num) {
	//onkeypress event listener
	
	var sel;

	DHTMLSafe=aeObjects[num];

	if(ae_breakonenter[num]||ae_sourceview) {
		//make enter insert <br> and ctrl+enter insert <p>
		switch(DHTMLSafe.DOM.parentWindow.event.keyCode) {
			case 10:
				DHTMLSafe.DOM.parentWindow.event.keyCode = 13;			
				break;
			case 13:
				if(DHTMLSafe.QueryStatus(DECMD_UNORDERLIST)!=DECMDF_LATCHED) {
					DHTMLSafe.DOM.parentWindow.event.returnValue = false;		
					sel = DHTMLSafe.DOM.selection.createRange();
					sel.pasteHTML("<BR>");
					sel.collapse(false);
					sel.select();
				}
				break;
			default:
				break;
		}
	}
}


// cancels the table selector when you click on DHTMLSafe
function ae_onmousedown(num) {
	if(typeof(document.all.frame1) != "undefined") {
		if(document.all.frame1.style.visibility == "visible") {
			cancelTable(false);
			return;
		}
	}
}

function ae_onclick(num) {
	set_tbstates(num);
}

function ae_ondisplaychange(num) {
	//if(DHTMLSafe.Busy) return;
 	set_tbstates(num);
}

function ae_onmenuaction(itemIndex, num) {
	ae_onCommand(ContextMenu[itemIndex].cmdId, num);
}


////////////////////////////
//    member functions    //
////////////////////////////

//perform basic operational commands

function ae_onCommand(cmdId, num) {

	//no buttons should work in html mode
	if (ae_HTMLMode[num]) { return; }

	if(typeof(num)=="undefined") {
		num=ae_hot;
	}
	DHTMLSafe=aeObjects[num];
	
	if(cmdId==null) cmdid=eval(window.event.srcElement.cid);
	else cmdid=cmdId;

	doFocus=true;	
		
	switch(parseInt(cmdid)) {
		case DECMD_IMAGE:
			DHTMLSafe.DOM.selection.createRange().collapse(false);
			onImagewin(num);
			doFocus=false;
			break;
		case DECMD_INSERTTABLE:
			onTableWin(num);
			doFocus=false;
			break;
		case DECMD_EDITSOURCE:
			if(tabview[num]) ae_editsourceinline(num);
			else { 
				ae_editsource(num);
				doFocus=false;
			}
			break;
		case DECMD_ABOUT:
			ae_about();
			doFocus=false;
			break;
		case DECMD_HELP:
			ae_help();
			doFocus=false;
			break;
		case DECMD_TOGGLE_DETAILS:
			ae_onToggleDetails(null, num);
			break;
		case DECMD_SAVE:
			//alert(DHTMLSafe1);
			//alert(frame1.document.body.innerHTML);
			//ae_submit_form('ae_form', '#attributes.fieldname#');
			eval(contentfromopener + " = DHTMLSafe.DOM.body.innerHTML;");
			self.close();
			break;
		case DECMD_EDITTABLE:
			editTableWin(num);
			doFocus=false;
			break;
		case DECMD_HYPERLINK:
			ae_hyperlinkwin(num);
			doFocus=false;
			break;
		case DECMD_SPELLCHECK:
			ae_spellcheckwin(num);
			doFocus=false;
			break;
		case DECMD_SPECIAL_CHARS:
			ae_specialchars();
			doFocus=false;
			break;
		default:
			if(DHTMLSafe.QueryStatus(cmdid)!=DECMDF_DISABLED) {
				DHTMLSafe.ExecCommand(cmdid, OLECMDEXECOPT_DODEFAULT);
			}
			break;
	}
	if (doFocus) DHTMLSafe.focus();
	
}


function ae_onToggleDetails(bVal, num) {
	//Show hidden Tags as glyphs
	DHTMLSafe=aeObjects[num];
	
	if (bVal == null) {
		DHTMLSafe.ShowDetails = !(DHTMLSafe.ShowDetails);
	}
	else {
		DHTMLSafe.ShowDetails = bVal;
	}
}

function editTableWin(num) {

	editTbl = window.open(inc + 'edittable.htm', "editTbl", "directories=no,height=310,width=350,location=no,menubar=no,status=no,toolbar=no");
	editTbl.focus();
}

function onTableWin(num) {	
	DHTMLSafe=aeObjects[num];
		if(DHTMLSafe.QueryStatus(DECMD_INSERTTABLE) == DECMDF_DISABLED) 
		{
		   	DHTMLSafe.focus();
		 		return;
		}	
		ae_hot = num;


		arr = window.open(inc + "table.htm", "arr", "Width=450, Height=225");
		arr.focus();
}

//dropdown table selector
function onTable(num) {
  	//open's table dialog window
	 //if it's in a table

    //no buttons should work in html mode
	if (ae_HTMLMode[num]) { return; }
	 
	DHTMLSafe=aeObjects[num];
	
	if(DHTMLSafe.QueryStatus(DECMD_INSERTTABLE) == DECMDF_DISABLED) 
	{
	   	DHTMLSafe.focus();
  		return;
	}
	
	if(	document.all.frame1.style.visibility == "visible" ) {
		cancelTable();
		return;
	}
	
	var str = "<div id=\"tblsel\" style=\"background-color:blue;position:absolute;";
	str = str + "width:0;height:0;z-index:-1;\"></div>";
	str = str + makeTable(4, 5);
	str = str + "<div style=\"text-align:center\" id=\"tblstat\">1 by 1 Table</div>";
	
	var ifrm = document.frames("frame1");
	var obj=eval("document.all.ae_tbtn"+num);
	var x=0;
	var y=0;

	ifrm.document.body.innerHTML=str;
	

	while(obj.tagName!="BODY") {

		x+=obj.offsetLeft;
		y+=obj.offsetTop;
		obj=obj.offsetParent;

	}	
	
	document.all.frame1.style.pixelTop = y + 24;
	document.all.frame1.style.pixelLeft = x;
	document.all.frame1.style.pixelWidth = 0;
	document.all.frame1.style.pixelHeight = 0;
	document.all.frame1.style.visibility = "visible";
	//bind events
	ae_hot=num;
	document.frames("frame1").document.body.onmouseover = paintTable;	
	document.frames("frame1").document.body.onclick = insertTable;
	if(typeof(document.onmousedown)=="function")
		ae_olddocmd = document.onmousedown;
	else ae_olddoccmd=null;
	
	document.onmousedown = cancelTable;
	DHTMLSafe.onmousedown = cancelTable;
	event.cancelBubble = true;

	ifrm.document.body.onselectstart=new Function("return false;");
	

	document.all.frame1.style.pixelWidth = ifrm.document.all.oTable.offsetWidth + 3
	document.all.frame1.style.pixelHeight = ifrm.document.all.oTable.offsetHeight + 3 +
		ifrm.document.all.tblstat.offsetHeight;

}

// Does the insert table for table selector
function insertTable(rows, cols, attrs, num) {
	//drop down table implementation

	
	
	if(typeof(num)=="undefined")
		num=ae_hot;

	DHTMLSafe=aeObjects[num];
	
	if (typeof(rows) == "undefined") {
		
		var se = document.frames('frame1').window.event.srcElement;
	  
		if(se.tagName!='TD') {
			cancelTable();
			return;
		}
			
		tableparamobj.NumRows = se.parentElement.rowIndex + 1;
		tableparamobj.NumCols = se.cellIndex + 1;
	  	tableparamobj.TableAttrs = "border=1 cellPadding=0 cellSpacing=0 width=75%";
		cancelTable();
	}
	else {
		tableparamobj.NumRows = rows;
		tableparamobj.NumCols = cols;
		tableparamobj.TableAttrs = attrs;
	}
	DHTMLSafe.ExecCommand(DECMD_INSERTTABLE,OLECMDEXECOPT_DODEFAULT, tableparamobj);    
	DHTMLSafe.focus();
}

//Paints the table selector
function paintTable() {

	var se = document.frames('frame1').window.event.srcElement;
	
	var sr, sc, tbl, fAll;
			
	fAll = document.frames('frame1').document.all;
	
	if(se.tagName!='TD') {
				sr = 0;
		sc = 0;
		var str="&nbsp;Cancel";
		fAll.tblsel.style.width = 0;
		fAll.tblsel.style.height = 0;
		return;
	}
	
	tbl=fAll.oTable;
	sr=se.parentElement.rowIndex;
	sc=se.cellIndex;
	
	//Expand the table selector if its too small
	if(!is_ie4) {
		if(tbl.rows.length == sr+1) {
			var r = tbl.insertRow(-1);
			var td;
			
			for(var i=0;i<tbl.rows(1).cells.length;i++) {
				td = r.insertCell(-1);
				td.innerHTML = "&nbsp;";
				td.style.pixelWidth = 20;
				td.style.pixelHeight = 20;
	
			}
				var bdy = document.frames("frame1").document.body;			
				var ifrm = document.frames("frame1");
				
				document.all.frame1.style.pixelWidth = ifrm.document.all.oTable.offsetWidth + 3
				document.all.frame1.style.pixelHeight = ifrm.document.all.oTable.offsetHeight + 3 +
					ifrm.document.all.tblstat.offsetHeight;
		}
		if(tbl.rows(1).cells.length == sc+1) {
			var td;
			for(var i=0;i<tbl.rows.length;i++) {
				td = tbl.rows(i).insertCell(-1);
				td.innerHTML = "&nbsp;";
				td.style.pixelWidth = 20;
				td.style.pixelHeight = 20;
			}			
				var bdy = document.frames("frame1").document.body;
				document.all.frame1.style.pixelWidth = bdy.createTextRange().boundingWidth + 5;
				document.all.frame1.style.pixelHeight = bdy.createTextRange().boundingHeight + 5;
		}
	}
	
	var str=(sr+1) + " by " + (sc+1) + " Table";
	fAll.tblsel.style.width = se.offsetWidth*(sc+1)+5;
	fAll.tblsel.style.height = se.offsetHeight*(sr+1)+5;
	
	fAll.tblstat.innerHTML = str;
}

//makes table html
function makeTable(rows, cols) {
	var a, b, str, n;
	
	str = "<table style=\"table-layout:fixed;border-style:solid; cursor:default;\" "; 
	str = str + "id=\"oTable\" cellpadding=\"0\" ";
	str = str + "cellspacing=\"0\" cols=" + cols;
	str = str + " border=6>\n";

	for (a=0;a<rows;a++) {
		str = str + "<tr>\n";
		for(b=0;b<cols;b++) {			
			str = str + "<td width=\"20\">" 
			str = str + "&nbsp;</td>\n";	
		}	
		str = str + "</tr>\n";
	}
	str = str + "</table>"
	return str;
}

//Closes table selector iframe and replaces document mousedown
function cancelTable(a) {
	document.onmousedown=null;
	document.all.frame1.style.visibility = "hidden";
	document.all.frame1.style.pixelWidth = 0;
	document.all.frame1.style.pixelHeight = 0;

	if(a==false) return;

	if(typeof(ae_olddocmd)=="function") {
		ae_olddocmd(false);
		document.onmousedown = ae_olddocmd;
	}
	ae_olddocmd = null;

	//Set DropDownTable IFrame to small
	document.all.frame1.style.pixelWidth = 10;
	document.all.frame1.style.pixelHeight = 10;
	
}

function onImagewin(num) {
	//if the focus never touched the control, you get an error, so lets touch the control
	DHTMLSafe=aeObjects[num];
	
	DHTMLSafe.focus();
	if (typeof(ae_imgwin) == "undefined" || ae_imgwin.closed) { //short circuit eval
		//spawn image window
		var szURL;
		
		szURL= "filepicker.asp?";
		szURL+="imagedata=";
		szURL+=ae_imagedata[num];
		szURL+="&imageurl=";
		szURL+=ae_imageurl[num];
		ae_imgwin = window.open(szURL ,"ae_imgwin","scrollbars=yes,width=490,height=340, resizable=yes");

	}
	ae_imgwin.focus();
}

function onImage(u, base_url, iborder, ialign, ialt, num) {
	//insert the image
	//DHTMLSafe.ExecCommand(DECMD_IMAGE,OLECMDEXECOPT_DONTPROMPTUSER,u);
	DHTMLSafe=aeObjects[num];
	
	var img = "<img src=\"" + u + "\" border=\"" + iborder + "\" align=\"" + ialign + "\" alt=\"" + ialt + "\">";
	DHTMLSafe.DOM.selection.createRange().pasteHTML(img);
	ae_imgwin.close();
}


function ae_onBeforeSave(aeObject) {
	//for images
	for (var i=0;i<aeObject.DOM.images.length;i++) {
		hs=aeObject.DOM.images[i].getAttribute("STYLE",0).height;
		ws=aeObject.DOM.images[i].getAttribute("STYLE",0).width;
		
		if(hs.length) {
			aeObject.DOM.images[i].removeAttribute("HEIGHT", 0); 			
			aeObject.DOM.images[i].setAttribute("HEIGHT", replaceString("px", "", hs),0); 
			aeObject.DOM.images[i].getAttribute("STYLE",0).removeAttribute("HEIGHT",0);
		}
		if(ws.length) {
			aeObject.DOM.images[i].removeAttribute("WIDTH", 0);	
			aeObject.DOM.images[i].setAttribute("WIDTH", replaceString("px", "", ws),0); 
			aeObject.DOM.images[i].getAttribute("STYLE",0).removeAttribute("WIDTH",0);
		}
	}

	//for tables
	for (var k=0;k<aeObject.DOM.all.tags("TABLE").length;k++) {
		hs=aeObject.DOM.all.tags("TABLE").item(k).getAttribute("STYLE",0).height;
		ws=aeObject.DOM.all.tags("TABLE").item(k).getAttribute("STYLE",0).width;
		
		if(hs.length) {
			aeObject.DOM.all.tags("TABLE").item(k).removeAttribute("HEIGHT", 0); 			
			aeObject.DOM.all.tags("TABLE").item(k).setAttribute("HEIGHT", replaceString("px", "", hs),0); 
			aeObject.DOM.all.tags("TABLE").item(k).getAttribute("STYLE",0).removeAttribute("HEIGHT",0);
		}
		if(ws.length) {
			aeObject.DOM.all.tags("TABLE").item(k).removeAttribute("WIDTH", 0);	
			aeObject.DOM.all.tags("TABLE").item(k).setAttribute("WIDTH", replaceString("px", "", ws),0); 
			aeObject.DOM.all.tags("TABLE").item(k).getAttribute("STYLE",0).removeAttribute("WIDTH",0);
		}
	}
		
	//use the DOM to filter out just what's inside the body

	var content = aeObject.DOM.body.innerHTML;
	if(content.length) {
		content = aeObject.FilterSourceCode(content);
	}

	//get rid of "the strange character" 
	//note: replaceString() is an activedit specific function
	replaceString("&#65279;", " ", content); 
	
	return content;
}

function ae_submit_form(obj, field) {
	//var ae_content = "";
	var i;	
	for(i=1;i<=ae_count;i++) {	
		DHTMLSafe=aeObjects[i];
		if (typeof(aeapi_local_onBeforeSave) == "function") {
			var ae_content = aeapi_local_onBeforeSave(DHTMLSafe, aeFieldnames[num]);
		}
		else if (typeof(aeapi_onBeforeSave) == "function") {
			var ae_content = aeapi_onBeforeSave(DHTMLSafe, aeFieldnames[num]);
		}
		else {
			var ae_content = ae_onBeforeSave(DHTMLSafe, aeFieldnames[num]);
		}
		//update the form value so it gets submitted
		eval(obj).elements[element_idx].value = ae_content;
	}
	//submit the form
	eval(obj).submit();
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
function ae_help() {
	//show help dialog
	window.showModalDialog(inc + "help.htm","","dialogHeight: 380px; dialogWidth: 350px; dialogTop: 150px; dialogLeft: 150px; center: Yes; help: No; resizable: No; status: No;");
}
function ae_about() {
	//show about dialog
	window.showModalDialog(inc + "about.htm","","dialogHeight: 260px; dialogWidth: 400px; dialogTop: 150px; dialogLeft: 150px; center: Yes; help: No; resizable: No; status: No;");
}

function ae_editsource(num) {
	//popup a window to edit document source
	DHTMLSafe=aeObjects[num];
	DHTMLSafe.DOM.selection.empty();

	codewin = window.open(inc + "editsource.htm","codewin","scrollbars=no,width=485,height=475");
}


function ae_editsourceinline(num, bVal) {
	
	//Toggle the inline source view
	DHTMLSafe=aeObjects[num];

	thisContentItem=eval("document.all.ae_tx_content"+num);
	
	if(ae_HTMLMode[num]==bVal) return;

	DHTMLSafe.DOM.selection.empty();
	
	if(ae_HTMLMode[num]) { //Coming out of view source
		document.images["normaltab"+num].src=img_normaltabon.src;
		document.images["htmltab"+num].src=img_htmltaboff.src;
		
		if(ae_defaultfont[num].length) 
			DHTMLSafe.DOM.body.style.font=ae_defaultfont[num];
		else {
			DHTMLSafe.DOM.body.style.fontFamily="";	
			DHTMLSafe.DOM.body.style.fontSize="";
		}
		thisContentItem.value=DHTMLSafe.DOM.body.createTextRange().text;
		DHTMLSafe.DOM.body.innerHTML = thisContentItem.value;	
		ae_HTMLMode[num] = false;
		//ae_sourceview=false;	
	}
	else { //Going into view source
		var re=/((<br>)+)/ig;

		document.images["normaltab"+num].src=img_normaltaboff.src;
		document.images["htmltab"+num].src=img_htmltabon.src;

		// Set the font to fixed width
		DHTMLSafe.DOM.body.style.fontFamily = "Courier New";
		DHTMLSafe.DOM.body.style.fontSize = "10pt";
		
		thisContentItem.value=DHTMLSafe.DOM.body.innerHTML;
		DHTMLSafe.DOM.body.innerHTML = "";
		DHTMLSafe.DOM.body.createTextRange().text = thisContentItem.value.replace(re, "$1\n");
		ae_HTMLMode[num] = true;
		//ae_sourceview=true;

	}


}

function ae_specialchars() {
	var szURL = inc + "specialchars.htm";
	ae_specialwin = window.open(szURL ,"ae_specialwin",",width=390,height=260, resizable=yes",true);
}


function ae_quickfont(num) {

	//no buttons should work in html mode
	if (ae_HTMLMode[num]) { return; }

	DHTMLSafe=aeObjects[num];

	oSel=eval('document.all.oQuickFont'+num);	
	DHTMLSafe.ExecCommand(DECMD_SETFONTNAME, OLECMDEXECOPT_DODEFAULT, oSel.options[oSel.selectedIndex].name);
	DHTMLSafe.focus();

}

function ae_quickfontsize(num) {

	//no buttons should work in html mode
	if (ae_HTMLMode[num]) { return; }

	DHTMLSafe=aeObjects[num];

	oSel=eval('document.all.oQuickFontSize'+num);	
	DHTMLSafe.ExecCommand(DECMD_SETFONTSIZE, OLECMDEXECOPT_DODEFAULT, oSel.options[oSel.selectedIndex].value);
	DHTMLSafe.focus();

}

function ae_quickformat(num) {

	//no buttons should work in html mode
	if (ae_HTMLMode[num]) { return; }
	
	DHTMLSafe=aeObjects[num];

	oSel=eval('document.all.oQuickFormat'+num);	
	DHTMLSafe.ExecCommand(DECMD_SETBLOCKFMT, OLECMDEXECOPT_DODEFAULT, oSel.options[oSel.selectedIndex].name);

	DHTMLSafe.focus();

}

function ae_hyperlinkwin(num) {
	ae_hot=num;
	DHTMLSafe=aeObjects[num];
	
	DHTMLSafe.focus();

	//DHTMLSafe.ExecCommand(cmdid, OLECMDEXECOPT_DODEFAULT); return;
	
	if(DHTMLSafe.DOM.selection.type=="Control") {
		var el=DHTMLSafe.DOM.selection.createRange().commonParentElement();
		var tr = DHTMLSafe.DOM.body.createTextRange();
		tr.moveToElementText(el);
		tr.select();
	}
	
	if (typeof(ae_linkwin) == "undefined" || ae_linkwin.closed) { //short circuit eval
		//spawn image window
		var szURL=inc + "hyperlink.htm";

		ae_linkwin = window.open(szURL ,"ae_linkwin","scrollbars=auto,width=360,height=190, resizable=yes",true);
	}
	ae_linkwin.focus();
}

function ae_hyperlink(num, iHref, iTarget, iStyle, iClass, iName) {
	DHTMLSafe=aeObjects[num];

	var uid="ae"+Math.random().toString();

	if(iHref=="" && !iName.length) { // Unlink
		if(DHTMLSafe.QueryStatus(DECMD_UNLINK)==DECMDF_ENABLED)
			DHTMLSafe.ExecCommand(DECMD_UNLINK);
	}
	else {
		var trSel=DHTMLSafe.DOM.selection.createRange();
		if(trSel.compareEndPoints("StartToEnd",trSel)==0) { // Need a brand new link
			txtHTML="<A href=\""+iHref+"\" ";
			if(iTarget.length)
				txtHTML+="target=\""+iTarget+"\" ";
			if(iStyle.length)
				txtHTML+="style=\""+iStyle+"\" ";
			if(iClass.length)
				txtHTML+="class=\""+iClass+"\" ";
			if(iName.length)
				txtHTML+="name=\""+iName+"\" ";
			txtHTML+=">"+iHref+"</a>";
			
			trSel.pasteHTML(txtHTML);
		}
		else { //Update existing link or link plain text
			DHTMLSafe.ExecCommand(DECMD_HYPERLINK,OLECMDEXECOPT_DONTPROMPTUSER,uid);
	
			var coll=DHTMLSafe.DOM.all.tags("A");
	
			for(i=0;i<coll.length;i++) {
				if(coll[i].href==uid) {
					coll[i].href=iHref;
					if(iTarget.length) coll[i].target=iTarget;
					else coll[i].removeAttribute("TARGET",0);
						
					if(iStyle.length) coll[i].style.cssText=iStyle;
					else {
						coll[i].style.cssText="";
					}
					
					if(iClass.length) coll[i].className=iClass;
					else {
						coll[i].className="";
					}
				}
			}
		}
	}

	DHTMLSafe.focus();
}

function ae_spellcheckwin(num) {

	
	if (typeof(ae_spellwin) == "undefined" || ae_spellwin.closed) { //short circuit eval
		var szURL=inc + "spellchecker/window.cfm?jsvar=aeObjects["+num+"].DOM.body.innerHTML";
		ae_spellwin = window.open(szURL, null, "height=230,width=450,status=no,toolbar=no,menubar=no,location=no");
	}

	ae_spellwin.focus();
}

//////////////////////////
//context menu functions//
//////////////////////////

//right click menu code

function ShowMenu(num) {

	var menuStrings = new Array();
	var menuStates = new Array();

	var state;
	var i;
	var idx = 0;

	ae_hot=num;
  
	DHTMLSafe=aeObjects[num];
	
	// Rebuild the context menu. 
	ContextMenu.length = 0;
	
	// Always show general menu
  
	if(alloweditsource[num]) i=0;
	else i=2;
  
	for (; i<GeneralContextMenu.length; i++) {
		ContextMenu[idx++] = GeneralContextMenu[i];
	}

	// Is the selection inside a table? Add table menu if so
	if (DHTMLSafe.QueryStatus(DECMD_INSERTROW) != DECMDF_DISABLED) {
		for (i=0; i<TableContextMenu.length; i++) {
			ContextMenu[idx++] = TableContextMenu[i];
		}
	}
	
	
	// Set up the actual arrays that get passed to SetContextMenu
	for (i=0; i<ContextMenu.length; i++) {
	
		menuStrings[i] = ContextMenu[i].string;

		if ((menuStrings[i] != MENU_SEPARATOR) && (ContextMenu[i].cmdId < 6000)) {
			state = DHTMLSafe.QueryStatus(ContextMenu[i].cmdId);
		}
		else {
			state = DECMDF_ENABLED;
		}

		if (state == DECMDF_DISABLED || state == DECMDF_NOTSUPPORTED) {
			menuStates[i] = OLE_TRISTATE_GRAY;
		}
		else if (state == DECMDF_ENABLED || state == DECMDF_NINCHED) {
			menuStates[i] = OLE_TRISTATE_UNCHECKED;
		}
		else { // DECMDF_LATCHED
			menuStates[i] = OLE_TRISTATE_CHECKED;
		}
		
		//CUSTOM Attribute Toggle Glyphs
		if (ContextMenu[i].cmdId == DECMD_TOGGLE_DETAILS) {
			if (DHTMLSafe.ShowDetails) {
				menuStates[i] = OLE_TRISTATE_CHECKED;
			}
			else {
				menuStates[i] = OLE_TRISTATE_UNCHECKED;
			}	
		}
		
		if(ContextMenu[i].cmdId == DECMD_EDITSOURCE) {
			if(ae_sourceview) {
				menuStates[i] = OLE_TRISTATE_CHECKED;							
			}
			else {
				menuStates[i] = OLE_TRISTATE_UNCHECKED;
			}	
		}
		
	}
	
	// Set the context menu
	DHTMLSafe.SetContextMenu(menuStrings, menuStates);
}



function ContextMenuItem(string, cmdId) {
	this.string = string;
	this.cmdId = cmdId;
}

function QueryStatusItem(command, element) {
	this.command = command;
	this.element = element;
}


////////////////////////////
//Global Menu Declarations//
////////////////////////////

var MENU_SEPARATOR = "";
var ContextMenu = new Array();
var GeneralContextMenu = new Array();
var TableContextMenu = new Array();


//define context elements

	var genId = 0; //index ids
	var tblId = 0;

	GeneralContextMenu[genId++] = new ContextMenuItem("Edit Source", DECMD_EDITSOURCE);
	GeneralContextMenu[genId++] = new ContextMenuItem(MENU_SEPARATOR, 0);

	if (!is_ie4) {
	  	//no edit table in IE 4
		TableContextMenu[tblId++] = new ContextMenuItem(MENU_SEPARATOR, 0);
	  	TableContextMenu[tblId++] = new ContextMenuItem("Edit Table", DECMD_EDITTABLE);
	}

	TableContextMenu[tblId++] = new ContextMenuItem(MENU_SEPARATOR, 0);
	TableContextMenu[tblId++] = new ContextMenuItem("Insert Row", DECMD_INSERTROW);
	TableContextMenu[tblId++] = new ContextMenuItem("Delete Rows", DECMD_DELETEROWS);
	TableContextMenu[tblId++] = new ContextMenuItem(MENU_SEPARATOR, 0);
	TableContextMenu[tblId++] = new ContextMenuItem("Insert Column", DECMD_INSERTCOL);
	TableContextMenu[tblId++] = new ContextMenuItem("Delete Columns", DECMD_DELETECOLS);
	TableContextMenu[tblId++] = new ContextMenuItem(MENU_SEPARATOR, 0);
	TableContextMenu[tblId++] = new ContextMenuItem("Insert Cell", DECMD_INSERTCELL);
	TableContextMenu[tblId++] = new ContextMenuItem("Delete Cells", DECMD_DELETECELLS);
	TableContextMenu[tblId++] = new ContextMenuItem("Merge Cells", DECMD_MERGECELLS);
	TableContextMenu[tblId++] = new ContextMenuItem("Split Cell", DECMD_SPLITCELL);


	GeneralContextMenu[genId++] = new ContextMenuItem("Find", DECMD_FINDTEXT);
	GeneralContextMenu[genId++] = new ContextMenuItem("Show Details", DECMD_TOGGLE_DETAILS);
	GeneralContextMenu[genId++] = new ContextMenuItem(MENU_SEPARATOR, 0);
	GeneralContextMenu[genId++] = new ContextMenuItem("About", DECMD_ABOUT);
	GeneralContextMenu[genId++] = new ContextMenuItem("Help", DECMD_HELP);


//////////////////////
// Style Functions  //
//////////////////////

//CSS style functions for buttons

function ae_m_out(src) {
	//mouse out button style

	if(src.state==0) return;	
	if(src.state==2) { src.className="latched"; return; }
	if(src.type=="btn") {
		window.status="";
		src.className="flat";
	}
}

function ae_m_over(src) {
	//mouse over button style

	if(src.state==0) return;
	if(src.state==2) return;
	
	if(src.type=="btn") {
		//window.status=src.status;
		src.className="outset";
	}
}

function ae_m_down(src) {
	//mouse down button style

	if(src.state==0) return;
	if(src.type=="btn") {
		src.className="inset";
	}
}

function ae_m_up(src) {
	//mouse up button style

	if(src.state==0) return;
	if(src.state==2) { src.className="latched"; return; }
		
	if(src.type=="btn") {
		src.className="outset";
	}
}


function set_tbstates(num) {

	var pbtn;
	var cid;
	var state;

	DHTMLSafe=aeObjects[num];
	ae_tbar=eval("ae_tbar"+num);
	
	if(DHTMLSafe.QueryStatus(5002)!=DHTMLSafe.QueryStatus(5003)) return;

	for(var i=0;i<ae_tbar.all.length;i++) {
		pbtn= ae_tbar.all(i);

		cid=pbtn.cid;
		if(cid < 6000&&cid!=DECMD_HYPERLINK) {
			if (!is_ie4) pbtn.style.visibility="visible";
			state=DHTMLSafe.QueryStatus(cid)
	   		if(state == DECMDF_DISABLED || state == DECMDF_NOTSUPPORTED) {
				if(pbtn.state!=0) {
						pbtn.className = "disabled";
						pbtn.state = 0;

				}
			}
			else if(state == DECMDF_ENABLED || state == DECMDF_NINCHED){
				if(pbtn.state!=1) {
					pbtn.className = "flat";
					pbtn.state = 1;
				}
			}
			else {   //latched
				if(pbtn.state!=2) {
					pbtn.className = "latched";
					pbtn.state = 2;
				}
				
			}
		}
		else if(cid==6004) {
			if(DHTMLSafe.ShowDetails) {
				if(pbtn.state!=2) {
					pbtn.className = "latched";
					pbtn.state = 2;
				}
			}
			else {
				if(pbtn.state!=1) {
					pbtn.className = "flat";
					pbtn.state = 1;
				}
			}
		}
	}

	if(oSel=eval('document.all.oQuickFont'+num)){
		if(DHTMLSafe.QueryStatus(DECMD_SETFONTNAME)!=DECMDF_DISABLED&&DHTMLSafe.DOM.selection.type!="control") {
			if(oSel.disabled) oSel.disabled=false;
			fontname=DHTMLSafe.ExecCommand(DECMD_GETFONTNAME);
			if(fontname!=""&&fontname!=null) {
				fCreateNew=true;
				window.status=fontname;
				for(i=0;i<oSel.options.length;i++) {
					if(oSel.options[i].name==fontname) {
						if(!oSel.options[i].selected)
							oSel.options[i].selected=true;
						fCreateNew=false;
					}
				}

				if(fCreateNew) {
					var oOption = document.createElement("OPTION");
					oSel.options.add(oOption,0);
					oOption.text = fontname;
					oOption.name = fontname;
					oOption.selected=true;
				}
			}
			else {
				oSel.selectedIndex=-1;
			}
		}
		else {
			if(!oSel.disabled) oSel.disabled=true;
		}
	}
	
	if(oSel=eval('document.all.oQuickFontSize'+num)){
		if(DHTMLSafe.QueryStatus(DECMD_SETFONTSIZE)!=DECMDF_DISABLED&&DHTMLSafe.DOM.selection.type!="control") {
			if(oSel.disabled) oSel.disabled=false; 
			fs=DHTMLSafe.ExecCommand(DECMD_GETFONTSIZE);
			if(fs!=null&&fs!="") {
				for(i=0;i<oSel.options.length;i++) {
					if(oSel.options[i].name=="ae_fs"+fs&&!oSel.options[i].selected)
						oSel.options[i].selected=true;
				}
			}
			else {
				oSel.selectedIndex=-1;
			}

		
		}
		else {
			if(!oSel.disabled) oSel.disabled=true;
		}
	}	

	if(oSel=eval('document.all.oQuickFormat'+num)){
		if(DHTMLSafe.QueryStatus(DECMD_SETBLOCKFMT)!=DECMDF_DISABLED&&DHTMLSafe.DOM.selection.type!="control") {
			if(oSel.disabled) oSel.disabled=false;
			fmt=DHTMLSafe.ExecCommand(DECMD_GETBLOCKFMT);

			if(fmt!=""&&fmt!=null) {
				for(i=0;i<oSel.options.length;i++) {
					if(oSel.options[i].name==fmt&&!oSel.options[i].selected)
						oSel.options[i].selected=true;
				}
			}
			else {
				oSel.selectedIndex=-1;
			}
		}
		else {
			if(!oSel.disabled) oSel.disabled=true;
		}
	}	
	
}

//////////////////
//Image preloads//
//////////////////
var img_htmltabon=new Image();
img_htmltabon.src=inc+"media/htmltabon.gif";
var img_htmltaboff=new Image();
img_htmltaboff.src=inc+"media/htmltaboff.gif";
var img_normaltabon=new Image();
img_normaltabon.src=inc+"media/normaltabon.gif";
var img_normaltaboff=new Image();
img_normaltaboff.src=inc+"media/normaltaboff.gif";


// </script>
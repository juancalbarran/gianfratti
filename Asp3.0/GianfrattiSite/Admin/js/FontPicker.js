// ===================================================================
// Author: Flemming Aunel <webdesign@aunel.dk>
// WWW: http://www.aunel.dk/
// Based on ColorPicker by author: Matt Kruse <matt@mattkruse.com>
// (http://www.mattkruse.com/)
//
// NOTICE: You may use this code for any purpose, commercial or
// private, without any further permission from the author. You may
// remove this notice from your final code if you wish, however it is
// appreciated by the author if at least my web site address is kept.
//
// Please DO NOT link directly to my .js files from your site. Copy
// the files to your server and use them there. Thank you.
// ===================================================================

/* 
DESCRIPTION: This widget is used to select a font from a list of selection.
The user can click on a font to select it.

COMPATABILITY: See notes in AnchorPosition.js and PopupWindow.js.

USAGE:
// Create a new FontPicker object using DHTML popup
var fp = new FontPicker();

// Create a new FontPicker object using Window Popup
var fp = new FontPicker('window');

// Add a link in your page to trigger the popup. For example:
<A HREF="#" onClick="fp.show('pick');return false;" NAME="pick" ID="pick">Pick</A>

// If using DHTML popup, write out the required DIV tag near the bottom
// of your page.
<SCRIPT LANGUAGE="JavaScript">fp.writeDiv()</SCRIPT>

// Write the 'pickFont' function that will be called when the user clicks
// a font and do something with the value
function pickFont(font) {
	field.value = font;
	}

NOTES:
1) Requires the functions in AnchorPosition.js and PopupWindow.js

2) Your anchor tag MUST contain both NAME and ID attributes which are the 
   same. For example:
   <A NAME="test" ID="test"> </A>

3) There must be at least a space between <A> </A> for IE5.5 to see the 
   anchor tag correctly. Do not do <A></A> with no space.

4) When a FontPicker object is created, a handler for 'onmouseup' is
   attached to any event handler you may have already defined. Do NOT define
   an event handler for 'onmouseup' after you define a fontPicker object or
   the font picker will not hide itself correctly.
*/ 

function FontPicker_writeDiv() {
	document.writeln("<DIV ID=\"FontPickerDiv\" STYLE=\"position:absolute;visibility:hidden;\"> </DIV>");
	}

function FontPicker_show(anchorname) {
	this.showPopup(anchorname);
	}

function FontPicker_pickFont(Font,obj) {
	obj.hidePopup();
	if (window.pickFont) {
		pickFont(Font);
		}
	else {
		alert("You must define a function named 'pickFont' to receive the value clicked!");
		}
	}
	
// This function runs when you move your mouse over a Font block, if you have a newer browser
function FontPicker_highlightFont(c) {
	var thedoc = (arguments.length>1)?arguments[1]:window.document;
	var d = thedoc.getElementById("FontPickerSelectedFont");
	d.style.font.style = c;
	d = thedoc.getElementById("FontPickerSelectedFontValue");
	d.innerHTML = c;
	}

function FontPicker() {
	var windowMode = false;
	// Create a new PopupWindow object
	if (arguments.length==0) {
		var divname = "FontPickerDiv";
		}
	else if (arguments[0] == "window") {
		var divname = '';
		windowMode = true;
		}
	else {
		var divname = arguments[0];
		}
	
	if (divname != "") {
		var fp = new PopupWindow(divname);
		}
	else {
		var fp = new PopupWindow();
		fp.setSize(220, 530);
		}

	// Object variables
	fp.currentValue = "arial";
	
	// Method Mappings
	fp.writeDiv = FontPicker_writeDiv;
	fp.highlightFont = FontPicker_highlightFont;
	fp.show = FontPicker_show;

	// Code to populate Font picker window
	var Fonts = new Array("Arial",
						  "Courier New", 
						  "Courier",  
						  "Georgia",
						  "Helvetica", 
						  "Lucida Console", 
						  "Mono", 
						  "Modern",
						  "Pristina", 
						  "Sans-serif", 
						  "Tahoma", 
						  "Times new roman", 
						  "Trebuchet MS", 
						  "Tunga",
						  "Tw Cen MT", 
						  "Verdana",
						  "Vivaldi"
						  );
	var total = Fonts.length;
	var width = 1;
	var fp_contents = "";
	var windowRef = (windowMode)?"window.opener.":"";
	if (windowMode) {
		fp_contents += "<HTML><HEAD><TITLE>Select Font</TITLE></HEAD>";
		fp_contents += "<BODY  leftmargin=0 topmargin=0 rightmargin=0 bottommargin=0 marginwidth=0 marginheight=0><CENTER>";
		}
	fp_contents += "<TABLE WIDTH=100% BORDER=0 BGCOLOR='#F0F0F0' CELLSPACING=1 CELLPADDING=0 style=\"border: 1px black solid;\">";
	var use_highlight = (document.getElementById || document.all)?true:false;
	for (var i=0; i<total; i++) {
		if ((i % width) == 0) { fp_contents += '<TR >'; }
		if (use_highlight) { var mo = 'onMouseOver="'+windowRef+'FontPicker_highlightFont(\''+Fonts[i]+'\',window.document)"'; }
		else { mo = ""; }
		fp_contents += '<TD align="left" width=100%  onmouseover="this.style.backgroundColor=\'#EEEEEE\';" onmouseout="this.style.backgroundColor=\'#FFFFFF\';" BGCOLOR="#FFFFFF"><FONT Face="'+Fonts[i]+'" SIZE="+2"><A HREF="#" onClick="'+windowRef+'FontPicker_pickFont(\''+Fonts[i]+'\','+windowRef+'window.popupWindowObjects['+fp.index+']);return false;" '+mo+' STYLE="text-decoration:none;">'+Fonts[i]+'</A></FONT></TD>';
		if ( ((i+1)>=total) || (((i+1) % width) == 0)) { 
			fp_contents += "</TR>";
			}
		}
	// If the browser supports dynamically changing TD cells, add the fancy stuff
	if (document.getElementById) {
		var width1 = Math.floor(width/2);
		var width2 = width = width1;
		fp_contents += "<TR><TD COLSPAN='"+width1+"' BGCOLOR='#ffffff' ID='FontPickerSelectedFont'>&nbsp;</TD></tr><tr><TD COLSPAN='"+width2+"' color ='#FFFFFF' ALIGN='CENTER' ID='FontPickerSelectedFontValue'>Arial</TD></TR>";
		}
	fp_contents += "</TABLE>";
	if (windowMode) {
		fp_contents += "</CENTER></BODY></HTML>";
		}
	// end populate code

	// Write the contents to the popup object
	fp.populate(fp_contents+"\n");
	// Move the table down a bit so you can see it
	fp.offsetY = 25;
	fp.autoHide();
	return fp;
	}

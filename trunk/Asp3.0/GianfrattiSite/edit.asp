<%@ LANGUAGE = "VBScript" %>
<%
	Option Explicit
	With Response
		.Buffer = true
		.Expires = -1000
		.AddHeader "pragma", "no-cache"
	End With
%>
<!-- #include file="Engine/CFullXMLEngine.asp" -->
<%		
	Dim oFullXMLEngine
		Dim boolAccess
	
	set oFullXMLEngine = new CFullXMLEngine		
		boolAccess = oFullXMLEngine.GrantAccessEx("administrator")
		boolAccess = boolAccess or oFullXMLEngine.GrantAccessEx("editor")
		boolAccess = boolAccess or oFullXMLEngine.GrantAccessEx("member")
	set oFullXMLEngine = nothing
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Fullxml editor</title>
	</head>
	<body style="border: 0px; margin: 0px; background-color:buttonface;">
		<!--<a href=# onclick='eval(contentfromopener + " = DHTMLSafe.DOM.body.innerHTML;");self.close();'>SAVE</a>-->
		<form action="" method="post" name="editform">
			<script language="JavaScript">			
			var alloweditsource = new Array();
			var tabview = new Array();
			var ae_fieldname = new Array();				
			var ae_imagedata = new Array();				
			var ae_imageurl = new Array();
			var ae_defaultfont = new Array();				
			var ae_baseurl = new Array();				
			var ae_breakonenter = new Array();
			var inc = 'admin/editor2/';	
			

			var errlevel = 2;

			ae_breakonenter[1] = false;
			ae_baseurl[1] = document.location;
			ae_defaultfont[1] = "";
			tabview[1] = true;
			alloweditsource[1] = true;
			ae_imagedata[1] = '';				
			ae_imageurl[1] = '/media';
			
			//Get the content from the Opener INPUT value
			var contentfromopener = <%= "'" & request("input") & "'" %>;			
			</script>
			<script language="JavaScript" src="admin/editor2/dhtmled.js"></script>
			<script language="JavaScript" id="clientEventHandlersJS" src="admin/editor2/editjs.js?id=12453"></script>
			<script language="JavaScript">
			//declare global javascript variables
			if (errlevel == 2){
				//error catching
				document.write("<BR>The file editjs.js did not load properly. Make sure the the inc attribute is specified correctly<br>");
				document.write("Current Value: inc=" + inc + "<br>");
				document.write("<comment>"); // Keeps the rest of the page from displaying
			}
			</script>
			<script language="javascript" src="admin/editor2/user.js"></script>
			<STYLE type="text/css">
				.disabled {filter:mask() mask(color=buttonshadow) 
				dropshadow(offX=1,offY=1,color=buttonhighlight,positive=1);width:23;height:22;margin:1px;padding:0px;vertical-align:middle;border-width:0;visibility:visible;} 
				.flat {width:23;height:22;margin:0px;padding:0px;vertical-align:middle;border-width:1px;border-color:buttonface;border-style:solid;visibility:visible;} 
				.outset {width:23;height:22;margin:0px;padding:0px;vertical-align:middle;border:1px solid;border-left-color:buttonhighlight;border-top-color:buttonhighlight;border-right-color:buttonshadow;border-bottom-color:buttonshadow;visibility:visible;} 
				.inset {width:23;height:22;margin:0px;padding:0px;vertical-align:middle;border-width:1px;border-style:inset;visibility:visible;} 
				.latched {width:23;height:22;margin:0px;padding:0px;vertical-align:middle;border-width:1px;border-style:inset;background-color:#EEEEEE;visibility:visible;} 
				.spc {margin:0;padding:0;vertical-align:middle;}
				/* Don't allow the background color to be overridden by default style sheet*/
				TABLE.ae_tableClass {border:0px outset buttonface;cursor:default;background-color:buttonface;}
				TR.ae_trClass {background-color:buttonface;}
				TD.ae_tdClass {background-color:buttonface;} 
			</STYLE>
			<table bgcolor="red" cellpadding="0" cellspacing="0" width="750" height="450" ondragstart="window.event.returnValue=false;" onselectstart="window.event.returnValue=false;" class="ae_tableClass">
				<tr class="ae_trClass">
					<td valign="bottom" colspan="2" class="ae_tdClass">
						<iframe src="admin/editor2/blank.htm" id="frame1" style="HEIGHT: 10px; POSITION: absolute; VISIBILITY: hidden; WIDTH: 10px; Z-INDEX: 2" marginheight="0" marginwidth="0" scrolling="no"></iframe>
						<table cellspacing=2 cellpadding=0 border=0>
							<tr valign="center">
								<td width=10 background="admin/editor2/media/toolbar.gif" >
									<IMG alt="" height=24 src="admin/editor2/media/spacer.gif" width=9>
								</td>
								<td>
									<span id="ae_tbar1" onmouseover="ae_m_over(window.event.srcElement);" onmouseup="ae_m_up(window.event.srcElement);" onmouseout="ae_m_out(window.event.srcElement);" ondragstart="window.event.returnValue=false;" onmousedown=ae_m_down(window.event.srcElement); onselectstart="window.event.returnValue=false;">
										<nobr>
										<IMG alt=Save class=flat onclick="ae_onCommand(null,1)" src="admin/editor2/media/save.gif" cid="6005" type="btn" status="Save">
										<IMG alt=Cut class=flat onclick="ae_onCommand(null,1)" src="admin/editor2/media/cut.gif" cid="5003" type="btn" status="Cut the selected text and put it on the clipboard">
										<IMG alt=Copy class=flat onclick="ae_onCommand(null, 1)" src="admin/editor2/media/copy.gif" cid="5002" type="btn" status="Copy the selected text into the clipboard">
										<IMG alt=Paste class=flat onclick="ae_onCommand(null, 1)" src="admin/editor2/media/paste.gif" cid="5032" type="btn" status="Paste the contents of the clipboard into the workspace"> 
										<IMG class=spc src="admin/editor2/media/space.gif">
										<wbr>
										<IMG alt=Redo class=flat onclick="ae_onCommand(null,1)" src="admin/editor2/media/redo.gif" cid="5033" type="btn" status="Redo the last operation">
										<IMG alt=Undo class=flat onclick="ae_onCommand(null,1)" src="admin/editor2/media/undo.gif" cid="5049" type="btn" status="Undo the last operation">
										<IMG class=spc src="admin/editor2/media/space.gif">
										<wbr>
										<IMG alt=Font class=flat onclick="ae_onCommand(null, 1)" src="admin/editor2/media/fgcolor.gif" cid="5009" type="btn" status="Change font and color">
										<IMG alt=Bold class=flat onclick="ae_onCommand(null, 1)" src="admin/editor2/media/bold.gif" cid="5000" type="btn" status="Make selected text bold">
										<IMG alt=Italic class=flat onclick="ae_onCommand(null, 1)" src="admin/editor2/media/italic.gif" cid="5023" type="btn" status="Make selected text italic">
										<IMG alt=Underline class=flat onclick="ae_onCommand(null, 1)" src="admin/editor2/media/under.gif" cid="5048" type="btn" status="Underline the selected text">
										<IMG class=spc src="admin/editor2/media/space.gif">
										<wbr>
										<IMG alt="Decrease Indent" class=flat onclick="ae_onCommand(null,1)" src="admin/editor2/media/deindent.gif" cid="5031" type="btn" status="Reverse indent the current line">
										<IMG alt=Indent class=flat onclick="ae_onCommand(null,1)" src="admin/editor2/media/inindent.gif" cid="5018" type="btn" status="Indent the current line">
										<IMG class=spc src="admin/editor2/media/space.gif">
										<wbr>
										<IMG alt="Align Left" class=flat onclick="ae_onCommand(null, 1)" src="admin/editor2/media/left.gif" cid="5025" type="btn" status="Left justify the current line">
										<IMG alt=Center class=flat onclick="ae_onCommand(null, 1)" src="admin/editor2/media/center.gif" cid="5024" type="btn" status="Center the current line">
										<IMG alt="Align Right" class=flat onclick="ae_onCommand(null,1)" src="admin/editor2/media/right.gif" cid="5026" type="btn" status="Right justify the current line">
										<IMG alt=Bullets class=flat onclick="ae_onCommand(null, 1)" src="admin/editor2/media/bullist.gif" cid="5051" type="btn" status="Insert a bullet on current line">
										<IMG class=spc src="admin/editor2/media/space.gif">
										<wbr>
										<IMG alt="Insert Table" class=flat name=ae_tbtn1 onclick="ae_onCommand(null, 1)" ondragstart="return false" onmouseout=ae_m_out(ae_tdrop1); onmouseover=ae_m_over(ae_tdrop1); src="admin/editor2/media/instable.gif" cid="5022" type="btn" status="Insert a table">
										<IMG alt="Quick Table" class=flat name=ae_tdrop1 onclick=onTable(1) ondragstart="return false" onmouseout=ae_m_out(ae_tbtn1); onmouseover=ae_m_over(ae_tbtn1); src="admin/editor2/media/tbdown.gif" style="WIDTH: 9px" cid="5022" type="btn" status="Insert a table">
										<IMG alt="Insert Image" class=flat onclick="ae_onCommand(null, 1)" src="admin/editor2/media/image.gif" cid="5017" type="btn" status="Insert an image">
										<IMG alt="Insert Hyperlink" class=flat onclick="ae_onCommand(null, 1)" src="admin/editor2/media/link.gif" cid="5016" type="btn" status="Insert a hyperlink on selected text">
										<IMG class=spc src="admin/editor2/media/space.gif">
										<wbr>
										<IMG alt=Find class=flat onclick="ae_onCommand(null, 1)" src="admin/editor2/media/find.gif" cid="5008" type="btn" status="Find text in the document">
										<IMG alt=Help class=flat onclick="ae_onCommand(null, 1)" src="admin/editor2/media/help.gif" cid="6003" type="btn" status="Help"> 
										<!--<IMG alt="Spell Check" class=flat onclick="ae_onCommand(null, 1)" src="admin/editor2/media/spell.gif"  cid="6007" type="btn" status="Open spell check window">-->
										<IMG alt="Special Characters" class=flat onclick="ae_onCommand(null, 1)" src="admin/editor2/media/specialchar.gif" cid="6008" type="btn" status="Insert a Special Character">
										<br>
										<IMG height=24 src="admin/editor2/media/spacer.gif" style="VERTICAL-ALIGN: middle" width=1 >
										<select size="1" id="oQuickFormat1" style="FONT: 8pt Verdana; VERTICAL-ALIGN: middle; WIDTH: 120px" onchange="ae_quickformat(1);"></select>
										<IMG height=24 src="admin/editor2/media/spacer.gif" style="VERTICAL-ALIGN: middle" width=1 > 
										<select size="1" id="oQuickFontSize1" style="FONT: 8pt Verdana; VERTICAL-ALIGN: middle; WIDTH: 40px" onchange="ae_quickfontsize(1);">
											<option name="ae_fs1" value=1 selected>8</option> 
											<option name="ae_fs2" value=2>10</option> 
											<option name="ae_fs3" value=3>12</option> 
											<option name="ae_fs4" value=4>14</option> 
											<option name="ae_fs5" value=5>18</option> 
											<option name="ae_fs6" value=6>24</option> 
											<option name="ae_fs7" value=7>36</option> 
										</select>
										<IMG height=24 src="admin/editor2/media/spacer.gif" style="VERTICAL-ALIGN: middle" width=1 >
										<select size="1" id="oQuickFont1" style="FONT: 8pt Verdana; VERTICAL-ALIGN: middle; WIDTH: 120px" onchange="ae_quickfont(1);">
											<option name="Arial" value="Arial" selected>Arial</option> 
											<option name="Courier New" value="Courier New">Courier New</option> 
											<option name="Helvetica" value="Helvetica">Helvetica</option> 
											<option name="Times New Roman" value="Times New Roman">Times New Roman</option> 
											<option name="Verdana" value="Verdana">Verdana</option>
											<option name="Tahoma" value="Tahoma">Tahoma</option>
										</select>
										</nobr>
										<br>
										<IMG alt="" height=1 src="admin/editor2/media/spacer.gif" width=1>
									</span>
								</td>
							</tr>
						</table>
					</td> 
					<td class="ae_tdClass">&nbsp;</td>
				</tr>
				<tr class="ae_trClass">
					<td class="ae_tdClass"> &nbsp; </td>
					<td class="ae_tdClass" width="100%" height="100%">
						<OBJECT classid=clsid:2D360201-FFF5-11d1-8D03-00A0C959BC0A height="100%" id=DHTMLSafe1 style="Z-INDEX: 1" width="100%">
							<PARAM NAME="ActivateApplets" VALUE="0">
							<PARAM NAME="ActivateActiveXControls" VALUE="0">
							<PARAM NAME="ActivateDTCs" VALUE="-1">
							<PARAM NAME="ShowDetails" VALUE="0">
							<PARAM NAME="ShowBorders" VALUE="0">
							<PARAM NAME="Appearance" VALUE="1">
							<PARAM NAME="Scrollbars" VALUE="-1">
							<PARAM NAME="ScrollbarAppearance" VALUE="0">
							<PARAM NAME="SourceCodePreservation" VALUE="-1">
							<PARAM NAME="AbsoluteDropMode" VALUE="0">
							<PARAM NAME="SnapToGrid" VALUE="0">
							<PARAM NAME="SnapToGridX" VALUE="50">
							<PARAM NAME="SnapToGridY" VALUE="50">
							<PARAM NAME="UseDivOnCarriageReturn" VALUE="0">
						</OBJECT>
						<script LANGUAGE="javascript" FOR="DHTMLSafe1" EVENT="ShowContextMenu">
							return ShowMenu(1);
						</script>
						<script LANGUAGE="javascript" FOR="DHTMLSafe1" EVENT="onkeypress">
							return ae_onkeypress(1);
						</script>
						<script LANGUAGE="javascript" FOR="DHTMLSafe1" EVENT="onmousedown">
							return ae_onmousedown(1);
						</script>
						<script LANGUAGE="javascript" FOR="DHTMLSafe1" EVENT="onclick">
							return ae_onclick(1);
						</script>
						<script LANGUAGE="javascript" FOR="DHTMLSafe1" EVENT="DisplayChanged">
							return ae_ondisplaychange(1);
						</script>
						<script LANGUAGE="javascript" FOR="DHTMLSafe1" EVENT="ContextMenuAction(itemIndex)"> 
							return ae_onmenuaction(itemIndex);
						</script>
					</td>
					<td class="ae_tdClass">&nbsp;</td>
				</tr>
				<tr class="ae_trClass">
					<td colspan="3" class="ae_tdClass">
						<table cellspacing=0 cellpadding=0 border=0 width="100%"> 
							<tr>
								<td>
									<IMG height=1 src="admin/editor2/media/spacer.gif" width=20>
									<IMG border=0 height=11 name=normaltab1 onclick="ae_editsourceinline(1, false)" src="admin/editor2/media/normaltabon.gif" width=49>
									<IMG alt="" border=0 height=11 name=htmltab1 onclick="ae_editsourceinline(1, true)" src="admin/editor2/media/htmltaboff.gif" width=41>
								</td>
								<td align="right">
									<a href="javascript:ae_about()" style="COLOR: gray; TEXT-DECORATION: none" >
										<span style="FONT-FAMILY: Arial; FONT-SIZE: 10px">FULLXML Editor&nbsp;</span>
									</a>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<TEXTAREA id=ae_tx_content1 name=content style="POSITION: absolute; VISIBILITY: hidden"></TEXTAREA>
			<script>ae_initialize(1);</script>
			<script>
				//</comment> 
			</script>
		</form>
		<script>
			document.editform.ae_tx_content1.value = eval(contentfromopener);
			//alert(frame1.document.body.innerHTML); 
			//alert(DHTMLSafe.DOM.body.innerHTML);
		</script>
	</body>
</html>
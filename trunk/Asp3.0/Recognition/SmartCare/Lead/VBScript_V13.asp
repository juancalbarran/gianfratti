<html>

	<head>
		<title>Client Side Image Resizing Tool</title>

		<script language="VBScript">
		<!--			
			'Types
			L_TWTY_UINT16 = 4			
			L_TWTY_FIX32 = 7
			L_TWTY_BOOL  = 6
			L_TWTY_STR32 = 9

			'Containers
			L_TWON_RANGE = 6
			L_TWON_ONEVALUE = 5
			L_TWON_ENUMERATION = 4
			L_TWON_ARRAY = 3					
			L_TWON_DONTCARE16 = -1

			'Capabilities
			L_CAP_DUPLEXENABLED = 4115
			L_CAP_DUPLEX = 4114
			L_CAP_SUPPORTEDCAPS = 4101
			L_ICAP_UNITS = 258
			L_ICAP_BRIGHTNESS = 4353
			L_ICAP_CONTRAST = 4355
			L_ICAP_HALFTONES = 4361
			L_ICAP_SUPPORTEDSIZES = 4386
			L_ICAP_THRESHOLD = 4387			
                        L_ICAP_PIXELTYPE = 257

			'Get/Set Capabilities
			L_LTWAIN_CAPABILITY_GETCURRENT = 3
			L_LTWAIN_CAPABILITY_GETVALUES  = 5
			L_LTWAIN_CAPABILITY_SET = 1

			'Possible Capability Values
			L_TWSS_USLEGAL = 4
                        L_TWPT_GRAY = 1

			'Set the Capability to set and get
			uCAP = L_ICAP_PIXELTYPE

			Sub window_onunLoad()
				RasterTwain.EndSession
			End sub

			Sub window_onLoad()
				RasterTwain.InitSession RasterView.Window
				RasterTwain.EnableMethodErrors = false
			End Sub
			
			Sub cmdSelectSource_Click()
				RasterTwain.SelectSource
			End Sub

			Sub Acquire_Click()
				RasterTwain.Acquire 0							
			End Sub
					
			Private Sub RasterTwain_AcquirePageEvent(ByVal pBitmap)
				RasterView.Raster.InsertBitmapListItem -1, pBitmap
				RasterView.Raster.BitmapListIndex = RasterView.Raster.BitmapListCount - 1				
			End Sub

			Private Sub cmdGetCap_Click()
				GetCap uCAP
			End Sub

			Private Sub cmdSetCap_Click()				
				SetCap uCAP, L_TWPT_GRAY
				GetCap uCAP
			End Sub
			
			Private Sub GetCap(Cap)
				Dim iRet
				TwainCap.CapInfo.Capability = Cap
				TwainCap.EnableMethodErrors = False
				MsgBox Cap
				iRet = RasterTwain.GetCapability2(TwainCap, L_LTWAIN_CAPABILITY_GETCURRENT)
				If (iRet <> 0) Then
					MsgBox "Error Getting Capability: " + CStr(iRet)
				Else
					DisplayContainer
				End If
			End Sub

			Private Sub SetCap(Cap, Val)
				Dim iRet				

				TwainCap.CapInfo.ConType = L_TWON_ONEVALUE
				TwainCap.CapInfo.Capability = Cap
				TwainCap.EnableMethodErrors = False
		
				TwainCap.CapOneValue.OneValItemType = L_TWTY_UINT16					
				TwainCap.CapOneValue.OneValCapValue = Val
		
				iRet = RasterTwain.SetCapability2(TwainCap, L_LTWAIN_CAPABILITY_SET)								
			End Sub
			
			Private Sub DisplayContainer()
				Dim msg
				If(TwainCap.CapInfo.ConType = L_TWON_RANGE)then					
					msg = "Current Value = " + CStr(TwainCap.CapRange.RangeCurrentValue) + Chr(13) + _
					      "Minimum Value = " + CStr(TwainCap.CapRange.RangeMinimumValue) + Chr(13) + _
					      "Maximum Value = " + CStr(TwainCap.CapRange.RangeMaximumValue) + Chr(13) + _
					      "Step Value = " + CStr(TwainCap.CapRange.RangeStepSize)
					MsgBox msg
				End If

				If(TwainCap.CapInfo.ConType = L_TWON_ONEVALUE)then
					MsgBox "OneValue = " + CStr(TwainCap.CapOneValue.OneValCapValue)
				End If

				If(Twaincap.CapInfo.ConType = L_TWON_ENUMERATION)then
					Dim Items
					Dim nNumOfItems
					Dim i
					msg = "Current Value = " + CStr(TwainCap.CapEnum.EnumCurrentIndex) + Chr(13) + _
					      "Default Value = " + CStr(TwainCap.CapEnum.EnumDefaultIndex) + Chr(13) + _
					      "Number of Items = " + CStr(TwainCap.CapEnum.EnumNumOfItems) + Chr(13)
					nNumOfItems = TwainCap.CapEnum.EnumNumOfItems
					For i = 0 To nNumOfItems - 1
						Items = Items + "Item" + CStr(i) + " = " + CStr(TwainCap.CapEnum.EnumCapValue(i)) + Chr(13)
					Next
					msg = msg + Items
					MsgBox msg
					      
				End If
			End Sub

			Private Sub cmdBmpListCount_Click()
				MsgBox RasterView.Raster.BitmapListCount
			End Sub

			Private Sub cmdPrev_Click()
                            if( (RasterView.Raster.BitmapListIndex - 1) > -1)then
                                RasterView.Raster.BitmapListIndex = RasterView.Raster.BitmapListIndex - 1
                            End if
			End Sub

			Private Sub cmdNext_Click()
				if( (RasterView.Raster.BitmapListIndex + 1) < RasterView.Raster.BitmapListCount)then
                                RasterView.Raster.BitmapListIndex = RasterView.Raster.BitmapListIndex + 1
                            End if
			End Sub
			-->
		</script>

	</head>
	<body>
<p>
		<OBJECT id=RasterTwain CLASSID="CLSID:00130752-B1BA-11CE-ABC6-F5B2E79D9E3F" 
			name=RasterTwain></OBJECT>
		
		<OBJECT id=TwainCap classid="CLSID:0013088B-B1BA-11CE-ABC6-F5B2E79D9E3F"
			name=TwainCap></OBJECT>

		<OBJECT id=RasterView style="LEFT: 0px; WIDTH: 370px; TOP: 0px; HEIGHT: 294px; BACKGROUND-COLOR: #e1e6ff" 
			height=294 width=370 
			data=data:application/x-oleobject;base64,CAcTALqxzhGrxvWy552ePwICAAA+JgAAYx4AABMA4ODgAAMAAAAAAAMAAAAAAAMAAAAAAAkAAAAAAAAAAAAAAAAAAAAAAAsA//8EAAAAAAAEAAAAAAAEAAAAAAAEAAAAAAADAAMAAAALAP//CwAAAAsA//8LAAAACwD//wMAAAAAAAMAAAAAAAMAAAAAAAQAAADIQgsAAAADAAEAAAALAAAAAgAAAAIAZAACAAAACwAAAAMAAAAAAAsAAAAEAAAAAAATAAAAAAADAAAAAAAEAAAAAAATAP///wATAICAgAADAAAAAAAEAAAAAAATAP///wATAICAgAALAP//CwAAAAQAAAAAAAQAAAAAAAQAAAAWQwQAAAAWQxMAAAAAAAgAAgAAAAAACwD//wMAAAAAAAMAAAAAAAMAAAAAAAMAAAAAAAkAAAAAAAAAAAAAAAAAAAAAAAkAAAAAAAAAAAAAAAAAAAAAAAIAAAADAOgDAAADAAAAAAADAOgDAAADAAAAAAATAAAA/wATAAAAAAACABAAAwAAAAAAEwAAAAAAEwAAAAAAAgABAAIABQACAAAAAgAAABMAAAAAAAIAAAALAP//AgABAAsAAAADAAAAAAALAAAAAgAAAAIAAQACAAEACwAAAAsA//8CAAAAAgBkAAIAAAA= 
			classid=CLSID:00130708-B1BA-11CE-ABC6-F5B2E79D9E3F codebase="ScanUpload_n.cab"  name=RasterView 
			VIEWASTEXT>If you see this text then your browser is not handling the ActiveX properly.
				Try downloading Microsoft Internet Explorer</OBJECT>

		<OBJECT id=RasterImgList style="WIDTH: 302px; HEIGHT: 272px" 
			data=data:application/x-oleobject;base64,hAcTALqxzhGrxvWy552ePwADAAA2HwAAHRwAAA== 
			classid=clsid:00130784-B1BA-11CE-ABC6-F5B2E79D9E3F></OBJECT>
</p><p>		
		<OBJECT id=Acquire style="LEFT: 0px; TOP: 0px" height=23 width=91 align=baseline 
	border=0 classid="CLSID:D7053240-CE69-11CD-A777-00DD01143C57" name=Acquire>
	<PARAM NAME="ForeColor" VALUE="2147483666">
	<PARAM NAME="BackColor" VALUE="2147483663">
	<PARAM NAME="VariousPropertyBits" VALUE="27">
	<PARAM NAME="Caption" VALUE="Acquire">
	<PARAM NAME="PicturePosition" VALUE="458753">
	<PARAM NAME="Size" VALUE="2408;609">
	<PARAM NAME="MousePointer" VALUE="0">
	<PARAM NAME="Accelerator" VALUE="0">
	<PARAM NAME="TakeFocusOnClick" VALUE="-1">
	<PARAM NAME="FontName" VALUE="MS Sans Serif">
	<PARAM NAME="FontEffects" VALUE="1073741824">
	<PARAM NAME="FontHeight" VALUE="160">
	<PARAM NAME="FontOffset" VALUE="0">
	<PARAM NAME="FontCharSet" VALUE="0">
	<PARAM NAME="FontPitchAndFamily" VALUE="2">
	<PARAM NAME="ParagraphAlign" VALUE="3">
	<PARAM NAME="FontWeight" VALUE="0"></OBJECT>
</P>
<P>
		<object id="cmdGetCap" name="cmdGetCap" classid="CLSID:D7053240-CE69-11CD-A777-00DD01143C57" align="baseline" border="0" width="91" height="23" >
				<param name="Caption" value="Get Cap">
				<param name="Size" value="2399;600">
				<param name="FontCharSet" value="0">
				<param name="FontPitchAndFamily" value="2">
				<param name="ParagraphAlign" value="3">
				<param name="FontWeight" value="0">
		</object>

		<object id="cmdSetCap" name="cmdSetCap" classid="CLSID:D7053240-CE69-11CD-A777-00DD01143C57" align="baseline" border="0" width="91" height="23" >
				<param name="Caption" value="Set Cap">
				<param name="Size" value="2399;600">
				<param name="FontCharSet" value="0">
				<param name="FontPitchAndFamily" value="2">
				<param name="ParagraphAlign" value="3">
				<param name="FontWeight" value="0">
		</object>
		<object id="cmdSelectSource" name="cmdSelectSource" classid="CLSID:D7053240-CE69-11CD-A777-00DD01143C57" align="baseline" border="0" width="91" height="23" >
				<param name="Caption" value="Select Source">
				<param name="Size" value="2399;600">
				<param name="FontCharSet" value="0">
				<param name="FontPitchAndFamily" value="2">
				<param name="ParagraphAlign" value="3">
				<param name="FontWeight" value="0">
		</object>
</P>
<P>

		<object id="cmdBmpListCount" name="cmdBmpListCount" classid="CLSID:D7053240-CE69-11CD-A777-00DD01143C57" align="baseline" border="0" width="91" height="23" >
				<param name="Caption" value="Bmp Count">
				<param name="Size" value="2399;600">
				<param name="FontCharSet" value="0">
				<param name="FontPitchAndFamily" value="2">
				<param name="ParagraphAlign" value="3">
				<param name="FontWeight" value="0">
		</object>

		<object id="cmdPrev" name="cmdPrev" classid="CLSID:D7053240-CE69-11CD-A777-00DD01143C57" align="baseline" border="0" width="91" height="23" >
				<param name="Caption" value="Previous">
				<param name="Size" value="2399;600">
				<param name="FontCharSet" value="0">
				<param name="FontPitchAndFamily" value="2">
				<param name="ParagraphAlign" value="3">
				<param name="FontWeight" value="0">
		</object>

		<object id="cmdNext" name="cmdNext" classid="CLSID:D7053240-CE69-11CD-A777-00DD01143C57" align="baseline" border="0" width="91" height="23" >
				<param name="Caption" value="Next">
				<param name="Size" value="2399;600">
				<param name="FontCharSet" value="0">
				<param name="FontPitchAndFamily" value="2">
				<param name="ParagraphAlign" value="3">
				<param name="FontWeight" value="0">
		</object>
</P>
	</body>
</html>



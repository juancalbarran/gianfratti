﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>attachme</title>
		<meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="StyleSheet.css" rel="stylesheet">
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="attachme" method="post" encType="multipart/form-data" runat="server">
			<INPUT class="bluebutton" id="FindFile" style="Z-INDEX: 101; LEFT: 36px; WIDTH: 274px; POSITION: absolute; TOP: 123px; HEIGHT: 22px" type="file" size="26" runat="server">
			<asp:listbox id="ListBox1" style="Z-INDEX: 102; LEFT: 36px; POSITION: absolute; TOP: 149px" runat="server" CssClass="txtbox" Height="100px" Width="274px" Font-Size="XX-Small"></asp:listbox>
			<asp:button id="AddFile" style="Z-INDEX: 103; LEFT: 34px; POSITION: absolute; TOP: 254px" runat="server" CssClass="bluebutton" Height="23px" Width="72px" Text="Add"></asp:button>
			<asp:button id="RemvFile" style="Z-INDEX: 104; LEFT: 119px; POSITION: absolute; TOP: 255px" runat="server" CssClass="bluebutton" Height="23px" Width="72px" Text="Remove"></asp:button>
			<INPUT class="bluebutton" id="Upload" style="Z-INDEX: 105; LEFT: 236px; WIDTH: 71px; POSITION: absolute; TOP: 254px; HEIGHT: 24px" type="submit" value="Upload" runat="server" onserverclick="Upload_ServerClick">
            <asp:Button ID="Button1" runat="server" Text="Button" onclick="Button1_Click" />
		</form>
        
		<asp:label id="Label1" style="Z-INDEX: 106; LEFT: 46px; POSITION: absolute; TOP: 326px" runat="server" Height="25px" Width="249px"></asp:label></SPAN>
	</body>
</HTML>

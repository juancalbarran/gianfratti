<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Upload.aspx.cs" Inherits="Admin_Autores_Upload" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
<form id="Form1" method="post" runat="server" enctype="multipart/form-data">
<table border="0" cellpadding="0" cellspacing="0"  style="width:100%">
<tr>
<td>
    <asp:FileUpload ID="arquivo" runat="server" />
    <asp:Button ID="btnEnviar" runat="server" OnClick="btnEnviar_Click" Text="Button" /></td>
</tr>
    <tr>
        <td>
            <asp:Label ID="lblMensagem" runat="server" Text="Label"></asp:Label></td>
    </tr>
</table>
</form>
</body>
</html>

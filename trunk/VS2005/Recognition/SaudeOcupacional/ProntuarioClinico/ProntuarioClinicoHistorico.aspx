<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProntuarioClinicoHistorico.aspx.cs" Inherits="ProntuarioClinico_ProntuarioClinicoHistorico" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <link href="../Template/Css/default.css" rel="stylesheet" type="text/css" />
    <title>Histórico - Prontuário Clínico</title>
</head>
<body style="margin:5px;">
    <form id="form1" runat="server">
    
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="DeleteProntuarioClinico" SelectMethod="SelectProntuarioClinicoByID" TypeName="ProntuarioClinicoDAL">
        <DeleteParameters>
            <asp:Parameter Name="id" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="idFuncionario" QueryStringField="idFuncionario" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td>           
            
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="LightGoldenrodYellow"
                BorderColor="Tan" BorderWidth="1px" CellPadding="2"
                DataSourceID="ObjectDataSource1" ShowHeader="False" GridLines="None" Width="100%" CssClass="texto" ForeColor="Black">
                <FooterStyle BackColor="Tan" />
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="ID" Visible="False" />
                    <asp:BoundField DataField="dtCadastro" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Template/Img/alterar.gif"
                                OnClick="ImageButton1_Click" ToolTip="Visualizar" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowDeleteButton="True" ButtonType="Image" DeleteImageUrl="~/Template/Img/excluir.gif" />
                </Columns>
                <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
                <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                <HeaderStyle BackColor="Tan" Font-Bold="True" />
                <AlternatingRowStyle BackColor="PaleGoldenrod" />
            </asp:GridView>
            
            </td>
        </tr>
    </table>    
    </form>
</body>
</html>

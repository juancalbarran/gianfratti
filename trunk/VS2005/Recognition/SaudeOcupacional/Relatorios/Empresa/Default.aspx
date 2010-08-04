<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Relatorios_Empresa_Default" Title="Untitled Page" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Button" />
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="SelectAll"
        TypeName="CID10DAL">
        <SelectParameters>
            <asp:ControlParameter ControlID="TextBox1" DefaultValue="" Name="CID10" PropertyName="Text"
                Type="String" />
            <asp:Parameter Name="Descricao" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <br />
    <rsweb:reportviewer id="ReportViewer1" runat="server" font-names="Verdana" font-size="8pt"
        height="100%" width="100%">
<LocalReport ReportPath="Relatorios\Empresa\Report1.rdlc"><DataSources>
<rsweb:ReportDataSource DataSourceId="ObjectDataSource1" Name="DataSet1_CID10SelectAll"></rsweb:ReportDataSource>
</DataSources>
</LocalReport>
</rsweb:reportviewer>
</asp:Content>


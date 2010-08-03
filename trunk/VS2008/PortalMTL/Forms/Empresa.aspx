<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Empresa.aspx.cs" Inherits="PortalMTL.Forms.Empresa" MasterPageFile="~/Template/Template01.master" %>

<%@ Register assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" namespace="System.Web.UI.WebControls" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <fieldset style="width: 100%; height: 100%">
        <legend align="center">Empresas</legend>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
            
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                    AllowSorting="True">
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
    </fieldset>
</asp:Content>

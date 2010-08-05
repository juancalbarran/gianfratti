<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Menu.ascx.cs" Inherits="PortalMTL.UserControl.Menu.Menu" %>

<asp:TreeView ID="TreeView1" runat="server" ImageSet="Arrows">
    <DataBindings> 
        <asp:TreeNodeBinding DataMember="siteMapNode" TextField="title" NavigateUrlField="url"  /> 
    </DataBindings> 
    <ParentNodeStyle Font-Bold="False" />
    <HoverNodeStyle Font-Underline="True" ForeColor="#5555DD" />
    <SelectedNodeStyle Font-Underline="True" ForeColor="#5555DD" HorizontalPadding="0px"
        VerticalPadding="0px" />
    <NodeStyle Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" HorizontalPadding="5px"
        NodeSpacing="0px" VerticalPadding="0px" />
</asp:TreeView>

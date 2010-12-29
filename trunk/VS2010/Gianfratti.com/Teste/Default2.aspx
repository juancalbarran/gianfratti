<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="Default2" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Simple Array Grid With Paging and Remote Reloading - Ext.NET Examples</title>
    <link href="../../../../resources/css/examples.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        var template = '<span style="color:{0};">{1}</span>';

        var change = function (value) {
            return String.format(template, (value > 0) ? "green" : "red", value);
        };

        var pctChange = function (value) {
            return String.format(template, (value > 0) ? "green" : "red", value + "%");
        };
    </script>
</head>
<body>
    <form id="Form1" runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
        
        <h1>Array Grid with Paging and Remote Reloading</h1>
        
        <p>Demonstrates how to create a grid from Array data with Local Paging and Remote Reloading.</p>
        
        <p>Notice <b>Last Updated</b> column is revised with a new server-side DateTime stamp when the GridPanel "Refresh" button is clicked.<br />This demonstrates that when the GridPanel is refreshed, the Data is requested again from the server via an DirectEvent, but the Paging and Sorting is done completely client-side in the browser.</p>
        
        <ext:GridPanel
            ID="GridPanel1"
            runat="server" 
            StripeRows="true"
            Title="Array Grid" 
            Width="600" 
            Height="290"
            AutoExpandColumn="Company">
            <Store>
                <ext:Store ID="Store1" runat="server" OnRefreshData="MyData_Refresh">
                    <Reader>
                        <ext:ArrayReader>
                            <Fields>
                                <ext:RecordField Name="company" />
                                <ext:RecordField Name="price" Type="Float" />
                                <ext:RecordField Name="change" Type="Float" />
                                <ext:RecordField Name="pctChange" Type="Float" />
                                <ext:RecordField Name="lastChange" Type="Date" />
                            </Fields>
                        </ext:ArrayReader>
                    </Reader>
                </ext:Store>
            </Store>
            <ColumnModel ID="ColumnModel1" runat="server">
                <Columns>
                    <ext:RowNumbererColumn />
                    <ext:Column ColumnID="Company" Header="Company" Width="160" DataIndex="company" />
                    <ext:Column Header="Price" Width="75" DataIndex="price">
                        <Renderer Format="UsMoney" />
                    </ext:Column>
                    <ext:Column Header="Change" Width="75" DataIndex="change">
                        <Renderer Fn="change" />
                    </ext:Column>
                    <ext:Column Header="Change" Width="75" DataIndex="pctChange">
                        <Renderer Fn="pctChange" />
                    </ext:Column>
                    <ext:DateColumn Header="Last Updated" Width="85" DataIndex="lastChange" Format="H:mm:ss" />
                </Columns>
            </ColumnModel>
            <SelectionModel>
                <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" />
            </SelectionModel>
            <LoadMask ShowMask="true" />
            <BottomBar>
                 <ext:PagingToolbar ID="PagingToolbar1" runat="server" PageSize="10">
                    <Items>
                        <ext:Label ID="Label1" runat="server" Text="Page size:" />
                        <ext:ToolbarSpacer ID="ToolbarSpacer1" runat="server" Width="10" />
                        <ext:ComboBox ID="ComboBox1" runat="server" Width="80">
                            <Items>
                                <ext:ListItem Text="1" />
                                <ext:ListItem Text="2" />
                                <ext:ListItem Text="10" />
                                <ext:ListItem Text="20" />
                            </Items>
                            <SelectedItem Value="10" />
                            <Listeners>
                                <Select Handler="#{PagingToolbar1}.pageSize = parseInt(this.getValue()); #{PagingToolbar1}.doLoad();" />
                            </Listeners>
                        </ext:ComboBox>
                    </Items>
                </ext:PagingToolbar>
            </BottomBar>
        </ext:GridPanel>
    </form>
</body>
</html>


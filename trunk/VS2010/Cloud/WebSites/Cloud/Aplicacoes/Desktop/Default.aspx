<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Cloud.Aplicacoes.Desktop.Default" %>

<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Desktop - Gianfratti.com</title>    
    
    <style type="text/css">        
        .start-button {
            background-image: url(../../Designer/Imagens/vista_start_button.gif) !important;
        }
        
        .shortcut-icon {
            width: 48px;
            height: 48px;
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src="../../Designer/Imagens/window.png", sizingMethod="scale");
        }
        
        .icon-grid48 {
            background-image: url(grid48x48.png) !important;
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src="../../Designer/Imagens/grid48x48.png", sizingMethod="scale");
        }
        
        .icon-user48 {
            background-image: url(user48x48.png) !important;
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src="../../Designer/Imagens/user48x48.png", sizingMethod="scale");
        }
        
        .icon-window48 {
            background-image: url(window48x48.png) !important;
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src="../../Designer/Imagens/window48x48.png", sizingMethod="scale");
        }
        
        .icon-feed48 {
            background-image: url(Designer/Imagens/fedd48x48.png) !important;
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src="../../Designer/Imagens/fedd48x48.png", sizingMethod="scale");
        }
        
        .icon-Tasks {
            background-image: url(Designer/Imagens/task48x48.png) !important;
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src="../../Designer/Imagens/task48x48.png", sizingMethod="scale");
        }
                
        .desktopEl {
            position: absolute !important;
        }

    </style>
    
    <script type="text/javascript">
        /*
        var alignPanels = function () {
        pnlSample.getEl().alignTo(Ext.getBody(), "tr", [-505, 5], false)
        };
        */

        var template = '<span style="color:{0};">{1}</span>';

        var change = function (value) {
            return String.format(template, (value > 0) ? "green" : "red", value);
        };

        var pctChange = function (value) {
            return String.format(template, (value > 0) ? "green" : "red", value + "%");
        };

        var createDynamicWindow = function (app) {
            var desk = app.getDesktop();

            var w = desk.createWindow({
                title: "Dynamic Web Browser",
                width: 1000,
                height: 600,
                maximizable: true,
                minimizable: true,
                autoLoad: {
                    url: "http://ajaxian.com/archives/mad-cool-date-library/",
                    mode: "iframe",
                    showMask: true
                }
            });

            w.center();
            w.show();
        };
    </script>
</head>
<body>
    <form id="Form1" runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server">
            <Listeners>
<%--                <DocumentReady Handler="alignPanels();" />
                <WindowResize Handler="alignPanels();" />--%>
            </Listeners>
        </ext:ResourceManager>
        
        <%--Quick Search--%>
        
        <ext:Store 
            ID="QuickSearchStore" 
            runat="server" 
            AutoLoad="false" 
            OnRefreshData="GetQuickSearchItems">
            <Proxy>
                <ext:PageProxy />
            </Proxy>
            <Reader>
                <ext:JsonReader>
                    <Fields>
                        <ext:RecordField Name="SearchItem" />
                    </Fields>
                </ext:JsonReader>
            </Reader>
            <BaseParams>
                <ext:Parameter Name="Filter" Value="#{QuickSearchFilter}.getValue()" Mode="Raw" />
            </BaseParams>
        </ext:Store>
        
        <%--End Quick Search--%>

        <ext:Desktop 
            ID="MyDesktop" 
            runat="server" 
            BackgroundColor="Black" 
            ShortcutTextColor="White" 
            Wallpaper="../../Designer/Imagens/desktop.jpg"
            >
            <StartButton Text="Start" IconCls="start-button" />
            <%-- NOTE: Body Controls must be added to a container with position:absolute --%>
  <%--          <Content>
                <ext:Panel 
                    ID="pnlSample" 
                    runat="server" 
                    Title="Sample Panel"
                    Cls="desktopEl" 
                    Height="400" 
                    Width="500"
                    Padding="5"
                    Collapsible="true">
                    <Items>
                        <ext:BorderLayout ID="BorderLayout1" runat="server">
                            <West 
                                Collapsible="true" 
                                Split="true" 
                                MarginsSummary="5 0 0 5" 
                                CMarginsSummary="5 5 0 5">
                                <ext:Panel runat="server" Title="West" Width="150" />
                            </West>
                            <Center MarginsSummary="5 0 0 0">
                                <ext:Panel 
                                    ID="Panel2" 
                                    runat="server" 
                                    Title="Center" 
                                    Html="<h1>Center</h1>Positioned Panel with BorderLayout" 
                                    Padding="5">
                                    <BottomBar>
                                        <ext:Toolbar runat="server">
                                            <Items>
                                                <ext:Button runat="server" Text="Button" />
                                                <ext:SplitButton runat="server" Text="Split Button">
                                                    <Menu>
                                                        <ext:Menu runat="server">
                                                            <Items>
                                                                <ext:MenuItem runat="server" Text="Item 1" />
                                                                <ext:MenuItem runat="server" Text="Item 2">
                                                                    <Menu>
                                                                        <ext:DateMenu runat="server" />
                                                                    </Menu>
                                                                </ext:MenuItem>
                                                                <ext:MenuItem runat="server" Text="Item 3">
                                                                    <Menu>
                                                                        <ext:ColorMenu runat="server" />
                                                                    </Menu>
                                                                </ext:MenuItem>
                                                            </Items>
                                                        </ext:Menu>
                                                    </Menu>
                                                </ext:SplitButton>
                                            </Items>
                                        </ext:Toolbar>
                                    </BottomBar>    
                                </ext:Panel>
                            </Center>
                            <East Collapsible="true" Split="true" MarginsSummary="5 5 0 0" CMarginsSummary="5 5 0 5">
                                <ext:Panel ID="Panel3" runat="server" Title="East" Width="150" Layout="Fit">
                                    <Items>
                                        <ext:TabPanel 
                                            ID="TabPanel1" 
                                            runat="server" 
                                            Height="300" 
                                            TabPosition="Bottom"
                                            Border="false">
                                            <Items>
                                                <ext:Panel 
                                                    ID="Tab1" 
                                                    runat="server" 
                                                    Title="Tab 1" 
                                                    />
                                                <ext:Panel 
                                                    ID="Tab2" 
                                                    runat="server" 
                                                    Title="Tab 2" 
                                                    Html="Hello!" 
                                                    Padding="5" 
                                                    />
                                            </Items>
                                        </ext:TabPanel>
                                    </Items>
                                </ext:Panel>
                            </East>
                            <South Collapsible="true" Split="true" MarginsSummary="0 5 5 5">
                                <ext:Panel ID="Panel4" runat="server" Height="125" Title="South" Collapsed="true" />
                            </South>
                        </ext:BorderLayout>
                    </Items>
                </ext:Panel>
            </Content>--%>
            <Modules>
                <ext:DesktopModule ModuleID="DesktopModule1" WindowID="winCustomer" AutoRun="true">
                    <Launcher ID="Launcher1" runat="server" Text="Adicionar Usuário" Icon="Add" />
                </ext:DesktopModule>
                
                <ext:DesktopModule ModuleID="DesktopModule2" WindowID="winCompany" AutoRun="true">
                    <Launcher ID="Launcher2" runat="server" Text="Empresa" Icon="Lorry" />
                </ext:DesktopModule>
                
                <ext:DesktopModule ModuleID="DesktopModule3" WindowID="FeedBrowser">
                    <Launcher ID="Launcher3" runat="server" Text="Leitor de Feed" Icon="Rss" />
                </ext:DesktopModule>

                <ext:DesktopModule ModuleID="DesktopModule4" WindowID="TasksBrowser">
                    <Launcher ID="Launcher4" runat="server" Text="Tarefas" Icon="PastePlain" />
                </ext:DesktopModule>

            </Modules>  
            
            <Shortcuts>
                <ext:DesktopShortcut ModuleID="DesktopModule1" Text="Adicionar Usuário" IconCls="shortcut-icon icon-user48" />
                <ext:DesktopShortcut ModuleID="DesktopModule2" Text="Empresa" IconCls="shortcut-icon icon-grid48" />
                <ext:DesktopShortcut ModuleID="DesktopModule3" Text="Leitor de Feed" IconCls="shortcut-icon icon-feed48" />
                <ext:DesktopShortcut ModuleID="DesktopModule4" Text="Tarefas" IconCls="shortcut-icon icon-Tasks" />
                <ext:DesktopShortcut ShortcutID="scJanelasLadoLado" Text="Janelas Lado a Lado" IconCls="shortcut-icon icon-window48" X="{DX}-90" Y="{DY}-90" />
                <ext:DesktopShortcut ShortcutID="scJanelasCascata" Text="Janelas em Cascata" IconCls="shortcut-icon icon-window48" X="{DX}-90" Y="{DY}-170" />
            </Shortcuts>
            
            <Listeners>
                <ShortcutClick Handler="var d=#{MyDesktop}.getDesktop(); if(id == 'scJanelasLadoLado'){d.tile();}else if(id == 'scJanelasCascata'){d.cascade();}" />
            </Listeners>
            
            <StartMenu Width="400" Height="400" ToolsWidth="227" Title="Start Menu">
                <ToolItems>
                    <ext:MenuItem Text="Opções" Icon="Wrench">
                        <Listeners>
                            <Click Handler="Ext.Msg.alert('Message', 'Você clicou em opções');" />
                        </Listeners>
                    </ext:MenuItem>
                    <ext:MenuItem Text="Logout" Icon="Disconnect">
                        <DirectEvents>
                            <Click OnEvent="Logout_Click">
                                <EventMask ShowMask="true" Msg="Good Bye..." MinDelay="1000" />
                            </Click>
                        </DirectEvents>
                    </ext:MenuItem>
                    
                    <ext:MenuSeparator />
                    
                    <ext:ComponentMenuItem ID="ComponentMenuItem1" runat="server" Shift="false">   
                        <Component>
                            <ext:GridPanel ID="QuickSearchGrid" runat="server" Width="210" Height="275" StoreID="QuickSearchStore" AutoExpandColumn="SearchItem">
                                <ColumnModel>
                                    <Columns>
                                        <ext:CommandColumn Width="30">
                                            <Commands>
                                                <ext:GridCommand Icon="Note" />
                                            </Commands>
                                        </ext:CommandColumn>
                                        
                                        <ext:Column ColumnID="SearchItem" Header="Procurar" DataIndex="SearchItem" />
                                    </Columns>
                                </ColumnModel>
                                <SelectionModel>
                                    <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true" />
                                </SelectionModel>
                                <LoadMask ShowMask="true" />
                            </ext:GridPanel>
                        </Component>                     
                    </ext:ComponentMenuItem>
                    
                    <ext:ComponentMenuItem ID="ComponentMenuItem2" runat="server" Target="#{QuickSearchFilter}" Shift="false" ComponentElement="Wrap"> 
                        <Component>
                            <ext:TriggerField ID="QuickSearchFilter" runat="server" Width="210">
                                <Triggers>
                                    <ext:FieldTrigger Icon="Search" />
                                    <ext:FieldTrigger Icon="Clear" HideTrigger="true" />
                                </Triggers>
                                <Listeners>
                                    <TriggerClick Handler="if (index === 1) { trigger.hide(); this.setValue(''); } else { this.triggers[1].show(); } #{QuickSearchGrid}.reload();" />
                                </Listeners>
                            </ext:TriggerField>
                        </Component>                      
                    </ext:ComponentMenuItem>
                </ToolItems>
                
                <Items>
                    <ext:MenuItem ID="MenuItem1" runat="server" Text="Programas" Icon="Folder" HideOnClick="false">
                        <Menu>
                            <ext:Menu ID="Menu1" runat="server">
                                <Items>
                                    <ext:MenuItem Text="Adicionar Usuário" Icon="Add">
                                        <Listeners>
                                            <Click Handler="#{winCustomer}.show();" />
                                        </Listeners>
                                    </ext:MenuItem>
                                    <ext:MenuItem Text="Empresa" Icon="Lorry">
                                        <Listeners>
                                            <Click Handler="#{winCompany}.show();" />
                                        </Listeners>
                                    </ext:MenuItem>
                                    <ext:MenuItem Text="Web Browser" Icon="Feed">
                                        <Listeners>
                                            <Click Handler="#{FeedBrowser}.show();" />
                                        </Listeners>
                                    </ext:MenuItem>
                                    <ext:MenuItem Text="Tarefas" Icon="PastePlain">
                                        <Listeners>
                                            <Click Handler="#{TasksBrowser}.show();" />
                                        </Listeners>
                                    </ext:MenuItem>
                                    <ext:MenuItem Text="Create dynamic" Icon="World">
                                        <Listeners>
                                            <Click Handler="createDynamicWindow(#{MyDesktop});" />
                                        </Listeners>
                                    </ext:MenuItem>
                                </Items>
                            </ext:Menu>
                        </Menu>
                    </ext:MenuItem>
                    <ext:MenuSeparator />
                </Items>
            </StartMenu>
        </ext:Desktop>
        
        <ext:Store ID="Store1" runat="server" OnRefreshData="MyData_Refresh">
            <Reader>
                <ext:ArrayReader>
                    <Fields>
                        <ext:RecordField Name="company" />
                        <ext:RecordField Name="price" Type="Float" />
                        <ext:RecordField Name="change" Type="Float" />
                        <ext:RecordField Name="pctChange" Type="Float" />
                        <ext:RecordField Name="lastChange" Type="Date" DateFormat="yyyy-MM-ddTHH:mm:ss" />
                    </Fields>
                </ext:ArrayReader>
            </Reader>
        </ext:Store>
        
        <ext:DesktopWindow 
            ID="winCustomer" 
            runat="server" 
            Title="Adicionar Novo Usuario" 
            InitCenter="false"
            Icon="User" 
            Padding="5"
            Width="350"
            Height="200"
            PageX="100" 
            PageY="25"
            Layout="Form">
            <Items>
                <ext:TextField ID="txtFirstName" runat="server" FieldLabel="Nome" Text="Steve" AnchorHorizontal="100%" />
                <ext:TextField ID="txtLastName" runat="server" FieldLabel="Sobrenome" Text="Caballero" AnchorHorizontal="100%" />
                <ext:TextField ID="txtCompany" runat="server" FieldLabel="Empresa" Text="Awesome Industries" AnchorHorizontal="100%" />
                <ext:ComboBox ID="cmbCountry" runat="server" FieldLabel="Pais" AnchorHorizontal="100%">
                    <SelectedItem Value="United States" />
                    <Items>
                        <ext:ListItem Text="Australia" />
                        <ext:ListItem Text="Canada" />
                        <ext:ListItem Text="Great Britian" />
                        <ext:ListItem Text="Japan" />
                        <ext:ListItem Text="United States" />
                    </Items>
                </ext:ComboBox>
                <ext:Checkbox ID="chkPremium" runat="server" FieldLabel="Administrador" Checked="true" AnchorHorizontal="100%" />
            </Items>
            <Buttons>
                <ext:Button ID="btnSaveCustomer" runat="server" Text="Save" Icon="Disk">
                    <Listeners>
                        <Click Handler="Ext.net.DirectMethods.AddCustomer({
                            success: function (customer) {
                                var template = 'ID: {0}{7} Name: {1} {2}{7} Company: {3}{7} Country: {4}{7} Premium Member: {5}{7} Date Created: {6}{7}',
                                    msg = String.format(template, 
                                            customer.ID, 
                                            customer.FirstName, 
                                            customer.LastName, 
                                            customer.Company, 
                                            customer.Country.Name, 
                                            customer.Premium, 
                                            customer.DateCreated,
                                            '&lt;br /&gt;&lt;br /&gt;');
                                
                                Ext.Msg.alert('Usuário Salvo', msg);
                            }
                        });" />
                    </Listeners>
                </ext:Button>
            </Buttons>
        </ext:DesktopWindow>
        
        <ext:DesktopWindow 
            ID="winCompany" 
            runat="server" 
            InitCenter="false"
            Title="Empresa" 
            Icon="Lorry"             
            Width="550"
            Height="320"
            PageX="200" 
            PageY="125"
            Layout="Fit">
            <TopBar>
                <ext:Toolbar ID="ToolBar1" runat="server">
                    <Items>
                        <ext:Button ID="btnSave" runat="server" Text="Salvar" Icon="Disk">
                            <Listeners>
                                <Click Handler="#{GridPanel1}.save();" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button ID="btnLoad" runat="server" Text="Atualizar" Icon="ArrowRefresh">
                            <Listeners>
                                <Click Handler="#{GridPanel1}.load();" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button ID="extbtnedit" runat="server" Icon="Add">
                            <ToolTips>
                                <ext:ToolTip ID="ToolTip2" Title="Edit Entry" runat="server" Html="Edit" />
                            </ToolTips>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>           
            <Items>
                <ext:GridPanel 
                    ID="GridPanel1" 
                    runat="server" 
                    StoreID="Store1" 
                    StripeRows="true"
                    Border="false"
                    AutoExpandColumn="Company">
                    <ColumnModel ID="ColumnModel1" runat="server">
                        <Columns>
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
                        </Columns>
                    </ColumnModel>
                    <SelectionModel>
                        <ext:RowSelectionModel ID="RowSelectionModel2" runat="server" />
                    </SelectionModel>
                    <LoadMask ShowMask="true" />
                    <BottomBar>
                        <ext:PagingToolbar ID="PagingToolBar2" runat="server" PageSize="10" StoreID="Store1" />
                    </BottomBar>
                </ext:GridPanel>
            </Items>
        </ext:DesktopWindow>
        
        <ext:DesktopWindow 
            ID="FeedBrowser" 
            runat="server" 
            Title="Leitor de Feed" 
            Icon="Feed"
            InitCenter="false"            
            Width="1000"
            Height="600"
            PageX="25" 
            PageY="25">
            <AutoLoad Url="../Feed_Viewer/default.aspx" Mode="IFrame" ShowMask="true" />
        </ext:DesktopWindow>

        <ext:DesktopWindow 
            ID="TasksBrowser" 
            runat="server" 
            Title="Tarefas" 
            Icon="PastePlain"
            InitCenter="false"            
            Width="1000"
            Height="600"
            PageX="25" 
            PageY="25">
            <AutoLoad Url="../Simple_Tasks/default.aspx" Mode="IFrame" ShowMask="true" />
        </ext:DesktopWindow>

    </form>
</body>
</html>

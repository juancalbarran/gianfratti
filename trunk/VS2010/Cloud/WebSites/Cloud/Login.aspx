<%@ Page Language="C#" %>

<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Gianfratti.com</title>    
    
    <script runat="server">
        protected void Button1_Click(object sender, DirectEventArgs e)
        {
            // Do some Authentication...

            FormsAuthentication.RedirectFromLoginPage("Fabrizio", true);
            // Then user send to application
            Response.Redirect("Desktop.aspx");
        }
    </script>
</head>
<body>
    <form id="Form1" runat="server">

        <ext:ResourceManager ID="ResourceManager1" runat="server" CleanResourceUrl="false" />
        
        <ext:Window 
            ID="Window1" 
            runat="server" 
            Closable="false"
            Resizable="false"
            Height="150" 
            Icon="Lock" 
            Title="Login"
            Draggable="false"
            Width="350"
            Modal="true"
            Padding="5"
            Layout="Form">
            <Items>
                <ext:TextField 
                    ID="txtUsername" 
                    runat="server" 
                    ReadOnly="false"
                    FieldLabel="Usuário" 
                    AllowBlank="false"
                    BlankText="Digite o nome de usuário."
                    Text="Demo"
                    />
                <ext:TextField 
                    ID="txtPassword" 
                    runat="server" 
                    ReadOnly="false"
                    InputType="Password" 
                    FieldLabel="Senha" 
                    AllowBlank="false" 
                    BlankText="Digite seua senha."
                    Text="Demo"
                    />
            </Items>
            <Buttons>
                <ext:Button ID="Button1" runat="server" Text="Acessar" Icon="Accept">
                    <DirectEvents>
                        <Click OnEvent="Button1_Click" Success="Window1.close();">
                            <EventMask ShowMask="true" Msg="Verificando..." MinDelay="1000" />
                        </Click>
                    </DirectEvents>
                </ext:Button>
            </Buttons>
        </ext:Window>
    </form>
</body>
</html>

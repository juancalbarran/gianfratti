<%@ Application Language="C#" %>
<%--Importamos a classe de log do Entrerprise Library--%>
<%@ Import Namespace="Microsoft.Practices.EnterpriseLibrary.Logging" %>


<script runat="server">

    void Application_Start(object sender, EventArgs e) 
    {
        // Code that runs on application startup

    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  Code that runs on application shutdown

    }
        
    void Application_Error(object sender, EventArgs e) 
    {
        //Caso o ocorra algum erro na aplicação entao a Entrerprise Library de log ira gravar na pasta log/erros.log ou conforme setado no web.config
        Exception ex = Server.GetLastError().GetBaseException();

        string message = ex.Message +
                        "\nSOURCE: " + ex.Source +
            //"\nFORM: " + Request.Form.ToString() + //Desabilitado o VIEWSTATE para o arquivo de log nao ficar tao grande
                        "\nQUERYSTRING: " + Request.QueryString.ToString() +
                        "\nTARGETSITE: " + ex.TargetSite +
                        "\nSTACKTRACE: " + ex.StackTrace;

        Logger.Write(message);
    }

    void Session_Start(object sender, EventArgs e) 
    {
        // Code that runs when a new session is started

    }

    void Session_End(object sender, EventArgs e) 
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.
        
        Session.Abandon();
    }
       
</script>

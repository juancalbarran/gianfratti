<HTML> 
Here's some text on your Web page. 
' This header tells proxy servers using HTTP/1.0 not to cache this request. 
<% Response.AddHeader "Pragma", "no-cache" %> 
<% Response.Flush %>  
<% Response.Write("Pragma is set to no-cache") %>  
</HTML> 


<%@ Language=JavaScript %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<%
	var xml = "<?xml version=\"1.0\" encoding=\"UTF-16\"?><cjb></cjb>";
	var xsl = "<?xml version=\"1.0\" encoding=\"UTF-16\"?><x:stylesheet version=\"1.0\" xmlns:x=\"http://www.w3.org/1999/XSL/Transform\" xmlns:m=\"urn:schemas-microsoft-com:xslt\"><x:template match=\"/\"><x:value-of select=\"system-property('m:version')\" /></x:template></x:stylesheet>";
	//var xsl = "<?xml version=\"1.0\" encoding=\"UTF-16\"?><x:stylesheet version=\"1.0\" xmlns:x=\"http://www.w3.org/TR/WD-xsl\"></x:stylesheet>";

	var x = null;
	var sniffer_msxml2_checked = "";
	var msxml2reason_innerText = "Installed";
	var sniffer_msxml2v26_checked = "";
	var msxml2v26reason_innerText = "Installed";
	var sniffer_msxml2v30_checked = "";
	var msxml2v30reason_innerText = "Installed";
	var sniffer_msxml2v40_checked = "";
	var msxml2v40reason_innerText = "Installed";
	var sniffer_msxml_checked = "";
	var msxmlreason_innerText = "Installed";
	var sniffer_replace_checked = "";
	var replacereason_innerText = "";
	var checked = "checked";
	
	try{ 
	    x = new ActiveXObject("Msxml2.DOMDocument"); 
	    x.async = false;
	    if (x.loadXML(xml)){
	   		sniffer_msxml2_checked = checked;
	   	}
	}catch(e){msxml2reason_innerText = e.description}
	 
	try{ 
	    x = new ActiveXObject("Msxml2.DOMDocument.2.6"); 
	    x.async = false;
	    if (x.loadXML(xml)) 
	    	  sniffer_msxml2v26_checked = checked;
	}catch(e){msxml2v26reason_innerText = e.description} 

	try{ 
	    x = new ActiveXObject("Msxml2.DOMDocument.3.0"); 
	    x.async = false;
	    if (x.loadXML(xml)) 
	    	  sniffer_msxml2v30_checked = checked;
	}catch(e){msxml2v30reason_innerText = e.description}

	try{ 
	    x = new ActiveXObject("Msxml2.DOMDocument.4.0"); 
	    x.async = false;
	    if (x.loadXML(xml)) 
	    	  sniffer_msxml2v40_checked = checked;
	}catch(e){msxml2v40reason_innerText = e.description}

	try{ 
	    x = new ActiveXObject("Microsoft.XMLDOM");  
	    x.async = false;
	    if (x.loadXML(xml))
	    	  sniffer_msxml_checked = checked;
	}catch(e){msxmlreason_innerText = e.description} 

	try{
		var s = new ActiveXObject("Microsoft.XMLDOM"); 
		s.async = false;
		if (s.loadXML(xsl)){
			try{
				var op = x.transformNode(s);
				if (op.indexOf("stylesheet") == -1){
					sniffer_replace_checked = checked;
					replacereason_innerText = "Replace V" + op.substr(op.lastIndexOf(">")+1);
				}else
					if (sniffer_msxml2_checked == checked)
						replacereason_innerText = "Side-By-Side";
			}catch(e){
				if (sniffer_msxml2_checked == checked)
						replacereason_innerText = "Side-By-Side";
			}
		}
	}catch(e){}

%>
<body bgcolor="#000000">

<h1 align="center"><font color="#ee8800">MSXML Sniffer</font></h1>
<form name="sniffer">
  <div align="center">
    <center>
    <table border="1" width="1%">
      <tr>
        <td width="1%" nowrap style="color:#ee8800;">MSXML</td>
        <td width="1%"><input type="checkbox" name="msxml" value="ON" disabled <%=sniffer_msxml_checked%>></td>
        <td id="msxmlreason" nowrap style="color:#ee8800;"><%=msxmlreason_innerText%></td>
      </tr>
      <tr>
        <td width="1%" nowrap style="color:#ee8800;">MSXML2</td>
        <td width="1%"><input type="checkbox" name="msxml2" value="ON" disabled <%=sniffer_msxml2_checked%>></td>
        <td id="msxml2reason" nowrap style="color:#ee8800;"><%=msxml2reason_innerText%></td>
      </tr>
      <tr>
        <td width="1%" nowrap style="color:#ee8800;">MSXML2 v2.6</td>
        <td width="1%"><input type="checkbox" name="msxml2v26" value="ON" disabled <%=sniffer_msxml2v26_checked%>></td>
        <td id="msxml2v26reason" nowrap style="color:#ee8800;"><%=msxml2v26reason_innerText%></td>
      </tr>
      <tr>
        <td width="1%" nowrap style="color:#ee8800;">MSXML2 v3.0</td>
        <td width="1%"><input type="checkbox" name="msxml2v30" value="ON" disabled <%=sniffer_msxml2v30_checked%>></td>
        <td id="msxml2v30reason" nowrap style="color:#ee8800;"><%=msxml2v30reason_innerText%></td>
      </tr>
      <tr>
        <td width="1%" nowrap style="color:#ee8800;">MSXML2 v4.0</td>
        <td width="1%"><input type="checkbox" name="msxml2v40" value="ON" disabled <%=sniffer_msxml2v40_checked%>></td>
        <td id="msxml2v40reason" nowrap style="color:#ee8800;"><%=msxml2v40reason_innerText%></td>
      </tr>
      <tr>
        <td width="1%" nowrap style="color:#ee8800;">Mode</td>
        <td width="1%"><input type="checkbox" name="replace" value="ON" disabled <%=sniffer_replace_checked%>></td>
        <td id="replacereason" nowrap style="color:#ee8800;"><%=replacereason_innerText%></td>
      </tr>
    </table>
    <br>
    <font color=white>from http://www.bayes.co.uk/xml/index.xml</font>
    </center>
  </div>
</form>
</body>
</HTML>

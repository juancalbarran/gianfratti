<html>
	<title>
	</title>
</html>
<script language="jscript" runat=server>
	var obj, file;
	
	Response.Write("This page test your server compliance with fullxml:<br>");
	
	//try to instantiate msxml4
	try{
	obj	= new ActiveXObject("msxml2.domdocument");
	obj.async = false;
	obj.loadXML("<test value='success'/>") 
	}
	catch(e) {
		 Response.Write("Msxml4 is not working.");
		 Response.End
	}
	
	//try to instantiate fso
	try
	{
		obj	= new ActiveXObject("Scripting.FileSystemObject");			
	}
	catch(e) {
		 Response.Write("You need to install vbscript runtime latest version (4.6)");
		 Response.End
	}
	
	
	//try to write the file
	/*
	try{
		file = obj.CreateTextFile(Server.MapPath("../db/test.txt"), true, true);
		file.Write("Good");
		file.close();
	}
	catch(e){
		Response.Write(e)
		Response.Write("Cannot write to the DB folder");
		Response.End
	}
	*/
	Response.Write( "Everything is fine, your configuration is OK.");
</script>

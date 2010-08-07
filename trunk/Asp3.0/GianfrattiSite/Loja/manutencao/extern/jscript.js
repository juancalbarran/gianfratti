<!-- Powered by aspAccessEditor 1.1.0. Copyright ©2001-2002 AspIt  -->

<!--  Begin

function ConfirmLink(Link, Msg) {
	if (confirm(Msg)) {
		window.location = Link;
	}
}


function changetitle(title) {
	if (typeof(parent.document.title) == 'string') {
	    parent.document.title = title;
	}	
}

function Left(str, n)
	    // JavaScript Function Written by:
           //    Scott Mitchell
	  //    mitchell@4guysfromrolla.com
	 //    http://www.4GuysFromRolla.com
        /***
		IN: str - the string we are LEFTing
                    n - the number of characters we want to return

                RETVAL: n characters from the left side of the string
	***/
{
	if (n <= 0)     // Invalid bound, return blank string
		return "";
	else if (n > String(str).length)   // Invalid bound, return
		return str;                // entire string
	else // Valid bound, return appropriate substring
		return String(str).substring(0,n);
}

function UCase(s){
	return s.toUpperCase();
}

function openwindow(url, width, height, left, top) {
	// open a window window
	window.open(url, "newWin", "toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1,width="+width+",height="+height+",left="+left+",top="+top);
}

// End -->
	// Make Variables----------------------
	var imgMouseOverHolder = new Array();
	var imgMouseDownHolder = new Array();
	//-------------------------------------

function preloader(imgTags){

	// Create Variables------------------
	var newmouseover, newmouseout, newmouseup, newmousedown, oldmouseover, oldmouseout, oldmouseup, oldmousedown
	//-----------------------------------
	
	// Get array length--------------
	var AL = imgMouseOverHolder.length + 1;
	//-------------------------------

	for (var i = 0; i < imgTags.length; i++) {

		if (imgTags[i].getAttribute('srcdown')||imgTags[i].getAttribute('srcover')) {
	
		newmouseover = null; newmouseout = null; newmouseup = null;	newmousedown = null; oldmouseover = null; oldmouseout = null; oldmouseup = null; oldmousedown = null

			// Store src Images------------------
			if (imgTags[i].getAttribute('srcover')) {imgMouseOverHolder[AL] = new Image(); imgMouseOverHolder[AL].src = imgTags[i].getAttribute('srcover');}
			if (imgTags[i].getAttribute('srcdown')) {imgMouseDownHolder[AL] = new Image(); imgMouseDownHolder[AL].src = imgTags[i].getAttribute('srcdown');}
			//-----------------------------------
			
			// Make backups----------------------
			if (imgTags[i].src) {imgTags[i].setAttribute("oldsrc", imgTags[i].src);}
			//-----------------------------------
				
			if (imgTags[i].getAttribute('srcover')) {
			
				// Make Mouse over--------------------
				if (imgTags[i].onmouseover) {imgTags[i].oldmouseover = imgTags[i].onmouseover; newmouseover = function (){this.src=this.getAttribute("srcover"); this.oldmouseover();}}
				else {newmouseover = function (){this.src=this.getAttribute("srcover");}}
				imgTags[i].onmouseover = newmouseover;
				//------------------------------------
			
				// Make Mouse out--------------------
				if (imgTags[i].onmouseout){imgTags[i].oldmouseout = imgTags[i].onmouseout; newmouseout = function (){this.src=this.getAttribute("oldsrc"); this.oldmouseout();}}
				else {newmouseout = function (){this.src=this.getAttribute("oldsrc");}}
				imgTags[i].onmouseout = newmouseout;
				//-----------------------------------
			}
			
			if (imgTags[i].getAttribute('srcdown')) {	
			
			// Make Mouse Down---------------------
			if (imgTags[i].onmousedown) {imgTags[i].oldmousedown = imgTags[i].onmousedown; newmousedown = function (){this.src=this.getAttribute("srcdown"); this.oldmousedown();}}
			else {newmousedown = function (){this.src=this.getAttribute("srcdown");}}
			imgTags[i].onmousedown = newmousedown;
			//-------------------------------------
			
				if (imgTags[i].getAttribute('srcover')) {
						
					// Make Mouse up-----------------------
					if (imgTags[i].onmouseup) {imgTags[i].oldmouseup = imgTags[i].onmouseup; newmouseup = function (){this.src=this.getAttribute("srcover"); this.oldmouseup();}}
					else {newmouseup = function (){this.src=this.getAttribute("srcover");}}
					imgTags[i].onmouseup = newmouseup;
					//-------------------------------------
				
				} else {
								
					//Make Mouse up-------------------------
					if (imgTags[i].onmouseup) {imgTags[i].oldmouseup = imgTags[i].onmouseup; newmouseup = function (){this.src=this.getAttribute("oldsrc"); this.oldmouseup();}}
					else {newmouseup = function (){this.src=this.getAttribute("oldsrc");}}
					imgTags[i].onmouseup = newmouseup;
					//-------------------------------------
					
					// Make Mouse out--------------------
					if (imgTags[i].onmouseout) {imgTags[i].oldmouseout = imgTags[i].onmouseout; newmouseout = function (){this.src=this.getAttribute("oldsrc"); this.oldmouseout();}}
					else {newmouseout = function (){this.src=this.getAttribute("oldsrc");}}
					imgTags[i].onmouseout = newmouseout;
					//-----------------------------------
				
				}
				
			}
		}
	}
}

function preloadimgsrc() {

	// Check to see if document element----
	if (!document.getElementById) return;
	//-------------------------------------
	
	// Declare variables--------------------
	var imgTags = document.getElementsByTagName('IMG'); 
	var imgTags2 = document.getElementsByTagName('INPUT');   // For image type submit buttons 
	//--------------------------------------
	
	// Preload Images-----------------------
	preloader(imgTags);
	preloader(imgTags2);  // For image type submit buttons 
	//--------------------------------------
}

if (window.addEventListener)
window.addEventListener("load", preloadimgsrc, false)
else if (window.attachEvent)
window.attachEvent("onload", preloadimgsrc)
else if (document.getElementById)
window.onload=preloadimgsrc

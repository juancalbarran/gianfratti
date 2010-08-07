/*
 DHTML Menu version 3.3.19
 Written by Andy Woolley
 Copyright 2002 (c) Milonic Solutions. All Rights Reserved.
 Plase vist http://www.milonic.co.uk/menu or e-mail menu3@milonic.com
 You may use this menu on your web site free of charge as long as you place prominent links to http://www.milonic.co.uk/menu and
 your inform us of your intentions with your URL AND ALL copyright notices remain in place in all files including your home page
 Comercial support contracts are available on request if you cannot comply with the above rules.
 This script featured on Dynamic Drive (http://www.dynamicdrive.com)
 */

//The following line is critical for menu operation, and MUST APPEAR ONLY ONCE. If you have more than one menu_array.js file rem out this line in subsequent files
menunum=0;menus=new Array();_d=document;function addmenu(){menunum++;menus[menunum]=menu;}function dumpmenus(){mt="<script language=javascript>";for(a=1;a<menus.length;a++){mt+=" menu"+a+"=menus["+a+"];"}mt+="<\/script>";_d.write(mt)}
//Please leave the above line intact. The above also needs to be enabled if it not already enabled unless this file is part of a multi pack.



////////////////////////////////////
// Editable properties START here //
////////////////////////////////////

// Special effect string for IE5.5 or above please visit http://www.milonic.co.uk/menu/filters_sample.php for more filters
if(navigator.appVersion.indexOf("MSIE 6.0")>0)
{
	effect = "Fade(duration=0.2);Alpha(style=0,opacity=88);Shadow(color='#777777', Direction=135, Strength=5)"
}
else
{
	effect = "Shadow(color='#777777', Direction=135, Strength=5)" // Stop IE5.5 bug when using more than one filter
}


timegap=500				// The time delay for menus to remain visible
followspeed=5			// Follow Scrolling speed
followrate=40			// Follow Scrolling Rate
suboffset_top=10;		// Sub menu offset Top position 
suboffset_left=10;		// Sub menu offset Left position

style1=[				// style1 is an array of properties. You can have as many property arrays as you need. This means that menus can have their own style.
"navy",					// Mouse Off Font Color
"ccccff",				// Mouse Off Background Color
"ffebdc",				// Mouse On Font Color
"4b0082",				// Mouse On Background Color
"000000",				// Menu Border Color 
12,						// Font Size in pixels
"normal",				// Font Style (italic or normal)
"bold",					// Font Weight (bold or normal)
"Verdana, Arial",		// Font Name
4,						// Menu Item Padding
"arrow.gif",			// Sub Menu Image (Leave this blank if not needed)
,						// 3D Border & Separator bar
"66ffff",				// 3D High Color
"000099",				// 3D Low Color
"Purple",				// Current Page Item Font Color (leave this blank to disable)
"pink",					// Current Page Item Background Color (leave this blank to disable)
"arrowdn.gif",			// Top Bar image (Leave this blank to disable)
"ffffff",				// Menu Header Font Color (Leave blank if headers are not needed)
"000099",				// Menu Header Background Color (Leave blank if headers are not needed)
]



addmenu(menu=[		// This is the array that contains your menu properties and details
"mainmenu",			// Menu Name - This is needed in order for the menu to be called
20,					// Menu Top - The Top position of the menu in pixels
200,				// Menu Left - The Left position of the menu in pixels
,					// Menu Width - Menus width in pixels
1,					// Menu Border Width 
,					// Screen Position - here you can use "center;left;right;middle;top;bottom" or a combination of "center:middle"
style1,				// Properties Array - this is set higher up, as above
1,					// Always Visible - allows the menu item to be visible at all time (1=on/0=off)
"left",				// Alignment - sets the menu elements text alignment, values valid here are: left, right or center
effect,				// Filter - Text variable for setting transitional effects on menu activation - see above for more info
,					// Follow Scrolling - Tells the menu item to follow the user down the screen (visible at all times) (1=on/0=off)
1, 					// Horizontal Menu - Tells the menu to become horizontal instead of top to bottom style (1=on/0=off)
,					// Keep Alive - Keeps the menu visible until the user moves over another menu or clicks elsewhere on the page (1=on/0=off)
,					// Position of TOP sub image left:center:right
,					// Set the Overall Width of Horizontal Menu to 100% and height to the specified amount (Leave blank to disable)
,					// Right To Left - Used in Hebrew for example. (1=on/0=off)
,					// Open the Menus OnClick - leave blank for OnMouseover (1=on/0=off)
,					// ID of the div you want to hide on MouseOver (useful for hiding form elements)
,					// Reserved for future use
,					// Reserved for future use
,					// Reserved for future use
,"Home","http://www.dynamicdrive.com",,"Back to the home page",1 // "Description Text", "URL", "Alternate URL", "Status", "Separator Bar"
,"News&nbsp;sites&nbsp;&nbsp;","show-menu=news",,"",1
,"Webmaster&nbsp;&nbsp;","show-menu=webmaster",,"",1
,"Downloads&nbsp;&nbsp;","show-menu=downloads",,"",1
,"Search&nbsp;&nbsp;","show-menu=search",,"",1
,"Other&nbsp;&nbsp;","show-menu=other",,"",1
])

	addmenu(menu=["news",
	,,120,1,"",style1,,"left",effect,,,,,,,,,,,,
	,"General","show-menu=generalnews",,,1
	,"Technology","show-menu=technonews",,,1
	])
	
	
		addmenu(menu=["generalnews",
		,,170,1,"",style1,,"left",effect,,,,,,,,,,,,
		,"CNN","http://www.cnn.com",,,0
		,"MSNBC","http://www.msnbc.com",,,0
		,"ABC News","http://www.abcnews.com",,,0
		,"Vancouver Local News","show-menu=canadanews",,,0
		,"BBC News","http://news.bbc.co.uk",,,0
		])

			addmenu(menu=["canadanews",
			,,120,1,"",style1,,"left",effect,,,,,,,,,,,,
			,"CTV News","http://www.ctvnews.com",,,
			,"Vancouver Sun","http://www.canada.com/vancouver/vancouversun/",,,
			])
		
		addmenu(menu=["technonews",
		,,110,1,"",style1,,"left",effect,,,,,,,,,,,,
		,"TechWeb","http://www.cnn.com",,,0
		,"News.com","http://www.news.com",,,0
		,"Wired News","http://www.wired.com",,,0
		,"Slashdot","http://www.slashdot.com",,,0		
		])



	addmenu(menu=["webmaster",
	,,170,1,"",style1,,"left",effect,,,,,,,,,,,,
	,"<img src=newsimage.gif border=0>&nbsp;Dynamic Drive","http://www.dynamicdrive.com",,,1
	,"<img src=newsimage.gif border=0>&nbsp;JavaScript Kit","http://www.javascriptkit.com",,,1
	,"<img src=newsimage.gif border=0>&nbsp;Freewarejava.Com","http://www.freewarejava.com",,,1
	,"<img src=newsimage.gif border=0>&nbsp;Active-X.com","http://www.active-x.com",,,1
	,"<img src=newsimage.gif border=0>&nbsp;Web Monkey","http://www.webmonkey.com",,,1
	,"<img src=newsimage.gif border=0>&nbsp;Jars","http://www.jars.com",,,1
	])
	
	addmenu(menu=["downloads",,,120,1,,style1,0,"left",effect,0,,,,,,,,,,,
	,"Download.com","http://www.download.com",,,1
	,"Tucows","http://www.tucows.com",,,1
	])
	
	addmenu(menu=["search",
	,,140,1,"",style1,,"",effect,,,,,,,,,,,,
	,"<img src=google_icon.gif border=0>&nbsp;Google.com", "http://www.google.com",,,1
	,"<img src=yahoo_icon.gif border=0>&nbsp;Yahoo", "http://www.yahoo.com",,,1
	,"<img src=av_icon.gif border=0>&nbsp;Altavista", "http://altavista.com",,,1
	,"<img src=excite.gif border=0>&nbsp;Excite", "http://www.excite.com",,,1
	])
	
	addmenu(menu=["Other",,,140,1,,style1,0,"left","randomdissolve(duration=0.5);Shadow(color='#999999', Direction=135, Strength=5)",0,,,,,,,,,,,
	,"Menu Authors Site","http://www.milonic.co.uk/menu",,"Milonic DHTML Menu Site",1
	])
	

dumpmenus()
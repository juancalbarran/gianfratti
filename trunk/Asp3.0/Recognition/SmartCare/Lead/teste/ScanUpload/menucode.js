
/* assumes IE4 or above*/

/*****************************************************************************
*****************************************************************************/
var zIndexMax = 500;
var lastElem='';
var overmenu=false;
document.onmouseover=docmouseover;

function popupMenu(elem, Ypos, Xpos, width, height, itemWidth) {
  this.elem = elem;          // the element's ID
  this.Ypos = Ypos;          // the element's top property
  this.Xpos = Xpos;          // the element's left property
  this.width = width;        // the element's width
  this.height = height;      // the element's height
  this.itemWidth = itemWidth // the box width
  this.show = false;         // the element's visibility
  this.createMainMenu = createMainMenu; // method to create the main menus
  this.createMenuItem = createMenuItem; // method to create the menu items
  this.ToggleShow = ToggleShow;     // sets the element's visibility
  
}

function createMainMenu(MENU, bkgColor, bdrColor, fontColor) {
  var padding = 'padding: 2;'; 
  document.write(
    '<STYLE TYPE="text/css">',
    '#', this.elem, 'main {',
      'position: absolute;',
      'left: ', this.Xpos, '; top: ', this.Ypos, ';',
      'width: ', this.width, '; height: ', this.height, ';',
      'layer-background-color: ', bkgColor, ';',
      'font: normal 9pt Tahoma;',
      'text-decoration: none;',
      'background-color: ', bkgColor, ';',
      'border-width: 1;',
      'border-style: solid;',
      'border-color: ', bdrColor, ';',
      'z-index: 1;', padding,
    '}',
    '</STYLE>',
    '<DIV onmouseout=mouseoffitem(',this.elem,') onmouseover=mouseonitem(',this.elem,') ID="', this.elem, 'main">',
    '<A HREF="javascript:', this.elem, '.ToggleShow()">',
    '<FONT COLOR=',fontColor, '>', MENU, '</FONT>',    
    '</A></DIV>'
  );
}

function createMenuItem(bkgColor, bdrColor,  menuItem) {
  var padding = 'padding: 3;';
  document.write(
    '<STYLE TYPE="text/css">',
    '#', this.elem, 'item {',
      'position: absolute;',
      'left: ', this.Xpos, '; top: ', this.Ypos+this.height, ';',
      'width: ', this.itemWidth, ';',
      'layer-background-color: ', bkgColor, ';',
      'background-color: ', bkgColor, ';',
      'font: normal 10pt Tahoma;',
      'text-decoration: none;',
      'visibility: hidden;',
      'border-width: 1;',
      'border-style: solid;',
      'border-color: ', bdrColor, ';',
       padding,
      'z-index: 1',
    '}',
    '</STYLE>',
    '<DIV onmouseout=mouseoffitem(',this.elem,') onmouseover=mouseonitem(',this.elem,') ID="', this.elem, 'item">',
    menuItem,
    '</DIV>'
  );
}


function MakeVisible(anItem)
{
	anItem.show=!anItem.show;
    eval(anItem.elem + 'item.style.zIndex = ' + (++zIndexMax));
    eval(anItem.elem + 'item.style.visibility = "visible"'); 
}
function MakeHidden(anItem)
{
	anItem.show=!anItem.show;
    eval(anItem.elem + 'item.style.zIndex = ' + (++zIndexMax));
    eval(anItem.elem + 'item.style.visibility = "hidden"'); 	
}

function ToggleShow() 
{
	if(this.show)
	{
		MakeHidden(this);
	}
	else
	{
		MakeVisible(this);
	}
}



function mouseonitem(AnItem)
{
	overmenu=true;
	
	if(lastElem=='')
	{
		lastElem=AnItem;
		MakeVisible(AnItem);
	}
	if(lastElem!=AnItem)
	{
		MakeHidden(lastElem);
		lastElem=AnItem;
		MakeVisible(AnItem);
	}
}

function mouseoffitem(AnItem)
{
	lastElem=AnItem;
	overmenu=false;
}

function docmouseover()
{
	if(lastElem!='' && !overmenu)
	{
		MakeHidden(lastElem);
		lastElem='';
	}

}

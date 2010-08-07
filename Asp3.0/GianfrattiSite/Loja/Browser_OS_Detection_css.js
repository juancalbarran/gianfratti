// Browser & OS Detection for .css files
var tmpBrowser	= navigator.appName.toLowerCase();
var tmpOS		= navigator.platform.toLowerCase();
var intAdjust	= 0;
var	c_smaller	= 7;
var	c_small		= 8;
var c_medium	= 9;
var c_large		= 10;
var c_larger	= 12;

if (tmpOS.indexOf("mac")!=-1){
	if (tmpBrowser.indexOf("netscape")!=-1){intAdjust=2}
	else {
		if (navigator.appVersion.indexOf("5.0")>0) {		
			intAdjust=0;
			}						
		else 
			{					
			intAdjust = 2 
			if ((navigator.appVersion.indexOf("4.") > 0) && (navigator.appName.indexOf("etscape") > 0) ) {
				intAdjust=3;
				}				
			}
		}
	}
if (tmpOS.indexOf("win")!=-1){
	if (tmpBrowser.indexOf("netscape")!=-1){intAdjust=.5}
	else {intAdjust = 0}
	}

if (navigator.userAgent.indexOf("Gecko") != -1 ) {
	intAdjust=0;
}

c_smaller		= c_smaller + intAdjust;
c_small			= c_small + intAdjust;
c_medium		= c_medium + intAdjust;
c_large			= c_large + intAdjust;
c_larger		= c_larger + intAdjust;

if ((c_smaller<7)&&(intAdjust==-1)) {c_smaller=7}
if ((c_smaller<9)&&(intAdjust==1)) {c_smaller=9}

document.write ( "<style>" );
document.write ( ".ti { FONT-WEIGHT: normal; FONT-SIZE: "+c_smaller+"pt; COLOR: #000000; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".sm { FONT-WEIGHT: normal; FONT-SIZE: "+c_small+"pt; COLOR: #000000; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".smcornblue { FONT-WEIGHT: normal; FONT-SIZE: "+c_small+"pt; COLOR: #1A42D1; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: underline }" );
document.write ( ".cornblue-lg { FONT-WEIGHT: bold; FONT-SIZE: 20pt; COLOR: #1A42D1; FONT-FAMILY: arial, verdana, helvetica; }" );
document.write ( ".cornblue-b {font-weight:bold; font-size:9pt; color: #1A42D1; font-family:arial, verdana, helvetica,;TEXT-DECORATION: none;}" );

document.write ( ".drk_blue {font-weight:normal; font-size:10px; color: #2B2A63; font-family: verdana, arial, helvetica,;TEXT-DECORATION: none;}" );
document.write ( ".drk_blue-heading {font-weight:bold; font-size:10px; color: #405E91; font-family: verdana, arial, helvetica,;TEXT-DECORATION: none;}" );
document.write ( ".drk_red-heading {font-weight:bold; font-size:10px; color: #FF0100; font-family: verdana, arial, helvetica,;TEXT-DECORATION: none;}" );


document.write ( ".smb { FONT-WEIGHT: bold; FONT-SIZE: "+c_small+"pt; COLOR: #000000; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".sbg { FONT-WEIGHT: bold; FONT-SIZE: "+c_small+"pt; COLOR: #707070; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".sg { FONT-WEIGHT: normal; FONT-SIZE: "+c_small+"pt; COLOR: #707070; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".mbg { FONT-WEIGHT: bold; FONT-SIZE: "+c_medium+"pt; COLOR: #707070; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".rdt { FONT-SIZE: "+c_smaller+"pt; COLOR: #cc0000; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );

document.write ( ".md { FONT-WEIGHT: normal; FONT-SIZE: "+c_medium+"pt; COLOR: #000000; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".mdb { FONT-WEIGHT: bold; FONT-SIZE: "+c_medium+"pt; COLOR: #000000; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".lrgb { FONT-WEIGHT: bold; FONT-SIZE: "+c_larger+"pt; COLOR: #000000; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );

document.write ( ".lg { FONT-WEIGHT: normal; FONT-SIZE: "+c_large+"pt; COLOR: #000000; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".lgb { FONT-WEIGHT: bold; FONT-SIZE: "+c_large+"pt; COLOR: #000000; LINE-HEIGHT: 10pt; FONT-FAMILY: verdana, arial, helvetica; TEXT-DECORATION: none }" );
document.write ( ".lgrb { FONT-WEIGHT: bold; FONT-SIZE: "+c_larger+"pt; COLOR: #000000; LINE-HEIGHT: 12pt; FONT-FAMILY: verdana, arial, helvetica; TEXT-DECORATION: none }" );

document.write ( ".w-smb { FONT-WEIGHT: bold; FONT-SIZE: "+c_small+"pt; COLOR: #ffffff; LINE-HEIGHT: 8pt; FONT-FAMILY: verdana, arial, helvetica; TEXT-DECORATION: none; }" );
document.write ( ".w-md { FONT-WEIGHT: normal; FONT-SIZE: "+c_medium+"pt; COLOR: #ffffff; LINE-HEIGHT: 10pt; FONT-FAMILY: verdana, arial, helvetica; TEXT-DECORATION: none; }" );
document.write ( ".wb { FONT-WEIGHT: bold; FONT-SIZE: "+c_medium+"pt; COLOR: #ffffff; LINE-HEIGHT: 10pt; FONT-FAMILY: verdana, arial, helvetica; TEXT-DECORATION: none; }" );
document.write ( ".wbu { FONT-WEIGHT: bold; FONT-SIZE: "+c_medium+"pt; COLOR: #ffffff; LINE-HEIGHT: 10pt; FONT-FAMILY: verdana, arial, helvetica; TEXT-DECORATION: underline }" );
document.write ( ".w-lg { FONT-WEIGHT: normal; FONT-SIZE: "+c_large+"pt; COLOR: #ffffff; LINE-HEIGHT: 10pt; FONT-FAMILY: verdana, arial, helvetica; TEXT-DECORATION: none; }" );
document.write ( ".wb-lg { FONT-WEIGHT: bold; FONT-SIZE: "+c_large+"pt; COLOR: #ffffff; LINE-HEIGHT: 10pt; FONT-FAMILY: verdana, arial, helvetica; TEXT-DECORATION: none; }" );
document.write ( ".wb-lgr { FONT-WEIGHT: bold; FONT-SIZE: "+c_larger+"pt; COLOR: #ffffff; LINE-HEIGHT: 12pt; FONT-FAMILY: verdana, arial, helvetica; TEXT-DECORATION: none; }" );


document.write ( ".headerBL { FONT-WEIGHT: bolder; FONT-SIZE: 10pt; COLOR: #000000; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".bu { FONT-WEIGHT: normal; FONT-SIZE: "+c_small+"pt; COLOR: #000000; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: underline }" );

document.write ( ".blue-md-u { FONT-WEIGHT: normal; FONT-SIZE: "+c_medium+"pt; COLOR: #0000ff; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: underline }" );


document.write ( ".bb { FONT-WEIGHT: normal; FONT-SIZE: "+c_small+"pt; COLOR: #000000; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".bb-b { FONT-WEIGHT: bold; FONT-SIZE: "+c_small+"pt; COLOR: #000000; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".bb:visited { FONT-WEIGHT: normal; FONT-SIZE: "+c_small+"pt; COLOR: #000000; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".bb:hover { FONT-WEIGHT: normal; FONT-SIZE: "+c_small+"pt; COLOR: #cc0000; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".bh { FONT-WEIGHT: normal; FONT-SIZE: "+c_small+"pt; COLOR: #0022b1; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".bh:visited { FONT-WEIGHT: normal; FONT-SIZE: "+c_small+"pt; COLOR: #0022b1; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".bh:hover { FONT-WEIGHT: normal; FONT-SIZE: "+c_small+"pt; COLOR: #cc0000; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: underline }" );
document.write ( ".bh-md { FONT-WEIGHT: normal; FONT-SIZE: "+c_medium+"pt; COLOR: #0022b1; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".bh-bold { FONT-WEIGHT: bold; FONT-SIZE: "+c_medium+"pt; COLOR: #055DC3; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".bh-md:visited { FONT-WEIGHT: normal; FONT-SIZE: "+c_medium+"pt; COLOR: #0022b1; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".bh-md:hover { FONT-WEIGHT: normal; FONT-SIZE: "+c_medium+"pt; COLOR: #cc0000; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: underline }" );

document.write ( ".bbh { FONT-WEIGHT: normal; FONT-SIZE: "+c_smaller+"pt; COLOR: #0165FF; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".bbb { FONT-WEIGHT: bold; FONT-SIZE: "+c_smaller+"pt; COLOR: #0165FF; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".bbh:visited { FONT-WEIGHT: normal; FONT-SIZE: "+c_smaller+"pt; COLOR: #0165FF; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: underline }" );
document.write ( ".bbh:hover { FONT-WEIGHT: normal; FONT-SIZE: "+c_smaller+"pt; COLOR: #cc0000; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: underline }" );

document.write ( ".rh { FONT-WEIGHT: normal; FONT-SIZE: "+c_small+"pt; COLOR: #cc0000; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".rh:visited { FONT-WEIGHT: normal; FONT-SIZE: "+c_small+"pt; COLOR: #cc0000; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".rh:hover { FONT-WEIGHT: normal; FONT-SIZE: "+c_small+"pt; COLOR: #cc0000; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: underline }" );
document.write ( ".rb { FONT-WEIGHT: bold; FONT-SIZE: "+c_small+"pt; COLOR: #cc0000; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".gh { FONT-WEIGHT: normal; FONT-SIZE: "+c_small+"pt; COLOR: #707070; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: underline }" );
document.write ( ".gh:hover { FONT-WEIGHT: normal; FONT-SIZE: "+c_small+"pt; COLOR: #cc0000; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: underline }" );
document.write ( ".gh:visited { FONT-WEIGHT: normal; FONT-SIZE: "+c_small+"pt; COLOR: #707070; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: underline }" );
document.write ( ".wh { FONT-WEIGHT: normal; FONT-SIZE: "+c_small+"pt; COLOR: #ffffff; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".wh:visited { FONT-WEIGHT: normal; FONT-SIZE: "+c_small+"pt; COLOR: #ffffff; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".wh:hover { FONT-WEIGHT: normal; FONT-SIZE: "+c_small+"pt; COLOR: #ffffff; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: underline }" );
document.write ( ".rd { FONT-SIZE: "+c_small+"pt; COLOR: #cc0000; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".rdl { FONT-SIZE: "+c_large+"pt; COLOR: #cc0000; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".rd:visited { FONT-SIZE: "+c_small+"pt; COLOR: #cc0000; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".rd-lg { FONT-SIZE: "+c_large+"pt; COLOR: #cc0000; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( ".rd:hover { FONT-SIZE: "+c_small+"pt; COLOR: #ff0808; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: underline }" );
document.write ( ".searchfont { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: "+c_small+"pt}" );
document.write ( ".searchtitle { font-family: Verdana, Arial, Helvetica, sans-serif; font-weight: normal; color: #707070; font-size: "+c_small+"pt}" );
document.write ( ".searchforms { font-family: Verdana, Arial, Helvetica, sans-serif; font-weight: normal; color: #333333; font-size: "+c_small+"pt}" );
document.write ( ".searchlinks { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: "+c_small+"pt; color: #000099; text-decoration: underline}" );
document.write ( ".price { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: "+c_small+"pt; text-decoration: none}" );
document.write ( "td { FONT-WEIGHT: normal; FONT-SIZE: "+c_small+"pt; COLOR: #000000; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( "p { FONT-WEIGHT: normal; FONT-SIZE: "+c_small+"pt; COLOR: #000000; FONT-FAMILY: verdana,arial,helvetica; TEXT-DECORATION: none }" );
document.write ( "</style>" );
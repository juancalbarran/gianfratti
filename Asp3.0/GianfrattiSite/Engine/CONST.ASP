<%
	'ACTIONS
	CONST ACTION_NONE		= ""
	CONST ACTION_PAGE		= "0"
	CONST ACTION_ADMIN		= "1"
	CONST ACTION_PHOTO		= "2"
	CONST ACTION_VOTE		= "3"
	CONST ACTION_SEARCH		= "4"
	CONST ACTION_ARTICLE		= "5"
	CONST ACTION_NEWSLETTER		= "6"
	CONST ACTION_GUESTBOOK		= "7"
	CONST ACTION_POST		= "8"
	CONST ACTION_SIGNUP		= "9"
	CONST ACTION_ADDMEMBER		= "10"
	CONST ACTION_LOGOFF		= "11"
	CONST ACTION_REACT		= "12"
	CONST ACTION_POSTREACT		= "13"
	CONST ACTION_CHOOSEDISCUSS	= "14"
	CONST ACTION_DISCUSS		= "15"
	CONST ACTION_DISCUSS_MSG	= "16"
	CONST ACTION_DISCUSS_DETAIL	= "17"
	CONST ACTION_SITEMAP		= "18"
	CONST ACTION_DOWNLOAD		= "19"
	CONST ACTION_PASSWORD		= "20"
	CONST ACTION_PASSWORDSEND	= "21"
	CONST ACTION_ACCOUNT		= "22"
	CONST ACTION_ACCOUNTSEND	= "23"
	CONST ACTION_DIRECTORY		= "24"
	CONST ACTION_MESSAGE		= "25"
	CONST ACTION_FAQ		= "26"
	CONST ACTION_CLASSIFIED		= "70"
	CONST ACTION_MEMBERMANAGER	= "80"
	CONST ACTION_MEMBERPROFILE	= "81"
	CONST ACTION_FRIENDS		= "82"
	CONST ACTION_INTERNALMESSAGE	= "83"
	CONST ACTION_KNOWLEDGE		= "90"
	CONST ACTION_CALENDAR		= "91"
	CONST ACTION_CHATMAN		= "92"
	CONST ACTION_CHAT		= "93"
	CONST ACTION_VERSION		= "94"
	CONST ACTION_SHOP		= "95"
	
	'Error messages
	CONST ERR_NONE			= ""
	CONST ERR_LOGIN_PWD		= "0"
	CONST ERR_VOTE_SPAM		= "1"
	CONST ERR_WELCOME		= "2"
	CONST ERR_FILL_FORM		= "3"
	CONST ERR_USERNAME		= "4"
	CONST ERR_FULL_XML		= "5"
	
	'System
	CONST MSXML4			= True
	CONST USE_CACHE			= False
	CONST VERSION_NUMBER		= "242"
	CONST WEBFARM			= False
	CONST COUNTER			= True
	CONST URL_REWRITE		= True
	
	'Cookie - added VOTE_COOKIE_NAME for a non-session cookie for voting
	CONST COOKIE_NAME		= "fullxml"
	
	CONST VOTE_COOKIE_NAME		= "FULLXMLVote"

	CONST SESSION_EXPIRE		= 30	'in minutes
	CONST COOKIE_RMB_EXPIRE		= 60	'in days
	CONST COOKIE_VALUE_SESSION	= "sid"

	CONST CRYPT_RC4_KEY		= "1d5tY4r7"
	CONST COOKIE_RMB_NAME		= "fxrmb"
	CONST COOKIE_VALUE_USR		= "u"
	CONST COOKIE_VALUE_PWD		= "p"
	

	'+--------------------------------------------------------------+
	'|						FOLDERS									|
	'+--------------------------------------------------------------+
	DIM ROOT_PATH			: ROOT_PATH		= server.MapPath(".")
	DIM LANGS_PATH			: LANGS_PATH		= ROOT_PATH & "\Engine\languages"
	DIM DB_DIRECTORY
	
	DIM UPLOAD_VIRTUAL_PATH	
	'DB_DIRECTORY			= "C:\Domains\gianfratti.com\wwwroot\db"
	DB_DIRECTORY			= ROOT_PATH & "\db"
	UPLOAD_VIRTUAL_PATH		= "media\"
	
	' If this option is set, then the subdomain is used in the path of the db, so each site can have its own data
	if WEBFARM then
		DB_DIRECTORY		= DB_DIRECTORY & "\" & mid(Request.ServerVariables("SERVER_NAME"),1 ,instr(1, Request.ServerVariables("SERVER_NAME"), ".")-1)
		UPLOAD_VIRTUAL_PATH = UPLOAD_VIRTUAL_PATH & mid(Request.ServerVariables("SERVER_NAME"),1 ,instr(1, Request.ServerVariables("SERVER_NAME"), ".")-1) & "\"
	end if
	
	DIM UPLOAD_PATH         	: UPLOAD_PATH       	= ROOT_PATH & "\" & UPLOAD_VIRTUAL_PATH                 
	DIM LOGS_FOLDER         	: LOGS_FOLDER       	= DB_DIRECTORY & "\logs"
	DIM ARTICLES_FOLDER		: ARTICLES_FOLDER	= DB_DIRECTORY & "\articles"
	
	
	
	'+--------------------------------------------------------------+
	'|						DATA FILES PATH							|
	'+--------------------------------------------------------------+
	DIM DATA_PATH			: DATA_PATH		= DB_DIRECTORY & "\data.xml"
	DIM MEMBER_PATH			: MEMBER_PATH		= DB_DIRECTORY & "\member.xml"
	DIM CATEGORY_PATH		: CATEGORY_PATH		= DB_DIRECTORY & "\category.xml"
	DIM BANNER_PATH			: BANNER_PATH		= DB_DIRECTORY & "\banner.xml"
	DIM TASK_PATH			: TASK_PATH		= DB_DIRECTORY & "\task.xml"
	DIM REACTION_PATH		: REACTION_PATH		= DB_DIRECTORY & "\reaction.xml"
	DIM GUESTBOOK_PATH		: GUESTBOOK_PATH	= DB_DIRECTORY & "\guestbook.xml"
	DIM DISCUSSION_PATH		: DISCUSSION_PATH	= DB_DIRECTORY & "\discussion.xml"
	DIM POLL_PATH			: POLL_PATH		= DB_DIRECTORY & "\poll.xml"
	DIM MEDIA_PATH			: MEDIA_PATH		= DB_DIRECTORY & "\media.xml"
	DIM LOG_PATH			: LOG_PATH		= DB_DIRECTORY & "\logs.xml"
	DIM DOWNLOAD_PATH		: DOWNLOAD_PATH		= DB_DIRECTORY & "\downloads.xml"
	DIM FAQ_PATH			: FAQ_PATH		= DB_DIRECTORY & "\faq.xml"
	DIM CONTENT_PATH		: CONTENT_PATH		= DB_DIRECTORY & "\content.xml"
	DIM PHOTO_PATH			:
	DIM TIP_PATH			:	
	DIM DIRECTORY_PATH		: DIRECTORY_PATH	= DB_DIRECTORY & "\directories2.xml"	
	DIM SESSIONS_PATH		: SESSIONS_PATH		= DB_DIRECTORY & "\sessions.xml"
	DIM SKIN_PATH			: SKIN_PATH		= DB_DIRECTORY & "\skinstudio.xml"
	DIM KB_PATH			: KB_PATH		= DB_DIRECTORY & "\knowbase.xml"
	DIM LIST_PATH			: LIST_PATH		= DB_DIRECTORY & "\list.xml"
	DIM NEWSLETTER_PATH		: NEWSLETTER_PATH	= DB_DIRECTORY & "\newsletter.xml"
	DIM CHAT_PATH			: CHAT_PATH		= DB_DIRECTORY & "\chat.xml"
	DIM CALENDAR_PATH		: CALENDAR_PATH		= DB_DIRECTORY & "\calendar.xml"
	DIM FRIENDS_PATH		: FRIENDS_PATH		= DB_DIRECTORY & "\friends.xml"
	DIM INTERNALMESSAGE_PATH	: INTERNALMESSAGE_PATH	= DB_DIRECTORY & "\imess.xml"
	DIM CLASSIFIED_PATH		: CLASSIFIED_PATH	= DB_DIRECTORY & "\classified.xml"
	DIM SHOP_PATH			: SHOP_PATH		= DB_DIRECTORY & "\shop.xml"
	DIM CART_PATH			: CART_PATH		= DB_DIRECTORY & "\cart.xml"
			
	DIM SKINS_FOLDER		: SKINS_FOLDER		= ROOT_PATH & "\skins\"
				
	'XSL PATH
	Dim ADMIN_SKIN_PATH		: ADMIN_SKIN_PATH	= ROOT_PATH & "\Admin\console.xsl"
	Dim XSLEXPORT_RSS_PATH		: XSLEXPORT_RSS_PATH	= ROOT_PATH & "\Engine\rss\exportTOrss.xsl"
	Dim XSLEXPORT_MEMBER_PATH	: XSLEXPORT_MEMBER_PATH	= ROOT_PATH & "\Admin\export_members.xsl"
	
	
	
	'+--------------------------------------------------------------+
	'|		MSXML progID					|
	'+--------------------------------------------------------------+
	Dim MSXML_PROGID
	Dim MSXML_PROGID2
	Dim MSXML_PROGID3
	
	If MSXML4 Then
		MSXML_PROGID		= "Msxml2.DOMDocument.4.0"
		MSXML_PROGID2		= "MSXML2.FreeThreadedDOMDocument.4.0"
		MSXML_PROGID3		= "MSXML2.XSLTemplate.4.0"		
	Else
		MSXML_PROGID		= "Msxml2.DOMDocument" 
		MSXML_PROGID2		= "MSXML2.FreeThreadedDOMDocument"
		MSXML_PROGID3		= "MSXML2.XSLTemplate"
	End If
%>

function MyBrowser()
{
	var settings='';
	var myCaller;
	var field;
	
};

MyBrowser.prototype.openWindow = function (field_name, url, type, myWin)
{
var ie = (document.all)? true : false
var nn6 = (!ie && document.getElementById)? true : false
var nn4 = (document.layers)? true : false
var posCode = ''
var wdt=700
var hgt=600
this.field=field_name

if (nn4 || nn6 || ie) {
if ( (screen.height < 481) && (hgt > 400) ) { hgt = 400 }
posX = Math.round((screen.width - wdt) / 2)
posY = Math.round((screen.height - hgt) / 2)
posCode = (nn4 || nn6)? ",screenX="+posX+",screenY="+posY : ",left="+posX+",top="+posY
}
	win = window.open(url, "MyBrowser", "status=yes,menubar=no,toolbar=no,resizable=yes,scrollbars=yes,location=no,width="+wdt+",height="+hgt+posCode)
	try {
		win.focus()
	} catch (e) {
	}
};

MyBrowser.prototype.fileCallBack = function (field_name, url, type, win){
	// ����� ����� open
	   myUrl="/picbrowser";
    	this.myCaller=win;
    	myBrowserInstance.openWindow(field_name, myUrl, type, this.myCaller);

};

MyBrowser.prototype.postUrlBack = function (imgUrl){
    		this.myCaller.document.forms[0].elements[this.field].value=imgUrl;
		try {
			     this.myCaller.document.forms[0].elements[this.field].onchange();
		     } 
		     catch (e) {
			// Skip it
    		}
    		return;
};

var myBrowserInstance=new MyBrowser();

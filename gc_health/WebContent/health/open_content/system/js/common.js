/* 층별소개 */
function tabmenu(n) {
	for(var i = 1; i < 9; i++) {
		obj = document.getElementById('tab_a'+i);
		img = document.getElementById('tab_b'+i);
		if ( n == i ) {
			obj.style.display = "block";
		} else {
			obj.style.display = "none";
		}
	}
}


/* navy(location) */

function topOn(tabid,a) {
	for (i=1;i<=10;i++) {
		if(i<10){inn="0"+i;} else {inn=""+i;}
		topMenu = document.getElementById("top"+tabid+"m"+i);

		topContent = document.getElementById("top"+tabid+"c"+i);
		if (topMenu) { //객체가존재하면
			if (topMenu.tagName=="IMG") { topMenu.src = topMenu.src.replace("on0" + i + ".gif", "off0" + i + ".gif"); } //이미지일때
			if (topMenu.tagName=="A") { topMenu.className=""; } //앵커일때
		}
		if (topContent) { topContent.style.display="none"; }
	}
	if(a<10){ann="0"+a;} else {ann=""+a;}
	topMenu = document.getElementById("top"+tabid+"m"+a);
	topContent = document.getElementById("top"+tabid+"c"+a);
	//alert(topMenu.tagName);
	if (topMenu) { //객체가존재하면
		if (topMenu.tagName=="IMG") { topMenu.src = topMenu.src.replace("off0" + a + ".gif", "on0" + a + ".gif"); } //이미지일때
		if (topMenu.tagName=="A") { topMenu.className="on"; } //앵커일때
	}
	if (topContent) { topContent.style.display="block"; }
	topMore = document.getElementById("top"+tabid+"more");
}

function initNavigation(seq,sec) {

	nav = document.getElementById("mainmenu");
	nav.menu = new Array();
	nav.current = null;
	nav.menuseq = 0;
	navLen = nav.childNodes.length;

	allA = nav.getElementsByTagName("li")
	for(k = 0; k < allA.length; k++) {
		allA.item(k).onmouseover = allA.item(k).onfocus = function () {
			nav.isOver = true;
		}
		allA.item(k).onmouseout = allA.item(k).onblur = function () {
			nav.isOver = false;
/*
			setTimeout(function () {
				if (nav.isOver == false) {
					if (nav.menu[seq])
						nav.menu[seq].onmouseover();
					else if(nav.current) {
						menuImg = nav.current.childNodes.item(0);
						menuImg.src = menuImg.src.replace("on0", "off0");
						if (nav.current.submenu)
							nav.current.submenu.style.display = "none";
						nav.current = null;
					}
				}
			}, 500);
*/	// 090508 메뉴고정
		}
	}

	for (i = 0; i < navLen; i++) {
		navItem = nav.childNodes.item(i);

		if (navItem.tagName != "LI")
			continue;

		navAnchor = navItem.getElementsByTagName("a").item(0);
		navAnchor.submenu = navItem.getElementsByTagName("ul").item(0);

/*
		if(seq == (i+1)){

			for(j = 0; j< navAnchor.submenu.childNodes.length;j++){
				navAnchor.submenu.sub = navAnchor.submenu.childNodes.item(j);
				var secname = "menu"+seq+"-"+sec;
				//alert(secname + " ===== " + navAnchor.submenu.sub.id);
				if(secname == navAnchor.submenu.sub.id) navAnchor.submenu.sub.className = "on";

			}
		}
*/

		navAnchor.onmouseover = navAnchor.onfocus = function () {

			if (nav.current) {
				menuImg = nav.current.childNodes.item(0);
				menuImg.src = menuImg.src.replace("on0", "off0");

				if (nav.current.submenu)
					nav.current.submenu.style.display = "none";
				nav.current = null;
			}

			if (nav.current != this) {
				menuImg = this.childNodes.item(0);
				menuImg.src = menuImg.src.replace("off0", "on0");

				if (this.submenu)
					this.submenu.style.display = "block";
				nav.current = this;
			}

			nav.isOver = true;
		}
		nav.menuseq++;
		nav.menu[nav.menuseq] = navAnchor;
	}
	if (nav.menu[seq])
		nav.menu[seq].onmouseover();
}


/* left menu */
function ClickMenu(Lab){
	MenuHidden();
	var mUse1 	= document.getElementById("menu_use1");
	var mUse2 	= document.getElementById("menu_use2");
	if(Lab == 1){
		mUse1.style.display="block";
	}else if(Lab == 2){
		mUse2.style.display="block";
	}

	var mUse1 	= document.getElementById("menu_use1");
	var mUse2 	= document.getElementById("menu_use2");
	if(Lab == 1){
		mUse1.style.display="block";
	}else if(Lab == 2){
		mUse2.style.display="block";
	}
}

function MenuHidden(){
	var mUse1 	= document.getElementById("menu_use1");
	var mUse2 	= document.getElementById("menu_use2");
	mUse1.style.display="none";
	mUse2.style.display="none";
}

/**
 * Check form's child validate.
 *
 * @param form
 * @return boolean
 */
function checkForm(form){
	var msg = "값이 필요합니다.";
	var k=0;
	var flag=false;
	var arr=new Array();
	var ele;
	for (var i=0; i<form.elements.length; i++) {
		ele = form.elements[i];
		tagName = ele.tagName;

		if(ele.getAttribute("dpname") != null){

			if(tagName == "SELECT" && ele.selectedIndex == 0 && (ele.getAttribute("check")!="false") && (ele.getAttribute("require") != null)){
				alert(ele.getAttribute("dpname")+msg);
				return false;
			}else{

				if ((ele.getAttribute("type")=="text" || ele.getAttribute("type")=="password") && (ele.getAttribute("check")!="false")) {
					if (ele.value=="") {
						alert(ele.getAttribute("dpname")+msg);
						ele.select();
						return false;
					}
				} else if (ele.type=="checkbox") {
					if (!ele.checked) {
						alert(ele.getAttribute("dpname")+msg);
						ele.focus();
						return false;
					}
				} else if (ele.type=="radio") {
					for (var j=0; j<arr.length; j++) {
						if (arr[j]==ele.name) {
							continue;
						}
					}
					if (eval("form."+ele.getAttribute("name")).length=="undefined") {
						if (!ele.checked) {
							alert(ele.getAttribute("dpname")+msg);
							ele.focus();
							return false;
						}
					} else {
						flag=false;
						for (var j=0; j<eval("form."+ele.getAttribute("name")).length; j++) {
							if (eval("form."+ele.getAttribute("name"))[j].checked) {
								flag=true;
								break;
							}
						}
						if (!flag) {
							alert(ele.getAttribute("dpname")+msg);
							ele.focus();
							return false;
						}
					}
					arr[k++]=ele.getAttribute("name");
				}
			}
		}
	}

	return true;
}


/* header 관련 script */
var zoomRate = 25;			// 확대/축소시 증감률
var maxRate = 200;			//최대확대률
var minRate = 100;			//최소축소률

/*
var fontSize = fSize;			//fontSize Default
var setfontsize = 12;		//setfontsize Default
var SetFont = strSetFont;	//SetFont Default "font";
*/
var fontColorIndex = 0;		//fontColorIndex Defalut(0은 글자색)
var bgColorIndex = 0;		//fontColorIndex Defalut(0은 바탕색)
var ScreenSize = 100;		//ScreenSize Default
var VoiceSpeed = 3;			//VoiceSpeed Default
var VoiceVolum = 3;			//VoiceVolum Default


var beforeBgColor;
var beforeTag;
var beforeTableTag;

//var afontSize = new Array();

var aVoice = new Array();
aVoice[1] = 1;
aVoice[2] = 2;
aVoice[3] = 3;
aVoice[4] = 4;
aVoice[5] = 5;

var aScreen = new Array();
aScreen[1] = 100;
aScreen[2] = 125;
aScreen[3] = 150;
aScreen[4] = 175;
aScreen[5] = 200;

var fontColor = new Array();
fontColor[0] = "";
fontColor[1] = "";
fontColor[2] = "#ffff00";
fontColor[3] = "#ffffff";
fontColor[4] = "#6666ff";
fontColor[5] = "#ff6666";
fontColor[6] = "#ff66ff";
fontColor[7] = "#66ff66";

var bgColor = new Array();
bgColor[0] = "";
bgColor[1] = "";
bgColor[2] = "#000000";
bgColor[3] = "#6666ff";
bgColor[4] = "#ff6666";
bgColor[5] = "#ff66ff";
bgColor[6] = "#66ff66";


/*****************************************************************/
//쿠키값 읽기
/*****************************************************************/
function readCookie( str ){
	var key = str + "=" ;
	var key_len = key.length;
	var cookie_len = document.cookie.length;
	var i = 0;

	while (i < cookie_len )	{
		var j = i + key_len;
		if ( document.cookie.substring( i, j ) == key ){
			var cookie_end = document.cookie.indexOf(";",j);

			if (cookie_end == -1){
				cookie_end = document.cookie.length;
			}
			return document.cookie.substring(j,cookie_end );
		}
		i++
	}
	return ""
}

/*****************************************************************/
//쿠키값 쓰기
/*****************************************************************/
function space_setCookie( key, value, term ){
	var expire = new Date();
	expire.setDate( expire.getDate() + term );
	document.cookie = key + "=" + escape( value ) + "; path=/; expires=" + expire.toGMTString() + ";";
}


//setTimeout( "bodyactive();", 5000);

/*****************************************************************/
//
/*****************************************************************/
function bodyactive(){
	if (window.ActiveXObject) { // IE
		var sRes = "";
		sRes = IsInstalled();
		if( sRes == true ){
			document.body.insertAdjacentHTML("BeforeEnd",objectTag);
		}else{
		}
	}
}

/*****************************************************************/
/*PageInit()*/
/*****************************************************************/
//페이지 로딩시 실행
function f_PageInit(){


		if( readCookie("VoiceStart").length == 0){
			space_setCookie("VoiceStart", VoiceStart , 1);
		}else VoiceStart = readCookie("VoiceStart");

		if( readCookie("VoiceVolum").length == 0 ){
			space_setCookie("VoiceVolum", VoiceVolum, 1);
		}else VoiceVolum = readCookie("VoiceVolum");

		if( readCookie("VoiceSpeed").length == 0 ){
			space_setCookie("VoiceSpeed", VoiceSpeed, 1);
		}else VoiceSpeed = readCookie("VoiceSpeed");

		var res = NetlightObjectType(NetLightCOM);
		if( res == true ){
		f_VoiceStart( readCookie("VoiceStart") )};

		if( typeof(DynamicNetLightCOM) != 'undefined' ){


			VoiceVolum = parseFloat(readCookie("VoiceVolum"));
			NetLightCOM.VoiceVolume=VoiceVolum;
			f_ImgChg(VoiceVolum, "volum");

			VoiceSpeed = parseFloat(readCookie("VoiceSpeed"));
			NetLightCOM.VoiceSpeed=VoiceSpeed;
			f_ImgChg(VoiceSpeed, "speed");
		}
		else{
			f_ImgChg("", "COM");
		}

		fontColorIndex = readCookie("fontColorIndex");
		bgColorIndex = readCookie("bgColorIndex");
		f_FontInit();

}


/*****************************************************************/
/*Init()*/
/*****************************************************************/
function f_FontInit(){

		/*
		if (readCookie("setfontsize").length == 0 ){
			space_setCookie("setfontsize", setfontsize, 1);
		}else setfontsize = readCookie("setfontsize");	//폰트사이즈

		if( readCookie("fontSize").length == 0 ){
			space_setCookie("fontSize", fontSize, 1);
		}else fontSize = readCookie("fontSize");		//폰트사이즈


		if (readCookie("SetFont").length == 0 ){
			space_setCookie("SetFont", SetFont, 1);
		}else SetFont = readCookie("SetFont");			//폰트or스크린
		*/

		if( readCookie("fontColorIndex").length == 0 ){
			space_setCookie("fontColorIndex", 0, 1);
		}else fontColorIndex = readCookie("fontColorIndex");

		if ( readCookie("bgColorIndex").length == 0 ){
			space_setCookie("bgColorIndex", 0, 1);
		}else bgColorIndex = readCookie("bgColorIndex");

		if ( readCookie("zoomVal").length == 0 ){
			space_setCookie("zoomVal", "100%", 7);
		}else currZoom = readCookie("zoomVal")+"%";		//화면크기

		zoomInOut("");

		//setFontSize(setfontsize);
		f_setFace();



}

/*****************************************************************/
/*폰트사이즈 배열저장*/
/*****************************************************************/
function setFontSize(val){
	afontSize[1] = val;
	for( var i=2; i<6; i++ ){
		val = parseInt(val) + 3;
		afontSize[i] = val;
	}
}


/*****************************************************************/
/*설치*/
/*****************************************************************/
function f_objectInsert(mode){
	var sRes = "";
	sRes = IsInstalled();
	if( sRes == true ){
		document.body.insertAdjacentHTML("BeforeEnd", objectTag);
	}else{
		var com = confirm("You should install program to use Voice Service.\n\nDo you want to install?");

		if( com == true ){
			top.location.href="/NetLight2/ActiveX.jsp?conf_Lang=enu";
		}
	}
}


/*****************************************************************/
/*음성 설정*/
/*****************************************************************/
function f_VoiceStart(str){
	//-setTimeout("", 2000);
	if( typeof(DynamicNetLightCOM) != 'undefined' ){
		if( str == "start" ){
			f_ImgChg('', "VoiceStart");
			if( FrameLength == 2 ){

				if( typeof(eval(FrameMainName +"document.all['VoiceLink']")) == 'object' ){
					eval(FrameMainName +"document.all['VoiceLink']").href = "JavaScript:NetReader('VoiceStop');";
					eval(FrameMainName +"document.all['VoiceLink']").title="Voice on";

				}
			}else{
				if( typeof(document.all['VoiceLink']) == 'object' ){
					document.all['VoiceLink'].href="JavaScript:NetReader('VoiceStop');";
					document.all['VoiceLink'].title="Voice on";

				}
			}

			DynamicNetLightCOM.VoiceActive=true;
		}
		else if( str == "stop"){
			f_ImgChg('', "VoiceStop");
			if( FrameLength == 2 ){
				if( typeof(eval(FrameMainName +"document.all['VoiceLink']")) == 'object' ){
					eval(FrameMainName +"document.all['VoiceLink']").href="JavaScript:NetReader('VoiceStart');";
					eval(FrameMainName +"document.all['VoiceLink']").title="Voice off";
				}
			}else{
				if( typeof(document.all['VoiceLink']) == 'object' ){
					document.all['VoiceLink'].href="JavaScript:NetReader('VoiceStart');";
					document.all['VoiceLink'].title="Voice off";
				}
			}


			DynamicNetLightCOM.VoiceActive=false;
		}
		space_setCookie("VoiceStart", str, 1);
	}else{
		//alert("NetLight 음성모듈이 존재하지 않습니다");
		f_objectInsert("voice");
	}
}
// 테스트

/*********************************************************/
//글자 크게
/*********************************************************/
/*
function f_fontPlus(){
	if (fontSize < 20){
		fontSize = parseInt(fontSize) + 3;
		//f_ImgChg(fontSize, "font");
		f_setFace();
	}
}
*/
/*********************************************************/
//글자 작게
/*********************************************************/
/*
function f_fontMinus() {
	if (fontSize > 13) {
		fontSize = parseInt(fontSize) - 3;
		f_setFace();
	}
}
*/
/*********************************************************/
//폰트컬러
/*********************************************************/
function f_setFontColor(val){
	if ( val >= 0 && val <= 7 )
	{
		fontColorIndex = val;
		f_setFace();
	}
}

/*********************************************************/
//바탕색
/*********************************************************/
function f_setBgColor(val){
	if ( val >= 0 && val <= 6 )
	{
		bgColorIndex = val;
		f_setFace();
	}
}
/*********************************************************/
//화면확대
/*********************************************************/
function zoomInOut(how){
	var sValue;
	//-setTimeout("", 1000);

	if(readCookie("zoomVal") != null && readCookie("zoomVal") != "" && readCookie("zoomVal") != "NaN"){
			if( FrameLength == 2 ){
				eval(FrameMainName +"document.body").style.zoom = readCookie("zoomVal")+"%";

			}else{

				document.body.style.zoom = readCookie("zoomVal")+"%";
			}
			currZoom=readCookie("zoomVal");
	}else{
			if( FrameLength == 2 ){
				eval(FrameMainName +"document.body").style.zoom = "100%";
			}else{
				document.body.style.zoom = "100%";
			}
			currZoom = "100%";
	}

	if ( ((how == "in") && (parseInt(currZoom) >= maxRate)) || ((how == "out") && (parseInt(currZoom) <= minRate)) ) {
		return;
	}
	if (how == "in") {
		if( FrameLength == 2 )
			eval(FrameMainName +"document.body").style.zoom = parseInt(eval(FrameMainName +"document.body").style.zoom)+zoomRate+"%";
		else
			document.body.style.zoom = parseInt(document.body.style.zoom)+zoomRate+"%";


	}else if( how == "out" ){
		if( FrameLength == 2 )
			eval(FrameMainName +"document.body").style.zoom = parseInt(eval(FrameMainName +"document.body").style.zoom)-zoomRate+"%";
		else
			document.body.style.zoom = parseInt(document.body.style.zoom)-zoomRate+"%";
	}
	if( FrameLength == 2 ){
		sValue = parseInt(eval(FrameMainName +"document.body").style.zoom);
	}else{
		sValue = parseInt(document.body.style.zoom);
	}

	space_setCookie("zoomVal", sValue, 365);




}

/*********************************************************/
//레벨 이미지 변경
/*********************************************************/
function f_ImgChg(val, flag){
	//Start
	if(flag == "VoiceStart"){
		if( FrameLength == 2 ){
			if( typeof(eval(FrameMainName +"document.all['VoiceStart']")) == 'object' ){
				eval(FrameMainName +"document.all['VoiceStart']").alt="Voice off";
				eval(FrameMainName +"document.all['VoiceStart']").title="Voice off";
				eval(FrameMainName +"document.all['VoiceStart']").src = VoiceOnImg;
			}
		}else{
			if( typeof(document.all['VoiceStart']) == 'object' ){
				document.all['VoiceStart'].alt="Voice off";
				document.all['VoiceStart'].title="Voice off";
				document.all['VoiceStart'].src = VoiceOnImg;
			}
		}
	}
	//Stop
	else if(flag == "VoiceStop"){
		if( FrameLength == 2 ){
			if( typeof(eval(FrameMainName +"document.all['VoiceStart']")) == 'object' ){
				eval(FrameMainName +"document.all['VoiceStart']").alt="Voice on";
				eval(FrameMainName +"document.all['VoiceStart']").title="Voice on";
				eval(FrameMainName +"document.all['VoiceStart']").src = VoiceOffImg;
			}
		}else{
			if( typeof(document.all['VoiceStart']) == 'object' ){
				document.all['VoiceStart'].alt="Voice on";
				document.all['VoiceStart'].title="Voice on";
				document.all['VoiceStart'].src = VoiceOffImg;
			}
		}
	}


	//Not NetLightCOM
	else if( flag == "COM" ){
	}
}

/*********************************************************/
//글자크기 설정
/*********************************************************/
function f_setFace(){
	var objs_td		= new Array();
	var objs_a		= new Array();
	var ogjs_span	= new Array();
	var objs_p		= new Array();
	var objs_li		= new Array();
	var Space_FontColor = fontColorIndex;	//fontColor[fontColorIndex]; //
	var Space_BGColor   = bgColorIndex; 	//bgColor[bgColorIndex];

	objs_td		= document.getElementsByTagName("td");
	objs_a		= document.getElementsByTagName("a");
	ogjs_span	= document.getElementsByTagName("span");
	objs_p		= document.getElementsByTagName("P");
	objs_div	= document.getElementsByTagName("div");
	objs_li		= document.getElementsByTagName("li");


	objs_dl		= document.getElementsByTagName("dl");
	objs_dt		= document.getElementsByTagName("dt");
	objs_dd		= document.getElementsByTagName("dd");
	objs_pre	= document.getElementsByTagName("pre");
	objs_font	= document.getElementsByTagName("font");

	objs_h3	= document.getElementsByTagName("h3");
	objs_h4	= document.getElementsByTagName("h4");


	for (i=0;i<objs_dl.length;i++){
		if (Space_FontColor !="0") objs_dl[i].style.color=fontColor[fontColorIndex];
		if (Space_BGColor !="0") objs_dl[i].style.backgroundColor=bgColor[bgColorIndex];
	}
	for (i=0;i<objs_dt.length;i++){
		if (Space_FontColor !="0") objs_dt[i].style.color=fontColor[fontColorIndex];
		if (Space_BGColor !="0") objs_dt[i].style.backgroundColor=bgColor[bgColorIndex];
	}
	for (i=0;i<objs_dd.length;i++){
		if (Space_FontColor !="0") objs_dd[i].style.color=fontColor[fontColorIndex];
		if (Space_BGColor !="0") objs_dd[i].style.backgroundColor=bgColor[bgColorIndex];
	}
	for (i=0;i<objs_pre.length;i++){
		if (Space_FontColor !="0") objs_pre[i].style.color=fontColor[fontColorIndex];
		if (Space_BGColor !="0") objs_pre[i].style.backgroundColor=bgColor[bgColorIndex];
	}
	for (i=0;i<objs_font.length;i++){
		//objs_td[i].style.fontSize=fontSize+'px';
		if (Space_FontColor !="0") objs_font[i].style.color=fontColor[fontColorIndex];
		//objs_font[i].style.backgroundColor=bgColor[bgColorIndex];
	}


	for (i=0;i<objs_td.length;i++){
		//objs_td[i].style.fontSize=fontSize+'px';
		if (Space_FontColor !="0") objs_td[i].style.color=fontColor[fontColorIndex];
		if (Space_BGColor !="0") objs_td[i].style.backgroundColor=bgColor[bgColorIndex];
	}

	for (i=0;i<objs_a.length;i++){
		//objs_a[i].style.fontSize=fontSize+'px';
		if (Space_FontColor !="0") objs_a[i].style.color=fontColor[fontColorIndex];
	}

	for (i=0;i<ogjs_span.length;i++){
		//ogjs_span[i].style.fontSize=fontSize+'px';
		if (Space_FontColor !="0") ogjs_span[i].style.color=fontColor[fontColorIndex];
	}

	for (i=0;i<objs_p.length;i++){
		//objs_p[i].style.fontSize=fontSize+'px';
		if (Space_FontColor !="0") objs_p[i].style.color=fontColor[fontColorIndex];
	}

	for (i=0;i<objs_div.length;i++){
		//objs_div[i].style.fontSize=fontSize+'px';
		if (Space_FontColor !="0") objs_div[i].style.color=fontColor[fontColorIndex];
		if (Space_BGColor !="0") objs_div[i].style.backgroundColor=bgColor[bgColorIndex];
	}

	for (i=0;i<objs_li.length;i++){
		//objs_div[i].style.fontSize=fontSize+'px';
		if (Space_FontColor !="0") objs_li[i].style.color=fontColor[fontColorIndex];
		if (Space_BGColor !="0") objs_li[i].style.backgroundColor=bgColor[bgColorIndex];
	}

	for (i=0;i<objs_h3.length;i++){
		//objs_div[i].style.fontSize=fontSize+'px';
		if (Space_FontColor !="0") objs_h3[i].style.color=fontColor[fontColorIndex];
		if (Space_BGColor !="0") objs_h3[i].style.backgroundColor=bgColor[bgColorIndex];
	}

	for (i=0;i<objs_h4.length;i++){
		//objs_div[i].style.fontSize=fontSize+'px';
		if (Space_FontColor !="0") objs_h4[i].style.color=fontColor[fontColorIndex];
		if (Space_BGColor !="0") objs_h4[i].style.backgroundColor=bgColor[bgColorIndex];
	}

	if ( document.all['fontSelect'] == '[object]' && document.all['bgSelect'] == '[object]' ){
		document.all['fontSelect'].selectedIndex	= parseInt(fontColorIndex);
		document.all['bgSelect'].selectedIndex		= parseInt(bgColorIndex);
	}

	//space_setCookie("fontSize", fontSize, 1);					//폰트저장
	space_setCookie("fontColorIndex", fontColorIndex, 1);		//폰트색상저장
	space_setCookie("bgColorIndex", bgColorIndex, 1);			//배경색저장
}

<!--
var changeTextColor1;
var changeBgColor1;
function f_setFontColor1(val){
	if ( !val || val == 'undefined' ) return;
	changeTextColor1 = val;
}
function f_setBgColor1(val){
	if ( !val || val == 'undefined' ) return;
	changeBgColor1 = val;
}

function f_setFontColorGo() {
	if ( !changeTextColor1 ) {
		alert("Choose a color change");
		return;
	}
	f_setFontColor(changeTextColor1);
}


function f_setBgColorGo() {
	if ( !changeBgColor1 ) {
		alert("Choose a color change");
		return;
	}
	f_setBgColor(changeBgColor1);
}
//-->
/*********************************************************/
function FontPlus1(uid)
{
	//메인 크기변환 시작 ----
	var m = document.getElementById('container');
    var mnSize = m.style.fontSize   ? m.style.fontSize   : '9pt';
    var miSize = parseInt(mnSize.replace('pt',''));

    if (miSize < 12)
    {
        m.style.fontSize   = (miSize + 1) + 'pt';
        m.style.lineHeight = '120%';
    }
	//메인 크기변환 끝 ----


	//서브페이지 크기변환 시작 ----
    var l = document.getElementById('content');
	var c = document.getElementById('conapp');
    var nSize = l.style.fontSize   ? l.style.fontSize   : '9pt';
    var iSize = parseInt(nSize.replace('pt',''));


    if (iSize < 12)
    {
        l.style.fontSize   = (iSize + 1) + 'pt';
        l.style.lineHeight = '120%';
		c.style.fontSize = '9pt';
    }
	//서브페이지 크기변환 끝  ----


	// h3 크기변환 시작 ----
	var h3Tag = l.getElementsByTagName("h3");
	if(h3Tag.length > 0){

		for(k = 0; k < h3Tag.length; k++) {
			var nSize2 = h3Tag.item(k).style.fontSize   ? h3Tag.item(k).style.fontSize   : '12pt';
		    var iSize2 = parseInt(nSize2.replace('pt',''));
			 if (iSize2 < 15)
			{
					h3Tag.item(k).style.fontSize = (iSize2 + 1) + 'pt';
					h3Tag.item(k).style.lineHeight = '120%';
			}

		}
	}
	// h3 크기변환 끝 ----

    // h4 크기변환 시작 ----
	var h4Tag = l.getElementsByTagName("h4");
	if(h4Tag.length > 0){

		for(k = 0; k < h4Tag.length; k++) {
			var nSize3 = h4Tag.item(k).style.fontSize   ? h4Tag.item(k).style.fontSize   : '9pt';
		    var iSize3 = parseInt(nSize3.replace('pt',''));
			 if (iSize3 < 12)
			{
					h4Tag.item(k).style.fontSize = (iSize3 + 1) + 'pt';
					h4Tag.item(k).style.lineHeight = '120%';
			}

		}
	}
	// h4 크기변환 끝 ----

}



//폰트축소
function FontMinus1(uid)
{

	//메인 크기변환 시작 ----
    var m = document.getElementById('container');
    var mnSize = m.style.fontSize ? m.style.fontSize : '9pt';
    var miSize = parseInt(mnSize.replace('pt',''));

    if (miSize > 6)
    {
        m.style.fontSize = (miSize - 1) + 'pt';
        m.style.lineHeight = '120%';
    }
	//메인 크기변환 끝 ----

	//서브페이지 크기변환 시작 ----
	var l = document.getElementById('content');
	var c = document.getElementById('conapp');
    var nSize = l.style.fontSize ? l.style.fontSize : '9pt';
    var iSize = parseInt(nSize.replace('pt',''));

    if (iSize > 6)
    {
        l.style.fontSize = (iSize - 1) + 'pt';
        l.style.lineHeight = '120%';
		c.style.fontSize = '9pt';
    }
	//서브페이지 크기변환 끝  ----


	// h3 크기변환 시작 ----
	var h3Tag = l.getElementsByTagName("h3");
	if(h3Tag.length > 0){

		for(k = 0; k < h3Tag.length; k++) {
			var nSize2 = h3Tag.item(k).style.fontSize   ? h3Tag.item(k).style.fontSize   : '12pt';
		    var iSize2 = parseInt(nSize2.replace('pt',''));
			 if (iSize2 > 9)
			{
					h3Tag.item(k).style.fontSize = (iSize2 - 1) + 'pt';
					h3Tag.item(k).style.lineHeight = '120%';
			}

		}
	}
	// h3 크기변환 끝 ----

    // h4 크기변환 시작 ----
	var h4Tag = l.getElementsByTagName("h4");
	if(h4Tag.length > 0){

		for(k = 0; k < h4Tag.length; k++) {
			var nSize3 = h4Tag.item(k).style.fontSize   ? h4Tag.item(k).style.fontSize   : '9pt';
		    var iSize3 = parseInt(nSize3.replace('pt',''));
			 if (iSize3 > 6)
			{
					h4Tag.item(k).style.fontSize = (iSize3 - 1) + 'pt';
					h4Tag.item(k).style.lineHeight = '120%';
			}

		}
	}
	// h4 크기변환 끝 ----

}
function FontBase1()
{
	//메인 기본크기 시작 ----
    var l = document.getElementById('container');
        l.style.fontSize = 10 + 'pt';
        l.style.lineHeight = '1.03em';
	//메인 기본크기 끝 ----


	//서브페이지 기본크기 시작 ----
    var l = document.getElementById('content');
	var c = document.getElementById('conapp');
        l.style.fontSize = 10 + 'pt';
        l.style.lineHeight = '1.03em';
		c.style.fontSize = '9pt';
	//서브페이지 기본크기 끝 ----


	// h3 기본크기 시작 ----
	var h3Tag = l.getElementsByTagName("h3");
	if(h3Tag.length > 0){

		for(k = 0; k < h3Tag.length; k++) {
			h3Tag.item(k).style.fontSize = '12pt';
			h3Tag.item(k).style.lineHeight = '1.3em';
		}
	}
	// h3 기본크기 끝 ----

    // h4 기본크기 시작 ----
	var h4Tag = l.getElementsByTagName("h4");
	if(h4Tag.length > 0){

		for(k = 0; k < h4Tag.length; k++) {
			h4Tag.item(k).style.fontSize = '9pt';
			h4Tag.item(k).style.lineHeight = '1.3em';
		}
	}
	// h4 기본크기 끝 ----


}


/* 병의원안내 바로가기 */
function LinkJump(){
	var Value = document.Jump.SiteLinkSet.value;
	location.href = Value;
}

/*정보평가 체크*/
function goApp(f){

	var checkpoint = false // 체크안된 것으로 봄 

	for(i=0;i<f.vlpt.length;i++){

		if(f.vlpt[i].checked == true){
			checkpoint=true;
		}
	}
	if(checkpoint == false){
		alert("만족도를 선택해 주세요");
		return false;
	}

}

function imageInt(t,boardWidth)
{
	var oBody = document.getElementById(t);    
	var oItem = oBody.getElementsByTagName("img");	//img object

	if(oItem != null)
	{
		for(i=0; i < oItem.length; i++)
		{			
			var imgWidth = oItem.item(i).width;	// object width value
			if(boardWidth < imgWidth){
				oItem.item(i).width = boardWidth;
			}
		}
	}
	return;
}

function checkField(obj,txt,fo){
	var flag = true;
	if(obj.value == ""){
		alert(txt);
		flag = false;
		if(fo == "Y") obj.focus();
	}
	return flag;
}

//한줄의견 작성시에 로그인 체크
function checkId(v){
	if(id == "" || id == null){
		if(confirm("실명인증 및 로그인을 하셔야 작성이 가능합니다. 로그인을 하시겠습니까?")){
			location.href=v;
		}
	}
}
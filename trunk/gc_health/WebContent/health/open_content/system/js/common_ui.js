try { document.execCommand('BackgroundImageCache', false, true); } catch(e) {}



/* 이벤트 헨들러 */

function addEvent(obj, evt, fn) {

	if (obj.addEventListener) {

		obj.addEventListener(evt, fn, false);

	} else if (obj.attachEvent) {

		obj.attachEvent('on' + evt, fn);

	}

}



var getElementsClass = function() { //className, tagName, parentNode

	var element = arguments[2] || document;

	var elements = [], nodes = arguments[1] ? element.getElementsByTagName(arguments[1]) : element.getElementsByTagName('*');



	for(var i=0; i<nodes.length; i++) {

		if(nodes[i].className.indexOf(arguments[0]) != -1)

			elements.push(nodes[i]);

	}

	return elements;

};



var getOffset = function () {

	var objRoot = null;

	var currentObj = arguments[0];

	var bLoop = !!arguments[1];

	var data = {left:0, top:0, width:0, height:0}



	data.width = currentObj.offsetWidth;

	data.height = currentObj.offsetHeight;



	switch (bLoop) {

	case true:

		while (!!currentObj && currentObj.nodeName.toLowerCase() != 'body') {

			data.top += currentObj.offsetTop;

			data.left += currentObj.offsetLeft;

			currentObj = currentObj.offsetParent;

		}

		break;

	case false:

		data.top = currentObj.offsetTop;

		data.left = currentObj.offsetLeft;

		break;

	}



	return data;

}



/* GNB */

function gnbMenu(objNum) {

	var _d = document,

		outEventTime = 3, //본 레이어로 돌아가는 시간

		objID = _d.getElementById('topmenu'),

		objUl = objID.getElementsByTagName('ul'),

		objUlLength = objUl.length,

		objList = [],

		objImage = [],

		currentNum = 0,

		objSetTime;



	var initialize = function() {

		for (var i=0; i<objUlLength; i++) {

			//if (objNum == 'null') objID.style.backgroundImage = 'url(/open_content/images/main/bg_topmenu.gif)';
	
			if (i != 0) {

				objList[i] = objUl[i].parentNode;

				objImage[i] = objList[i].getElementsByTagName('img')[0];

				//objID.style.backgroundImage = 'url(/open_content/images/main/bg_topmenu.gif)';
				objEvent(i);

			}

		}


		
		if (objNum >= 0) {

			objNum = objNum + 1;

			objImage[objNum].src = objImage[objNum].src.replace('.gif', '_on.gif');

			objUl[objNum].style.display = 'block';

			
		}
		

	};



	var objEvent = function(num) {

		objList[num].onmouseover = function() {

			currentNum = num;

			clearTimeout(objSetTime);

			for (var i=0; i<objUlLength; i++) {

				if (i != 0) {

					if (i == num) {

						//Do nothing

					} else {

						objImage[i].src = objImage[i].src.replace('_on.gif', '.gif');

						objUl[i].style.display = 'none';

						//objID.style.backgroundImage = 'url(/open_content/images/main/bg_topmenu_on.gif)';
					}

				}

			}



			if (objImage[num].src.indexOf('_on.gif') == -1)

				objImage[num].src = objImage[num].src.replace('.gif', '_on.gif');


				
			objUl[num].style.display = 'block';



		};

		objList[num].onkeyup = objList[num].onmouseover;



		objID.onmouseout = function(e) {

			var evt = e || window.event;

			var relatedNode = evt.relatedTarget || evt.toElement;


			//objID.style.backgroundImage = 'url(/open_content/images/main/bg_topmenu.gif)';
			searchOutNode(relatedNode, this);

		};

	};



	var outEvent = function() {

		if (!objNum) {

			objImage[currentNum].src = objImage[currentNum].src.replace('_on.gif', '.gif');

			objUl[currentNum].style.display = 'none';


			//objID.style.backgroundImage = 'url(/open_content/images/main/bg_topmenu_on.gif)';
		} else if (objNum && currentNum != objNum) {

			if (objImage[objNum].src.indexOf('_on.gif') == -1)

				objImage[objNum].src = objImage[objNum].src.replace('.gif', '_on.gif');

				objUl[objNum].style.display = 'block';

			


			objImage[currentNum].src = objImage[currentNum].src.replace('_on.gif', '.gif');

			objUl[currentNum].style.display = 'none';

			//objID.style.backgroundImage = 'url(/open_content/images/main/bg_topmenu_on.gif)';
		}

	};



	var searchOutNode = function (obj1, obj2) { //이벤트 버블링현상 제거

		while (obj1 != obj2) {

			if (!obj1) {

				objSetTime = setTimeout(outEvent, (outEventTime * 1000));

				return true;

			}

			obj1 = obj1.parentNode;

		}

		return false;

	};



	initialize();

}



/* LNB */

function lnbMenu() {

	var _d = document,

		objID = _d.getElementById('lnb_menu'),

		objOpenDepth = _d.getElementById('openDepth'),

		objUl = objID.getElementsByTagName('ul'),

		objUlLength = objUl.length,

		objLi = objID.getElementsByTagName('li'),

		objLiLength = objLi.length,

		objLink;



	var initialize = function() {

		for(var i=0; i<objUlLength; i++) {

			objUl[i].style.display = 'none';

			objLink = objUl[i].parentNode.getElementsByTagName('a')[0];	

		}

		if (objOpenDepth) objDepthEvent();

	};



	var objDepthEvent = function() {

		var objOpenDepths = objOpenDepth;

		while (objID != objOpenDepths) {

			//alert(objOpenDepths.getElementsByTagName('img')[0].length)

			//objOpenDepths.getElementsByTagName('img').src = objOpenDepths.getElementsByTagName('img').src.replace('.gif', '_on.gif');

			objOpenDepths.className += ' current';

			objOpenDepths.style.display = 'block';			

			objOpenDepths = objOpenDepths.parentNode;

		}

	};



	var objEvent = function() {

		var objParent = this.parentNode;

		var objDepth = objParent.getElementsByTagName('ul')[0];



		if (objDepth.style.display != 'block') {

			objParent.className += ' current';

			objDepth.style.display = 'block';

		} else {

			objParent.className = objParent.className.replace('current', ' ');

			objDepth.style.display = 'none';

		}



		return false;

	};



	this.allOpen = function() {

		var objTest = objID;

		for(var i=0; i<objUlLength; i++) {

			//alert(objTest.length)

			objUl[i].style.display = 'block';

			//objUl[i].parentNode.getElementsByTagName('img')[0].src = objUl[i].parentNode.getElementsByTagName('img')[0].src.replace('btn_open', 'btn_close');

			if (objUl[i].parentNode.className == ' ')

			{

				objUl[i].parentNode.className += ' current';	

			}

		}

	};



	this.specifyOpen = function(idx) {

		var objTest = objID;

		for(var i=0; i<objUlLength; i++) {

			//alert(objTest.length)

			if(i == idx)

			{

				objUl[i].style.display = 'block';

				//objUl[i].parentNode.getElementsByTagName('img')[0].src = objUl[i].parentNode.getElementsByTagName('img')[0].src.replace('btn_open', 'btn_close');

				if (objUl[i].parentNode.className == '')

				{

					objUl[i].parentNode.className += 'current';	

				}

			}

			else

			{

				objUl[i].style.display = 'none';

				//objUl[i].parentNode.getElementsByTagName('img')[0].src = objUl[i].parentNode.getElementsByTagName('img')[0].src.replace('btn_close', 'btn_open');

				if (objUl[i].parentNode.className == 'current')

				{

					objUl[i].parentNode.className = objUl[i].parentNode.className.replace('current', '');

				}

			}

		}

	};



	this.allClose = function() {

		for(var i=0; i<objUlLength; i++) {

			objUl[i].style.display = 'none';

			//objUl[i].parentNode.getElementsByTagName('img')[0].src = objUl[i].parentNode.getElementsByTagName('img')[0].src.replace('btn_close', 'btn_open');

			if (objUl[i].parentNode.className == ' current')

			{

				objUl[i].parentNode.className = objUl[i].parentNode.className.replace(' current', ' ');

			}

		}

	};



	initialize();

}



function siteZoomIn() {
	var _d = document,
		sizeNum = 0.1,
		objContent;
		objWrap = _d.getElementById('content'),
		objContainer = _d.getElementById('wrap'),
		objZoomIn = _d.getElementById('font_zoomin'),
		objZoomOut = _d.getElementById('font_zoomout'),
		objZoomDefault = _d.getElementById('font_default');

	var initialize = function() {
		if (objWrap)
			objContent = objWrap;
		else
			objContent = objContainer;

		objContent.style.fontSize = '1em';
		objZoomIn.onclick = zoomIn;
		objZoomOut.onclick = zoomOut;
		objZoomDefault.onclick = zoomDefault;
	};

	var zoomIn = function() {
		sizeNum = parseFloat(sizeNum + 0.1);
		if (sizeNum >= 0.5) {
			
			alert('더 이상 확대 하실 수 없습니다.');
			return false;
		}
		objContent.style.fontSize = parseFloat(0.9 + sizeNum) + 'em';
		return false;
	};

	var zoomOut = function() {
		
		sizeNum = parseFloat(sizeNum - 0.1);

	
		if (sizeNum <= -0.5) {
			alert('더 이상 축소 하실 수 없습니다.');
			return false;
		}
		objContent.style.fontSize = parseFloat(0.9 + sizeNum) + 'em'
		return false;

	};

	var zoomDefault = function() {
		
		//var objContent = document.getElementById('content');
		//objContent.style.fontSize = '1em';
		document.location.reload();
		return false;
	};

	initialize();
	
}

function openPopup() {
	var popup = [];

	var initialize = function() {
		popup = getElementsClass('popup');
		if (popup.length < 0) return;
		for (var i=0; i<popup.length; i++)
			popup[i].onclick = openEvent;
	};

	var openEvent = function() {
		if (!this.getAttribute('rel')) return;

		var popupOption = this.getAttribute('rel').split(',');

		window.open(this.getAttribute('href'), '', 'width='+popupOption[0]+', height='+popupOption[1]+', scrollbars='+popupOption[2]);
		return false;
	};

	initialize();
}
/* 로테이트 2009-08-21 임태우 추가 */
function rotatecontents(objectid){
    
    this.pagingobject=null;
    this.pagingstart='';
    this.pagingdelimiter='/';
    this.pagingend='';
    this.rotatemethod=null;
    this.maxzindex=1;
    this.speed=5;
    this.autoplay=true;
    this.autoplaytime=3;
 
    this.buttonobject=null;
    this.buttontype='text';
    this.buttononclassname='on';
    this.buttononimagename='';

    
    var object=document.getElementById(objectid);
    var items=new Array(),itemsnum,titles=new Array();
    var btns=new Array(),btnsmover=new Array(),btnsmout=new Array();
    var speed,timer,nowno=0,canimove=true;
    var isie=(navigator.userAgent.toLowerCase().indexOf('msie')!=-1)? true : false;
 
    this.initialize=function(){
        var isfirst=true,removeobjs=new Array(),childs=object.childNodes;
        for(var i=0,j=-1,max=childs.length; i<max; i++){
            if(childs[i].nodeType==1){
                j++;
                if(!isfirst) childs[i].style.display='none';
                items.push(childs[i]);
                if(this.rotatemethod=='overlap' || this.rotatemethod=='slide' || this.rotatemethod=='fadein' || this.rotatemethod=='vertical'){
                    speed=this.speed;
                    object.style.position='relative';
                    with(childs[i].style){
                        position='absolute';
                        left='0px';
                        top='0px';
                        width=object.offsetWidth+'px';
						//2009-08-25
                        height=object.offsetHeight+'px';
                        
                    }
                    if(this.rotatemethod=='fadein'){
                        setopacity(childs[i],(isfirst)? 100 : 0);
                    }
                }
                if(isfirst) isfirst=false;
            }
        }
        itemsnum=items.length;
        if(removeobjs[0]){
            for(var i=0,max=removeobjs.length; i<max; i++) object.removeChild(removeobjs[i]);
        }
 
        if(this.pagingobject) this.pagingobject=document.getElementById(this.pagingobject);
        this.settitlenpaging(nowno);
        object.style.width=object.offsetWidth+'px';
        //alert(object.style.width);
		object.style.height=object.offsetHeight+'px';
        object.style.overflow='hidden';
        object.onmouseover =function(){
            clearTimeout(eval(objectid).autoplaytimer);
        }
        object.onmouseout=function(){
            eval(objectid).autoplayaction();
        }
        if(this.buttonobject){
            this.buttonobject=document.getElementById(this.buttonobject);
            var childs=this.buttonobject.childNodes;
            for(var i=0,j=0,max=childs.length; i<max; i++){
                if(childs[i].nodeType==1){
                    childs[i].myno=j;
                    if(childs[i].onmouseover) btnsmover.push(childs[i].onmouseover);
                    if(childs[i].onmouseout) btnsmout.push(childs[i].onmouseout);
                    btns.push(childs[i]);
                    j++;
                }
            }
            if(items.length!=btns.length) this.buttonobject=null;
            else this.setbtns();
        }
        this.autoplayaction();
    }
 
    this.settitlenpaging=function(no){
       
        if(this.pagingobject) this.pagingobject.innerHTML=this.pagingstart+(no+1)+this.pagingdelimiter+itemsnum+this.pagingend;
    }
 
    this.setzindex=function(no){
        for(var i=0; i<itemsnum; i++){
            if(i==no){
                items[i].style.zIndex=this.maxzindex+3;
                items[i].style.display='';
            }else if(i==nowno){
                items[i].style.zIndex=this.maxzindex+2;
            }else{
                items[i].style.zIndex=this.maxzindex+1;
                items[i].style.display='none';
            }
        }
    }
 
    this.setbtns=function(no){
        if(!no && no!==0) no=nowno;
        for(var i=0; i<itemsnum; i++){
            if(i==no){
                this.setbtnon(btns[i]);
                btns[i].onmouseover=null;
                btns[i].onmouseout=null;
            }else{
                this.setbtnoff(btns[i]);
                btns[i].onmouseover=function(){
                    eval(objectid).setbtnon(this);
                    if(btnsmover[this.myno]) btnsmover[this.myno]();
                }
                btns[i].onmouseout=function(){
                    eval(objectid).setbtnoff(this);
                    if(btnsmout[this.myno]) btnsmout[this.myno]();
                }
            }
        }
    }
 
    this.setbtnon=function(target){
        var classes,exist=false;
        if(this.buttontype=='image'){
            var btnimg=target.getElementsByTagName('img')[0];
            var btnimgexp=btnimg.src.substring(btnimg.src.lastIndexOf('.'));
            if(btnimg.src.indexOf(this.buttononimagename+btnimgexp)==-1) btnimg.src=btnimg.src.replace(btnimgexp,this.buttononimagename+btnimgexp);
        }
        classes=target.className.split(' ');
        for(var i=0; i<classes.length; i++) if(classes[i]==this.buttononclassname) exist=true;
        if(!exist) target.className=target.className+' '+this.buttononclassname;
    }
 
    this.setbtnoff=function(target){
        var classes;
        if(this.buttontype=='image'){
            var btnimg=target.getElementsByTagName('img')[0];
            var btnimgexp=btnimg.src.substring(btnimg.src.lastIndexOf('.'));
            if(btnimg.src.indexOf(this.buttononimagename+btnimgexp)!=-1) btnimg.src=btnimg.src.replace(this.buttononimagename+btnimgexp,btnimgexp);
        }
        if(target.className.indexOf(this.buttononclassname)!=-1){
            if(target.className.indexOf(' ')==-1) target.className=target.className.replace(this.buttononclassname,'');
            else{
                classes=target.className.split(' ');
                for(var i=0; i<classes.length; i++) if(classes[i]==this.buttononclassname) classes[i]='';
                target.className=classes.join(' ');
            }
        }
    }
 
    this.change=function(no){
        no=no-1;
        if(no!=nowno){
            if(this.rotatemethod=='overlap') this.moveaction('overlap',no,(no<nowno)? 'prev' : 'next');
            else if(this.rotatemethod=='slide') this.moveaction('slide',no,(no<nowno)? 'prev' : 'next');
            else if(this.rotatemethod=='vertical') this.moveaction('vertical',no,(no<nowno)? 'prev' : 'next');
            else if(this.rotatemethod=='fadein') this.fadeinaction(no);
            else this.hideitem(no);
            this.settitlenpaging(no);
            if(this.buttonobject) this.setbtns(no);
        }
    }

	this.stop = function() {
		clearTimeout(eval(objectid).autoplaytimer);
		this.hideitem;
	};

	this.play = function() {
		if(!this.autoplay) return;
        this.autoplaytimer=setTimeout(objectid+'.next()',this.autoplaytime*1000);
	};

	this.viewall = function() {
		
		var viewwrap = document.getElementById('banner_bot');
		var banbtn = document.getElementById('lbtn'); 
		var banclose = document.getElementById('rbtn');
		var bbtn = document.getElementById('bbtn');
		if (viewwrap.style.height == '' )
		{	clearTimeout(eval(objectid).autoplaytimer);
			viewwrap.style.height = '175px';
			viewwrap.style.backgroundImage = 'url(/open_content/images/main/bg_banner_02.gif)';
			var objList = document.getElementById(objectid);
			var objListul = objList.getElementsByTagName('ul');
			objList.style.height = '175px';
			objList.style.paddingTop = '25px';
			for (var i=0; i < objListul.length ; i++)
			{
				objListul[i].style.position = 'static';
				objListul[i].style.display = 'block';
			}	
			banbtn.style.display = 'none';
			banclose.style.display = 'none';
			bbtn.style.display = 'block';
			object.onmouseover = "null";
			object.onmouseout = "null";

		}else {
			
			viewwrap.style.height = '';
			viewwrap.style.backgroundImage = 'url(/open_content/images/main/bg_banner_01.gif)';
			var objList = document.getElementById(objectid);
			var objListul = objList.getElementsByTagName('ul');
			objList.style.height = '50px';
			objList.style.paddingTop = '0';
			for (var i=0; i < objListul.length ; i++)
			{
				objListul[i].style.position = 'absolute';
				objListul[i].style.display = '';
			}
			if(!this.autoplay) return;
			this.autoplaytimer=setTimeout(objectid+'.next()',this.autoplaytime*1000);
			banbtn.style.display = '';
			banclose.style.display = 'block'
			bbtn.style.display = 'none';
		}
	};

    this.prev=function(){
        var prevno=(nowno==0)? itemsnum-1 : nowno-1;
        if(this.rotatemethod=='overlap') this.moveaction('overlap',prevno,'prev');
        else if(this.rotatemethod=='slide') this.moveaction('slide',prevno,'prev');
        else if(this.rotatemethod=='vertical') this.moveaction('vertical',prevno,'prev');
        else if(this.rotatemethod=='fadein') this.fadeinaction(prevno);
        else this.hideitem(prevno);
        this.settitlenpaging(prevno);
    }
 
    this.next=function(){
        var nextno=(nowno==(itemsnum-1))? 0 : nowno+1;
        if(this.rotatemethod=='overlap') this.moveaction('overlap',nextno,'next');
        else if(this.rotatemethod=='slide') this.moveaction('slide',nextno,'next');
        else if(this.rotatemethod=='vertical') this.moveaction('vertical',nextno,'next');
        else if(this.rotatemethod=='fadein') this.fadeinaction(nextno);
        else this.hideitem(nextno);
        this.settitlenpaging(nextno);
        if(this.buttonobject) this.setbtns(nextno);
    }
 
    this.autoplaytimer=null;
    this.autoplayaction=function(){
        if(!this.autoplay) return;
        this.autoplaytimer=setTimeout(objectid+'.next()',this.autoplaytime*1000);
    }
 
    this.hideitem=function(no){
        clearTimeout(this.autoplaytimer);
        for(var i=0; i<itemsnum; i++) items[i].style.display=(i==no)? '' : 'none';
        this.autoplayaction();
        nowno=no;
    }
 
    var getleft=function(no){
        return parseInt(items[no].style.left);
    }
    var setleft=function(no,value){
        items[no].style.left=value+'px';
    }

	var gettop=function(no){
        return parseInt(items[no].style.top);
    }
	var settop=function(no,value){
        items[no].style.top=value+'px';
    }
 
    this.moveaction=function(method,no,direction){
        clearTimeout(this.autoplaytimer);
        if(canimove){
            canimove=false;

            if(method=='slide') setleft(no,(direction=='prev')? -(object.offsetWidth) : object.offsetWidth);
            if(method=='vertical') settop(no,(direction=='prev')? -(object.offsetHeight) : object.offsetHeight);
            
            this.setzindex(no);
            var nowv,now,snow,to=0,mv=0;
            var action=function(){
                clearTimeout(timer);
                now=getleft(no);
                nowv=gettop(no);

                if(method=='slide') snow=getleft(nowno);
				if(method=='vertical') snow=gettop(nowno);
                
                if(now!=to){
                    mv=(now-to)/speed;
                    setleft(no,(direction=='prev')? Math.ceil(now-mv) : Math.floor(now-mv));                  
                    if(method=='slide') setleft(nowno,(direction=='prev')? Math.ceil(snow-mv) : Math.floor(snow-mv));                   
                    setTimeout(action,10);
                }else if (nowv!=to)
                {
					mv=(nowv-to)/speed;
                    settop(no,(direction=='prev')? Math.ceil(nowv-mv) : Math.floor(nowv-mv));           
                    if(method=='vertical') settop(nowno,(direction=='prev')? Math.ceil(snow-mv) : Math.floor(snow-mv));
                    setTimeout(action,10);
                }
				else{
                    eval(objectid+'.autoplayaction()');
                    clearTimeout(timer);
                    canimove=true;
                    nowno=no;
                }
            }
            action();
        }
    }
 
    var getopacity=function(target){
        return (isie)? parseInt(target.style.filter.match(/alpha\(opacity=([0-9]+)\)/)[1]) : target.style.opacity*100;
    }
 
    var setopacity=function(target,value){
        if(isie) target.style.filter='alpha(opacity='+value+')';
        else target.style.opacity=value/100;
    }
 
    this.fadeinaction=function(no){
        clearTimeout(this.autoplaytimer);
        if(canimove){
            canimove=false;
            setopacity(items[no],0);
            this.setzindex(no);
            var nowo,to=0;
            var action=function(){
                clearTimeout(timer);
                nowo=getopacity(items[no]);
                if(nowo!=100){
                    setopacity(items[no],Math.ceil(nowo+(100-nowo)/speed));
                    setTimeout(action,10);
                }else{
                    eval(objectid+'.autoplayaction()');
                    clearTimeout(timer);
                    canimove=true;
                    nowno=no;
                }
            }
            action();
        }
    }
 
}

function wholemenu_Show() {
	var obj = document.getElementById("wholemenulist");
	if ( !obj.style.display || obj.style.display == "none" ) {
		obj.style.display = "block";
	} else {
		obj.style.display = "none";
	}
}


function siteLinkValidate(selectBoxId){

	var selectedChecker = false;
	var siteBoxId = document.getElementById(selectBoxId);

	for(var i=0;i<siteBoxId.length;i++){
		if(siteBoxId[i].selected && siteBoxId[i].value != ""){
			selectedChecker = true;
			//alert(siteBoxId[i].value);
			break;
		}
	}
	if(!selectedChecker){
		alert("이동하시려는 사이트를 선택하세요.");
		siteBoxId.focus();
		return false;
	}

}


function printContent(code) {
	window.open('/common/print/print_new.jsp?code='+code,'printWindow', 'location=no, directories=no, resizable=yes, status=no, toolbar=no, menubar=no, scrollbars=no, width=660, height=600');
}


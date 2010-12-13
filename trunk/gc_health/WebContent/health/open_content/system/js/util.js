	//<![CDATA[
/* 전역 변수 */

var IS_NAV = (navigator.appName == "Netscape");
var IS_IE = (navigator.appName == "Microsoft Internet Explorer");

var IS_WIN = (navigator.userAgent.indexOf("Win") != -1);
var IS_MAC = (navigator.userAgent.indexOf("Mac") != -1);
var IS_UNIX = (navigator.userAgent.indexOf("X11") != -1);

/**
 * 쿠키에 저장된 값을 반환한다.
 * @param name 쿠키 이름
 * @return 쿠키 이름에 대한 값을 반환. 없는 경우에는 ""를 반환.
 */
function getCookie(name) {
    var arg = name + "=";
    var alen = arg.length;
    var clen = document.cookie.length;
    var i = 0;
    while (i < clen) {
        var j = i + alen;
        if (document.cookie.substring(i, j) == arg) {
            return getCookieVal(j);
        }
        i = document.cookie.indexOf(" ", i) + 1;
        if (i == 0) break;
    }
    return "";
}


/**
 * 쿠키를 저장한다.
 * @param name 쿠키 이름
 * @param value 쿠키 값
 * @param expires 쿠키의 유효 일
 * @param path
 * @param domain
 * @param secure
 */
function setCookie(name, value, expires, path, domain, secure) {
    if (!path) {
        path = "/";
    }
    document.cookie = name + "=" + escape (value) +
                    ((expires) ? "; expires=" + expires : "") +
                    ((path) ? "; path=" + path : "") +
                    ((domain) ? "; domain=" + domain : "") +
                    ((secure) ? "; secure" : "");
}


/**
 * 쿠키를 삭제한다.
 * @param name 삭제할 쿠키 이름
 * @param path
 * @param domain
 */
function deleteCookie(name, path, domain) {
    if (!path) {
        path = "/";
    }
    if (getCookie(name)) {
        document.cookie = name + "=" +
            ((path) ? "; path=" + path : "") +
            ((domain) ? "; domain=" + domain : "") + 
            "; expires=Thu, 01-Jan-70 00:00:01 GMT";
    }
}


/**
 * 쿠키를 저장할 때 필요한 적합한 형식의 유효기간을 반환한다.
 * @days 쿠키가 유효할 일 (예를 들어 3 일 동안 유효해야 하면 3을 입력)
 * @hours 쿠키가 유효할 시간 (예를 들어 2 시간 동안 유효해야 하면 2를 입력)
 * @minutes 쿠키가 유효할 분 (예를 들어 30 분 동안 유효해야 하면 30을 입력)
 */
function getExpDate(days, hours, minutes) {
    var expDate = new Date( );
    if (typeof days == "number" && typeof hours == "number" &&
        typeof hours == "number") {
        expDate.setDate(expDate.getDate( ) + parseInt(days));
        expDate.setHours(expDate.getHours( ) + parseInt(hours));
        expDate.setMinutes(expDate.getMinutes( ) +
        parseInt(minutes));
        return expDate.toGMTString( );
    }
}


/**
 * 쿠키 값을 읽을 때 사용하는 보조 함수
 */
function getCookieVal(offset) {
    var endstr = document.cookie.indexOf (";", offset);
    if (endstr == -1) {
        endstr = document.cookie.length;
    }
    return unescape(document.cookie.substring(offset, endstr));
}

/**
 * 입력받을 수 있는 값을 필터링한다.
 * ex : <input type="text" ..... onkeypress="filterKey('[0-9]')"> ; 숫자만 키입력이 가능한 text filed
 * ex : <input type="text" ..... onkeypress="filterKey('[0-9a-zA-Z]')"> ; 영문,숫자만 키입력이 가능한 text filed
 * @param filter : 필터링할 정규표현식 ex) '[0-9]':0~9의 값만 허용, '[a-zA-Z]':알파벳만 허용
 * @return 
 */
function filterInputData(filter) {
    if (filter) {
        var sKey = String.fromCharCode(event.keyCode);
        var re = new RegExp(filter);
        if (!re.test(sKey)) {
            event.returnValue = false;
        }
    }
}


/**
 * 주어진 텍스트(source)에 특정 문자(query)가 나타나는 횟수를 반환한다.
 * @param source 대상이 되는 텍스트
 * @param query 검색하려는 텍스트
 * @return 주어진 텍스트에 특정 문자가 나타나는 횟수
 */
function countInstances(source, query) {
    var re = new RegExp(query, "g");
    var result = source.match(re);
    return (result) ? result.length : 0;
}

/**
 * <div> 태그의 내용 중 특정 텍스트(before)를 특정 텍스트(after)로 변경한다.
 * @param id <div> 태그의 id 속성 값
 * @param before 변경 전 텍스트
 * @param after 변경 후 텍스트
 */
function replaceTextInDiv(id, before, after) {
    var element = document.getElementById(id).firstChild;
    var re = new RegExp(before, "g");
    element.nodeValue = element.nodeValue.replace(re, after);
    return false;
}

function writeTextInElement(id, text) {
    var element = document.getElementById(id);
    if (element.firstChild) {
        element.firstChild.nodeValue = text;
    } else {
        var child = document.createTextNode(text);
        element.appendChild(child);
    }
    return false;
}

/**
 * 입력 변수에 3 자리마다 콤마(,)를 붙여 반환한다.
 * @param field 콤마를 붙일 값
 */
function formatCommas(val) {
    var re = /,|\s+/g;
    var numString = val.replace(re, "");

    re = /(-?\d+)(\d{3})/;
    while (re.test(numString)) {
        numString = numString.replace(re, "$1,$2");
    }
    val = numString;
    return val;
}

function stripCommas(numString) {
    var re = /,/g;
    return numString.replace(re, "");
}

/**
 * 텍스트 필드에 입력한 값에 3자리마다 콤마(,)를 붙인다.
 * 텍스트 필드에 아래를 기입한다. onkeyup="toMoney(this)"
 * @param field 텍스트 필드
 */
function toMoney(field) {
    var value = field.value;
    var indexOfPoint = value.indexOf(".");
    if (indexOfPoint == -1) {
        field.value = formatCommas(value);
    } else {
        field.value = formatCommas(value.substring(0, indexOfPoint)) +
                        value.substring(indexOfPoint, value.length);
    }
}


/**
 * 두 날짜 사이의 일수를 계산하여 반환한다.
 * @param date1 문자열 데이터로 '20041012' 형식
 * @param date2 문자열 데이터로 '20041012' 형식
 */
function daysBetween(date1, date2) {
    date1 = new Date(date1.substring(0, 4), date1.substring(4, 6)-1, date1.substring(6,8));
    date2 = new Date(date2.substring(0, 4), date2.substring(4, 6)-1, date2.substring(6,8));
    var DSTAdjust = 0;
    oneMinute = 1000 * 60;
    var oneDay = oneMinute * 60 * 24;
    date1.setHours(0);
    date1.setMinutes(0);
    date1.setSeconds(0);
    date2.setHours(0);
    date2.setMinutes(0);
    date2.setSeconds(0);
    DSTAdjust = (date2.getTimezoneOffset( ) - 
                     date1.getTimezoneOffset( )) * oneMinute;
    var diff = date2.getTime( ) - date1.getTime() - DSTAdjust;
    return Math.ceil(diff/oneDay);
}

/**
* 두 Time이 며칠 차이나는지 구함
* time1이 time2보다 크면(미래면) minus(-)
*/
function getDayInterval(date1,date2) {
	var date1s = date1.split("-");
	var date2s = date2.split("-");
    date1 = new Date(date1s[0], date1s[1]-1, date1s[2]);
    date2 = new Date(date2s[0], date2s[1]-1, date2s[2]);
    resultDt = Math.floor(date2.valueOf()/(24*60*60*1000)- date1.valueOf()/(24*60*60*1000));
    
    return resultDt;
}
/*
* ----------------------------------------------------------------------------
* 특정 날짜에 대해 지정한 값만큼 가감(+-)한 날짜를 반환

* 

* 입력 파라미터 -----
* pInterval : "yyyy" 는 연도 가감, "m" 은 월 가감, "d" 는 일 가감
* pAddVal  : 가감 하고자 하는 값 (정수형)
* pYyyymmdd : 가감의 기준이 되는 날짜
* pDelimiter : pYyyymmdd 값에 사용된 구분자를 설정 (없으면 "" 입력)

* 

* 반환값 ----

* yyyymmdd 또는 함수 입력시 지정된 구분자를 가지는 yyyy?mm?dd 값
*

* 사용예 ---

* 2008-01-01 에 3 일 더하기 ==> addDate("d", 3, "2008-08-01", "-");

* 20080301 에 8 개월 더하기 ==> addDate("m", 8, "20080301", "");
--------------------------------------------------------------------------- */
function addDate(pInterval, pAddVal, pYyyymmdd, pDelimiter)
{
	var yyyy;
	var mm;
	var dd;
	var cDate;
	var oDate;
	var cYear, cMonth, cDay;
	
	if (pDelimiter != "") {
	 pYyyymmdd = pYyyymmdd.replace(eval("/\\" + pDelimiter + "/g"), "");
	}
	
	
	yyyy = pYyyymmdd.substr(0, 4);
	mm  = pYyyymmdd.substr(4, 2);
	dd  = pYyyymmdd.substr(6, 2);
	
	if (pInterval == "yyyy") {
	 yyyy = (yyyy * 1) + (pAddVal * 1); 
	} else if (pInterval == "m") {
	 mm  = (mm * 1) + (pAddVal * 1);
	} else if (pInterval == "d") {
	 dd  = (dd * 1) + (pAddVal * 1);
	}
	
	cDate = new Date(yyyy, mm - 1, dd) // 12월, 31일을 초과하는 입력값에 대해 자동으로 계산된 날짜가 만들어짐.
	cYear = cDate.getFullYear();
	cMonth = cDate.getMonth() + 1;
	cDay = cDate.getDate();
	
	cMonth = cMonth < 10 ? "0" + cMonth : cMonth;
	cDay = cDay < 10 ? "0" + cDay : cDay;
	
	if (pDelimiter != "") {
	 return cYear + pDelimiter + cMonth + pDelimiter + cDay;
	} else {
	 return cYear + cMonth + cDay;
	}
	
} 



/**
 * 특정 노드가 가지고 있는 모든 속성을 TEXTAREA에 출력한다. 개발 편의를 위해서
 * 제공되는 함수이다.
 * @param obj 속성 값을 알고자 하는 노드
 */
function listProperties(obj) {
    var objName;

    if (obj.nodeName) {
        objName = obj.nodeName;
    } else {
        objName = "navigator";
    }

    var result = "";
    for (var i in obj) {
        result += objName + "." + i + "=" + obj[i] + "\n";
    }

    var area = document.createElement("textarea");
    area.rows = 20;
    area.cols = 50;
    var body = document.getElementsByTagName("BODY");
    if (body) {
        body[0].appendChild(area);
    } else {
        alert("body 태그가 있어야 합니다.");
        return false;
    }
    area.value = result;
    return false;
}

function getQueryString() {
    var result = "";
    var queryTags = document.getElementsByTagName("input");
    for (var i = 0; i < queryTags.length; i++) {
        var name = queryTags[i].name;
		if (name && name.substring(0, 2) == "q_" || name == "pageNo") {
		    result += "&" + name + "=" + queryTags[i].value;
		}
    }

    queryTags = document.getElementsByTagName("select");
    for (var i = 0; i < queryTags.length; i++) {
        var name = queryTags[i].name;
		if (name && name.substring(0, 2) == "q_" || name == "pageNo") {
		    result += "&" + name + "=" + queryTags[i].value;
		}
    }
    return result;
}

// 정규표현식을 이용한 이메일 검사
function validateEmail(emailad) { 

	var exclude=/[^@\-\.\w]|^[_@\.\-]|[\._\-]{2}|[@\.]{2}|(@)[^@]*\1/; 
	var check=/@[\w\-]+\./; 
	var checkend=/\.[a-zA-Z]{2,3}$/; 

    if(((emailad.search(exclude) != -1)||(emailad.search(check)) == -1)||(emailad.search(checkend) == -1)){ 		
		return false;
    }
    
    return true;
} 

function isNumeric(s) {
    for (i=0; i<s.length; i++) {
            c = s.substr(i, 1);
            if (c < "0" || c > "9") return false;
    }
    return true;
}

function lpad(newValue, len, ch)
{
	//왼쪽에 ch 문자 채우기
	var strlen = trim(newValue).length;
	var ret = "";
	var alen = len - strlen;
	var astr = ""; 
	
	//부족한 숫자만큼  len 크기로 ch 문자로 채우기
	for (i=0; i<alen; ++i)
	{
		astr = astr + ch;
	}
	
	ret = astr + trim(newValue); //앞에서 채우기
	return ret;
}

function delChar(source)
{
	var str = trim(source);
	var strlen = str.length;
	var idx = strlen-1;
	for(var i = 0; i < strlen; i++) 
	{
        var chr = str.substr(i,1);
        if(chr != '0')
        {
        	idx = i;
            break; 
        }
	}
	return str.substr(idx);
}

function rpad(newValue, len, ch)
{
	//오른쪽에 ch문자로 채우기
	var strlen = trim(newValue).length;
	var ret = "";
	var alen = len - strlen;
	var astr = ""; 
	
	//부족한 숫자만큼  len 크기로 ch 문자로 채우기
	for (i=0; i<alen; ++i)
	{
		astr = astr + ch;
	}
	
	ret = trim(newValue) + astr; //뒤에서 채우기
	return ret;
}

function trim(str) 
{  
    return str.replace(/^\s\s*/, '').replace(/\s\s*$/, '');  
} 

function textCounter(field, countfield, maxlimit)
{
	if(field.value.length>maxlimit)
	{
		alert('허용된 길이를 초과했습니다.');
		field.value = field.value.substring(0, maxlimit);
	}
	else countfield.value = maxlimit-field.value.length;
}       

String.prototype.bytes = function() {
	var str = this;
	var l = 0;
	for (var i=0; i<str.length; i++) l += (str.charCodeAt(i) > 128) ? 2 : 1;
	return l;
}


String.prototype.formatDate = function() {
	var str = this;
	var l = 0;
	if(!str || str.length != 8) return "";
	else return str.substring(0, 4)+"."+str.substring(4, 6)+"."+str.substring(6);
}
	//]]>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=7" /> 
<title>금천구청</title>
<meta name="robots" content="all" />  
<meta name="keywords" content="금천구청" />  
<meta name="description" content="금천구청" />  
<meta name="author" content="금천구청" />
<link rel="stylesheet" type="text/css" href="http://www.geumcheon.go.kr/open_content/system/css/reset.css" />
<link rel="stylesheet" type="text/css" href="http://www.geumcheon.go.kr/open_content/system/css/popup.css" />
<!--[if lte IE 7]><link rel="stylesheet" type="text/css" href="/open_content/system/css/ie7.css" /><![endif]-->
<!--[if IE 6]><link rel="stylesheet" type="text/css" href="/open_content/system/css/ie6.css" /><![endif]-->
<script type="text/javascript" src="/health/open_content/system/js/jslb_ajax.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/prototype.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>
<script type="text/javascript">
	function getDong()
	{
		var form = $('frm');
		var v = new MiyaValidator(form);
	    v.add("dongNm", {
	    	required: true,
            message: "동/읍/면을 입력하세요."
	    });
	    var result = v.validate();
	    if (!result) {
	        alert(v.getErrorMessage());
	        v.getErrorElement().focus();
	        return;
	    } 
		var url = "/health/zipcode/selectDongList.do";
		var param = "&dongNm="+$F('dongNm');
		sendRequest(callbackGetDong, param, 'POST', url, true, true);
	}
		
	function callbackGetDong(oj)
	{
		try 
		{
			var jsonData = oj.responseText;
			var j = eval('(' + jsonData + ')');

	        var dongs = j.dong.split("|");
			if(dongs && dongs.length <= 0)
			{
				alert("데이터가 없습니다.");
				return;
			}
			
	        var selectObj = $("dong");
			selectObj.innerHTML = "";
        	var opt = document.createElement("OPTION");
        	selectObj.options.add(opt);
        	opt.innerText = "-선택-";
        	opt.value = "";
        
	        for(i=0;i<dongs.length;i++)
	        {
	        	var opt = document.createElement("OPTION");
	        	selectObj.options.add(opt);
	        	opt.innerText = dongs[i];
	        	opt.value = dongs[i];
	        }
		}	
		catch (err) 
		{
			alert("FUNCTION : callbackGetDong() " + err.description);
		}
	}

	function getAddr()
	{
		var addr = $F('dong');
		var addrs = addr.split(" ");
		var url = "/health/zipcode/selectAddrList.do";
		var param = "&sido="+addrs[0]+"&gugun="+addrs[1]+"&dong="+addrs[addrs.length-1];
		sendRequest(callbackGetAddr, param, 'POST', url, true, true);
	}
	
	function callbackGetAddr(oj)
	{
		try 
		{
			var jsonData = oj.responseText;
			var j = eval('(' + jsonData + ')');
	        var zipcods = j.zipcod.split("|");;
	        var addrs = j.addr.split("|");
	        var bunsistas = j.bunsista.split("|");
	        var bunsiends = j.bunsiend.split("|");
	        var str = "";	        
	        for(i=0;i<addrs.length;i++)
	        {
		        str += "<li><a href=\"javascript:setAddr('"+zipcods[i].substr(0,3)+"-"+zipcods[i].substr(3,3)+"','"+addrs[i]+"');\">";
		        str += "<span>["+zipcods[i].substr(0,3)+"-"+zipcods[i].substr(3,3)+"]</span>";
				str += addrs[i] + "" + bunsistas[i];
				if(bunsiends[i] != "")
					str += "~" + bunsiends[i];
		        str += "</a></li>";		   
	        }
	        $('addrList').innerHTML = str;
		}	
		catch (err) 
		{
			alert("FUNCTION : callbackGetZipcode() " + err.description);
		}
	}

	function setAddr(zipcode, addr)
	{
		var form = opener.document.frm;
		var zipcodes = zipcode.split("-");
		var zip1 = opener.document.getElementById("${param.code1}");
		var zip2 = opener.document.getElementById("${param.code2}");
		var addr1 = opener.document.getElementById("${param.code3}");
		zip1.value = zipcodes[0];
		zip2.value = zipcodes[1];
		addr1.value = addr;
		self.close();
	}
</script>
</head>

<body>
<!-- [ Popup Size 400*400 ] -->
<div id="popupwrap" class="popupwrap2">
	<h1>우편번호 찾기</h1>
	<p class="paragraph_type2">동/읍/면의 이름을 입력하시고 ‘주소검색’을 클릭하세요.<br />(예 : 여의도 또는 해남읍 또는 계곡면)</p>
	<div class="zipcode_search">
		<form id="frm">
		<fieldset>
			<label for="dong">동 : </label>
			<select name="dong" id="dong" onchange="getAddr();"></select>
			<input name="dongNm" type="text" class="intext" id="dongNm" onKeypress="if(event.keyCode==13) {javascript:getDong(); return false;}" />
			<a href="#getDong" onClick="javascript:getDong();" onKeypress="if(event.keyCode==13) {this.onclick(); return false;}"><img src="http://www.geumcheon.go.kr//open_content/images/common/btn/btn_search_address.gif" alt="주소검색" /></a>
		</fieldset>
		</form>
	</div>
	<div class="address_list">
		<p>[해당주소를 선택하십시오]</p>
		<ul id="addrList">
		</ul>
	</div>
	<div class="close">
		<div>
			<a href="#popupwrap" onclick="javascript:self.close();"><img src="http://www.geumcheon.go.kr/open_content/images/common/btn/btn_popup_confirm.gif" alt="확인" /></a>
			<a href="#popupwrap" onclick="javascript:self.close();"><img src="http://www.geumcheon.go.kr/open_content/images/common/btn/btn_popup_close.gif" alt="닫기" /></a>
		</div>
	</div>
</div>

</body>
</html>
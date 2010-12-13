<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="egovframework.kr.go.geumcheon.health.util.ZValue" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="today" class="java.util.Date" />
<%
	String categoryId = request.getParameter("categoryId");
	if(categoryId == null) throw new Exception("categoryId 값이 없습니다.!");

	HashMap healthMenuCategoryMap = (HashMap)application.getAttribute("healthMenuCategoryMap");
	pageContext.setAttribute("healthMenuCategoryMap", healthMenuCategoryMap);

	HashMap<String, ZValue> healthMenuMap = (HashMap)application.getAttribute("healthMenuMap");
	pageContext.setAttribute("healthMenuMap", healthMenuMap);

	ZValue currMenu = healthMenuMap.get("menu_" + categoryId);
	pageContext.setAttribute("currMenu", currMenu);
	
	String position = currMenu.getString("position");
	if(position == null) throw new Exception("position 값이 없습니다.!");
	System.out.println("***********************position : " + position);
	
	int depth01 = Integer.parseInt(position.substring(0,2)) -1;
	int depth02 = Integer.parseInt(position.substring(2,4)) -1;
	int depth03 = Integer.parseInt(position.substring(4,6)) -1;
	int depth04 = Integer.parseInt(position.substring(6,8)) -1;
	int depth05 = Integer.parseInt(position.substring(8,10)) -1;
	pageContext.setAttribute("depth01", depth01);
	pageContext.setAttribute("depth02", depth02);
	pageContext.setAttribute("depth03", depth03);
	pageContext.setAttribute("depth04", depth04);
	pageContext.setAttribute("depth05", depth05);
	
	org.springframework.context.ApplicationContext context =
		org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(getServletContext());

	/*
	egovframework.kr.go.geumcheon.health.util.ZValue zvl = new egovframework.kr.go.geumcheon.health.util.ZValue();
	zvl.put("categoryId", categoryId);
	zvl.put("progrmFileNm", (String)request.getAttribute("includePage"));
	egovframework.kr.go.geumcheon.health.service.MasterMenuManagerService service =
		(egovframework.kr.go.geumcheon.health.service.MasterMenuManagerService)context.getBean("masterMenuManagerService");
	service.insertProgramList(zvl);
	*/
	
	egovframework.kr.go.geumcheon.health.service.VisitorLogService service =
		(egovframework.kr.go.geumcheon.health.service.VisitorLogService)context.getBean("visitorLogService");

	egovframework.kr.go.geumcheon.health.util.ZValue logCount = service.selectLogCount("11");
	pageContext.setAttribute("logCount", logCount);
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />

	<c:set var="path" value="${fn:split(currMenu.fullPath, '/')}" />
    <c:set var="title" value=""/>
	<c:forEach var="x" begin="0" end="${fn:length(path)-1}">
		<c:set var="title" value="${path[x]}&lt;${title}"/>
	</c:forEach>
	<title>${title}금천구 보건소</title>
<link href="/health/open_content/system/css/default.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/common.css" rel="stylesheet" type="text/css" />
<c:choose>
<c:when test="${depth01 == 0 || depth01 == 4}">
<c:set var="depth01Color" value="green" />
<link href="/health/open_content/system/css/green.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_green.css" rel="stylesheet" type="text/css" />
</c:when>
<c:when test="${depth01 == 1}">
<c:set var="depth01Color" value="perple" />
<link href="/health/open_content/system/css/perple.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_perple.css" rel="stylesheet" type="text/css" />
</c:when>
<c:when test="${depth01 == 2}">
<c:set var="depth01Color" value="blue" />
<link href="/health/open_content/system/css/blue.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_blue.css" rel="stylesheet" type="text/css" />
</c:when>
<c:when test="${depth01 == 3}">
<c:set var="depth01Color" value="orange" />
<link href="/health/open_content/system/css/orange.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_orange.css" rel="stylesheet" type="text/css" />
</c:when>
</c:choose>

<!--[if IE 7]><link rel="stylesheet" type="text/css" href="/health/open_content/system/css/ie67.css" /> <![endif]-->
<!--[if IE 6]><link rel="stylesheet" type="text/css" href="/health/open_content/system/css/ie67.css" />
              <link rel="stylesheet" type="text/css" href="/health/open_content/system/css/ie6.css" /> <![endif]-->

<script type="text/javascript" src="/health/open_content/system/js/common_ui.js"></script>
<script type="text/javascript">
	//<![CDATA[
function getCheckedValue(radioObj) 
{
	if(!radioObj)
		return "";
	var radioLength = radioObj.length;
	if(radioLength == undefined)
		if(radioObj.checked)
			return radioObj.value;
		else
			return "";
	for(var i = 0; i < radioLength; i++) 
	{
		if(radioObj[i].checked) 
		{
			return radioObj[i].value;
		}
	}
	return "";
}

function checkSatisfactionForm(form)
{
	var statusVal = getCheckedValue(form.status);
	if(!statusVal)
	{
		alert("사용자 만족도 평가를 선택하세요.");
		//(document.getElementById("status3")).focus();
		return false;			
	}
	if(!form.opinion.value)
	{
		alert("한줄의견을 입력해주세요.");
		//form.opinion.focus();
		(document.getElementById("opinion")).style.backgroundImage="url(none)";
		return false;			
	}
	return true;
}

function checkSearchForm(form)
{
	if(!form.searchTxt.value)
	{
		alert("검색어를 입력해 주세요.");
		//(document.getElementById("status3")).focus();
		return false;			
	}
	return true;
}

function checkSearchForm2(form)
{
	if(!form.branchId.value)
	{
		alert("병의원/약국을 선택해 주세요.");
		//(document.getElementById("status3")).focus();
		return false;			
	}
	/*
	if(!form.searchTxt.value)
	{
		alert("검색어를 입력해 주세요.");
		//(document.getElementById("status3")).focus();
		return false;			
	}
	*/
	return true;
}
	//]]>
</script>
</head>

<body>
<div id="warp">
    <ul id="skipNavi">
        <li><a href="#contentArea">본문으로 건너뛰기</a></li>
		<li><a href="#gnb">주메뉴로 건너뛰기</a></li>
        <li><a href="#left_lnb">서브메뉴로 건너뛰기</a></li>
        <li><a href="#idx_tsearch">통합검색으로 건너뛰기</a></li>
        <li><a href="#quick_menu">우측 퀵메뉴로 건너뛰기</a></li>
    </ul>
    <div id="header" >
        <h1><a href="/health/main/main.do"><img src="/health/open_content/images/common/logo.gif" width="180" height="43" alt="서울특별시 금천구 보건소" /></a></h1>
        <ul id="global">
            <li><a href="/health/main/main.do"><img src="/health/open_content/images/common/global/global_home.gif" width="35" height="11" alt="HOME" /></a></li>
		<c:choose>
		<c:when test="${empty user.webMemId && empty company}">
            <li><a href="http://www.geumcheon.go.kr/member.do?method=loginPage&amp;fromLogin=health&amp;pageKey=08010101"><img src="/health/open_content/images/common/global/global_login.gif" width="37" height="11" alt="로그인" /></a></li>
		</c:when>
		<c:otherwise>
            <li><a href="/health/member/logout.do"><img src="/health/open_content/images/common/global/global_logout.gif" width="37" height="11" alt="로그아웃" /></a></li>
		</c:otherwise>
		</c:choose>
            <li><a href="http://www.geumcheon.go.kr/member.do?method=agreePage1&amp;pageKey=08020101"><img src="/health/open_content/images/common/global/global_join.gif" width="44" height="11" alt="회원가입" /></a></li>
            <li><a href="/health/main/sitemap.do?categoryId=3081"><img src="/health/open_content/images/common/global/global_sitemap.gif" width="46" height="11" alt="사이트맵" /></a></li>
            <li><a href="http://www.geumcheon.go.kr"><img src="/health/open_content/images/common/global/global_guchung.gif" width="41" height="11" alt="금천구청" /></a></li>
            <li>
                <dl>
                    <dt><img src="/health/open_content/images/common/global/font_title.gif" width="33" height="11" alt="글자크기" /></dt>
                    <dd>
                        <button type="button" class="btn_font_plus">확대</button>
                    </dd>
                    <dd>
                        <button type="button" class="btn_font_minus">축소</button>
                    </dd>
                    <dd>
                        <button type="button" class="btn_font_reset">초기화</button>
                    </dd>
                </dl>
            </li>
            <li><a href="/english/main/main.do"><img src="/health/open_content/images/common/global/global_lang_1.gif" width="45" height="11" alt="ENGLISH(영문 홈페이지)" /></a></li>
            <li><a href="/japanese/main/main.do"><img src="/health/open_content/images/common/global/global_lang_2.gif" width="33" height="11" alt="日本語(일본어 홈페이지)" /></a></li>
            <li><a href="/china/main/main.do"><img src="/health/open_content/images/common/global/global_lang_3.gif" width="25" height="11" alt="中文(중국어 홈페이지)" /></a></li>
			<li><a href="/btn/main/main.do"><img src="/health/open_content/images/common/global/global_lang_4.gif" width="40" height="11" alt="vietnam(베트남어 홈페이지)" /></a></li>
            <!--li><a href="#"><img src="/health/open_content/images/common/global/global_lang_4.gif" width="40" height="11" alt="베트남어" /></a></li>
            <li><a href="#"><img src="/health/open_content/images/common/global/global_lang_5.gif" width="47" height="11" alt="캄보디아어" /></a></li-->
        </ul>
        <div id="gnb">
            <ul>
			<c:set var="curCategory" value="" />
			<c:set var="topCategories" value="${healthMenuCategoryMap['menu_0']}" />
			<c:if test="${fn:length(topCategories)>0}">
		 		<c:forEach var="x" begin="0" end="3">
                <li><a href="${topCategories[x].fullMenuLink}"><img src="/health/open_content/images/menu/gnb_tab_${x+1}_${x==depth01 ? 'on' : 'off'}.gif" alt="${topCategories[x].name}" /></a>
	 				<c:set var="imgIdx" value="${x+1}" />
	 				<c:if test="${imgIdx < 10 }" ><c:set var="imgIdx" value="0${x+1}" /></c:if>
	 				<c:set var="clss1" value="${x == depth01 ? 'class=\"current\"' : ''}"/>
                    <ul ${clss1} id="gnb_${imgIdx}">
					<c:set var="d02MenuKey" value="menu_${topCategories[x].categoryId}" />
					<c:set var="d02Categories" value="${healthMenuCategoryMap[d02MenuKey]}" />
					<c:if test="${fn:length(d02Categories)>0}">
			 			<c:forEach var="y" begin="0" end="${fn:length(d02Categories)-1}">
			 				<c:if test="${x == depth01 && y == depth02}"><c:set var="curCategory" value="${d02Categories[y]}" /><c:set var="curD02Category" value="${d02Categories[y]}" /></c:if>
	 						<c:set var="clss2" value="${x == depth01 && y == depth02 ? 'class=\"current\"' : ''}"/>
                        <li><a href="${d02Categories[y].fullMenuLink}"><img src="/health/open_content/images/menu/1depth_${depth01Color}_${y+1}_${x == depth01 && y == depth02 ? 'on' : 'off'}.gif" alt="${d02Categories[y].name}" /></a>
                            <ul id="smenu_${x+1}_${y+1}" ${clss2}>
							<c:set var="d03MenuKey" value="menu_${d02Categories[y].categoryId}" />
							<c:set var="d03Categories" value="${healthMenuCategoryMap[d03MenuKey]}" />
							<c:choose>
							<c:when test="${fn:length(d03Categories)>0}">
		 						<c:forEach var="z" begin="0" end="${fn:length(d03Categories)-1}">
			 						<c:if test="${x == depth01 && y == depth02 && z == depth03}"><c:set var="curCategory" value="${d03Categories[z]}" /></c:if>
	 								<c:set var="clss3" value="${x == depth01 && y == depth02 && z == depth03 ? 'class=\"current\"' : ''}"/>
	 								<c:choose>
	 								<c:when test="${z == 0}"><c:set var="liClss3" value="${'class=\"fir\"'}" /></c:when>
	 								<c:when test="${z == fn:length(d03Categories)-1}"><c:set var="liClss3" value="${'class=\"end\"'}" /></c:when>
	 								<c:otherwise><c:set var="liClss3" value="" /></c:otherwise>
	 								</c:choose>
                                <li ${liClss3}><a ${clss3} href="${d03Categories[z].fullMenuLink}">${d03Categories[z].name}</a></li>
                                </c:forEach>
                            </c:when>
                            </c:choose>
                            </ul>
                        </li>
                        </c:forEach>
                    </c:if>
                    </ul>
                </li>
                </c:forEach>
            </c:if>
            </ul>
        </div>
        <!-- gnb e --> 
    </div>
    <!-- header e -->
	
	<c:if test="${empty curD02Category}">
 		<c:set var="curD02Id" value="menu_${topCategories[depth01].categoryId}" />
		<c:set var="d02Categories" value="${healthMenuCategoryMap[curD02Id]}" />
 		<c:set var="curD02Category" value="${d02Categories[depth02]}" />
 		<c:set var="curCategory" value="${d02Categories[depth02]}" />
 	</c:if>

    <div id="left_lnb">
        <div id="lnb">
            <h2><img src="/health/open_content/images/lnb_menu/lng_h2_${curD02Category.categoryId}.gif" alt="${curD02Category.name}" /></h2>
            <div class="menu_all_view">
                <button type="button" class="menu_toggle_on" onclick="objLNB.allOpen(); return false;" onkeypress="this.onclick();">메뉴펼침</button>
                <button type="button" class="menu_toggle_off" onclick="objLNB.allClose(); return false;" onkeypress="this.onclick();">메뉴닫힘</button>
            </div>
            <ul id="lnb_menu">
		<c:set var="d01Category" value="${topCategories[depth01]}" />
		<c:set var="d01menuKey" value="menu_${d01Category.categoryId}" />
		<c:set var="d02Categories" value="${healthMenuCategoryMap[d01menuKey]}" />
		<c:set var="d02menuKey" value="menu_${d02Categories[depth02].categoryId}" />
		<c:set var="d03Categories" value="${healthMenuCategoryMap[d02menuKey]}" />
		<c:if test="${fn:length(d03Categories)>0}">
		 	<c:forEach var="x" begin="0" end="${fn:length(d03Categories)-1}">
				<c:if test="${x == depth03}"><c:set var="curCategory" value="${d03Categories[x]}" /></c:if>
				<c:set var="d03MenuKey" value="menu_${d03Categories[x].categoryId}" />
				<c:set var="d04Categories" value="${healthMenuCategoryMap[d03MenuKey]}" />
                <c:set var="clss3" value="${x == depth03 ? 'class=\"current\"' : ''}"/>
				<c:choose>
				<c:when test="${fn:length(d04Categories)>0}">
                <li><a href="${d03Categories[x].fullMenuLink}" ${clss3} >${d03Categories[x].name}</a>
                    <ul>
                    <c:forEach var="y" begin="0" end="${fn:length(d04Categories)-1}">
						<c:if test="${x == depth03 && y == depth04}"><c:set var="curCategory" value="${d04Categories[y]}" /><c:set var="curD04Category" value="${d04Categories[y]}" /></c:if>
                    	<c:set var="clss4" value="${x == depth03 && y == depth04 ? 'class=\"current\"' : ''}"/>
                        <li><a ${clss4} href="${d04Categories[y].fullMenuLink}">${d04Categories[y].name}</a></li>
                    </c:forEach>
                    </ul>
                </li>
                </c:when>
                <c:otherwise>
                <li><a ${clss3} href="${d03Categories[x].fullMenuLink}">${d03Categories[x].name}</a>
                	<ul class="blindtext"><li>${d03Categories[x].name}</li></ul>
                </li>
                </c:otherwise>
                </c:choose>
            </c:forEach>
        </c:if>
            </ul>
        </div>
    </div>
	<!-- LNB script -->
	<script type="text/javascript"> 
	//<![CDATA[
	var objLNB = new lnbMenu();
	objLNB.specifyOpen(${depth03});
	//]]>
	</script>
	<!-- //LNB script -->
    <div id="contents">
		<div class="main_search" id="idx_tsearch">
			<form name="searchFrm" method="post" action="/health/search/search.do" onsubmit="return checkSearchForm(this);" class="idx_search" >
                <fieldset>
				<legend>통합검색</legend>
				<label for="method" class="blind">통합검색구분</label>
                <select id="method" name="method">
                    <option value="0">통합검색</option>
                    <option value="1" <c:if test="${param.method == '1'}">selected="selected"</c:if>>메뉴</option>
                    <option value="2" <c:if test="${param.method == '2'}">selected="selected"</c:if>>게시판</option>
                    <option value="3" <c:if test="${param.method == '3'}">selected="selected"</c:if>>직원/업무</option>
                </select>
				<label for="search_word" class="blind">통합검색어</label>
                <input type="text" id="search_word" name="searchTxt" class="search_word" />
                <input type="image" src="/health/open_content/images/main/btn_search.gif" alt="검색" />
				</fieldset>
			</form>
            
			<form name="searchFrm2" action="/health/wcmboard/searchWcmboardList.do" onsubmit="return checkSearchForm2(this);" class="idx_gis_search">
				<fieldset>
				<input type="hidden" name="communityId" value="B0048" />
				<input type="hidden" name="searchType" value="3" />
				<legend>GIS병의원/약국찾기</legend>
				<label for="branchId" class="blind">기관선택</label>
				<select name="branchId" id="branchId">
					<option value="">GIS병의원/약국찾기</option>
					<option value="75" <c:if test="${param.branchId == '75'}">selected="selected"</c:if>>가정의학과의원</option>
					<option value="76" <c:if test="${param.branchId == '76'}">selected="selected"</c:if>>기타의원</option>
					<option value="77" <c:if test="${param.branchId == '77'}">selected="selected"</c:if>>병원</option>
					<option value="78" <c:if test="${param.branchId == '78'}">selected="selected"</c:if>>산부인과의원</option>
					<option value="79" <c:if test="${param.branchId == '79'}">selected="selected"</c:if>>성형외과의원</option>
					<option value="80" <c:if test="${param.branchId == '80'}">selected="selected"</c:if>>소아청소년과의원</option>
					<option value="81" <c:if test="${param.branchId == '81'}">selected="selected"</c:if>>신경정신과의원</option>
					<option value="82" <c:if test="${param.branchId == '82'}">selected="selected"</c:if>>안과의원</option>
					<option value="84" <c:if test="${param.branchId == '84'}">selected="selected"</c:if>>외과의원</option>
					<option value="85" <c:if test="${param.branchId == '85'}">selected="selected"</c:if>>이비인외과의원</option>
					<option value="86" <c:if test="${param.branchId == '86'}">selected="selected"</c:if>>정형외과의원</option>
					<option value="87" <c:if test="${param.branchId == '87'}">selected="selected"</c:if>>종합병원</option>
					<option value="88" <c:if test="${param.branchId == '88'}">selected="selected"</c:if>>치과의원</option>
					<option value="89" <c:if test="${param.branchId == '89'}">selected="selected"</c:if>>피부과의원</option>
					<option value="90" <c:if test="${param.branchId == '90'}">selected="selected"</c:if>>한의원</option>
				</select>
				<label for="search_word2" class="blind">병의원/약국 검색어</label>
				<input type="text" id="search_word2" name="searchTxt" class="search_word2" />
				<input type="image" src="/health/open_content/images/main/btn_search.gif" alt="검색" />
				</fieldset>
			</form>
		</div>
        <ul class="navigator">
            <li>HOME &gt; </li>
			<c:set var="fullPath" value="${fn:split(currMenu.fullPath, '/')}" />
			<c:set var="size" value="${fn:length(fullPath)}" />
			<c:if test="${size > 0}" >
			<c:forEach var="x" begin="0" end="${size-1}">
				<li <c:if test="${x == size-1}">class="current"</c:if>>
					<c:choose>
					<c:when test="${x == size-1}">${fullPath[x]}</c:when>
					<c:otherwise>${fullPath[x]} &gt;</c:otherwise>
					</c:choose>
				</li>
			</c:forEach>
			</c:if>
        </ul>
        <h3><img src="/health/open_content/images/content_title_h3/content_title_h3_${curCategory.categoryId}.gif" alt="${curCategory.name}" /></h3>
		
		<p class="title_deco"></p>
		<div class="body">

		<c:set var="d04menuKey" value="menu_${curD04Category.categoryId}" />
		<c:set var="d05Categories" value="${healthMenuCategoryMap[d04menuKey]}" />
		<c:if test="${fn:length(d05Categories)>0}">
		<div class="tab_type1">
			<ul>
		 	<c:forEach var="x" begin="0" end="${fn:length(d05Categories)-1}">
				<c:set var="clss5" value="${x==depth05 ? 'class=\"current\"' : ''}" />
				<li ${clss5}><a href="${d05Categories[x].fullMenuLink}">${d05Categories[x].name}</a> </li>
			</c:forEach>
			</ul>
		</div>
		</c:if>

        <!-- contents area -->
		<div id="contentArea">
			<jsp:include page="${includePage}" flush="true" />
		</div>
        <!-- contents area -->

		</div>

        <!-- 정보책임자 -->
        <div id="officer_set">
            <h4 class="officer"><img src="/health/open_content/images/common/title_Officer.gif" alt="정보책임자" /></h4>
            <ul class="officer_list">
                <li>
                    <dl>
                        <dt>${currMenu.department}</dt>
                        <dd class="name">${currMenu.userName}</dd>
                    </dl>
                </li>
                <li>
                    <dl>
                        <dt>전화. </dt>
                        <dd>${currMenu.officetelno}</dd>
                    </dl>
                </li>
                <li>
                    <dl>
                        <dt class="novisible">메일</dt>
                        <dd>${currMenu.email}</dd>
                    </dl>
                </li>
                <li class="end">
                    <dl>
                        <dt>최종수정일</dt>
                        <dd><fmt:parseDate value='${fn:substring(currMenu.updateDate,0,10)}' var='udate' pattern='yyyy-mm-dd'/>
								<fmt:formatDate value='${udate}' pattern="yyyy년mm월dd일"/></dd>
                    </dl>
                </li>
                <li class="end2"><a href="#ready" onclick="alert('준비중입니다.');"><img src="/health/open_content/images/common/btn_edit_input.gif" alt="수정요청" /></a></li>
          </ul>
        </div>
		<form name="satisfactionFrm" method="post" onsubmit="return checkSatisfactionForm(this);" action="/health/satisfaction/saveSatisfaction.do">
		<input type="hidden" id="categoryId" name="categoryId" value="${currMenu.categoryId}" />
        <fieldset class="satisfaction">
            <legend>고객 만족도 평가</legend>
            <dl>
                <dt>홈페이지 <strong>내용</strong>이나 <strong>사용자 편의성</strong>에 만족하십니까?</dt>
          <dd>
                    <input type="radio" id="sr_point1" name="status" value="5" />
                    <label for="sr_point1"> 아주만족</label>
                </dd>
                <dd>
                    <input type="radio" id="sr_point2" name="status" value="4" />
                    <label for="sr_point2"> 만족</label>
                </dd>
                <dd>
                    <input type="radio" id="sr_point3" name="status" value="3" />
                    <label for="sr_point3"> 보통</label>
                </dd>
                <dd>
                    <input type="radio" id="sr_point4" name="status" value="2" />
                    <label for="sr_point4"> 불만족</label>
                </dd>
                <dd>
                    <input type="radio" id="sr_point5" name="status" value="1" />
                    <label for="sr_point5"> 매우불만족</label>
                </dd>
            </dl>
			<label for="opinion" class="blind">의견입력</label>
            <input type="text" id="opinion" name="opinion" value="" class="text" />
            <input type="image" src="/health/open_content/images/common/opinion_off.gif" alt="의견남기기" />
        </fieldset>
		</form>
    </div>
    <div id="sub_visual"></div>
    <div id="quick_menu">
    <h3>Quick Menu</h3>
	<ul>
    	<li><a href="http://www.geumcheon.go.kr" target="_blank" title="새창열기"><img src="/health/open_content/images/common/quick_menu_1.gif" width="80" height="11" alt="금천구청 홈페이지" /></a></li>
        <li><a href="http://council.geumcheon.go.kr/" target="_blank" title="새창열기"><img src="/health/open_content/images/common/quick_menu_2.gif" width="80" height="11" alt="구의회" /></a></li>
        <li><a href="http://www.gfmc.co.kr/" target="_blank" title="새창열기"><img src="/health/open_content/images/common/quick_menu_3.gif" width="80" height="11" alt="시설관리공단" /></a></li>
        <li><a href="http://www.gcvc.go.kr" target="_blank" title="새창열기"><img src="/health/open_content/images/common/quick_menu_4.gif" width="80" height="11" alt="자원봉사센터" /></a></li>
        <!-- // 2010.8.4 여성/장애인/아동청소년 삭제 
        <li><a href="#"><img src="/health/open_content/images/common/quick_menu_5.gif" width="80" height="11" alt="여성" /></a></li>
        <li><a href="#"><img src="/health/open_content/images/common/quick_menu_6.gif" width="80" height="11" alt="장애인" /></a></li>
        <li><a href="#"><img src="/health/open_content/images/common/quick_menu_7.gif" width="80" height="11" alt="아동청소년" /></a></li>
        -->
        <li><a href="http://www.blutouch.net " target="_blank" title="새창열기"><img src="/health/open_content/images/common/quick_menu_10.gif" width="80" height="11" alt="정신보건(새창)" /></a></li>
        <li><a href="http://geumcheon.seouldementia.or.kr" target="_blank" title="새창열기"><img src="/health/open_content/images/common/quick_menu_11.gif" width="80" height="11" alt="치매지원센터(새창)" /></a></li>
        <li><a href="http://viva21.geumcheon.go.kr" target="_blank" title="새창열기"><img src="/health/open_content/images/common/quick_menu_8.gif" width="80" height="11" alt="VIVA21(새창)" /></a></li>
        <li class="end"><a href="#ready" onclick="alert('준비중입니다.');"><img src="/health/open_content/images/common/quick_menu_9.gif" width="80" height="11" alt="SMS 신청" /></a></li>
        <li class="top"><a href="#skipNavi"><img src="/health/open_content/images/common/quick_top_btn.gif" width="30" height="15" alt="페이지 처음으로이동" /></a></li>
 	</ul>
    </div>
</div>
<div id="footer">
    <div class="area">
	<!--웹접근성 평가관계로 페이지 경로 표시는 삭제합니다 네모소프트 양종훈 -->
        <ul class="footer_menu">
            <li><a href="http://www.geumcheon.go.kr/main.do?pageKey=10020101"><img src="/health/open_content/images/common/footer_menu_1.gif" width="78" height="13" alt="개인정보보호방침" /></a></li>
            <li><a href="http://www.geumcheon.go.kr/main.do?pageKey=10030101"><img src="/health/open_content/images/common/footer_menu_2.gif" width="48" height="13" alt="저작권정책" /></a></li>
            <li><a href="http://www.geumcheon.go.kr/board.do?communityKey=B0056&amp;pageKey=10040101"><img src="/health/open_content/images/common/footer_menu_3.gif" width="81" height="13" alt="홈페이지 개선의견" /></a></li>
            <li><a href="/health/main/contents.do?categoryId=2567"><img src="/health/open_content/images/common/footer_menu_4.gif" width="60" height="13" alt="찾아오시는 길" /></a></li>
            <li><a href="http://www.geumcheon.go.kr/main.do?pageKey=10080101"><img src="/health/open_content/images/common/footer_menu_5.gif" width="58" height="13" alt="뷰어다운로드" /></a></li>
            <li class="end"><a href="#ready" onclick="alert('준비중입니다.');"><img src="/health/open_content/images/common/footer_menu_6.gif" width="38" height="13" alt="이용안내" /></a></li>
        </ul>
        <address>
        [153-701] 서울특별시 금천구 시흥동 1020   전화. (02)2627-2422, 2426   팩스. (02)2627-2101
        </address>
        <p class="copyright_text"> Copyright 2010 Geumcheon-Gu Public Health Center. All rights reserved.<br />
            본 웹사이트에 게시된 이메일 주소의 자동수집을 거부하며, 이를 위반 시 정보통신망법에 의해 처벌됨을 유념하시기 바랍니다. </p>
        <!--img class="footer_mark" src="/health/open_content/images/common/mark.gif" width="52" height="53" alt="웹접근성 품질마크 획득" /--> <img class="footer_logo" src="/health/open_content/images/common/footer_logo.gif" width="130" height="32" alt="서울특별시 금천구 보건소" />
		<dl class="count_view">
			<dt><img src="/health/open_content/images/common/title_count_today.gif" width="24" height="9" alt="오늘 접속자" /> </dt>
			<dd class="today"><fmt:formatNumber value="${logCount.dayCount}" type="currency" pattern="#,###"/></dd>
			<dt><img src="/health/open_content/images/common/title_count_total.gif" width="24" height="9" alt="전체 접속자" /></dt>
			<dd><fmt:formatNumber value="${logCount.totalCount}" type="currency" pattern="#,###"/></dd>
		</dl>
    </div>
</div>
</body>
</html>
<font color="white">${includePage}</font>
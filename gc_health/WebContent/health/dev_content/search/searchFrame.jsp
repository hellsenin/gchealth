<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="today" class="java.util.Date" />
<%
	java.util.HashMap healthMenuCategoryMap = (java.util.HashMap)application.getAttribute("healthMenuCategoryMap");
	pageContext.setAttribute("healthMenuCategoryMap", healthMenuCategoryMap);

	int depth01 = 0;
	int depth02 = 0;
	int depth03 = 0;
	int depth04 = 0;
	int depth05 = 0;
	pageContext.setAttribute("depth01", depth01);
	pageContext.setAttribute("depth02", depth02);
	pageContext.setAttribute("depth03", depth03);
	pageContext.setAttribute("depth04", depth04);
	pageContext.setAttribute("depth05", depth05);
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>금천구 보건소</title>
	<link href="/health/open_content/system/css/default.css" rel="stylesheet" type="text/css" />
	<link href="/health/open_content/system/css/common.css" rel="stylesheet" type="text/css" />
	<link href="/health/open_content/system/css/green.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_green.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="http://www.geumcheon.go.kr/open_content/system/css/search.css" />
	<script type="text/javascript" src="/health/open_content/system/js/main_ctrl.js"></script>
	<!--[if IE 7]><link rel="stylesheet" type="text/css" href="/health/open_content/system/css/ie67.css" /> <![endif]-->
	<!--[if IE 6]><link rel="stylesheet" type="text/css" href="/health/open_content/system/css/ie67.css" />
				  <link rel="stylesheet" type="text/css" href="/health/open_content/system/css/ie6.css" /> 
	<script type="text/javascript" src="/health/open_content/system/js/DD_belatedPNG_0.0.8a-min.js"></script>
	<script>
	  DD_belatedPNG.fix('#popup_area,#gnb ul li ul li ul li,img');
	</script>
	<![endif]--> 
	<script type="text/javascript">
	//<![CDATA[
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

	function goMore(method)
	{
		var f = document.searchFrm;
		f.method.value = method;
		f.submit();
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
        <li><a href="#mainSearch">통합검색으로 건너뛰기</a></li>
        <li><a href="#quick_menu">우측 퀵메뉴로 건너뛰기</a></li>
    </ul>
  <div id="header" >
		<h1><a href="/health/main/main.do"><img src="/health/open_content/images/common/logo.gif" width="180" height="43" alt="서울특별시 금천구 보건소" /></a></h1>
		<ul id="global">
			<li><a href="#"><img src="/health/open_content/images/main/global/global_home.gif" alt="홈" /></a></li>
		<c:if test="${empty user.webMemId}">
			<li><a href="http://www.geumcheon.go.kr/member.do?method=loginPage&amp;fromLogin=health&amp;pageKey=08010101"><img src="/health/open_content/images/main/global/global_login.gif" alt="로그인" /></a></li>
		</c:if>
		<c:if test="${not empty user.webMemId}">
			<li><a href="/health/member/logout.do"><img src="/health/open_content/images/main/global/global_logout.gif" alt="로그아웃" /></a></li>
		</c:if>
			<li><a href="#"><img src="/health/open_content/images/main/global/global_join.gif" alt="회원가입" /></a></li>
			<li><a href="#"><img src="/health/open_content/images/main/global/global_sitemap.gif" alt="사이트맵" /></a></li>
			<li><a href="#"><img src="/health/open_content/images/main/global/global_guchung.gif" alt="금천구청" /></a></li>
			<li>
				<dl>
					<dt><img src="/health/open_content/images/main/global/font_title.gif" alt="글자크기" /></dt>
					<dd>
						<button type="button" class="btn_font_plus" >확대</button>
					</dd>
					<dd>
						<button type="button" class="btn_font_minus"  >축소</button>
					</dd>
					<dd>
						<button type="button" class="btn_font_reset"  >초기화</button>
					</dd>
				</dl>
			</li>
            <li><a href="#"><img src="/health/open_content/images/common/global/global_lang_1.gif" width="45" height="11" alt="ENGLISH" /></a></li>
            <li><a href="#"><img src="/health/open_content/images/common/global/global_lang_2.gif" width="33" height="11" alt="日本語" /></a></li>
            <li><a href="#"><img src="/health/open_content/images/common/global/global_lang_3.gif" width="25" height="11" alt="中文" /></a></li>
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
    <div id="contents">        
	<form name="searchFrm" method="post" action="/health/search/search.do" onsubmit="return checkSearchForm(this)">
        <div class="main_search" id="mainSearch">
            <fieldset class="main_total_search">
                <legend>통합검색</legend>
                <select id="method" name="method" title="검색구분">
                    <option value="0">통합검색</option>
                    <option value="1" <c:if test="${param.method == '1'}">selected</c:if>>메뉴</option>
                    <option value="2" <c:if test="${param.method == '2'}">selected</c:if>>게시판</option>
                    <option value="3" <c:if test="${param.method == '3'}">selected</c:if>>직원/업무</option>
                </select>
                <input type="text" id="searchTxt" name="searchTxt" value="${param.searchTxt}" class="search_word" title="검색어" />
                <input type="image" src="/health/open_content/images/main/btn_search.gif" alt="검색" />
            </fieldset>
            <fieldset class="gis_search">
                <legend class="iebug"><img src="/health/open_content/images/main/title_search_gs.gif" width="94" height="11" alt="GIS 병의원/약국찾기" /></legend>
                <input type="text" class="search_word2" title="검색어" />
                <input type="image" src="/health/open_content/images/main/btn_search.gif" alt="검색" />
            </fieldset>
        </div>
     </form>
        <ul class="navigator">
        <li>HOME &gt; </li>
        <li class="current">검색 </li>
		</ul>
        
		<div class="body">
        <!-- contents area -->
<!-- 검색 contents 시작 -->
<div id="container">
	<ul id="search_tab">
		<li><a href="#search_tab" onclick="goMore('0');return false;" <c:if test="${param.method == 0}">class="on"</c:if>>통합검색</a></li>
		<li><a href="#search_tab" onclick="goMore('1');return false;" <c:if test="${param.method == 1}">class="on"</c:if>>메뉴검색</a></li>
		<li><a href="#search_tab" onclick="goMore('2');return false;" <c:if test="${param.method == 2}">class="on"</c:if>>게시판</a></li>
		<li><a href="#search_tab" onclick="goMore('3');return false;" <c:if test="${param.method == 3}">class="on"</c:if>>직원/업무</a></li>
	</ul>

	<p id="txt_search1">통합검색은 금천구청 보건소 홈페이지의 메뉴 및 게시판등을 검색한 결과입니다. </p>

	<div id="search_result">
		<p>'<strong>${param.searchTxt}</strong>'에 대한 검색결과 <em>총 ${totCnt} 건</em></p>
	</div>
        
			<jsp:include page="${searchPage}" flush="true" />
</div>
        <!-- contents area -->
		</div>
 
        <!-- 정보책임자 -->
        <div id="officer_set">
            <h4 class="officer"><img src="/health/open_content/images/common/title_Officer.gif" alt="정보책임자" /></h4>
            <ul class="officer_list">
                <li>
                    <dl>
                        <dt></dt>
                        <dd class="name"></dd>
                    </dl>
                </li>
                <li>
                    <dl>
                        <dt>전화. </dt>
                        <dd></dd>
                    </dl>
                </li>
                <li>
                    <dl>
                        <dt class="novisible">메일</dt>
                        <dd></dd>
                    </dl>
                </li>
                <li class="end">
                    <dl>
                        <dt>최종수정일</dt>
                        <dd>2010.07.07</dd>
                    </dl>
                </li>
                <li class="end2"><a href="#ready" onclick="alert('준비중입니다.');"><img src="/health/open_content/images/common/btn_edit_input.gif" alt="수정요청" /></a></li>
          </ul>
        </div>
		<form name="satisfactionFrm" method="post" onsubmit="return checkSatisfactionForm(this);" action="/health/satisfaction/saveSatisfaction.do">
		<input type="hidden" id="categoryId" name="categoryId" value="2474" />
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
            <input type="text" id="opinion" name="opinion" value="" title="의견입력" class="text" />
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
        <ul class="footer_menu">
            <li><a href="http://www.geumcheon.go.kr/main.do?pageKey=10020101"><img src="/health/open_content/images/common/footer_menu_1.gif" width="78" height="13" alt="개인정보보호방침" /></a></li>
            <li><a href="http://www.geumcheon.go.kr/main.do?pageKey=10030101"><img src="/health/open_content/images/common/footer_menu_2.gif" width="48" height="13" alt="저작권정책" /></a></li>
            <li><a href="http://www.geumcheon.go.kr/board.do?communityKey=B0056&amp;pageKey=10040101"><img src="/health/open_content/images/common/footer_menu_3.gif" width="81" height="13" alt="홈페이지 개선의견" /></a></li>
            <li><a href="http://www.geumcheon.go.kr/main.do?pageKey=06040501"><img src="/health/open_content/images/common/footer_menu_4.gif" width="60" height="13" alt="찾아오시는 길" /></a></li>
            <li><a href="http://www.geumcheon.go.kr/main.do?pageKey=10080101"><img src="/health/open_content/images/common/footer_menu_5.gif" width="58" height="13" alt="뷰어다운로드" /></a></li>
            <li class="end"><a href="#ready" onclick="alert('준비중입니다.');"><img src="/health/open_content/images/common/footer_menu_6.gif" width="38" height="13" alt="이용안내" /></a></li>
        </ul>
        <address>
        [153-701] 서울특별시 금천구 시흥동 1020   전화. (02)2627-2422, 2426   팩스. (02)2627-2101
        </address>
        <p class="copyright_text"> Copyright 2010 Geumcheon-Gu Public Health Center. All rights reserved.<br />
            본 웹사이트에 게시된 이메일 주소의 자동수집을 거부하며, 이를 위반 시 정보통신망법에 의해 처벌됨을 유념하시기 바랍니다. </p>
        <!--img class="footer_mark" src="/health/open_content/images/common/mark.gif" width="52" height="53" alt="웹접근성 품질마크 획득" /--> <img class="footer_logo" src="/health/open_content/images/common/footer_logo.gif" width="130" height="32" alt="금천구 보건소" />
		<dl class="count_view">
			<dt><img src="/health/open_content/images/common/title_count_today.gif" width="24" height="9" alt="오늘 접속자" /> </dt>
			<dd class="today">174</dd>
			<dt><img src="/health/open_content/images/common/title_count_total.gif" width="24" height="9" alt="전체 접속자" /></dt>
			<dd>1,778</dd>
		</dl>
    </div>
</div>
</body>
</html>
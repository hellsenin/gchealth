<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8"%>
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
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<title>금천구 보건소</title>
	<link href="/health/open_content/system/css/default.css" rel="stylesheet" type="text/css" />
	<link href="/health/open_content/system/css/common.css" rel="stylesheet" type="text/css" />
	<link href="/health/open_content/system/css/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="/health/open_content/system/js/main_ctrl.js"></script>
	<!--[if IE 7]><link rel="stylesheet" type="text/css" href="/health/open_content/system/css/ie67.css" /> <![endif]-->
	<!--[if IE 6]><link rel="stylesheet" type="text/css" href="/health/open_content/system/css/ie67.css" />
	<link rel="stylesheet" type="text/css" href="/health/open_content/system/css/ie6.css" /> 
	<script type="text/javascript" src="/health/open_content/system/js/DD_belatedPNG_0.0.8a-min.js"></script>
	<script type="text/javascript">
	  DD_belatedPNG.fix('#popup_area,#gnb ul li ul li ul li,img');
	</script>
	<![endif]--> 
	<script type="text/javascript" src="/health/open_content/system/js/jquery-1.4.2.min.js"></script>
	<script type="text/javascript" src="/health/open_content/system/js/ui.js"></script>
	<script type="text/javascript">
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
	</script>
</head>

<body>
<div id="warp">
	<ul id="skipNavi">
		<li><a href="#busi_id">주요서비스로 건너뛰기</a></li>
		<li><a href="#gnb">주메뉴로 건너뛰기</a></li>
		<li><a href="#idx_search">통합검색으로 건너뛰기</a></li>
		<li><a href="#notice_wrap">최근게시물로 건너뛰기</a></li>
		<li><a href="#quick_menu">우측 퀵메뉴로 건너뛰기 </a></li>
	</ul>
	<div id="header" >
		<h1><a href="/health/main/main.do"><img src="/health/open_content/images/common/logo.gif" width="180" height="43" alt="서울특별시 금천구 보건소" /></a></h1>
		<ul id="global">
			<li><a href="/health/main/main.do"><img src="/health/open_content/images/main/global/global_home.gif" alt="홈" /></a></li>
		<c:if test="${empty user.webMemId}">
			<li><a href="http://www.geumcheon.go.kr/member.do?method=loginPage&amp;fromLogin=health&amp;pageKey=08010101"><img src="/health/open_content/images/main/global/global_login.gif" alt="로그인" /></a></li>
		</c:if>
		<c:if test="${not empty user.webMemId}">
			<li><a href="/health/member/logout.do"><img src="/health/open_content/images/main/global/global_logout.gif" alt="로그아웃" /></a></li>
		</c:if>
			<li><a href="http://www.geumcheon.go.kr/member.do?method=agreePage1&amp;pageKey=08020101"><img src="/health/open_content/images/main/global/global_join.gif" alt="회원가입" /></a></li>
			<li><a href="/health/main/sitemap.do?categoryId=3081"><img src="/health/open_content/images/main/global/global_sitemap.gif" alt="사이트맵" /></a></li>
			<li><a href="http://www.geumcheon.go.kr"><img src="/health/open_content/images/main/global/global_guchung.gif" alt="금천구청" /></a></li>
			<li>
				<dl>
					<dt><img src="/health/open_content/images/main/global/font_title.gif" alt="글자크기" /></dt>
					<dd>
						<button type="button" class="btn_font_plus" onclick="alert('준비중입니다.');" onkeypress="this.onclick();">글자 크기 확대</button>
					</dd>
					<dd>
						<button type="button" class="btn_font_minus" onclick="alert('준비중입니다.');" onkeypress="this.onclick();">글자 크기 축소</button>
					</dd>
					<dd>
						<button type="button" class="btn_font_reset" onclick="alert('준비중입니다.');" onkeypress="this.onclick();">글자 크기 초기화</button>
					</dd>
				</dl>
			</li>
            <li><a href="/english/main/main.do"><img src="/health/open_content/images/common/global/global_lang_1.gif" width="45" height="11" alt="ENGLISH(영문 홈페이지)" /></a></li>
            <li><a href="/japanese/main/main.do"><img src="/health/open_content/images/common/global/global_lang_2.gif" width="33" height="11" alt="日本語(일본어 홈페이지)" /></a></li>
            <li><a href="/china/main/main.do"><img src="/health/open_content/images/common/global/global_lang_3.gif" width="25" height="11" alt="中文(중국어 홈페이지)" /></a></li>
			<li><a href="/btn/main/main.do"><img src="/health/open_content/images/common/global/global_lang_4.gif" width="46" height="11" alt="vietnam(베트남어 홈페이지)" /></a></li>
		</ul>
		<div id="gnb">
			<ul>
			<c:set var="curCategory" value="" />
			<c:set var="topCategories" value="${healthMenuCategoryMap['menu_0']}" />
			<c:if test="${fn:length(topCategories)>0}">
		 		<c:forEach var="x" begin="0" end="3">
					<c:choose>
					<c:when test="${x == 0}">
					<c:set var="depth01Color" value="green" />
					</c:when>
					<c:when test="${x == 1}">
					<c:set var="depth01Color" value="perple" />
					</c:when>
					<c:when test="${x == 2}">
					<c:set var="depth01Color" value="blue" />
					</c:when>
					<c:when test="${x == 3}">
					<c:set var="depth01Color" value="orange" />
					</c:when>
					</c:choose>
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
	<div id="maincontent">
		<div id="main_top">
			<div class="left_con">
				<div class="container_left_top">
					<h2><img src="/health/open_content/images/main/title_time.gif" alt="근무시간안내" /></h2>
						<ul class="text_titme">
							<li><img src="/health/open_content/images/main/text_titme01.gif" alt="평일 : 09~18시" /></li>
							<li><img src="/health/open_content/images/main/text_titme02.gif" alt="토요일: 직장 임산부 진료 (예약제) 매월2,4주" /></li>
						</ul>
				</div>
				<div class="container_left_top_ares">
					<p class="deco_text2"><img src="/health/open_content/images/main/text_infor.gif" alt="지역주민의 건/강/증/진을 위해항상 노력하겠습니다." /></p>
					<ul class="btn_ares">
						<li><a href="/health/main/contents.do?categoryId=2576"><img src="/health/open_content/images/main/btn_infor.gif" alt="청사안내" /></a></li>
						<li><a href="/health/main/contents.do?categoryId=2567"><img src="/health/open_content/images/main/btn_map.gif" alt="오시는 길" /></a></li>
					</ul>
				</div>
				<ul class="clear"> 
					<li><a href="http://geumcheon.seouldementia.or.kr" target="_blank" title="새창열림"><img src="/health/open_content/images/main/btn_left_quick_3.gif" alt="치매지원센터(새창)" /></a></li>
					<li><a href="http://www.hope-gcmhc.com/" target="_blank" title="새창열림"><img src="/health/open_content/images/main/btn_left_quick_4.gif" alt="정신보건센터(새창)" /></a></li>
				</ul>
			</div>
			<div id="popupzone" class="right_con">
				<div id="popuplist">
					<ul>
					<c:forEach items="${portalAlertList}" var="alertItem" varStatus="status">
						<li><a href="${alertItem.alert_url}" <c:if test="${alertItem.popup == 'Y'}"> target="_blank" title="새창열림" </c:if>><img src="/health/open_content/images/alert/${alertItem.img_nm}" alt="${alertItem.alert_nm}" id="pop_${status.count}" /></a></li>
					</c:forEach>
					</ul>
				</div>
				<div id="zonePannel">
					<ol id="bannerPaging">
					<c:forEach var="x" begin="1" end="${fn:length(portalAlertList)}">  
						<li><a href="#pop_${x}"><img src="/health/open_content/images/main/btn_popup_number_${x}_off.gif" alt="${x}번째팝업보기" /></a></li>
					</c:forEach>
					</ol>
					<ul id="controll">
						<li><a class="start" href="#start"><img src="/health/open_content/images/main/controll_play.gif" alt="알림판 재생" id="start" /></a></li>
						<li><a class="stop" href="#stop"><img src="/health/open_content/images/main/controll_stop.gif" alt="알림판 정지" id="stop" /></a></li>
					</ul>
				</div>
			</div>
		</div>

		<div id="main_center">
			<div class="main_center_search">
			<h2 class="blind" id="idx_search">통합검색영역</h2>
				<form name="searchFrm" method="post" action="/health/search/search.do" onsubmit="return checkSearchForm(this);" class="main_total_search">
					<fieldset>
						<legend>통합검색</legend>
						<label for="method">통합검색분류 선택</label>
						<select id="method" name="method">
							<option value="0">통합검색</option>
							<option value="1" <c:if test="${param.method == '1'}">selected="selected"</c:if>>메뉴</option>
							<option value="2" <c:if test="${param.method == '2'}">selected="selected"</c:if>>게시판</option>
							<option value="3" <c:if test="${param.method == '3'}">selected="selected"</c:if>>직원/업무</option>
						</select>
						<label for="searchTxt">통합검색어 입력</label>
						<input type="text" id="searchTxt" name="searchTxt" class="search_word" />
						<input type="image" src="/health/open_content/images/main/btn_search.gif" alt="검색" />
					</fieldset>
				</form>
				<div class="search_link">
						<h2>인기검색어 : </h2>
							<ul class="text_font">
								<li>보건,</li>
								<li>보건소,</li>
								<li>민원,</li>
								<li>건강검진</li>
							</ul>
				</div>
				<form class="main_gis_search" name="searchFrm2" action="/health/wcmboard/searchWcmboardList.do" onsubmit="return checkSearchForm2(this);">
					<input type="hidden" id="communityId" name="communityId" value="B0048" />
					<input type="hidden" id="searchType" name="searchType" value="3" />
					<fieldset>
						<label for="branchId">병의원/약국분류 선택</label>
						<select id="branchId" name="branchId">
							<option value="">GIS 병의원/약국찾기</option>
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
						<label for="search_word2">병의원/약국검색어 입력</label>
						<input type="text" id="search_word2" name="searchTxt" class="search_word2" />
						<input type="image" src="/health/open_content/images/main/btn_search.gif" alt="검색" />
						<!-- input type="image" src="/health/open_content/images/main/btn_more0906.gif" alt="더보기" / -->
						<!-- a href="" ><img src="/health/open_content/images/main/btn_more0906.gif" alt="더보기" /></a -->
					</fieldset>
				</form>
			</div>
		</div>

		<div id="main_bottom">
			<div class="notice">
				<div id="notice_wrap" class="t01">
					<h2 class="text-indent">공지사항</h2>

						<div id="tab_noticewapper01">
							<h3 class="title"><a href="#tab_notice_01"><img src="/health/open_content/images/main/tab_notice_01_on.gif" alt="새소식" /></a></h3>
							<ul id="tab_notice_01">
								<c:forEach var="result" items="${resultList}" varStatus="status">
									<li>
										<a href="/health/bbs/selectBoardArticle.do?bbsId=${result.bbsId}&amp;nttId=${result.nttId}&amp;categoryId=2568">
										<span class="text">
											<c:choose>
												<c:when test="${fn:length(result.nttSj) <20}" >
													<c:out value="${result.nttSj}" />
												</c:when>
												<c:otherwise>
													<c:out value="${fn:substring(result.nttSj,0,20)}" />...
												</c:otherwise>
											</c:choose>
										</span>	
										 
										<span class="date"><c:out value="${result.frstRegisterPnttm}"/></span>
										</a>
									</li>
								</c:forEach>
								<c:if test="${empty resultList}">
									<li>
										등록된 글이 없습니다.
									</li>
								</c:if>
								<li class="more">
									<a href="/health/bbs/selectBoardList.do?bbsId=BBSMSTR_000000001151&amp;categoryId=2568"><img src="/health/open_content/images/main/btn_more.gif" width="27" height="5" alt="새소식 더보기" /></a>
								</li>
							</ul>								
						</div>

						<div id="tab_noticewapper02">
							<h3 class="title"><a href="#tab_notice_02"><img src="/health/open_content/images/main/tab_notice_03_off.gif" alt="보건소식지" /></a></h3>
							<ul id="tab_notice_02">
									<c:forEach var="result2" items="${resultList2}" varStatus="status">
									<li>
										<a href="/health/bbs/selectBoardArticle.do?bbsId=${result2.bbsId}&amp;nttId=${result2.nttId}&amp;categoryId=2569">
										<span class="text">
											<c:choose>
												<c:when test="${fn:length(result2.nttSj) <20}" >
													<c:out value="${result2.nttSj}" />
												</c:when>
												<c:otherwise>
													<c:out value="${fn:substring(result2.nttSj,0,20)}" />...
												</c:otherwise>
											</c:choose>
										</span>	
										
										<span class="date"><c:out value="${result2.frstRegisterPnttm}"/></span>
										</a>
									</li>
								</c:forEach>
								<c:if test="${empty resultList2}">
									<li>
										등록된 글이 없습니다.
									</li>
								</c:if>
								<li class="more">
									<a href="/health/bbs/selectBoardList.do?bbsId=BBSMSTR_000000001152&amp;categoryId=2569"><img src="/health/open_content/images/main/btn_more.gif" width="27" height="5" alt="보건소식지 더보기" /></a>
								</li>
							</ul>
						</div>

						<div id="tab_noticewapper03">
							<h3 class="title"><a href="#tab_notice_03"><img src="/health/open_content/images/main/tab_notice_04_off.gif" alt="의약게시판" /></a></h3>
							<ul id="tab_notice_03">
								<c:forEach var="result3" items="${resultList3}" varStatus="status">
									<li>
										<a href="/health/bbs/selectBoardArticle.do?bbsId=${result3.bbsId}&amp;nttId=${result3.nttId}&amp;categoryId=2584">
										<span class="text">
											<c:choose>
												<c:when test="${fn:length(result3.nttSj) <20}" >
													<c:out value="${result3.nttSj}" />
												</c:when>
												<c:otherwise>
													<c:out value="${fn:substring(result3.nttSj,0,20)}" />...
												</c:otherwise>
											</c:choose>
										</span>	
										
										<span class="date"><c:out value="${result3.frstRegisterPnttm}"/></span>
										</a>
									</li>
								</c:forEach>
								<c:if test="${empty resultList3}">
									<li>
										등록된 글이 없습니다.
									</li>
								</c:if>
								<li class="more">
									<a href="/health/bbs/selectBoardList.do?categoryId=2584&amp;bbsId=BBSMSTR_000000001148"><img src="/health/open_content/images/main/btn_more.gif" width="27" height="5" alt="의약게시판 더보기" /></a>
								</li>
							</ul>
						</div>

						<div id="tab_noticewapper04">
							<h3 class="title"><a href="#tab_notice_04"><img src="/health/open_content/images/main/tab_notice_05_off.gif" alt="부적합 식품" /></a></h3>
							<ul id="tab_notice_04">
								<c:forEach var="result4" items="${resultList4}" varStatus="status">
									<li>
										<a href="/health/bbs/selectBoardArticle.do?bbsId=${result4.bbsId}&amp;nttId=${result4.nttId}&amp;categoryId=2748">
										<span class="text">
											<c:choose>
												<c:when test="${fn:length(result4.nttSj) <20}" >
													<c:out value="${result4.nttSj}" />
												</c:when>
												<c:otherwise>
													<c:out value="${fn:substring(result4.nttSj,0,20)}" />...
												</c:otherwise>
											</c:choose>
										</span>	
										
										<span class="date"><c:out value="${result4.frstRegisterPnttm}"/></span>
										</a>
									</li>
								</c:forEach>	
								<c:if test="${empty resultList4}">
									<li>
										등록된 글이 없습니다.
									</li>
								</c:if>
							<li class="more">
									<a href="/health/bbs/selectBoardList.do?bbsId=BBSMSTR_000000001163&amp;categoryId=2748"><img src="/health/open_content/images/main/btn_more.gif" width="27" height="5" alt="부적합식품 더보기" /></a>
								</li>
							</ul>
						</div>

						<div id="tab_noticewapper05">
							<h3 class="title"><a href="#tab_notice_05" ><img src="/health/open_content/images/main/tab_notice_02_off.gif" alt="고시공고" /></a></h3>
							<ul id="tab_notice_05">
									<c:forEach var="x" begin="0" end="${fn:length(resultList5)-6}">
									<li>
										<a href="/health/wcmboard/selectWcmboard.do?communityId=B0037&amp;categoryId=2571&amp;boardId=${resultList5[x].boardId}">
										<span class="text">
											<c:choose>
												<c:when test="${fn:length(resultList5[x].title) <20}" >
													<c:out value="${resultList5[x].title}" />
												</c:when>
												<c:otherwise>
													<c:out value="${fn:substring(resultList5[x].title,0,20)}" />...
												</c:otherwise>
											</c:choose>
										</span>	
										
										<span class="date">
											<c:out value="${fn:substring(resultList5[x].createDate,0,4)}" />-<c:out value="${fn:substring(resultList5[x].createDate,4,6)}" />-<c:out value="${fn:substring(resultList5[x].createDate,6,8)}" />
										</span>
										</a>
									</li>
								</c:forEach>
								<c:if test="${empty resultList5}">
									<li>
										등록된 글이 없습니다.
									</li>
								</c:if>
								<li class="more">
									<a href="/health/wcmboard/selectWcmboardList.do?communityId=B0037&amp;categoryId=2571"><img src="/health/open_content/images/main/btn_more.gif" width="27" height="5" alt="고시공고 더보기" /></a>
								</li>
							</ul>
						</div>
				</div>
				<div class="calendar_link">
					<div id="calendar_area">
						<h2><img src="/health/open_content/images/main/calender_h2.gif" alt="캘린더" /></h2>
						<div class="cal_eve">
							<h3 class="title"><a href="#edu_id"><img src="/health/open_content/images/main/title_date_1.gif" alt="교육" /></a></h3>
							${calendarStr}
							<p class="controll">
								<input type="button" value="이전달 보기" class="btn_calendar_pre" />
								<span class="now_date"><fmt:formatDate value='${today}' pattern="yyyy년MM월"/>	</span>
								<input type="button" value="다음달 보기" class="btn_calendar_nex" />
							</p>
						</div>
						<div class="cal_edu">
							<h3 class="title"><a href="#eve_id"><img src="/health/open_content/images/main/title_date_2.gif" alt="행사" /></a></h3>
							${evtCalendarStr}
							<p class="controll">
								<input type="button" value="이전달 보기" class="btn_calendar_pre" />
								<span class="now_date"><fmt:formatDate value='${today}' pattern="yyyy년MM월"/></span>
								<input type="button" value="다음달 보기" class="btn_calendar_nex" />
							</p>
						</div>
					</div>
					<ul class="cont_link">
						<li><a href="/health/freecheck/loginPage.do?categoryId=2589"><img src="/health/open_content/images/main/main_link01.gif" alt="의약업소 자율점검" /></a></li>
						<li><a href="/health/freecheck/loginPage.do?categoryId=2583"><img src="/health/open_content/images/main/main_link02.gif" alt="약국간의약품 나눔센터" /></a></li>
					</ul>
				</div>
			</div>
		
			<div class="business">
				<div class="busi_cont">
					<h2 class="h2_float"><img src="/health/open_content/images/main/main_text_h2.gif" alt="주요사업안내" /></h2>
					<ul class="busi_list">
						<li><a href="/health/main/contents.do?categoryId=2464"><img src="/health/open_content/images/main/main_text_01.gif" alt="건강증진" /></a></li>
						<li><a href="/health/main/contents.do?categoryId=2626"><img src="/health/open_content/images/main/main_text_02.gif" alt="모자보건" /></a></li>
						<li><a href="/health/main/contents.do?categoryId=2627"><img src="/health/open_content/images/main/main_text_03.gif" alt="출산장려" /></a></li>
						<li><a href="/health/main/contents.do?categoryId=2635"><img src="/health/open_content/images/main/main_text_04.gif" alt="치매관리" /></a></li>
						<li><a href="/health/main/contents.do?categoryId=2640"><img src="/health/open_content/images/main/main_text_05.gif" alt="정신보건" /></a></li>
						<li><a href="/health/main/contents.do?categoryId=2645"><img src="/health/open_content/images/main/main_text_06.gif" alt="방문보건" /></a></li>
						<li><a href="/health/main/contents.do?categoryId=2648"><img src="/health/open_content/images/main/main_text_07.gif" alt="만성질환관리" /></a></li>
						<li><a href="/health/main/contents.do?categoryId=2651"><img src="/health/open_content/images/main/main_text_08.gif" alt="방역관리" /></a></li>
						<li><a href="/health/main/contents.do?categoryId=2657"><img src="/health/open_content/images/main/main_text_09.gif" alt="의료비지원" /></a></li>
						<li><a href="/health/main/contents.do?categoryId=2617"><img src="/health/open_content/images/main/main_text_10.gif" alt="구강보건" /></a></li>
						<li><a href="/health/main/contents.do?categoryId=2650"><img src="/health/open_content/images/main/main_text_11.gif" alt="대사증후군" /></a></li>
                        <li><a href="/health/poll/view.do?master_cd=1&amp;categoryId=2558"><img src="/health/open_content/images/main/main_text_12.gif" alt="보건소 이용만족도 조사" /></a></li>
					</ul>
				</div>

				<div class="busi_tab" id="busi_id">
					<h2 class="text-indent">주요서비스</h2>
				<c:if test="${fn:length(customMainMenuList) > 0}">
				<c:forEach var="x" begin="0" end="${fn:length(customMainMenuList)-1}">
					<c:set var="key" value="cstmId_${customMainMenuList[x].cstmId}" />
					<c:set var="subMenuList" value="${subMenuMap[key]}" />
					<c:if test="${x == 0}"><c:set var="onOff" value="on" /></c:if>
					<c:if test="${x > 0}"><c:set var="onOff" value="off" /></c:if>
					<div id="busi_tabwrapper0${x+1}">
						<h3 class="title"><a href="#busi_tab_cont0${x+1}"><img src="/health/open_content/images/main/tab_cont_0${x+1}_${onOff}.gif" alt="${customMainMenuList[x].categoryNm}" /></a></h3>
						<ul id="busi_tab_cont0${x+1}">
						<c:if test="${fn:length(subMenuList) > 0}">
						<c:forEach var="y" begin="0" end="${fn:length(subMenuList)-1}">
							<li <c:if test="${y > 6}">class="back-none"</c:if>><a href="${subMenuList[y].fullMenuLink}">${subMenuList[y].cstmMenuNm}</a></li>
						</c:forEach>
						</c:if>
						</ul>
					</div>
				</c:forEach>
				</c:if>
				</div>

				<div id="main_qm">
					<ul>
						<li><a href="#ready" onclick="alert('2010년 12월 서비스 예정입니다.');"><img src="/health/open_content/images/main/cqm01_off.gif" width="66" height="59" alt="인터넷민원발급" /></a></li>
						<li><a href="http://bogunso.geumcheon.go.kr/health/wcmboard/selectWcmboardList.do?communityId=B0068&healthPosition=1&categoryId=2419"><img src="/health/open_content/images/main/cqm02_off.gif" width="66" height="59" alt="민원서식다운로드" /></a></li>
						<li><a href="http://bogunso.geumcheon.go.kr/health/main/contents.do?categoryId=2457"><img src="/health/open_content/images/main/cqm03_off.gif" width="66" height="59" alt="진료검진예약" /></a></li>
						<li><a href="http://bogunso.geumcheon.go.kr/health/main/contents.do?categoryId=2572"><img src="/health/open_content/images/main/cqm04_off.gif" width="66" height="59" alt="식약청정보" /></a></li>
						<li><a href="http://cfscr.kfda.go.kr/user/complain/customer_1.jsp" target="blank" title="새창열림"><img src="/health/open_content/images/main/cqm05_off.gif" width="66" height="59" alt="식품안전소비자신고(새창)" /></a></li>
						<li><a href="http://bogunso.geumcheon.go.kr/health/medicalTeam/selectMedicalTeamList.do?categoryId=2417"><img src="/health/open_content/images/main/cqm06_off.gif" width="66" height="59" alt="건강상담" /></a></li>
						<li class="nopadding"><a href="http://bogunso.geumcheon.go.kr/health/main/contents.do?categoryId=3070"><img src="/health/open_content/images/main/cqm07_off.gif" width="66" height="59" alt="맞춤보건" /></a></li>
					</ul>
				</div>
		<!-- middlecon e-->
		<div id="banner_bot" class="ad_area">
			<h2>배너존</h2>
			<div class="ad_zone">
				<div id="RollingTest2" class="visible_area">
					<c:forEach items="${bannerList}" var="bannerArr1">
						<ul class="ad_list">
							<c:forEach items="${bannerArr1}" var="bannerArr2">
							<li><a href="${bannerArr2.bnr_url}" target="_blank" title="새창열림"><img src="/health/open_content/images/banner/${bannerArr2.bnr_img_nm}" width="105px" height="31px" alt="${bannerArr2.bnr_nm}(새창열림)" /></a></li>
							</c:forEach>
						</ul>
					</c:forEach>
				</div>
			</div>
			<div class="btn_set">
				<ul id="lbtn" class="controll">
					<li><a href="#banner_prev" onclick="RollingTest2.prev(); return false;"><img src="/health/open_content/images/main/btn_prev01.gif" alt="이전배너" id="banner_prev" /></a></li>
					<li><a href="#banner_play" onclick="RollingTest2.play(); return false;"><img src="/health/open_content/images/main/btn_play01.gif" alt="배너재생" id="banner_play" /></a></li>
					<li><a href="#banner_stop" onclick="RollingTest2.stop(); return false;"><img src="/health/open_content/images/main/btn_stop01.gif" alt="배너정지" id="banner_stop" /></a></li>
					<li><a href="#banner_next" onclick="RollingTest2.next(); return false;"><img src="/health/open_content/images/main/btn_next01.gif" alt="다음배너" id="banner_next" /></a></li>
				</ul>
				<!--<p><a href="#"><img src="/health/open_content/images/main/btn_more.gif" alt="모두보기" /></a></p>-->
			</div>
			<script type="text/javascript"> 
			<!--
				var RollingTest2=new _rotatecontents('RollingTest2');
				RollingTest2.rotatemethod='vertical';
				RollingTest2.initialize();
			-->
			</script>
		</div>

	</div>
	</div>

	</div>
	<div id="quick_menu">
		<h2 class="hidden">Quick Menu</h2>
		<ul>
			<li><a href="http://www.geumcheon.go.kr" target="_blank" title="새창열기"><img src="/health/open_content/images/common/quick_menu_1.gif" width="80" height="11" alt="금천구청 홈페이지(새창)" /></a></li>
			<li><a href="http://council.geumcheon.go.kr/" target="_blank" title="새창열기"><img src="/health/open_content/images/common/quick_menu_2.gif" width="80" height="11" alt="구의회(새창)" /></a></li>
			<li><a href="http://www.gfmc.co.kr/" target="_blank" title="새창열기"><img src="/health/open_content/images/common/quick_menu_3.gif" width="80" height="11" alt="시설관리공단(새창)" /></a></li>
			<li><a href="http://www.gcvc.go.kr" target="_blank" title="새창열기"><img src="/health/open_content/images/common/quick_menu_4.gif" width="80" height="11" alt="자원봉사센터(새창)" /></a></li>
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
		<div id="relatesite">
			<script type="text/javascript">
			<!--
				function siteCheck(){
					if(goSite.site_go.value=="" || goSite.site_go.value==null){
						alert(" 이동 할 사이트를 선택해주세요.");
						return false;
					} else {
						return true;
					}
				}
			//-->
			</script>
			<form id="goSite" name="goSite" method="post" action="/health/open_content/main/gogo.jsp" onsubmit="return siteCheck();" target="_blank">
				<label for="site_go" class="blind">관련사이트 선택</label>
				<select name="site_go" id="site_go">					
						<option value="">관련사이트 가기</option>
					<optgroup label="관련사이트">
						<option value="http://www.mohw.go.kr/index.jsp">보건복지부</option>	
						<option value="http://healthinfo.seoul.go.kr">서울시건강도시</option>
						<option value="http://healthguide.kihasa.re.kr/">건강길라잡이</option>
						<option value="http://www.nih.go.kr">국립보건원</option>
						<option value="http://dis.cdc.go.kr">전염병정보망</option>
						<option value="http://www.who.int">서울시 건강정보</option>
						<option value="http://www.khidi.or.kr/">한국보건산업진흥원</option>
						<option value="http://www.nhic.or.kr/">국민건강보험공단</option>
						<option value="http://www.nemc.go.kr/sub02/sub02_03.htm">보건복지부 중앙응급의료센터</option>
						<option value="http://fmtp.cdc.go.kr">FMTP</option>
						<option value="http://www.hira.or.kr">건강보험심사평가원</option>
						<option value="http://childhosp.seoul.go.kr">어린이병원</option>
						<option value="http://sbhosp.seoul.go.kr">서북병원</option>
						<option value="http://ephosp.seoul.go.kr">은평병원</option>
						<option value="http://www.seoulmc.or.kr">서울의료원</option>
						<option value="http://www.brmh.co.kr">보라매병원</option>
						<option value="http://dbhosp.go.kr">동부병원</option>
						<option value="http://www.bbhosp.go.kr">북부노인병원</option>
						<option value="http://www.sdh.go.kr">장애인치과의원</option>
						<option value="http://www.yonginmh.co.kr">용인정신병원</option>
						<option value="http://www.baekammh.or.kr">백암정신병원</option>
						<option value="http://www.creh.or.kr">축령정신병원</option>
						<option value="http://www.kymhosp.com">고양정신병원</option>
						<option value="http://www.blutouch.net">서울시광역정신보건센터</option>
					</optgroup>
					<optgroup label="서울시 보건소">
						<option value="http://health.jongno.go.kr">종로구보건소</option>
						<option value="http://health.junggu.seoul.kr">중구보건소</option>
						<option value="http://health.yongsan.go.kr">용산구보건소</option>
						<option value="http://e-bogunso.seoul.kr">성동구보건소</option>
						<option value="http://www.gwangjin.go.kr/gj_health">광진구보건소</option>
						<option value="http://ddm.go.kr/bogun/">동대문구보건소</option>
						<option value="http://www.healthcare.go.kr">중랑구보건소</option>
						<option value="http://bogunso.seongbuk.go.kr">성북구보건소</option>
						<option value="http://www.ehealth.or.kr">강북구보건소</option>
						<option value="http://health.dobong.go.kr">도봉구보건소</option>
						<option value="http://health.nowon.seoul.kr">노원구보건소</option>
						<option value="http://www.ehealth.seoul.kr">은평구보건소</option>
						<option value="http://health.seodaemun.seoul.kr">서대문구보건소</option>
						<option value="http://health.mapo.seoul.kr">마포구보건소</option>
						<option value="http://www.ydp.go.kr/health/main.do">영등포구보건소</option>
						<option value="http://www.yangcheon.go.kr/Health/">양천구보건소</option>
						<option value="http://www.gangseo.seoul.kr/portal/health/v2/index.jsp">강서구보건소</option>
						<option value="http://www2.guro.go.kr/site/gh/index.jsp">구로구보건소</option>							
						<option value="http://healthcare.dongjak.go.kr">동작구보건소</option>
						<option value="http://www.gwanak.go.kr/health/main.html">관악구보건소</option>
						<option value="http://health.seocho.go.kr">서초구보건소</option>
						<option value="http://healthpia.gangnam.go.kr">강남구보건소</option>
						<option value="http://ehealth.songpa.go.kr">송파구보건소</option>
						<option value="http://www.gangdong.go.kr/pub/hlt/">강동구보건소</option>
					</optgroup>
				</select>
				<input type="image" src="/health/open_content/images/main/footer_btn_go.gif" alt="이동(새창)" />
			</form>
		</div>
		<address>
		[153-701] 서울특별시 금천구 시흥동 1020   전화. (02)2627-2422, 2426   팩스. (02)2627-2101
		</address>
		<p class="copyright_text"> Copyright 2010 Geumcheon-Gu Public Health Center. All rights reserved.<br />
			본 웹사이트에 게시된 이메일 주소의 자동수집을 거부하며, 이를 위반 시 정보통신망법에 의해 처벌됨을 유념하시기 바랍니다. </p>
		<img class="footer_logo" src="/health/open_content/images/common/footer_logo.gif" width="130" height="32" alt="서울특별시 금천구 보건소" />
		<dl class="count_view">
			<dt><img src="/health/open_content/images/common/title_count_today.gif" width="24" height="9" alt="오늘 접속자" /> </dt>
			<dd class="today"><fmt:formatNumber value="${logCount.dayCount}" type="currency" pattern="#,###"/></dd>
			<dt><img src="/health/open_content/images/common/title_count_total.gif" width="24" height="9" alt="전체 접속자" /></dt>
			<dd><fmt:formatNumber value="${logCount.totalCount}" type="currency" pattern="#,###"/></dd>
		</dl>
	</div>
</div>
<script type="text/javascript">
/*<![CDATA[*/
	var tabmenu1 = new tabnavi("#notice_wrap");
	tabmenu1.run();
	var tabmenu2 = new tabnavi("#busi_id");
	tabmenu2.run();
	var tabmenu3 = new tabnavi("#calendar_area");
	tabmenu3.run();

	var cqm = new imgChanger("#main_qm");
	cqm.init();	

	var pzone = new popupzoneClass("#popupzone");
	pzone.pause = 4000;
	pzone.speed = 1000;
	pzone.clickspeed = 400;
	pzone.start();
/*]]>*/
</script>
</body>
</html>
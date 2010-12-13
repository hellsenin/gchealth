<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	java.util.HashMap healthMenuCategoryMap = (java.util.HashMap)application.getAttribute("healthMenuCategoryMap");
	pageContext.setAttribute("healthMenuCategoryMap", healthMenuCategoryMap);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>금천시 보건소</title>
<link href="/health/open_content/system/css/default.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/common.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/main.css" rel="stylesheet" type="text/css" />
<!--[if IE 7]><link rel="stylesheet" type="text/css" href="/usr/kr//health/open_content/system/css/ie67.css" /> <![endif]-->
<!--[if IE 6]><link rel="stylesheet" type="text/css" href="/usr/kr//health/open_content/system/css/ie67.css" />
              <link rel="stylesheet" type="text/css" href="/health/open_content/system/css/ie6.css" /> 
<script type="text/javascript" src="js/DD_belatedPNG_0.0.8a-min.js"></script>
<script>
  DD_belatedPNG.fix('#popup_area,#gnb ul li ul li ul li,img');
</script>
<![endif]--> 

</head>

<body>
<div id="warp">
    <ul id="skipnavi">
        <li><a href="#main_search">통합검색</a></li>
        <li><a href="#main_time">근무시간안내</a></li>
        <li><a href="#main_cal">캘린더</a></li>
        <li><a href="#notice_warp">최근게시물</a></li>
        <li><a href="#quickmenu">빠른서비스</a></li>
        <li><a href="#main_poll">설문조사</a></li>
    </ul>
    <div id="header" >
        <h1><a href="/health/main/main.do"><img src="/health/open_content/images/common/logo.gif" width="180" height="43" alt="서울특별시 금천구 보건소" /></a></h1>
        <ul id="global">
            <li><a href="#"><img src="/health/open_content/images/main/global/global_home.gif" width="35" height="11" alt="홈" /></a></li>
            <li><a href="#"><img src="/health/open_content/images/main/global/global_login.gif" width="37" height="11" alt="로그인" /></a></li>
            <li><a href="#"><img src="/health/open_content/images/main/global/global_join.gif" width="44" height="11" alt="회원가입" /></a></li>
            <li><a href="#"><img src="/health/open_content/images/main/global/global_sitemap.gif" width="46" height="11" alt="사이트맵" /></a></li>
            <li><a href="#"><img src="/health/open_content/images/main/global/global_guchung.gif" width="41" height="11" alt="금천구청" /></a></li>
            <li>
                <dl>
                    <dt><img src="/health/open_content/images/main/global/font_title.gif" width="33" height="11" alt="글자크기" /></dt>
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
            <li><a href="#"><img src="/health/open_content/images/main/global/global_lang_1.gif" width="45" height="11" alt="ENGLISH" /></a></li>
            <li><a href="#"><img src="/health/open_content/images/main/global/global_lang_2.gif" width="33" height="11" alt="日本語" /></a></li>
            <li><a href="#"><img src="/health/open_content/images/main/global/global_lang_3.gif" width="25" height="11" alt="中文" /></a></li>
            <li><a href="#"><img src="/health/open_content/images/main/global/global_lang_4.gif" width="40" height="11" alt="베트남어" /></a></li>
            <li><a href="#"><img src="/health/open_content/images/main/global/global_lang_5.gif" width="47" height="11" alt="캄보디아어" /></a></li>
        </ul>
        <div id="gnb">
            <ul>
			<c:set var="topCategories" value="${healthMenuCategoryMap['menu_0']}" />
			<c:if test="${fn:length(topCategories)>0}">
		 		<c:forEach var="x" begin="0" end="3">
                <li><a href="${topCategories[x].fullMenuLink}"><img src="/health/open_content/images/menu/gnb_tab_${x+1}_off.gif" alt="${topCategories[x].name}" width="125" height="15" /></a>
	 				<c:set var="imgIdx" value="${x+1}" />
	 				<c:if test="${imgIdx < 10 }" ><c:set var="imgIdx" value="0${x+1}" /></c:if>
	 				<c:set var="clss1" value="${x == depth01 ? 'class=\"current\"' : ''}"/>
                    <ul ${clss1} id="gnb_${imgIdx}">
					<c:set var="d02MenuKey" value="menu_${topCategories[x].categoryId}" />
					<c:set var="d02Categories" value="${healthMenuCategoryMap[d02MenuKey]}" />
					<c:if test="${fn:length(d02Categories)>0}">
			 			<c:forEach var="y" begin="0" end="${fn:length(d02Categories)-1}">
			 				<c:if test="${x == depth01 && y == depth02}"><c:set var="curD02Category" value="${d02Categories[y]}" /></c:if>
	 						<c:set var="clss2" value="${x == depth01 && y == depth02 ? 'class=\"current\"' : ''}"/>
                        <li><a href="${d02Categories[y].fullMenuLink}"><img src="/health/open_content/images/menu/1depth_${depth01Color}_${y+1}_off.gif" width="105" height="25" alt="${d02Categories[y].name}" /></a>
                            <ul id="smenu_${x+1}_${y+1}" ${clss2}>
							<c:set var="d03MenuKey" value="menu_${d02Categories[y].categoryId}" />
							<c:set var="d03Categories" value="${healthMenuCategoryMap[d03MenuKey]}" />
							<c:choose>
							<c:when test="${fn:length(d03Categories)>0}">
		 						<c:forEach var="z" begin="0" end="${fn:length(d03Categories)-1}">
			 						<c:if test="${x == depth01 && y == depth02 && z == depth03}"><c:set var="curD03Category" value="${d03Categories[z]}" /></c:if>
	 								<c:set var="clss3" value="${x == depth01 && y == depth02 && z == depth03 ? 'class=\"current\"' : ''}"/>
	 								<c:if test="${z == 0}"><c:set var="liClss3" value="${'class=\"fir\"'}" /></c:if>
	 								<c:if test="${z == fn:length(d03Categories)-1}"><c:set var="liClss3" value="${'class=\"end\"'}" /></c:if>
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
        <div class="main_search">
            <fieldset class="main_total_search">
                <legend>통합검색</legend>
                <select title="검색구분">
                    <option>통합검색</option>
                </select>
                <input type="text" class="search_word" title="검색어" />
                <input type="image" src="/health/open_content/images/main/btn_search.gif" alt="검색" />
            </fieldset>
            <fieldset class="gis_search">
                <legend ><img src="/health/open_content/images/main/title_search_gs.gif" width="94" height="11" alt="GIS 병의원/약국찾기" /></legend>
                <input type="text" class="search_word2" title="검색어" />
                <input type="image" src="/health/open_content/images/main/btn_search.gif" alt="검색" />
            </fieldset>
        </div>
        <div class="left_con">
            <div class="bug_position">
            <div class="container_left_top">
                <h2><img src="/health/open_content/images/main/title_time.gif" width="73" height="11" alt="근무시간안내" /></h2>
                <p class="deco_text"><img src="/health/open_content/images/main/text_titme.gif" width="215" height="26" alt="평일 : 09시~18시 토요일 : 직장 임산부 진료 (예약제) 매월2,4주" /> </p>
                <p class="deco_text2"><img src="/health/open_content/images/main/text_infor.gif" width="130" height="25" alt="지역주민의 건/강/증/진을 위해항상 노력하겠습니다." /></p>
                <p class="btn_ares"><a href="#"><img src="/health/open_content/images/main/btn_infor.gif" width="71" height="17" alt="청사안내" /></a> <a href="#"><img src="/health/open_content/images/main/btn_map.gif" width="71" height="17" alt="오시는 길" /></a></p>
                <div class="popup_area"> <a href="#popup_area"><img src="/health/open_content/images/main/btn_pop_open.gif" width="93" height="82" alt="알림판 열기" /></a>
                <div id="popup_zone" style="display:block">
				<!--[if IE 6]><iframe  frameborder="0" class="ie6pop_bug" title="익스 버그해결용"></iframe><![endif]-->
                    <div id="popup_area" style="display:block">
                    	<h3><img src="/health/open_content/images/main/title_pop.gif" width="76" height="13" alt="보건소알림판" /></h3>
                        <ul>
                        	<li><span class="img current"><a href="#"><img src="/health/open_content/images/main/popex.gif" width="310" height="140" alt="설명" /></a></span><span class="number"><a href="#"><img src="/health/open_content/images/main/btn_popup_number_1_off.gif" width="12" height="11" alt="1번 배너" /></a></span></li>
                            <li><span class="img"><a href="#"><img src="/health/open_content/images/main/popex.gif" width="310" height="140" alt="설명" /></a></span><span class="number"><a href="#"><img src="/health/open_content/images/main/btn_popup_number_2_off.gif" width="12" height="11" alt="1번 배너" /></a></span></li>
                            <li><span class="img"><a href="#"><img src="/health/open_content/images/main/popex.gif" width="310" height="140" alt="설명" /></a></span><span class="number"><a href="#"><img src="/health/open_content/images/main/btn_popup_number_3_off.gif" width="12" height="11" alt="1번 배너" /></a></span></li>
                            <li><span class="img"><a href="#"><img src="/health/open_content/images/main/popex.gif" width="310" height="140" alt="설명" /></a></span><span class="number"><a href="#"><img src="/health/open_content/images/main/btn_popup_number_4_off.gif" width="12" height="11" alt="1번 배너" /></a></span></li>
                            <li><span class="img"><a href="#"><img src="/health/open_content/images/main/popex.gif" width="310" height="140" alt="설명" /></a></span><span class="number"><a href="#"><img src="/health/open_content/images/main/btn_popup_number_5_off.gif" width="12" height="11" alt="1번 배너" /></a></span></li>
                            <li><span class="img"><a href="#"><img src="/health/open_content/images/main/popex.gif" width="310" height="140" alt="설명" /></a></span><span class="number"><a href="#"><img src="/health/open_content/images/main/btn_popup_number_6_off.gif" width="12" height="11" alt="1번 배너" /></a></span></li>
                            <li><span class="img"><a href="#"><img src="/health/open_content/images/main/popex.gif" width="310" height="140" alt="설명" /></a></span><span class="number"><a href="#"><img src="/health/open_content/images/main/btn_popup_number_7_off.gif" width="12" height="11" alt="1번 배너" /></a></span></li>
                            <li><span class="img"><a href="#"><img src="/health/open_content/images/main/popex.gif" width="310" height="140" alt="설명" /></a></span><span class="number"><a href="#"><img src="/health/open_content/images/main/btn_popup_number_8_off.gif" width="12" height="11" alt="1번 배너" /></a></span></li>
                            <li><span class="img"><a href="#"><img src="/health/open_content/images/main/popex.gif" width="310" height="140" alt="설명" /></a></span><span class="number"><a href="#"><img src="/health/open_content/images/main/btn_popup_number_9_off.gif" width="12" height="11" alt="1번 배너" /></a></span></li>
                            <li><span class="img"><a href="#"><img src="/health/open_content/images/main/popex.gif" width="310" height="140" alt="설명" /></a></span><span class="number"><a href="#"><img src="/health/open_content/images/main/btn_popup_number_10_off.gif" width="12" height="11" alt="1번 배너" /></a></span></li>
                        </ul>
                        <div class="pop_controll">
                        	<button type="button" class="play"><img src="/health/open_content/images/main/controll_play.gif" width="12" height="11" alt="플레이" /></button>
                            <button type="button" class="play"><img src="/health/open_content/images/main/controll_stop.gif" width="12" height="11" alt="정지" /></button>
                            <button type="button" class="close"><span>닫기</span></button>
                        </div>
                    </div>
                    </div>
                </div>
                <div class="infor_set">
                    <h2 class="title_bo"><img src="/health/open_content/images/main/title_bo.gif" width="48" height="11" alt="부서안내" /></h2>
                    <ul>
                        <li><a href="#"><img src="/health/open_content/images/main/btn_bo_1.gif" width="61" height="11" alt="보건위생과" /></a></li>
                        <li><a href="#"><img src="/health/open_content/images/main/btn_bo_1.gif" width="61" height="11" alt="건강증진과" /></a></li>
                        <li><a href="#"><img src="/health/open_content/images/main/btn_bo_1.gif" width="61" height="11" alt="의약과" /></a></li>
                    </ul>
                </div>
                <p class="clear"> <a href="#"><img src="/health/open_content/images/main/btn_left_quick_1.gif" width="121" height="27" alt="엄마랑 아가랑" /></a><a href="#"><img src="/health/open_content/images/main/btn_left_quick_2.gif" width="189" height="27" alt="대사증후군 5樂 프로젝트" /></a></p>
            </div>
          
            <div id="notice_warp" class="clearfix tab_4">
                <h2 class="novisible">최근게시물</h2>
                <h3><a href="#"><img src="/health/open_content/images/main/tab_notice_01_on.gif" width="38" height="12" alt="새소식" /></a></h3>
                <ul class="current">
                    <li><a href="#" class="new"><span class="text">유방암 강좌 안내</span> <span class="date">2010-06-18</span></a></li>
                    <li><a href="#" class="new"><span class="text">유방암 강좌 안내</span> <span class="date">2010-06-18</span></a></li>
                    <li><a href="#" class="new"><span class="text">유방암 강좌 안내</span> <span class="date">2010-06-18</span></a></li>
                    <li class="more"><a href="#"><img src="/health/open_content/images/main/btn_more.gif" width="27" height="5" alt="더보기" /></a></li>
                </ul>
                <h3><a href="#"><img src="/health/open_content/images/main/tab_notice_02_off.gif" width="42" height="12" alt="고시공고" /></a></h3>
                <ul >
                    <li><a href="#" class="new"><span class="text">유방암 강좌 안내</span> <span class="date">2010-06-18</span></a></li>
                    <li><a href="#" class="new"><span class="text">유방암 강좌 안내</span> <span class="date">2010-06-18</span></a></li>
                    <li><a href="#" class="new"><span class="text">유방암 강좌 안내</span> <span class="date">2010-06-18</span></a></li>
                    <li class="more"><a href="#"><img src="/health/open_content/images/main/btn_more.gif" width="27" height="5" alt="더보기" /></a></li>
                </ul>
                <h3><a href="#"><img src="/health/open_content/images/main/tab_notice_03_off.gif" width="54" height="12" alt="보건소식지" /></a></h3>
                <ul >
                    <li><a href="#" class="new"><span class="text">유방암 강좌 안내</span> <span class="date">2010-06-18</span></a></li>
                    <li><a href="#" class="new"><span class="text">유방암 강좌 안내</span> <span class="date">2010-06-18</span></a></li>
                    <li><a href="#" class="new"><span class="text">유방암 강좌 안내</span> <span class="date">2010-06-18</span></a></li>
                    <li class="more"><a href="#"><img src="/health/open_content/images/main/btn_more.gif" width="27" height="5" alt="더보기" /></a></li>
                </ul>
                <h3><a href="#"><img src="/health/open_content/images/main/tab_notice_04_off.gif" width="42" height="12" alt="의약공람 " /></a></h3>
                <ul >
                    <li><a href="#" class="new"><span class="text">유방암 강좌 안내</span> <span class="date">2010-06-18</span></a></li>
                    <li><a href="#" class="new"><span class="text">유방암 강좌 안내</span> <span class="date">2010-06-18</span></a></li>
                    <li><a href="#" class="new"><span class="text">유방암 강좌 안내</span> <span class="date">2010-06-18</span></a></li>
                    <li class="more"><a href="#"><img src="/health/open_content/images/main/btn_more.gif" width="27" height="5" alt="더보기" /></a></li>
                </ul>
                <h3><a href="#"><img src="/health/open_content/images/main/tab_notice_05_off.gif" width="54" height="12" alt="식약청 정보" /></a></h3>
                <ul >
                    <li><a href="#" class="new"><span class="text">유방암 강좌 안내</span> <span class="date">2010-06-18</span></a></li>
                    <li><a href="#" class="new"><span class="text">유방암 강좌 안내</span> <span class="date">2010-06-18</span></a></li>
                    <li><a href="#" class="new"><span class="text">유방암 강좌 안내</span> <span class="date">2010-06-18</span></a></li>
                    <li class="more"><a href="#"><img src="/health/open_content/images/main/btn_more.gif" width="27" height="5" alt="더보기" /></a></li>
                </ul>
            </div>
            <h2 id="quickmenu" class="novisible">퀵메뉴</h2>
            <ul class="quickmenu_1 clearfix">
                <li><a href="#"><img src="/health/open_content/images/main/quickmenu_1_01.gif" width="66" height="65" alt="주요사업안내" /></a></li>
                <li><a href="#"><img src="/health/open_content/images/main/quickmenu_1_02.gif" width="87" height="65" alt="건강한 생활관리" /></a></li>
                <li><a href="#"><img src="/health/open_content/images/main/quickmenu_1_03.gif" width="96" height="65" alt="가정간호 의료기관" /></a></li>
                <li><a href="#"><img src="/health/open_content/images/main/quickmenu_1_04.gif" width="81" height="65" alt="소비자 부적합 식품" /></a></li>
            </ul>
              </div>
        </div>
        <div class="middle_con">
            <h2 class="novisible">편의시설 정보</h2>
            <ul class="quickmenu_2 clearfix">
                <li class="mr35"><a href="#"><img src="/health/open_content/images/main/quick_menu_right_1.gif" width="62" height="22" alt="예방접종" /></a></li>
                <li><a href="#"><img src="/health/open_content/images/main/quick_menu_right_2.gif" width="62" height="22" alt="건강검진" /></a></li>
                <li class="mr35"><a href="#"><img src="/health/open_content/images/main/quick_menu_right_3.gif" width="62" height="22" alt="진료안내" /></a></li>
                <li><a href="#"><img src="/health/open_content/images/main/quick_menu_right_4.gif" width="62" height="22" alt="건강상담" /></a></li>
                <li class="mr15"><a href="#"><img src="/health/open_content/images/main/quick_menu_right_5.gif" width="82" height="22" alt="건강자가진단" /></a></li>
                <li><a href="#"><img src="/health/open_content/images/main/quick_menu_right_6.gif" width="103" height="22" alt="의약업소 자율점검" /></a></li>
                <li class="mr35"><a href="#"><img src="/health/open_content/images/main/quick_menu_right_7.gif" width="62" height="22" alt="민원서식" /></a></li>
                <li><a href="#"><img src="/health/open_content/images/main/quick_menu_right_8.gif" width="62" height="22" alt="민원신고" /></a></li>
                <li class="mr35"><a href="#"><img src="/health/open_content/images/main/quick_menu_right_9.gif" width="62" height="22" alt="민원안내" /></a></li>
                <li><a href="#"><img src="/health/open_content/images/main/quick_menu_right_10.gif" width="107" height="22" alt="인터넷 민원 서비스" /></a></li>
            </ul>
            <div class="calendar_area">
                <h2 class="novisible">캘린더</h2>
                <h3><a href="#"><img src="/health/open_content/images/main/title_date_1.gif" width="22" height="13" alt="교육" /></a></h3>
                <div class="cal_edu current">
                    <div class="controll">
                        <input type="button" class="btn_calendar_pre" value="이전달 보기" />
                        <span class="now_date">2010.06</span>
                        <input type="button" class="btn_calendar_nex" value="다음달 보기" />
                    </div>
                    <table border="0" cellpadding="0" cellspacing="0" class="calendar" summary="이달의 교육은 15일,17일 있습니다">
                        <caption>
                        교육 캘린더
                        </caption>
                        <tr>
                            <th scope="col"><img src="/health/open_content/images/main/date_1.gif" width="17" height="8" alt="일" /></th>
                            <th scope="col"><img src="/health/open_content/images/main/date_2.gif" width="20" height="8" alt="월" /></th>
                            <th scope="col"><img src="/health/open_content/images/main/date_3.gif" width="17" height="8" alt="화" /></th>
                            <th scope="col"><img src="/health/open_content/images/main/date_4.gif" width="21" height="8" alt="수" /></th>
                            <th scope="col"><img src="/health/open_content/images/main/date_5.gif" width="19" height="8" alt="목" /></th>
                            <th scope="col"><img src="/health/open_content/images/main/date_6.gif" width="14" height="8" alt="금" /></th>
                            <th scope="col"><img src="/health/open_content/images/main/date_7.gif" width="17" height="8" alt="토" /></th>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>1</td>
                            <td>2</td>
                            <td>3</td>
                            <td>4</td>
                            <td>5</td>
                            <td>6</td>
                        </tr>
                        <tr>
                            <td>7</td>
                            <td>8</td>
                            <td>9</td>
                            <td>10</td>
                            <td>11</td>
                            <td>12</td>
                            <td>13</td>
                        </tr>
                        <tr>
                            <td>14</td>
                            <td><a href="#" title="땡땡땡 교육">15</a></td>
                            <td>16</td>
                            <td><a href="#" title="땡땡땡 교육">17</a></td>
                            <td>18</td>
                            <td>19</td>
                            <td>20</td>
                        </tr>
                        <tr>
                            <td>21</td>
                            <td>22</td>
                            <td>23</td>
                            <td>24</td>
                            <td>25</td>
                            <td>26</td>
                            <td>27</td>
                        </tr>
                        <tr>
                            <td>28</td>
                            <td>29</td>
                            <td>30</td>
                            <td>31</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                </div>
                <h3><a href="#"><img src="/health/open_content/images/main/title_date_2.gif" width="22" height="13" alt="행사" /></a></h3>
                <div class="cal_eve">
                    <div class="controll">
                        <input type="button" class="btn_calendar_pre" value="이전달 보기" />
                        <span class="now_date">2010.06</span>
                        <input type="button" class="btn_calendar_nex" value="다음달 보기" />
                    </div>
                    <table border="1" class="calendar" summary="이달의 행사 15일,17일 있습니다">
                        <caption>
                        행사 캘린더
                        </caption>
                        <tr>
                            <th scope="col"><img src="/health/open_content/images/main/date_1.gif" width="17" height="8" alt="일" /></th>
                            <th scope="col"><img src="/health/open_content/images/main/date_2.gif" width="20" height="8" alt="월" /></th>
                            <th scope="col"><img src="/health/open_content/images/main/date_3.gif" width="17" height="8" alt="화" /></th>
                            <th scope="col"><img src="/health/open_content/images/main/date_4.gif" width="21" height="8" alt="수" /></th>
                            <th scope="col"><img src="/health/open_content/images/main/date_5.gif" width="19" height="8" alt="목" /></th>
                            <th scope="col"><img src="/health/open_content/images/main/date_6.gif" width="14" height="8" alt="금" /></th>
                            <th scope="col"><img src="/health/open_content/images/main/date_7.gif" width="17" height="8" alt="토" /></th>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>1</td>
                            <td>2</td>
                            <td>3</td>
                            <td>4</td>
                            <td>5</td>
                            <td>6</td>
                        </tr>
                        <tr>
                            <td>7</td>
                            <td>8</td>
                            <td>9</td>
                            <td>10</td>
                            <td>11</td>
                            <td>12</td>
                            <td>13</td>
                        </tr>
                        <tr>
                            <td>14</td>
                            <td>15</td>
                            <td>16</td>
                            <td>17</td>
                            <td>18</td>
                            <td>19</td>
                            <td>20</td>
                        </tr>
                        <tr>
                            <td>21</td>
                            <td>22</td>
                            <td>23</td>
                            <td>24</td>
                            <td>25</td>
                            <td>26</td>
                            <td>27</td>
                        </tr>
                        <tr>
                            <td>28</td>
                            <td>29</td>
                            <td>30</td>
                            <td>31</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="main_poll">
                <h2><img src="/health/open_content/images/main/title_voit.gif" width="55" height="11" alt="설문조사" /></h2>
                <p>보건소 제공서비스에 대해 평소어떻게 생각하십니까?</p>
                <div> <a href="#"><img src="/health/open_content/images/main/btn_voit_1.gif" width="78" height="17" alt="참여하기" /></a> <a href="#"><img src="/health/open_content/images/main/btn_voit_2.gif" width="78" height="17" alt="결과보기" /></a> </div>
            </div>
        </div>
        <!-- middlecon e-->
        <div class="ad_area">
            <h2 class="novisible">배너존</h2>
            <ul class="controll">
                <li>
                    <input type="button" class="btn_pre" value="이전 보기" />
                </li>
                <li>
                    <input type="button" class="btn_play" value="플레이" />
                </li>
                <li>
                    <input type="button" class="btn_stop" value="정지" />
                </li>
                <li>
                    <input type="button" class="btn_next" value="다음 보기" />
                </li>
            </ul>
            <div class="ad_zone">
                <div class="visible_area">
                    <ul class="ad_list">
                        <li><a href="#"><img src="ad_ex.gif" width="104" height="31" alt="질병관리본부" /></a></li>
                        <li><a href="#"><img src="ad_ex.gif" width="104" height="31" alt="질병관리본부" /></a></li>
                        <li><a href="#"><img src="ad_ex.gif" width="104" height="31" alt="질병관리본부" /></a></li>
                        <li><a href="#"><img src="ad_ex.gif" width="104" height="31" alt="질병관리본부" /></a></li>
                        <li><a href="#"><img src="ad_ex.gif" width="104" height="31" alt="질병관리본부" /></a></li>
                        <li><a href="#"><img src="ad_ex.gif" width="104" height="31" alt="질병관리본부" /></a></li>
                        <li><a href="#"><img src="ad_ex.gif" width="104" height="31" alt="질병관리본부" /></a></li>
                        <li><a href="#"><img src="ad_ex.gif" width="104" height="31" alt="질병관리본부" /></a></li>
                        <li><a href="#"><img src="ad_ex.gif" width="104" height="31" alt="질병관리본부" /></a></li>
                        <li><a href="#"><img src="ad_ex.gif" width="104" height="31" alt="질병관리본부" /></a></li>
                        <li><a href="#"><img src="ad_ex.gif" width="104" height="31" alt="질병관리본부" /></a></li>
                        <li><a href="#"><img src="ad_ex.gif" width="104" height="31" alt="질병관리본부" /></a></li>
                        <li><a href="#"><img src="ad_ex.gif" width="104" height="31" alt="질병관리본부" /></a></li>
                        <li><a href="#"><img src="ad_ex.gif" width="104" height="31" alt="질병관리본부" /></a></li>
                        <li><a href="#"><img src="ad_ex.gif" width="104" height="31" alt="질병관리본부" /></a></li>
                        <li><a href="#"><img src="ad_ex.gif" width="104" height="31" alt="질병관리본부" /></a></li>
                        <li><a href="#"><img src="ad_ex.gif" width="104" height="31" alt="질병관리본부" /></a></li>
                    </ul>
                </div>
            </div>
            <a class="btn_more" href="#"><img src="/health/open_content/images/main/btn_more.gif" width="27" height="5" alt="모두보기" /></a> </div>
        <!-- ad_area e -->
        <div class="main_visual">
            <p class="text_slogan"><strong><img src="/health/open_content/images/main/slogan.gif" width="246" height="71" alt="건강한 미래를 약속합니다" /></strong></p>
            <p class="img"><img src="/health/open_content/images/main/visual_main.jpg" width="370" height="456" alt="4인가족이 공원 들판에 앉아 환하게 웃고있다" /></p>
        </div>
    </div>
</div>
<div id="footer">
    <div class="area">
        <ul class="footer_menu">
            <li><a href="#"><img src="/health/open_content/images/common/footer_menu_1.gif" width="78" height="13" alt="개인정보보호방침" /></a></li>
            <li><a href="#"><img src="/health/open_content/images/common/footer_menu_2.gif" width="48" height="13" alt="저작권정책" /></a></li>
            <li><a href="#"><img src="/health/open_content/images/common/footer_menu_3.gif" width="81" height="13" alt="홈페이지 개선의견" /></a></li>
            <li><a href="#"><img src="/health/open_content/images/common/footer_menu_4.gif" width="60" height="13" alt="찾아오시는 길" /></a></li>
            <li><a href="#"><img src="/health/open_content/images/common/footer_menu_5.gif" width="58" height="13" alt="뷰어다운로드" /></a></li>
            <li class="end"><a href="#"><img src="/health/open_content/images/common/footer_menu_6.gif" width="38" height="13" alt="이용안내" /></a></li>
        </ul>
        <address>
        [153-701] 서울특별시 금천구 시흥동 1020   전화. (02)2627-2422, 2426   팩스. (02)2627-2101
        </address>
        <p class="copyright_text"> Copyright 2010 Geumcheon-Gu Public Health Center. All rights reserved.<br />
            본 웹사이트에 게시된 이메일 주소의 자동수집을 거부하며, 이를 위반 시 정보통신망법에 의해 처벌됨을 유념하시기 바랍니다. </p>
        <img class="footer_mark" src="/health/open_content/images/common/mark.gif" width="52" height="53" alt="웹접근성 품질마크 획득" />
		<img class="footer_logo" src="/health/open_content/images/common/footer_logo.gif" width="130" height="32" alt="금천구 보건소" />
        <dl class="count_view">
            <dt><img src="/health/open_content/images/common/title_count_today.gif" width="24" height="9" alt="오늘 접속자" /> </dt>
            <dd class="today">124</dd>
            <dt><img src="/health/open_content/images/common/title_count_total.gif" width="24" height="9" alt="전체 접속자" /></dt>
            <dd>12345678</dd>
        </dl>
    </div>
</div>
</body>
</html>
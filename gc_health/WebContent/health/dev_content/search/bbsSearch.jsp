<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 메뉴검색 영역 시작 -->

	<div class="result_box1">
		<h4><strong>게시판</strong> (해당 검색어에 대한 검색결과가 <strong>${bbsListCnt}</strong>건입니다)</h4>
		<ul class="result_list1">
			<c:if test="${fn:length(bbsList)>0}">
			<c:forEach var="x" begin="0" end="${fn:length(bbsList)-1}">
			<li style="list-style:none; ">
				<dl>
					<dt><a href="/health/bbs/selectBoardArticle.do?categoryId=${bbsList[x].categoryId}&amp;bbsId=${bbsList[x].bbsId}&amp;nttId=${bbsList[x].nttId}">${bbsList[x].nttSj}</a></dt>
					<dd class="result_text">
						<a href="/health/bbs/selectBoardArticle.do?categoryId=${bbsList[x].categoryId}&amp;bbsId=${bbsList[x].bbsId}&amp;nttId=${bbsList[x].nttId}">
							<c:choose>
								<c:when test="${fn:length(bbsList[x].nttCn) < 150}" >
									<c:out value="${bbsList[x].nttCn}" />
								</c:when>
								<c:otherwise>
									<c:out value="${fn:substring(bbsList[x].nttCn,0,150)}" />...
								</c:otherwise>
							</c:choose>
						</a>
					</dd>
					<dd class="location">
						<c:choose>
							<c:when test="${bbsList[x].bbsId == 'BBSMSTR_000000001159'}" >
								금천보건소>보건민원>진료검진>진료안내>휴일야간진료
							</c:when>
							<c:when test="${bbsList[x].bbsId == 'BBSMSTR_000000001168'}" >
								금천보건소>보건민원>진료검진>건강동영상
							</c:when>
							<c:when test="${bbsList[x].bbsId == 'BBSMSTR_000000001167'}" >
								금천보건소>보건민원>예방접종>국가필수예방접종>위탁의료기관
							</c:when>
							<c:when test="${bbsList[x].bbsId == 'BBSMSTR_000000001138'}" >
								금천보건소>보건민원>식품공중위생>식품위생>모범음식점
							</c:when>
							<c:when test="${bbsList[x].bbsId == 'BBSMSTR_000000001137'}" >
								금천보건소>보건행정>식품공중위생>감시활동 대상업소 사전예고제
							</c:when>
							<c:when test="${bbsList[x].bbsId == 'BBSMSTR_000000001127'}" >
								금천보건소>보건행정>보건사업>방역관리>방역소독>소독업소현황
							</c:when>
							<c:when test="${bbsList[x].bbsId == 'BBSMSTR_000000001187'}" >
								금천보건소>보건행정/보건사업>방역관리>방역소독>방역게시판
							</c:when>
							<c:when test="${bbsList[x].bbsId == 'BBSMSTR_000000001147'}" >
								금천보건소>보건행정>의약관리>의료기관 약국안내>휴일 야간진료기관/약국
							</c:when>
							<c:when test="${bbsList[x].bbsId == 'BBSMSTR_000000001156'}" >
								금천보건소>보건행정>의약관리>의약업소 자율점검>자율점검 서식
							</c:when>
							<c:when test="${bbsList[x].bbsId == 'BBSMSTR_000000001157'}" >
								금천보건소>보건행정>의약관리>의약업소 자율점검>자율점검 작성방법
							</c:when>
							<c:when test="${bbsList[x].bbsId == 'BBSMSTR_000000001158'}" >
								금천보건소>보건행정>의약관리>약국간 의약품 나눔센터
							</c:when>
							<c:when test="${bbsList[x].bbsId == 'BBSMSTR_000000001148'}" >
								금천보건소>보건행정>의약관리>의약게시판>공지사항
							</c:when>
							<c:when test="${bbsList[x].bbsId == 'BBSMSTR_000000001149'}" >
								금천보건소>보건행정>의약관리>의약게시판>자료실
							</c:when>
							<c:when test="${bbsList[x].bbsId == 'BBSMSTR_000000001150'}" >
								금천보건소>보건행정>의약관리>의약게시판>약물정보 게시판
							</c:when>
							<c:when test="${bbsList[x].bbsId == 'BBSMSTR_000000001151'}" >
								금천보건소>보건행정>의약관리>의약게시판>약물정보 게시판
							</c:when>
							<c:when test="${bbsList[x].bbsId == 'BBSMSTR_000000001152'}" >
								금천보건소>보건행정>보건소 소개>보건소식>보건 소식지
							</c:when>
							<c:when test="${bbsList[x].bbsId == 'BBSMSTR_000000001153'}" >
								금천보건소>보건행정>보건소소개>고시공고>소비자 부적합 식품 고시
							</c:when>
							<c:when test="${bbsList[x].bbsId == 'BBSMSTR_000000001155'}" >
								금천보건소>보건행정>보건소 소개>고시공고>의약공람
							</c:when>
							<c:when test="${bbsList[x].bbsId == 'BBSMSTR_000000001169'}" >
								금천보건소>보건행정>보건 자료실>영상 자료실
							</c:when>
							<c:when test="${bbsList[x].bbsId == 'BBSMSTR_000000001170'}" >
								금천보건소>보건행정>보건 자료실>일반 자료실
							</c:when>
							<c:when test="${bbsList[x].bbsId == 'BBSMSTR_000000001162'}" >
								금천보건소>보건행정>보건 자료실>자유게시판
							</c:when>
							<c:when test="${bbsList[x].bbsId == 'BBSMSTR_000000001160'}" >
								금천보건소>건강생활>안전한 식품>식품안전>식품안전교실
							</c:when>
							<c:when test="${bbsList[x].bbsId == 'BBSMSTR_000000001161'}" >
								금천보건소>건강생활>안전한 식품>식중독 자료실>식중독 예방 홍보자료
							</c:when>
							<c:when test="${bbsList[x].bbsId == 'BBSMSTR_000000001163'}" >
								금천보건소>건강생활>안전한 식품>부적합 식품
							</c:when>
							<c:when test="${bbsList[x].bbsId == 'BBSMSTR_000000001164'}" >
								금천보건소>행복가정>노인>질병
							</c:when>
						</c:choose>
					</dd>
					<dd class="result_link">
						<a href="${bbsList[x].fullMenuLink}" class="blank" title="검색결과 새창보기" target="_blank">${bbsList[x].fullMenuLink}</a>
						<span>|</span>
						<a href="${bbsList[x].fullMenuLink}">[현재창에서보기]</a>
					</dd>
				</dl>
			</li>
			</c:forEach>
			</c:if>
		</ul>


<ol class="paging">${pageNav}</ol>
	</div>


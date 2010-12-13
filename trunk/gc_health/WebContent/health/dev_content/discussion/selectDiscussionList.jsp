<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="comment_box">
<div class="comment_box_top"></div>
<div class="comment_box_in" style="background:url(/health/open_content/images/comment/comment_img_s_001.gif) 580px top no-repeat;">
    <ul class="list">
		<li>소비자식품위생감시원토론방은 구민 여러분의 좋은 의견을 받아들이는 열린 행정창구입니다.</li>
		<li>여러분들이 제안한 좋은 의견은 추후 우리구 각종 정책시행에 귀중한 의견으로 활용될 것입니다. </li>
		<li>많은 관심과 참여를 바랍니다.</li>	
		<li>저속한 표현, 타인의 명예훼손, 근거없는 비방, 반사회적인 글, 영리목적의 광고성 글, 게시판의 운영목적에 부적합한 내용 등은 사전양해없이 삭제될 수 있습니다. </li>		
    </ul>
</div>
<div class="comment_box_bottom"></div>
</div>
				
					<!-- board list start -->
					<table class="default_list" summary="구민이 제안한 좋은 의견 중에 지난 토론의 제목, 토론기간, 주관부서, 진행상태 등을 보실 수 있습니다">
						<caption>지난 토론 목록 보기</caption>
						<colgroup>
							<col width="8%" />
							<col width="*" />
							<col width="20%" />
							<col width="10%" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col" class="fir">번호</th>
								<th scope="col">제목</th>
								<th scope="col">등록일</th>
								<th scope="col">조회수</th>
							</tr>
						</thead>
						<tbody>
						<c:if test="${fn:length(discussionList) > 0}" >
						<c:forEach var="x" begin="0" end="${fn:length(discussionList)-1}">  
							<tr>
								<td>${paginationInfo.totalRecordCount - (paginationInfo.currentPageNo-1)*paginationInfo.pageSize - x}</td>
								<td class="tal">
									<c:choose><c:when test="${user.authCode == 'ROLE_FOOD'}">
									<a href="/health/discussion/selectDiscussion.do?disseq=${discussionList[x].disseq}&amp;categoryId=${param.categoryId}">${discussionList[x].distitle}</a>
									</c:when>
									<c:otherwise>${discussionList[x].distitle}</c:otherwise>
									</c:choose>
								</td>
								<td><fmt:parseDate value='${discussionList[x].rdate}' var='rdate' pattern='yyyy-mm-dd'/>
							<fmt:formatDate value='${rdate}' pattern="yyyy년mm월dd일"/></td>
								<td>${discussionList[x].hit}</td>
							</tr>
						</c:forEach>
						</c:if>							
						<c:if test="${fn:length(discussionList) == 0}" >
							<tr>
								<td colspan="6">데이터가 없습니다</td>
							</tr>
						</c:if>	
						</tbody>
					</table>
					<!-- board list end //-->
					
					<c:if test="${fn:length(discussionList) > 0}" >
<ol class="paging">${pageNav}</ol>
					</c:if>

<c:if test="${user.authCode == 'ROLE_FOOD'}">
<div class="board_btn_set mt13">
	<span class="btn_del"><a href="/health/discussion/writeDiscussionPage.do?categoryId=${param.categoryId}">등록하기</a></span>
</div>
</c:if>
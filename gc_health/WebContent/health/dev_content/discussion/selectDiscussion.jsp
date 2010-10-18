<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%pageContext.setAttribute("crlf", "\n"); %> 
		
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
						
				<h4>토론 내용</h4>
				<table summary="토론주제, 토론내용, 토론기관등을 확인할 수 있습니다" class="default_view">
					<caption>토론 내용</caption>
					<colgroup>
						<col width="20%" />
						<col width="35%" />
						<col width="15%" />
						<col width="35%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">토론주제</th>
							<td colspan="3" class="output">${result.distitle}</td>
						</tr>
						<tr>
							<td colspan="3" class="output">${fn:replace(result.discont, crlf, "<br/>")}</td>
						</tr>
						<tr>
							<th scope="row">등록일</th>
							<td colspan="3" class="output">	
							<fmt:parseDate value='${result.rdate}' var='rdate' pattern='yyyy-mm-dd'/>
							<fmt:formatDate value='${rdate}' pattern="yyyy년mm월dd일"/>
							</td>
						</tr>
						
					</tbody>
				</table>

<br/>
				<h4>토론 참여 의견</h4>
				<table class="default_list" summary="토론 참여 의견 목록 테이블입니다">
						<caption>토론 참여 의견</caption>
						<colgroup>
							<col width="8%" />
							<col width="*" />
							<col width="20%" />
							<col width="15%" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col" class="fir">번호</th>
								<th scope="col">의견</th>
								<th scope="col">글쓴이</th>
								<th scope="col">입력일자</th>
							</tr>
						</thead>
						<tbody>
						<c:if test="${fn:length(divisionList) > 0}" >
						<c:forEach var="x" begin="0" end="${fn:length(divisionList)-1}">  
							<tr>
								<td>${paginationInfo.totalRecordCount - (paginationInfo.currentPageNo-1)*paginationInfo.pageSize - x}</td>
								<td class="tal">${fn:replace(divisionList[x].divcont, crlf, "<br/>")}</td>
								<td>
								<c:choose>
								<c:when test="${(not empty user.webMemId && user.webMemId == divisionList[x].memberId) || (not empty user.pin && user.pin == divisionList[x].pinno)}">
								<a href="/health/discussion/modifyDivisionPage.do?disseq=${param.disseq}&amp;divseq=${divisionList[x].divseq}&amp;categoryId=${param.categoryId}">${divisionList[x].name}</a>
								</c:when>
								<c:otherwise>
								${divisionList[x].name}
								</c:otherwise>
								</c:choose>
								</td>
								<td><fmt:parseDate value='${divisionList[x].rdate}' var='rdate' pattern='yyyy-mm-dd'/>
							<fmt:formatDate value='${rdate}' pattern="yyyy년mm월dd일"/></td>
							</tr>
						</c:forEach>
						</c:if>
						<c:if test="${fn:length(divisionList) == 0}" >
							<tr><td colspan="4">데이터가 없습니다.</td></tr>
						</c:if>
						</tbody>
					</table>

					<c:if test="${fn:length(divisionList) > 0}" >
						<ol class="paging">${pageNav}</ol>
					</c:if>

<div class="board_btn_set mt13">
	<span class="btn_del">
		<a href="/health/discussion/writeDivisionPage.do?disseq=${param.disseq}&amp;categoryId=${param.categoryId}">등록하기</a>
	</span>
	<c:if test="${(not empty user.webMemId && user.webMemId == divisionList[x].memberId) || (not empty user.pin && user.pin == divisionList[x].pinno)}">
	<span class="btn_del">
		<a href="/health/discussion/modifyDivisionPage.do?disseq=${param.disseq}&amp;categoryId=${param.categoryId}">수정하기</a>
	</span>
	</c:if>
	<span class="btn_list"><a href="/health/discussion/selectDiscussionList.do?categoryId=${param.categoryId}">목록보기</a></span>
</div>
				
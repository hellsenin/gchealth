<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/admin/health/application/applyStatus.jsp" %>

<table class="default_list" summary="모범업소지정 신청확인 게시판으로 번호, 작성자, 업소 및 기관명, 등록일, 처리상황으로 구성">
    <caption>모범업소지정 신청확인</caption>
    <thead>
        <tr>
            <th width="7%" scope="col">번호</th>
            <th width="13%" scope="col">작성자</th>
            <th width="37%" scope="col">업소 및 기관명</th>
            <th width="13%" scope="col">등록일</th>
            <th width="10%" scope="col">처리상황</th>
        </tr>
    </thead>
    <tbody>
	<c:if test="${fn:length(resultList) > 0}" >
	<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}">  
        <tr>
            <td>${pageInfo.totCnt - (pageInfo.pageIndex-1)*pageInfo.pageUnit - x}</td>
            <td><a href="/health/application/selectApplyView.do?applyCode=${param.applyCode}&amp;applyId=${resultList[x].applyId}&amp;petiGubun=${param.petiGubun}&amp;categoryId=${param.categoryId}">${resultList[x].name}</a></td>
            <td class="tal">${resultList[x].etc1}</td>
          <td>		
			<fmt:parseDate value='${resultList[x].applyDate}' var='applyDate' pattern='yyyy-mm-dd'/>
			<fmt:formatDate value='${applyDate}' pattern="yyyy년mm월dd일"/>	
          </td>
            <td>
				<c:if test="${empty resultList[x].status || resultList[x].status == RECEIPT_WAITING}">접수대기</c:if>
				<c:if test="${resultList[x].status == RECEIPT}">접수</c:if>
				<c:if test="${resultList[x].status == ASSIGNED_DEPT}">부서지정</c:if>
				<c:if test="${resultList[x].status == OFFICER_PROCESSING}">담당자지정/처리</c:if>
				<c:if test="${resultList[x].status == ANSWERING}">답변중</c:if>
				<c:if test="${resultList[x].status == COMPLETE_ANSWER}">답변완료</c:if>
				<c:if test="${resultList[x].status == COMPLETION}">완료</c:if>
				<c:if test="${resultList[x].status == DELETION}">신청취소</c:if>
				<c:if test="${resultList[x].status == TRANSFER}">이관</c:if>
            </td>
        </tr>
     </c:forEach>
     </c:if>
	<c:if test="${fn:length(resultList) == 0}" >
	<tr><td colspan="7">데이터가 없습니다</td></tr>
	</c:if>
    </tbody>
</table>
<ol class="paging">
<c:if test="${fn:length(resultList) > 0}" >
${pageNav}
</c:if>
</ol>
<!-- 
<div class="board_btn_set send_mg"> <span class="register"><a href="/health/application/writePage.do?applyCode=${param.applyCode}&amp;petiGubun=${param.petiGubun}&amp;categoryId=${param.categoryId}">등록하기</a></span> </div>
 -->

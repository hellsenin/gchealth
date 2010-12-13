<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%pageContext.setAttribute("crlf", "\n"); %>
 
<p class="title_deco"></p>
<div class="body">

<table summary="제목,작성자,등록일자,연락처,내용,첨부파일 제공" class="default_view">
    <caption>
    게시물제목
    </caption>
    <tr>
        <th scope="row" class="title_1	">제목</th>
        <td colspan="9" class="title_td">${result.title}</td>
    </tr>
    <tr>
        <th scope="row">작성자 </th>
        <td>${result.name}</td>
        <th scope="row">공개여부</th>
        <td>
        	<c:if test="${result.openFlag == 'Y'}">공개</c:if>
        	<c:if test="${result.openFlag == 'N'}">비공개</c:if>
        </td>
        <th scope="row">등록일</th>
        <td>
			<fmt:parseDate value='${result.applyDate}' var='applyDate' pattern='yyyy-mm-dd'/>
			<fmt:formatDate value='${applyDate}' pattern="yyyy년mm월dd일"/>	
        </td>
        <th scope="row">조회수 </th>
        <td>${result.hit}</td>
    </tr>
    <tr>
        <td colspan="10" id="db_data_area"> 상담요청 내용입니다.</td>
    </tr>
    <tr>
        <th scope="row">첨부파일 </th>
        <td colspan="9">			
			<c:forEach var="file" items="${fileList}" varStatus="status">
			<c:if test="${empty file.answerId || file.answerId == 0}">
				<a href="/health/apply/fileDown.do?fileId=${file.fileId}">${file.orgFileName}</a><br/>
			</c:if>
			</c:forEach>	 
        </td>
    </tr>
</table>

<c:if test="${fn:length(answerList) > 0}" >	
<table summary="답변내용 포함" class="default_view">
    <caption>
    답변내용
    </caption>
	<c:forEach var="answer" items="${answerList}" varStatus="status">
    <tr class="fir">
        <th scope="row">답변내용</th>
        <td>${fn:replace(answer.answerContent, crlf, "<br/>")}</td>
    </tr>
	</c:forEach>
</table>
 </c:if>

<div class="board_btn_set mt13">
    <span class="btn_edit"><a href="/health/application/modifyApplyPage.do?applyCode=${param.applyCode}&amp;petiGubun=${param.petiGubun}&amp;applyId=${param.applyId}&amp;categoryId=${param.categoryId}">수정하기</a></span>
    <span class="btn_list"><a href="/health/application/selectApplyList.do?applyCode=${param.applyCode}&amp;petiGubun=${param.petiGubun}&amp;categoryId=${param.categoryId}">목록보기</a></span>
</div>

</div>

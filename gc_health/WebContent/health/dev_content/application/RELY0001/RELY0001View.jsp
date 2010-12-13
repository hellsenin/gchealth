<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%pageContext.setAttribute("crlf", "\n"); %>
 
<div class="consult_box">
<div class="consult_box_img">
<div class="consult_box_top"></div>
<div class="consult_box_in">
	<div class="photo"><img src="/health/open_content/images/medicalTeam/${medicalTeam.imgNm}" alt="사진" width="65" height="75" /></div>
    <ul class="list">
        <li><strong>상담 전문의</strong> : ${medicalTeam.name}</li>
        <li><strong>진료과목</strong> : ${medicalTeam.subject}</li>
        <li><strong>의료기관</strong> : ${medicalTeam.institution}</li>
        <li><strong>전화번호</strong> : ${medicalTeam.tel}</li>
    </ul></div>
<div class="consult_box_bottom"></div>
</div>
</div>
			
<table summary="선택하신 상담내용보기로 제목, 작성자, 공개여부, 등록일, 조회수, 첨부파일로 구성" class="default_view">
    <caption>상담내용보기</caption>
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
        <td colspan="10" id="db_data_area">${fn:replace(result.contents, crlf, '<br/>')}</td>
    </tr>
    <tr>
        <th scope="row">첨부파일</th>
        <td colspan="9">			
			<c:forEach var="file" items="${fileList}" varStatus="status">
			<c:if test="${empty file.answerId || file.answerId == 0}">
				<a href="/health/apply/fileDown.do?fileId=${file.fileId}">${file.orgFileName}</a><br/>
			</c:if>
			</c:forEach>	 
        </td>
    </tr>
</table>

<table summary="문의하신 상담 답변내용입니다" class="answer_view">
    <caption>상담 답변내용</caption>
<c:if test="${fn:length(answerList) > 0}" >	
	<c:forEach var="answer" items="${answerList}" varStatus="status">
    <tr class="fir">
        <th scope="row">답변내용</th>
        <td>${fn:replace(answer.answerContent, crlf, '<br/>')}</td>
    </tr>
	</c:forEach>
 </c:if>
</table>
<div class="board_btn_set mt13">
<c:if test="${accessable}">
    <span class="btn_edit"><a href="/health/medicalTeam/modifyApplyPage.do?applyCode=${param.applyCode}&amp;petiGubun=${param.petiGubun}&amp;applyId=${param.applyId}&amp;categoryId=${param.categoryId}">수정하기</a></span>
</c:if>
    <span class="btn_list"><a href="/health/medicalTeam/selectApplyList.do?applyCode=${param.applyCode}&amp;petiGubun=${param.petiGubun}&amp;categoryId=${param.categoryId}">목록보기</a></span>
</div>
<c:if test="${fn:replace(user.authCode,'ROLE_MT', '') == result.petiGubun}">	
	<br />
	<h5>답변등록</h5>
	<jsp:include page="/health/dev_content/application/answerAssignedDeptApply.jsp" flush="true" />
</c:if>
			

<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
		
<%pageContext.setAttribute("crlf", "\n"); %> 

<div class="comment_box">
<div class="comment_box_top"></div>
<div class="comment_box_in" style="background:url(/health/open_content/images/comment/comment_img_s_001.gif) 580px top no-repeat;">
    <ul class="list">
        <li>신청.신고 내용은 본인만 확인이 가능합니다.</li>
        <li>저속한 표현이나, 타인의 명예훼손, 비방, 반사회적인 글, 영리목적의 광고글 및 홈페이지 운영 목적에 <br />부적합 내용등은 사전 양해 없이 관리자에 의해 삭제될 수 있습니다.</li>
        <li>파일을 첨부하실 경우 첨부파일명은 영문으로 올려주시기 바라며, 용량은 5MB 이하로 등록하여 주시기<br /> 바랍니다.</li>
    </ul>
</div>
<div class="comment_box_bottom"></div>
</div>
<h4>신고인정보</h4>	
<c:if test="${accessable}">
<jsp:include page="/health/dev_content/application/userInfoView.jsp" flush="true" />
</c:if>
<br />

<h4>신고내용</h4>
<table summary="선택하신 전염병신고 내용으로 신고인, 신고내용, 첨부파일, 전화번호, 주소, 처리결과 회신 여부로 구성" class="default_write">
    <caption>전염병신고 내용</caption>
    
    <tr>
      <th width="20%" scope="row">신고인</th>
      <td width="85%" colspan="3">${result.etc1}</td>
    </tr>
    <tr>
      <th scope="row">신고내용</th>
      <td colspan="3">${fn:replace(result.etcContents1, crlf, "<br/>")}</td>
    </tr>
    <tr>
      <th scope="row">첨부파일</th>
      <td colspan="3"> 		
		<c:forEach var="file" items="${fileList}" varStatus="status">
		<c:if test="${empty file.answerId || file.answerId == 0}">
			<a href="/health/apply/fileDown.do?fileId=${file.fileId}">${file.orgFileName}</a><br/>
		</c:if>
		</c:forEach>
      </td>
    </tr>
    <tr>
      <th scope="row">전화번호</th>
      <td colspan="3">${result.etc2}</td>
    </tr>
    
    <tr>
      <th rowspan="2" scope="row">주소</th>
      <td colspan="3">${result.etc3}</td>
    </tr>
    <tr>
      <td colspan="3">${result.etc4} ${result.etc5}</td>
    </tr>
    <tr>
      <th scope="row">처리결과 회신</th>
      <td colspan="3">${result.smsFlag == 'Y' ? '동의' : '동의하지않음'}</td>
    </tr>
</table>

<div class="board_btn_set mt13">
	<span class="btn_del"><a href="/health/application/cancelApply.do?applyCode=${param.applyCode}&amp;applyId=${param.applyId}&amp;categoryId=${param.categoryId}" onclick="return confirm('정말로 신고를 취소하시겠습니까?');">신고취소</a></span>
	<c:if test="${result.status == '1'}">
    <span class="btn_del"><a href="/health/application/modifyApplyPage.do?applyCode=${param.applyCode}&amp;applyId=${param.applyId}&amp;categoryId=${param.categoryId}">수정하기</a></span>
    </c:if>
    <span class="btn_del"><a href="/health/application/selectMyApplyList.do?applyCode=${param.applyCode}&amp;categoryId=${param.categoryId}">목록보기</a></span>
</div>

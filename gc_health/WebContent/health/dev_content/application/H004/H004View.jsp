<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	
<%pageContext.setAttribute("crlf", "\n"); %>
 			
<div class="comment_box">
<div class="comment_box_top"></div>
<div class="comment_box_in" style="background:url(/health/open_content/images/comment/comment_img_s_001.gif) 580px top no-repeat;">
    <ul class="list">
        <li>자주 이용하시는 보건/위생 관련 민원 사무 내용을 확인하실 수 있습니다.</li>
        <li>보건/위생 서식 이외의 서식을 이용하시고자 할 경우에는 금천구청 홈페이지를 이용해 주세요.</li>
    </ul>
</div>
<div class="comment_box_bottom"></div>
</div>
<h4>신고인정보</h4>	
<jsp:include page="/health/dev_content/application/userInfoView.jsp" flush="true" />

<br />
<h4>신고내용</h4>
<table summary="선택하신 청소년 유해 업소 신고내용으로 업소명, 위반일, 첨부파일, 신고내용, 처리결과 회신 여부로 구성" class="default_view">
    <caption>청소년 유해 업소 신고내용</caption>
    <tbody>
    <tr>
      <th width="20%" scope="row"><label for="etc1">업소명</label></th>
      <td width="85%" colspan="3">${result.etc1}</td>
    </tr>
    <tr>
      <th scope="row"><label for="etc2_1">위반일</label></th>
      <td colspan="3">
      	<c:if test="${fn:length(result.etc2) == 10}">
			<fmt:parseDate value='${result.etc2}' var='etc2' pattern='yyyy-mm-dd'/>
			<fmt:formatDate value='${etc2}' pattern="yyyy년mm월dd일"/>
		</c:if>	
      </td>
    </tr>
    <tr>
      <th scope="row"><label for="file1">첨부파일</label></th>
      <td colspan="3">			
			<c:forEach var="file" items="${fileList}" varStatus="status">
			<c:if test="${empty file.answerId || file.answerId == 0}">
				<a href="/health/apply/fileDown.do?fileId=${file.fileId}">${file.orgFileName}</a><br/>
			</c:if>
			</c:forEach>
      </td>
    </tr>
    <tr>
      <th scope="row"><label for="sr_contents">신고내용</label></th>
      <td colspan="3">${fn:replace(result.etcContents1, crlf, '<br/>')}</td>
    </tr>
    <tr>
      <th scope="row"><label for="smsFlag">처리결과 회신</label></th>
      <td colspan="3">${result.smsFlag == 'Y' ? '동의' : '동의하지않음'}</td>
    </tr>
	</tbody>
</table>

<div class="board_btn_set mt13">
	<span class="btn_del"><a href="/health/application/cancelApply.do?applyCode=${param.applyCode}&amp;applyId=${param.applyId}&amp;categoryId=${param.categoryId}" onclick="return confirm('정말로 신고를 취소하시겠습니까?');">취소하기</a></span>
	<c:if test="${result.status == '1'}">
    <span class="btn_del"><a href="/health/application/modifyApplyPage.do?applyCode=${param.applyCode}&amp;applyId=${param.applyId}&amp;categoryId=${param.categoryId}">수정하기</a></span>
    </c:if>
    <span class="btn_del"><a href="/health/application/selectMyApplyList.do?applyCode=${param.applyCode}&amp;categoryId=${param.categoryId}">목록보기</a></span>
</div>

<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	
<%pageContext.setAttribute("crlf", "\n"); %>
 			
<div class="comment_box">
<div class="comment_box_top"></div>
<div class="comment_box_in" style="background:url(/health/open_content/images/comment/comment_img_s_001.gif) 580px top no-repeat;">
    <ul class="list">
        <li>식품제조 가공업소방입니다</li>
        <li>게시글 내용에는 개인정보를 기재하지 않습니다.</li>
        <li>저속한 표현이나, 타인의 명예훼손, 비방, 반사회적인 글, 영리목적의 광고글 및 홈페이지 운영 목적에 부적합 내용등은
    사전 양해 없이 관리자에 의해 삭제될 수 있습니다.
</li>
        <li>파일을 첨부하실 경우 첨부파일명은 영문으로 올려주시기 바라며, 용량은 5MB 이하로 등록하여 주시기 바랍니다.
</li>
    </ul>
</div>
<div class="comment_box_bottom"></div>
</div>

<jsp:include page="/health/dev_content/application/userInfoView.jsp" flush="true" />

<br />
<h4>내용</h4>
<table summary="업소 및 기관명, 대표자명, 대표자 주민번호, 영업형태, 전화번호, 업소 소재지, 음식물종류, 처리결과 회신" class="default_view">
    <caption>
    식품제조 가공업소방
    </caption> 
    <tr>
      <th width="20%" scope="row"><label for="title">제목</label></th>
      <td width="85%" colspan="3">${result.title}</td>
    </tr> 
    <tr>
        <td colspan="6" id="db_data_area">
        	 ${fn:replace(result.contents, crlf, '<br/>')}
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
</table>

<div class="board_btn_set mt13">
	<span class="btn_del"><a href="/health/application/cancelApply.do?applyCode=${param.applyCode}&amp;applyId=${param.applyId}&amp;categoryId=${param.categoryId}" onclick="return confirm('정말로 취소하시겠습니까?');">취소하기</a></span>
	<c:if test="${result.status == '1'}">
    <span class="btn_del"><a href="/health/application/modifyApplyPage.do?applyCode=${param.applyCode}&amp;applyId=${param.applyId}&amp;categoryId=${param.categoryId}">수정하기</a></span>
    </c:if>
    <span class="btn_del"><a href="/health/application/selectMyApplyList.do?applyCode=${param.applyCode}&amp;categoryId=${param.categoryId}">목록보기</a></span>
</div>

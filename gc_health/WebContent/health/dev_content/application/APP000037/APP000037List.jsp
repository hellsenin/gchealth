<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/admin/health/application/applyStatus.jsp" %>
	
<div class="comment_box">
<div class="comment_box_top"></div>
<div class="comment_box_in" style="background:url(/health/open_content/images/comment/comment_img_s_001.gif) 580px top no-repeat;">
    <ul class="list">
        <li>소비자 식품 감시원입니다</li>
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

<table class="default_list" summary="번호,제목,공개여부, 작성자, 등록일, 첨부파일 구성">
    <caption>
    게시물리스트
    </caption>
    <thead>
        <tr>
            <th width="7%" scope="col">번호</th>
            <th width="*" scope="col">제목</th>
            <th width="13%" scope="col">작성자</th>
            <th width="13%" scope="col">등록일</th>
            <th width="10%" scope="col">조회수</th>
        </tr>
    </thead>
    <tbody>
	<c:if test="${fn:length(resultList) > 0}" >
	<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}">  
        <tr>
            <td>${pageInfo.totCnt - (pageInfo.pageIndex-1)*pageInfo.pageUnit - x}</td>
            <td><a href="/health/application/selectApplyView.do?applyCode=${param.applyCode}&amp;applyId=${resultList[x].applyId}&amp;petiGubun=${param.petiGubun}&amp;categoryId=${param.categoryId}">${resultList[x].title}</a></td>
            <td class="tal">${resultList[x].name}</td>
          <td>		
			<fmt:parseDate value='${resultList[x].applyDate}' var='applyDate' pattern='yyyy-mm-dd'/>
			<fmt:formatDate value='${applyDate}' pattern="yyyy년mm월dd일"/>	
          </td>
          <td>${resultList[x].hit}</td>
        </tr>
     </c:forEach>
     </c:if>
	<c:if test="${fn:length(resultList) == 0}" >
	<tr><td colspan="5">데이터가 없습니다</td></tr>
	</c:if>
    </tbody>
</table>
<ol class="paging">
<c:if test="${fn:length(resultList) > 0}" >
${pageNav}
</c:if>
</ol>
<div class="board_btn_set send_mg"> <span class="register"><a href="/health/application/writePage.do?applyCode=${param.applyCode}&amp;petiGubun=${param.petiGubun}&amp;categoryId=${param.categoryId}">등록하기</a></span> </div>


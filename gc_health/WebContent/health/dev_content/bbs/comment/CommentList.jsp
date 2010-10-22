<%@page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>
function chkInput(){
	if( commentFrm.content.value.length == 0 ){
		alert( "댓글이 입력되지 않았습니다. 댓글을 입력하세요." );
		commentFrm.content.focus();
		return false;
	}
	else if( commentFrm.content.value.length > 200 ){
		alert( "댓글은 200자 이내로 입력해야 합니다." );
		commentFrm.content.focus();
		return false;
	}
	else{
		return true;
	}
}

function commentDel(seq){
	if(confirm('삭제 하시겠습니까?')){
		document.commentFrm2.seq.value = seq;
		return true;
	}
	
	return false;
}
</script>
<form name="commentFrm" method="post" action="/health/comment/insertCommentArticle.do" onSubmit="return chkInput();">
<input type="hidden" name="categoryId" value="<c:out value='${param.categoryId}'/>" />
<input type="hidden" name="bbsId" value="<c:out value='${param.bbsId}'/>" />
<input type="hidden" name="nttId" value="<c:out value='${param.nttId}'/>" />
<table class="default_write" summary="의견쓰기">
	<caption>의견쓰기</caption>
	<colgroup>
		<col width="15%" />
		<col width="*" />
		<col width="15%" />
		<col width="30%" />
		<col width="7%" />
	</colgroup>
	<tbody>
		<tr>
			<th class="bg"><label for="cont">댓글입력</label></th>
			<td class="bg" colspan="3">
				<textarea id="cont" name="content" rows="2" cols="50" style="width:98%;"></textarea>
			</td>
			<td class="bg" >*200자이내<br /><input type="image" class="vam" src="/health/open_content/images/btn/btn_ok.gif" alt="확인" /></td>
		</tr>
	</tbody>
</table>
</form>
<br/>
<br/>
<form name="commentFrm2" method="post" action="/healt/comment/deleteCommentArticle.do">
<input type="hidden" name="categoryId" value="<c:out value='${param.categoryId}'/>" />
<input type="hidden" name="bbsId" value="<c:out value='${param.bbsId}'/>" />
<input type="hidden" name="nttId" value="<c:out value='${param.nttId}'/>" />
<input type="hidden" name="seq" value="" />
<table class="default_list" summary="토론 참여 의견 목록 테이블입니다">
		<caption>토론 참여 의견</caption>
		<colgroup>
			<col width="8%" />
			<col width="*" />
			<col width="20%" />
			<col width="15%" />
			<col width="7%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col" class="fir">번호</th>
				<th scope="col">내용</th>
				<th scope="col">작성자</th>
				<th scope="col">입력일자</th>
				<th scope="col">삭제</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="comment" items="${commentList}" varStatus="status">
		<tr>
			<td>${status.count}</td>
			<td class="tal">${comment.content}</td>
			<td>${comment.name}</td>
			<td><fmt:parseDate value='${comment.regDate}' var='rdate' pattern='yyyy-mm-dd'/>
		<fmt:formatDate value='${rdate}' pattern="yyyy년mm월dd일"/></td>
			<td>
		<c:if test="${comment.id == company.id}">
			<a href="/health/comment/deleteCommentArticle.do?seq=${comment.seq}&amp;bbsId=${param.bbsId}&amp;nttId=${param.nttId}&amp;categoryId=${param.categoryId}"><img src="/health/open_content/images/btn/btn_delcomment.gif" alt="삭제하기"/></a>
		</c:if>
			</td>
		</tr>
	</c:forEach>
	<c:if test="${fn:length(commentList) == 0}">
		<tr><td colspan="5">데이터가 없습니다.</td></tr>	
	</c:if>
	</tbody>
</table>
</form>
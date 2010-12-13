<%@page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>
function chkInput(){
	if( commentFrm.cont.value.length == 0 ){
		alert( "댓글이 입력되지 않았습니다. 댓글을 입력하세요." );
		commentFrm.cont.focus();
		return false;
	}
	else if( commentFrm.cont.value.length > 200 ){
		alert( "댓글은 200자 이내로 입력해야 합니다." );
		commentFrm.cont.focus();
		return false;
	}
	else{
		return true;
	}
}

function commentDel(seq){
	var oDelRe = document.commentFrm2.delRe;
	
	if( "ADMIN" == "<c:out value='${userGubun}'/>" ){
		if( oDelRe.length != undefined && oDelRe.length > 1 ){
			for( i=0; i<oDelRe.length; i++ ){
				if( oDelRe[i].commentSeq == seq && oDelRe[i].value == "" ){
					alert( "삭제사유가 입력되지 않았습니다. 삭제사유를 입력하세요." );
					oDelRe[i].focus();
					return false;
				}
			}
		}
		else{
			if( oDelRe.value == "" ){
				alert( "삭제사유가 입력되지 않았습니다. 삭제사유를 입력하세요." );
				oDelRe.focus();
				return false;
			}
		}
	}


	if(confirm('삭제 하시겠습니까?')){
		document.commentFrm2.seq.value = seq;
		return true;
	}
	
	return false;
}
</script>

<c:if test="${userGubun != 'ADMIN'}">
<form name="commentFrm" method="post" action="/tour/comment/insertCommentArticle.do" onSubmit="return chkInput();">
<input type="hidden" name="contentsDvCo" value="<c:out value='${param.contentsDvCo}'/>" />
<input type="hidden" name="menuId" value="<c:out value='${param.menuId}'/>" />
<input type="hidden" name="tour" value="<c:out value='${param.tour}'/>" />
<input type="hidden" name="menuNo" value="<c:out value='${param.menuNo}'/>" />
<input type="hidden" name="contentsCo" value="<c:out value='${param.contentsCo}'/>" />
<input type="hidden" name="sbCode" value="<c:out value='${param.sbCode}'/>" />
<table class="board_write" summary="의견쓰기">
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
			<td class="bg" >*200자이내<br /><input type="image" class="vam" src="/tour/open_content/images/common/btn/btn_ok.gif" alt="확인" /></td>
		</tr>
	</tbody>
</table>
</form>
</c:if>

<form name="commentFrm2" method="post" action="<c:if test="${userGubun == 'ADMIN'}">/admin</c:if>/tour/comment/deleteCommentArticle.do">
<input type="hidden" name="contentsDvCo" value="<c:out value='${param.contentsDvCo}'/>" />
<input type="hidden" name="menuId" value="<c:out value='${param.menuId}'/>" />
<input type="hidden" name="tour" value="<c:out value='${param.tour}'/>" />
<input type="hidden" name="menuNo" value="<c:out value='${param.menuNo}'/>" />
<input type="hidden" name="contentsCo" value="<c:out value='${param.contentsCo}'/>" />
<input type="hidden" name="sbCode" value="<c:out value='${param.sbCode}'/>" />
<input type="hidden" name="seq" value="" />
<c:forEach var="result" items="${resultList}" varStatus="status">
<div class="comment_view">
	<dl>
		<dt><c:out value="${result.writeId}"/></dt>
		<dd><c:out value="${result.content}"/></dd>
	</dl>
	<c:if test="${result.status == '1' || userGubun == 'ADMIN'}">
	<div class="pos">
		<c:if test="${userGubun == 'ADMIN'}">
			 등록상태 : ${result.regSt}&nbsp;&nbsp;&nbsp;삭제사유
			 <c:choose>
			 	<c:when test="${result.delRe != null && result.delRe != ''}">
			 		: ${result.delRe}
			 	</c:when>
			 	<c:otherwise>
			 		<input type="text" name="delRe" id="delRe" class="txt_w" commentSeq="${result.seq}" style="width:50%;height:14px" maxlength="100" />
			 	</c:otherwise>
			 </c:choose>
		</c:if>
		<c:if test="${result.regSt == 'C'}">
			<input type="image" class="vam" src="/tour/open_content/images/common/btn/btn_delcomment.gif" alt="삭제하기" onClick="return commentDel('${result.seq}'); return false;"/>
		</c:if>
		<c:if test="${userGubun == 'ADMIN' && result.regSt != 'C'}">
			<a href="/admin/tour/comment/updateCommentState.do?contentsDvCo=${param.contentsDvCo}&amp;menuId=${param.menuId}&amp;tour=${param.tour}&amp;menuNo=${param.menuNo}&amp;contentsCo=${param.contentsCo}&amp;seq=${result.seq}${sbCodeParam}"><img src="/tour/open_content/images/common/btn/btn_regist_ok.gif" alt="등록승인" /></a>
		</c:if>
	</div>
	</c:if>
</div>
</c:forEach>
</form>
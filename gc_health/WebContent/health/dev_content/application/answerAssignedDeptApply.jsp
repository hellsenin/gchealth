<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>


<%@ include file="/admin/health/application/applyStatus.jsp" %>

<%pageContext.setAttribute("crlf", "\n"); %>
 
<c:set var="action" value="/health/apply/addAssignedDeptAnswer.do" />
<c:if test="${not empty answerList[0]}" >
	<c:set var="action" value="/health/apply/updateAssignedDeptAnswer.do" />
</c:if>	
<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>
<script type="text/javascript">
	function checkAnswerForm(form)
	{			
		var v = new MiyaValidator(form);
	    v.add("answerContent", {
	        required: true
	    });
		result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return false;
		} 
		else
		{
			return true;
		}
	}

</script>
				
<c:set var="answer" value="${answerList[0]}" />
<form name="answerFrm" method="post" action="${action}" onsubmit="return checkAnswerForm(this);">
<input type="hidden" name="userId" value="${user.webMemId}" />
<input type="hidden" name="applyCode" value="${param.applyCode}" />
<input type="hidden" name="petiGubun" value="${param.petiGubun}" />
<input type="hidden" name="answerId" value="${answer.answerId}" />
<input type="hidden" name="applyId" value="${param.applyId}" />
<input type="hidden" name="categoryId" value="${param.categoryId}" />
	<table class="default_write" summary="답변 쓰기 페이지 입니다">
		<caption>답변 쓰기 페이지 입니다</caption>
			<colgroup>
				<col width="20%"/>
				<col width="80%"/>
			</colgroup>
		<tbody>
		<tr>
			<th scope="row">
				<label for="subject">등록일자</label>
			</th>
			<td class="output" colspan="3">
			<c:if test="${empty answer.answerDate}" >
				<jsp:useBean id="today" class="java.util.Date" />
				<fmt:formatDate value='${today}' pattern="yyyy년MM월dd일"/>
			</c:if>	
			<c:if test="${not empty answer.answerDate}" >						
				<fmt:parseDate value='${answer.answerDate}' var='answerDate' pattern='yyyy-mm-dd'/>
				<fmt:formatDate value='${answerDate}' pattern="yyyy년mm월dd일"/>	
			</c:if>							
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="writecontents">답변</label></th>
			<td colspan="3" class="output">								
				<textarea name="answerContent" id="writecontents" cols="50" rows="10" style="width:90%;">${answer.answerContent}</textarea>
			</td>
		</tr>
		</tbody>
	</table>
	

<div class="board_btn_set mt13">
	<c:if test="${empty answerList[0]}">
					<span class="btn_del"><input type="submit" value="등록하기" /></span>
	</c:if>
	<c:if test="${not empty answerList[0]}">
					<span class="btn_del"><input type="submit" value="수정하기" /></span>
	</c:if>	
</div><!-- btn end -->
</form>

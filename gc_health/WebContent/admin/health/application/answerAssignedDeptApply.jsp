<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>


<%@ include file="/admin/health/application/applyStatus.jsp" %>

<%pageContext.setAttribute("crlf", "\n"); %>
 
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

	function addAssignedDeptAnswer()
	{
		var form = document.answerFrm;
		if(checkAnswerForm(form))
		{
			form.action = "/admin/health/apply/addAssignedDeptAnswer.do";
			form.submit();
		}
			
	}

	function updateAssignedDeptAnswer()
	{
		var form = document.answerFrm;
		if(checkAnswerForm(form))
		{
			form.action = "/admin/health/apply/updateAssignedDeptAnswer.do";
			form.submit();
		}
	}

	function selectOfficer() 
	{
		var url = "/admin/health/apply/selectOfficerList.do";
		var param = "&deptId="+$F("deptId");  
		sendRequest(callbackSelectOfficer, param, 'POST', url, true, true);
	}

	function callbackSelectOfficer(oj)
	{
	    try 
	    {
	    	var jsonData = oj.responseText;
	        var j = eval('(' + jsonData + ')');
	        var userIdData = j.userId.split("|");;
	        var userNameData = j.userName.split("|");;
	        var selectObj = $("userId");
			selectObj.innerHTML = "";
		  	var opt = document.createElement("OPTION");
		  	selectObj.options.add(opt);
		  	opt.innerText = "담당자를 선택하세요";
		  	opt.value = "";
	        
	        for(i=0;i<userIdData.length;i++)
	        {
	        	var opt = document.createElement("OPTION");
	        	selectObj.options.add(opt);
	        	opt.innerText = userNameData[i];
	        	opt.value = userIdData[i];
	        }
	    } 
	    catch (err)
	    {
	        alert("FUNCTION : callbackSelectOfficer() " + err.description);
	    }
	}
		
</script>
				
	 		<c:set var="answer" value="${answerList[0]}" />
	 		<c:if test="${empty answer}">
	 			<c:set var="deptId" value="${adminUser.dept_id}" />
	 			<c:set var="deptName" value="${adminUser.dept_name}" />
	 			<c:set var="userId" value="${adminUser.id}" />
	 			<c:set var="userName" value="${adminUser.name}" />
	 			<c:set var="tel" value="${adminUser.tel}" />
	 			<c:set var="email" value="${adminUser.email}" />
	 		</c:if>
	 		<c:if test="${not empty answer}">
	 			<c:set var="deptId" value="${answer.deptId}" />
	 			<c:set var="deptName" value="${answer.deptName}" />
	 			<c:set var="userId" value="${answer.userId}" />
	 			<c:set var="userName" value="${answer.userName}" />
	 			<c:set var="tel" value="${answer.tel}" />
	 			<c:set var="email" value="${answer.email}" />
	 		</c:if>
				<form name="answerFrm" method="post">
				<input type="hidden" name="applyCode" value="${param.applyCode}" />
				<input type="hidden" name="petiGubun" value="${param.petiGubun}" />
				<input type="hidden" name="answerId" value="${answer.answerId}" />
				<input type="hidden" name="applyId" value="${param.applyId}" />
					<table class="default_write" summary="구청장에게 바란다 쓰기 페이지 입니다">
						<caption>구청장에게 바란다 쓰기</caption>
							<colgroup>
								<col width="20%"/>
								<col width="30%"/>
								<col width="20%"/>
								<col width="30%"/>
							</colgroup>
						<tbody>
						<tr>
							<th scope="row">
								<label for="subject">처리일자</label>
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
						<tr>
							<th scope="row">담당부서</th>
							<td class="output">${deptName}<input type="hidden" name="deptId" value="${deptId}" />	</td>
							<th scope="row">담당자</th>
							<td class="output">${userName}<input type="hidden" name="userId" value="${userId}" /></td>
						</tr>
						<tr>
							<th scope="row">전화번호</th>
							<td class="output">${tel}</td>
							<th scope="row">E-mail</th>
							<td class="output">${email}</td>
						</tr>
						</tbody>
					</table>
					

				<div class="board_btn_set mt13">
					<c:if test="${empty answer}">
						<span class="btn_del"><a href="javascript:addAssignedDeptAnswer();">답변등록</a></span>
					</c:if>
					<c:if test="${not empty answer}">
						<span class="btn_del"><a href="javascript:updateAssignedDeptAnswer();">답변수정</a></span>
					</c:if>	
				</div><!-- btn end -->
				</form>

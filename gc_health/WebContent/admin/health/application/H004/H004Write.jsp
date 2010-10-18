<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ include file="/admin/health/application/applyStatus.jsp" %>

<c:set var="action" value="/admin/health/application/multiApply.do" />
<c:if test="${not empty result}" >
	<c:set var="action" value="/admin/health/application/multiModify.do" />
</c:if>	

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>금천시 보건소</title>
<link href="/health/open_content/system/css/default.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/common.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/blue.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_blue.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="/health/open_content/system/js/prototype.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/util.js"></script>
<script type="text/javascript" src="/js/egovframework/cmm/sym/zip/EgovZipPopup.js" ></script>

<script type="text/javascript">
	function checkForm()
	{			
		var form = $("frm");
		var v = new MiyaValidator(form);
	    v.add("email_E", {
	        required: true,
	        span: 2,
	        glue: "@",
			option: "email"
	    });
	    v.add("tel_U", {
	        span: 3,
            glue: "-",
	        option: "phone"
	    });
	    v.add("cellPhone_U", {
	        required: true,
	        span: 3,
            glue: "-",
	        option: "handphone"
	    });
	    v.add("zipcode_U", {
	        required: true,
            span: 2,
            glue: "-",
	        option: "zip"
	    });
	    v.add("addr1", {
	        required: true
	    });
		result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		} 
		else
		{
			form.submit();
		}
	}

	function changeStatus()
	{
		var url = "/admin/health/apply/changeStatus.do";
		var param="&applyCode="+$F("applyCode")+"&applyId="+$F("applyId")+"&status="+$F("status");
		sendRequest(callbackChangeStatus, param, 'POST', url, true, true);
	}

	function callbackChangeStatus(oj)
	{
		try 
		{
			var jsonData = oj.responseText;
			var j = eval('(' + jsonData + ')');
			var code = j.resultCode;
			if(code == "1")
			{
				 alert("성공적으로 변경되었습니다.");
			}
			else if(code == "0")
			{
				 alert("알수없는 오류입니다.");
			}
		}	
		catch (err) 
		{
			alert("FUNCTION : callbackChangeStatus() " + err.description);
		}
	}
</script>

</head>
<body style="background:none;padding:10px;">
<h3 class="tit_03">청소년유해업소신고</h3>
<form id="frm" name="frm" enctype="multipart/form-data" method="post" onsubmit="return checkForm(this);" action="${action}">
	<input type="hidden" name="applyCode" value="${param.applyCode}" />
	<input type="hidden" name="applyId" value="${param.applyId}" />
	
			<jsp:include page="/admin/health/application/userInfoWrite.jsp" flush="true" />
						
				<table class="default_write" summary="글 내용을 등록합니다. 내용을 쓰신 후 저장버튼을 클릭해주세요." cellspacing="1" cellpadding="0">
					<caption>글쓰기</caption>
					<col />
					<col style="width:85%;" />
					<tbody>
					<tr>
						<th scope="row">업소명</th>
						<td class="subject" >
							<input type="text" id="etc1" name="etc1" class="intext" style="width:203px;" value="${result.etc1}" />
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="address2">위반일</label></th>
						<td class="subject" >
							<input type="text" id="etc2" name="etc2" class="intext" style="width:203px;" value="${result.etc2}" /></td>
					</tr>
					<tr>
						<th scope="row"><label for="address2">첨부파일</label></th>
						<td class="subject" >
		 				<c:forEach var="file" items="${fileList}" varStatus="status">
						<a href="/health/apply/fileDown.do?fileId=${file.fileId}">${file.orgFileName}</a><label for="${file.fileId}"><input name="fileId" type="checkbox" value="${file.fileId}" id="${file.fileId}" />삭제하기</label><br/>
		 				</c:forEach>
							<input type="file" name="file1" title="첫번째첨부파일" class="infile" size="25" style="width:400px;" /><br/>
							<input type="file" name="file2" title="첫번째첨부파일" class="infile" size="25" style="width:400px;" /><br/>
							<input type="file" name="file3" title="첫번째첨부파일" class="infile" size="25" style="width:400px;" />
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="address2">신고내용</label></th>
						<td class="subject" >
						<textarea id="etcContents1" name="etcContents1" cols="100" rows="10" class="intextarea"  style="width:600px;">${result.etcContents1}</textarea>
					
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="address2">처리결과회신</label></th>
						<td class="subject" >
							<input type="checkbox" id="smsFlag" name="smsFlag" value="Y" <c:if test="${result.smsFlag == 'Y'}">checked</c:if> />
						</td>
					</tr>
					</tbody>
				</table>
			
			<div class="board_btn_set mt13">
				<span class="btn_del"><a href="javascript:checkForm();">수정하기</a></span>
				<span class="btn_list"><a href="/admin/health/application/selectApplicationList.do?applyCode=${param.applyCode}">목록보기</a></span>
			</div>

	</form>
	<!--// [ Content End ] -->
	<br/>
	<table class="default_write" summary="글 내용을 등록합니다. 내용을 쓰신 후 저장버튼을 클릭해주세요." cellspacing="1" cellpadding="0">
		<caption>글쓰기</caption>
		<col />
		<col style="width:85%;" />
		<tbody> 
		<tr>
	      <th scope="row"><label for="smsFlag">처리상태</label></th>
	      <td colspan="3">
			<c:choose>
			<c:when test="${result.delFlag == 'Y'}">삭제</c:when>
			<c:otherwise>
			<select name="status" id="status">
				<option value="">선택</option>
				<option value="${RECEIPT_WAITING}" <c:if test="${result.status == RECEIPT_WAITING}">selected</c:if>>접수대기</option>
				<option value="${COMPLETION}" <c:if test="${result.status == COMPLETION}">selected</c:if>>완료</option>
			</select>
			<input type="button" id="btn" value="변경" onclick="changeStatus();" />
			</c:otherwise>
			</c:choose>
		</td>
	    </tr>
		</tbody>
	</table>
</body>
</html>
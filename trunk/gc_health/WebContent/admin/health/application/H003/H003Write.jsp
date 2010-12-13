<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ include file="/admin/health/application/applyStatus.jsp" %>

<c:set var="action" value="/admin/health/application/apply.do" />
<c:if test="${not empty result}" >
	<c:set var="action" value="/admin/health/application/modify.do" />
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
<script type="text/javascript" src="/health/open_content/system/js/jslb_ajax.js"></script>
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
<h3 class="tit_03">전염병신고센터</h3>

<form id="frm" name="frm" method="post" action="${action}">
	<input type="hidden" name="applyCode" value="${param.applyCode}" />
	<input type="hidden" name="applyId" value="${param.applyId}" />
	<div id="board_form" style="width:770px;margin:0 0 0 10px;">
			
			<jsp:include page="/admin/health/application/userInfoWrite.jsp" flush="true" />
						
				<table class="default_write" summary="글 내용을 등록합니다. 내용을 쓰신 후 저장버튼을 클릭해주세요." cellspacing="1" cellpadding="0">
					<caption>신고내용</caption>
					<col />
					<col style="width:85%;" />
					<tbody>
				    <tr>
				      <th width="20%" scope="row"><label for="etc1">신고인</label></th>
				      <td width="85%" colspan="3"><input type="text" id="etc1" name="etc1" value="${result.etc1}" style="width:400px" class="txt" /></td>
				    </tr>
				    <tr>
				      <th scope="row"><label for="sr_contents">신고내용</label></th>
				      <td colspan="3">
				      	<textarea rows="5" cols="50" id="sr_contents" name="etcContents1"  onkeydown="textCounter(this.form.etcContents1,this.form.remLen,800);" onkeyup="textCounter(this.form.etcContents1,this.form.remLen,800);" onmousedown="this.onkeydown();" onmouseup="this.onkeyup();">${result.etcContents1}</textarea>
				      	<input type="text" name="remLen" id="remLen" value="800" class="board1 vamb" style="width:30px;" readonly="readonly" /> 자남음
				      </td>
				    </tr>
				    <tr>
				      <th scope="row"><label for="file1">첨부파일</label></th>
				      <td colspan="3">
		 				<c:forEach var="file" items="${fileList}" varStatus="status">
						<a href="/health/apply/fileDown.do?fileId=${file.fileId}">${file.orgFileName}</a><label for="${file.fileId}"><input name="fileId" type="checkbox" value="${file.fileId}" id="${file.fileId}" />삭제하기</label><br/>
		 				</c:forEach>
				      	<input type="file" name="file1" /><br/>
				      	<input type="file" name="file2" /><br/>
				      	<input type="file" name="file3" /><br/>
				      	※ 첨부파일은 이미지 및 문서 파일만 등록하세요 (최대용량 5MB / 최대 3개까지 등록 가능)
				      </td>
				    </tr>
				    <tr>
				      <th scope="row"><label for="etc2_1">전화번호</label></th>
				      <td colspan="3">
						<c:set var="_etc2" value="${fn:split(result.etc2, '-')}"/>
				        <input type="text" id="etc2_1" name="etc2_U" value="${_etc2[0]}" style="width:30px" class="txt"/>
				        - <input type="text" id="etc2_2" name="etc2_U" value="${_etc2[1]}" style="width:30px" class="txt"/> 
				        - <input type="text" id="etc2_3" name="etc2_U" value="${_etc2[2]}" style="width:27px" class="txt"/>   
				      </td>
				    </tr>
				    
				    <tr>
				      <th rowspan="2" scope="row"><label for="etc6_1">주소</label></th>
				      <td colspan="3">
						<c:set var="_etc3" value="${fn:split(result.etc3, '-')}"/>
				        <input type="text" id="etc3_1" name="etc3_U" value="${_etc3[0]}" style="width:50px" class="txt"/>
				-
				<input type="text" id="etc3_2" name="etc3_U" value="${_etc3[1]}" style="width:50px" class="txt" />
				<a href="/health/dev_content/zipcode/GC_member_zipcode.jsp?code1=etc3_1&amp;code2=etc3_2&amp;code3=etc4" onclick="window.open(this.href,'','width=400,height=400,location=no,toolbar=no,menubar=no,status=no,scrollbars=no,resizable=yes');return false;" onkeypress="if(event.keyCode==13) {this.onclick(); return false;}" title="우편번호검색 팝업"><img src="/health/open_content/images/btn/btn_s_zipcode.gif" alt="우편번호" align="absmiddle" /></a></td>
				    </tr>
				    <tr>
				      <td colspan="3"><input type="text" id="etc4" name="etc4" value="${result.etc4}" style="width:200px" class="txt"/> 
				      <input type="text" id="etc5" name="etc5" value="${result.etc5}" style="width:200px" class="txt"/></td>
				    </tr>
				    <tr>
				      <th scope="row"><label for="smsFlag">처리결과 회신</label></th>
				      <td colspan="3">
				          <input type="checkbox" name="smsFlag" id="smsFlag" value="Y" <c:if test="${result.smsFlag == 'Y'}">checked</c:if> />
				      민원 처리결과 핸드폰 회신 동의</td>
				    </tr>
					</tbody>
				</table>
			</div>
			
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
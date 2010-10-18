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

<!-- 
<script type="text/javascript" src="/health/open_content/system/js/jquery-1.2.1.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/jquery.form.js"></script> -->
<script type="text/javascript" src="/health/open_content/system/js/jslb_ajax.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/prototype.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>
<script type="text/javascript">
	function checkForm()
	{			
		var form = $("#frm")[0];
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
	    v.add("etc1", {
	        required: true
	    });
	    v.add("etc2", {
	        required: true
	    });
	    v.add("etc3_U", {
	        required: true,
	        span: 2,
	        glue: "-",
	        option: "jumin"
	    });
	    v.add("etc5_U", {
	        required: true,
	        span: 3,
	        glue: "-",
	        option: "phone"
	    });
	    v.add("etc6_U", {
	        required: true,
	        span: 2,
	        glue: "-",
	        option: "zipcode"
	    });
	    v.add("etc7", {
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
/*
	$(function(){
		$('#btn').click(function(){
			var option = {
				url: '/admin/health/apply/changeStatus.do',
				dataType: 'json',
				beforeSubmit: function(data, set, options){
					if(!$('#status').val())
					{
						alert("상태값을 선택하세요.");
						return;
					}
				},
				success: 
					function(data){
					if(data.resultCode == '1') alert("성공적으로 변경되었습니다.");
					else alert('알수없는 오류입니다.');
				}
			} 
			$('#frm').ajaxSubmit(option);
		});
	});
*/	
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
<h3 class="tit_03">모범업소지정신청</h3>
<form id="frm" name="frm" method="post" action="${action}">
	<input type="hidden" name="applyCode" value="${param.applyCode}" />
	<input type="hidden" id="applyId" name="applyId" value="${param.applyId}" />
				
			<jsp:include page="/admin/health/application/userInfoWrite.jsp" flush="true" />
					
				<table class="default_write" summary="글 내용을 등록합니다. 내용을 쓰신 후 저장버튼을 클릭해주세요." cellspacing="1" cellpadding="0">
					<caption>글쓰기</caption>
					<col />
					<col style="width:85%;" />
					<tbody>
    <tr>
      <th width="20%" scope="row"><label for="etc1">업소 및 기관명(*)</label></th>
      <td width="85%" colspan="3"><input type="text" id="etc1" name="etc1" value="${result.etc1}" style="width:400px" class="txt" /></td>
    </tr>
    <tr>
      <th scope="row"><label for="etc2">대표자명(*)</label></th>
      <td colspan="3"><input type="text" id="etc2" name="etc2" value="${result.etc2}" style="width:200px" class="txt" /></td>
    </tr>
    <tr>
      <th scope="row"><label for="etc3_1">대표자 주민번호(*)</label></th>
      <td colspan="3">
		<c:set var="_etc3" value="${fn:split(result.etc3, '-')}"/>
      <input type="text" id="etc3_1" name="etc3_U" value="${_etc3[0]}" style="width:50px" class="txt" maxlength="6"/> - <input type="password" id="etc3_2" name="etc3_U" value="${_etc3[1]}" style="width:50px" class="txt"  maxlength="7"/></td>
    </tr>
    <tr>
      <th scope="row"><label for="etc4">영업형태</label></th>
      <td colspan="3">
        <input type="text" id="etc4" name="etc4" value="${result.etc4}" style="width:200px" class="txt" />
      </td>
    </tr>
    <tr>
      <th scope="row"><label for="etc5_1">전화번호(*)</label></th>
      <td colspan="3">
		<c:set var="_etc5" value="${fn:split(result.etc5, '-')}"/>
        <input type="text" id="etc5_1" name="etc5_U" value="${_etc5[0]}" style="width:30px" class="txt" maxlength="4"/>
        - <input type="text" id="etc5_2" name="etc5_U" value="${_etc5[1]}" style="width:30px" class="txt" maxlength="4"/> 
        - <input type="text" id="etc5_3" name="etc5_U" value="${_etc5[2]}" style="width:27px" class="txt" maxlength="4"/>   
      </td>
    </tr>
    
    <tr>
      <th rowspan="2" scope="row"><label for="etc6_1">업소 소재지(*)</label></th>
      <td colspan="3">
		<c:set var="_etc6" value="${fn:split(result.etc6, '-')}"/>
        <input type="text" id="etc6_1" name="etc6_U" value="${_etc6[0]}" style="width:50px" class="txt" maxlength="3"/>
-
<input type="text" id="etc6_2" name="etc6_U" value="${_etc6[1]}" style="width:50px" class="txt" maxlength="3" />
<a href="/health/dev_content/zipcode/GC_member_zipcode.jsp?code1=etc6_1&amp;code2=etc6_2&amp;code3=etc7" onclick="window.open(this.href,'','width=400,height=400,location=no,toolbar=no,menubar=no,status=no,scrollbars=no,resizable=yes');return false;" onkeypress="if(event.keyCode==13) {this.onclick(); return false;}" title="우편번호검색 팝업"><img src="/health/open_content/images/btn/btn_s_zipcode.gif" alt="우편번호" align="absmiddle" /></a></td>
    </tr>
    <tr>
      <td colspan="3"><input type="text" id="etc7" name="etc7" value="${result.etc7}" style="width:200px" class="txt"/> <input type="text" id="etc8" name="etc8" value="${result.etc8}" style="width:200px" class="txt"/></td>
    </tr>
    <tr>
      <th scope="row"><label for="etc9">음식물 종류</label></th>
      <td colspan="3"><input type="text" id="etc9" name="etc9" value="${result.etc9}" style="width:500px" class="txt"/></td>
    </tr>
    <tr>
      <th scope="row"><label for="smsFlag">처리결과 회신</label></th>
      <td colspan="3">
          <input type="checkbox" name="smsFlag" id="smsFlag" value="Y" <c:if test="${result.smsFlag == 'Y'}">checked</c:if> />
      민원 처리결과 핸드폰 회신 동의</td>
    </tr>
					</tbody>
				</table>
			
			<div class="board_btn_set mt13">
				<span class="btn_del"><a href="javascript:checkForm();">${empty result ? '등록' : '수정'}하기</a></span>
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
	<br/>
		<c:if test="${not empty result && applyMst.replyYn == 'Y'}">
			<jsp:include page="/admin/health/application/answerAssignedDeptApply.jsp" flush="true" />
		</c:if>
					
</body>
</html>
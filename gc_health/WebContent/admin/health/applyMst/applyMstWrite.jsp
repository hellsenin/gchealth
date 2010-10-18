<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="action" value="/admin/health/applyMst/addApplyMst.do" />
<c:if test="${not empty result}" >
	<c:set var="action" value="/admin/health/applyMst/modifyApplyMst.do" />
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
<script type="text/javascript">
	function checkForm()
	{			
		var form = $("frm");
		var v = new MiyaValidator(form);
	    v.add("applyName", {
	        required: true
	    });
	    v.add("applyAttrb", {
	        required: true
	    });
	    v.add("replyYn", {
	        required: true
	    });
	    v.add("fileAttatchYn", {
	        required: true
	    });
	    v.add("useYn", {
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

</script>

</head>
<body style="background:none;padding:10px;">
<h3 class="tit_03">신청마스터</h3>
<form id="frm" name="frm" method="post" onsubmit="return checkForm(this);" action="${action}">
					
				<table class="default_write" summary="글 내용을 등록합니다. 내용을 쓰신 후 저장버튼을 클릭해주세요." cellspacing="1" cellpadding="0">
					<caption>글쓰기</caption>
					<col />
					<col style="width:85%;" />
					<tbody>
<c:if test="${not empty result}">
    <tr>
      <th width="20%" scope="row"><label for="etc1">신청코드</label></th>
      <td width="85%" colspan="3">
      	${result.applyCode}
		<input type="hidden" name="applyCode" value="${result.applyCode}" />
	</td>
    </tr>
</c:if>
    <tr>
      <th width="20%" scope="row"><label for="etc1">신청명</label></th>
      <td width="85%" colspan="3"><input type="text" id="applyName" name="applyName" value="${result.applyName}" style="width:400px" class="txt" /></td>
    </tr>
    <tr>
      <th scope="row"><label for="applyAttrb">신청유형</label></th>
      <td colspan="3">
			<select id="applyAttrb" name="applyAttrb" >
				<option value="">선택</option>
				<option value="1" <c:if test="${result.applyAttrb == '1'}">selected</c:if>>일반신청</option>
				<option value="2" <c:if test="${result.applyAttrb == '2'}">selected</c:if>>교육신청</option>
			</select>
      </td>
    </tr>
    <tr>
      <th scope="row"><label for="applyDesc">신청상세</label></th>
      <td colspan="3">
      	<textarea rows="5" cols="50" id="applyDesc" name="applyDesc" onkeydown="textCounter(this.form.applyDesc,this.form.remLen,800);" onkeyup="textCounter(this.form.applyDesc,this.form.remLen,800);" onmousedown="this.onkeydown();" onmouseup="this.onkeyup();">${result.applyDesc}</textarea>
      	<input type="text" name="remLen" id="remLen" value="800" class="board1 vamb" style="width:30px;" readonly="readonly" /> 자남음
	  </td>
    </tr>
    <tr>
      <th scope="row"><label for="replyYn1">답글유무</label></th>
      <td colspan="3">
        <input type="radio" name="replyYn" id="replyYn1" value="Y" <c:if test="${result.replyYn == 'Y'}">checked</c:if> /> 사용
        <input type="radio" name="replyYn" id="replyYn2" value="N" <c:if test="${result.replyYn == 'N'}">checked</c:if> /> 미사용
      </td>
    </tr>
    <tr>
      <th scope="row"><label for="fileAttatchYn1">파일첨부유무</label></th>
      <td colspan="3">
        <input type="radio" name="fileAttatchYn" id="fileAttatchYn1" value="Y" <c:if test="${result.fileAttatchYn == 'Y'}">checked</c:if> /> 첨부
        <input type="radio" name="fileAttatchYn" id="fileAttatchYn2" value="N" <c:if test="${result.fileAttatchYn == 'N'}">checked</c:if> /> 미첨부
      </td>
    </tr>
    <tr>
      <th scope="row"><label for="useYn1">사용유무</label></th>
      <td colspan="3">
        <input type="radio" name="useYn" id="useYn1" value="Y" <c:if test="${result.replyYn == 'Y'}">checked</c:if> /> 사용
        <input type="radio" name="useYn" id="useYn2" value="N" <c:if test="${result.replyYn == 'N'}">checked</c:if> /> 미사용
      </td>
    </tr>
    
					</tbody>
				</table>
			
			<div class="board_btn_set mt13">
				<span class="btn_del"><a href="javascript:checkForm();">${empty result ? '등록' : '수정'}하기</a></span>
				<span class="btn_list"><a href="/admin/health/applyMst/selectApplyMstList.do">목록보기</a></span>
			</div>

	</form>
					
</body>
</html>
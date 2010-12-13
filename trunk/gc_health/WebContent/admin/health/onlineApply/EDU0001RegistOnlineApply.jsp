<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="action" value="/admin/health/onlineApply/registOnlineApply.do" />
<c:if test="${not empty result}" >
	<c:set var="action" value="/admin/health/onlineApply/modifyOnlineApply.do" />
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

<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/Calendar.js"></script>
<script type="text/javascript">
	function checkForm(form)
	{				
		var v = new MiyaValidator(form);
	    v.add("title", {
	        required: true
	    });
	    v.add("receiptSdate", {
	        required: true
	    });
	    v.add("receiptEdate", {
	        required: true
	    });
	    v.add("eduSdate", {
	        required: true
	    });
	    v.add("appInwon", {
	        required: true,
	        option: "number"      
	    });
	    v.add("dupYn", {
	        required: true    
	    });
	    v.add("content", {
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
</head>
<body style="background:none;padding:10px;">
<h2 style="padding:15px 0 15px 0;">	
		응급처치교육신청
</h2>
<p class="title_deco"></p>
<div class="body">
			<form name="frm" method="post" action="${action}" onsubmit="return checkForm(this);">
			<input type="hidden" name="onlineId" value="${param.onlineId}" />
			<input type="hidden" name="applyCode" value="${param.applyCode}" />
					<table class="default_write">
						<caption>응급처치교육신청</caption>
						<colgroup>
							<col width="20%" />
							<col width="0%" />
							<col width="50%" />
							<col width="30%" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row">
								<label for="subject">제목(*)</label>
							</th>
							<td class="output" colspan="3">
								<input id="subject" name="title" value="${result.title}" type="text" style="width:90%" class="board1" />
							</td>
						</tr>
						<tr>
							<th scope="row">
								<label for="receiptSdate">신청기간(*)</label>
							</th>
							<td class="output" colspan="3">
								<input type="text" id="receiptSdate" name="receiptSdate" class="board1" value="${result.receiptSdate}" style="width:125px"/><a href="javascript:Calendar_D(frm.receiptSdate)"><img src="/health/open_content/images/calendar.gif" class="vat" alt=""/></a> ~ 
								<input type="text" id="receiptEdate" name="receiptEdate" class="board1" value="${result.receiptEdate}" style="width:125px"/><a href="javascript:Calendar_D(frm.receiptEdate)"><img src="/health/open_content/images/calendar.gif" class="vat" alt=""/></a>
							</td>
						</tr>
						<tr>
							<th scope="row">
								<label for="eduSdate">교육일자(*)</label>
							</th>
							<td class="output" colspan="3">
								<input type="text" id="eduSdate" name="eduSdate" class="board1" value="${result.eduSdate}" style="width:125px"/><a href="javascript:Calendar_D(frm.eduSdate)"><img src="/health/open_content/images/calendar.gif" class="vat" alt=""/></a>
							</td>
						</tr>	
						<tr>
							<th scope="row">
								<label for="eduStime">교육시간(*)</label>
							</th>
							<td class="output" colspan="3">
								<input type="text" id="eduStime" name="eduStime" class="board1" value="${result.eduStime}" style="width:125px"/>
							</td>
						</tr>						
						<tr>
							<th scope="row">
								<label for="appInwon">모집인원(*)</label>
							</th>
							<td class="output" colspan="3">
								<input type="text" id="appInwon" name="appInwon" class="board1" value="${result.appInwon}" style="width:125px" /> 명
							</td>
						</tr>						
						<tr>
							<th scope="row">
								<label for="dupYn">중복신청(*)</label>
							</th>
							<td class="output" colspan="3">
								<input type="radio" id="dupYn" name="dupYn" class="board1" value="Y" ${result.dupYn == 'Y' ? 'checked' : '' } /> 허용
								<input type="radio" id="dupYn" name="dupYn" class="board1" value="N" ${result.dupYn == 'N' ? 'checked' : '' } /> 허용하지않음
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="writecontents">내용</label></th>
							<td colspan="3" class="output">								
								<textarea name="content" id="writecontents" cols="50" rows="10" style="width:90%;">${result.content}</textarea>
							</td>
						</tr>
						</tbody>
					</table>
				
<div class="board_btn_set mt13">

	<span class="btn_del"><input type="submit" value="${empty result ? '등록' : '수정'}하기" /></span>

	<span class="btn_list"><a href="/admin/health/onlineApply/listOnlineApply.do?applyCode=${param.applyCode}">목록보기</a></span>
</div>
			
			</form>
			
</div>
</body>
</html>
			
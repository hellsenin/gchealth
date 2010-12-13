<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="action" value="/admin/health/medicalTeam/addMedicalTeam.do" />
<c:if test="${not empty result}" >
	<c:set var="action" value="/admin/health/medicalTeam/updateMedicalTeam.do" />
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
	    v.add("name", {
	        required: true
	    });
	    v.add("subject", {
	        required: true
	    });
	    v.add("institution", {
	        required: true
	    });
	    v.add("tel", {
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
<h3 class="tit_03">상담의료진 </h3>
<form id="frm" name="frm" enctype="multipart/form-data" method="post" onsubmit="return checkForm(this);" action="${action}">
	<input type="hidden" name="no" value="${param.no}" />
	
				<table class="default_write" summary="글 내용을 등록합니다. 내용을 쓰신 후 저장버튼을 클릭해주세요." cellspacing="1" cellpadding="0">
					<caption>글쓰기</caption>
					<col />
					<col style="width:85%;" />
					<tbody>
					<tr>
						<th scope="row">이름</th>
						<td class="subject" >
							<input type="text" id="name" name="name" class="intext" style="width:203px;" value="${result.name}" />
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="subject">상담진료과목</label></th>
						<td class="subject" >
							<input type="text" id="subject" name="subject" class="intext" style="width:203px;" value="${result.subject}" />
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="institution">의료기관명</label></th>
						<td class="subject" >
							<input type="text" id="institution" name="institution" class="intext" style="width:203px;" value="${result.institution}" />
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="institution">전화번호</label></th>
						<td class="subject" >
							<input type="text" id="tel" name="tel" class="intext" style="width:203px;" value="${result.tel}" />
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="address2">사진</label></th>
						<td class="subject" >
						<c:if test="${not empty result.imgNm}">
						<img src="/health/open_content/images/medicalTeam/${result.imgNm}" /><br/>
						</c:if>
							<input type="file" name="file1" title="첫번째첨부파일" class="infile" size="25" style="width:400px;" />
						</td>
					</tr>
				<c:if test="${not empty result}">
					<tr>
						<th scope="row">URL</th>
						<td class="subject" >
							${result.url}
						</td>
					</tr>
				</c:if>
					</tbody>
				</table>
			
			<div class="board_btn_set mt13">
				<span class="btn_del"><a href="javascript:checkForm();">${empty result ? '등록' : '수정'}하기</a></span>
			<c:if test="${not empty result}">
				<span class="btn_del"><a href="/admin/health/medicalTeam/delMedicalTeam.do?no=${result.no}">삭제하기</a></span>
			</c:if>
				<span class="btn_list"><a href="/admin/health/medicalTeam/selectMedicalTeamList.do">목록보기</a></span>
			</div>

	</form>
	<!--// [ Content End ] -->
</body>
</html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="action" value="/admin/health/infoCustomMade/addCustomMainMenuCategory.do" />
<c:if test="${not empty result}" >
	<c:set var="action" value="/admin/health/infoCustomMade/modifyCustomMainMenuCategory.do" />
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
<script type="text/javascript" src="/js/egovframework/admin/sulmun/Calendar.js"></script>
<script type="text/javascript">
	function checkForm()
	{			
		var form = document.frm;
		var v = new MiyaValidator(form);
	    v.add("categoryNm", {
	        required: true
	    });
	    v.add("categoryOrdr", {
	        required: true,
	        option: "number"
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
<h2 style="padding:15px 0 15px 0;">	
		주요서비스 
</h2>
<p class="title_deco"></p>
<div class="body">

							
			<form name="frm" method="post" action="${action}">
				<input type="hidden" name="cstmId" value="${param.cstmId}" />
				<table summary="글 내용을 등록합니다. 내용을 쓰신 후 저장버튼을 클릭해주세요." class="default_view">
					<colgroup>
						<col width="20%" />
						<col width="80%" />
					</colgroup>
					<tbody>
					<tr>
						<th scope="row"><label for="categoryNm">카테고리이름(*)</label></th>
						<td colspan="3" class="output">
							<input type="text" id="categoryNm" name="categoryNm" value="${result.categoryNm}" class="board1" style="width:90%" />
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="categoryOrdr">순서(*)</label></th>
						<td colspan="3" class="output">
							<input type="text" id="categoryOrdr" name="categoryOrdr" value="${result.categoryOrdr}" class="board1" style="width:150px" />
						</td>
					</tr>
					</tbody>
				</table>

<div class="board_btn_set mt13">
	<span class="btn_del"><a href="javascript:checkForm();">${empty result ? '등록' : '수정'}하기</a></span>

	<span class="btn_list"><a href="/admin/health/infoCustomMade/selectCustomMainMenuCategoryList.do">목록보기</a></span>
</div>
				</form><!-- write form end -->


</div>
</body>
</html>

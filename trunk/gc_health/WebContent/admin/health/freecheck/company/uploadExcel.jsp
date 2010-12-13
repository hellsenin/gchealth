<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	java.util.Calendar cal1 = java.util.Calendar.getInstance();
	int year = cal1.get(java.util.Calendar.YEAR);
	pageContext.setAttribute("year", year);
%>
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
<script type="text/javascript" src="/health/open_content/system/js/util.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/Calendar.js"></script>
<script type="text/javascript">
	function checkForm(form)
	{	
		var v = new MiyaValidator(form);
	    v.add("year_cd", {
	        required: true
	    });
	    v.add("dataFile", {
	        required: true
	    });
	    var result = v.validate();
	    if (!result) {
	        alert(v.getErrorMessage());
	        v.getErrorElement().focus();
			return false;
	    } 
	    else
	    {
		    if(confirm("등록하시겠습니까?"))
		    	return true;
		    else return false;
	    }
	}
</script>
</head>
<body style="background:none;padding:10px;">
<h2 style="padding:15px 0 15px 0;">	
		${param.industry_name} 엑셀등록하기 
</h2>
<p class="title_deco"></p>
<div class="body">

<form name="form1" method="post" enctype="multipart/form-data" action="/admin/freecheck/uploadExcel.do" onsubmit="return checkForm(this);">
	<input type="hidden" name="industry_cd" value="${param.industry_cd}" />
<table width="100%" border="0">
<tr><td height="15"></td></tr>
<tr>
  <td><b>* 업소 엑셀자료 업로드</b></td>
</tr>
<tr>
	<td>
		<input type="checkbox" name="chk" value="Y" /><b>${param.industry_name}하위 데이터 모두 삭제</b><br/>
		<select id="year_cd" name="year_cd">
			<option value="">년도</option>
			<option value='${year}'>${year} 년도</option>
			<option value='${year-1}'>${year-1} 년도</option>
			<option value='${year-2}'>${year-2} 년도</option>
		</select>
		<input type="file" size="30" name="dataFile"/>&nbsp;<input type="submit" value="전송" />
	</td>
</tr>
<tr><td height="5"></td></tr>
<tr>
	<td>
		<font color="red">*반드시 아래샘플과 같은 양식으로 업로드해주세요.</font><br/>
	</td>
</tr>
<tr><td height="5"></td></tr>
<tr><td><a href="/health/main/contentsDownload.do?filename=%EC%97%85%EC%86%8C%EC%83%98%ED%94%8C.xls">업소샘플 다운로드</a></td></tr>
</table>
</form>

<div class="board_btn_set mt13">
	<span class="btn_list"><a href="/admin/freecheck/industry/select.do?industry_cd=${param.industry_cd}&year_cd=${year}">목록보기</a></span>
</div>

</div>
</body>
</html>

				
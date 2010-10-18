<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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

<script>
function setNum(obj) {
    var val=obj.value;
    var re=/[^0-9]/gi;
    obj.value=val.replace(re,"");
};

function checkAndSubmit(f) {

	var v = new MiyaValidator(f);

    v.add("name", {
		required: true
    });
	result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return false;
	} else {
		if (confirm('수정하시겠습니까?')) {
			return true;
		} else {
			return false;
		}
	}
};
</script>
</head>
<body style="background:none;padding:10px;">
<h2 style="padding:15px 0 15px 0;">	
의약업소 자율점검 (업종관리)
</h2>

<p class="title_deco"></p>
<div class="body">
<c:url var="updateUrl" value="/admin/freecheck/industry/update.do">
	<c:param name="industry_cd" value="${result.industry_cd}"/>
	<c:param name="pageIndex" value="${Bean.pageIndex}"/>
	<c:param name="searchCondition" value="${Bean.searchCondition}"/>
	<c:param name="searchKeyword" value="${Bean.searchKeyword}"/>
</c:url>

<form name="fm" method="post" action="${updateUrl}" enctype="multipart/form-data" onsubmit="return checkAndSubmit(this);">
<table summary="의약업소 자율점검 (업종관리) 수정 페이지" class="default_write">
	<caption>의약업소 자율점검 (업종관리) 수정</caption>
	<colgroup>
		<col width="20%" />
		<col width="30%" />
		<col width="20%" />
		<col width="30%" />
	</colgroup>
	<tbody>
		<tr>
			<th scope="row"><label for="divide_cd">업종코드</label></th>
			<td class="output" colspan="3">
				<input type="text" name="divide_cd" id="divide_cd" value="${result.divide_cd}" style="width: 250px; padding-left: 5px;" class="board1"/>
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="name">업종명</label></th>
			<td class="output" colspan="3">
				<input type="text" name="name" id="name" style="width: 250px; padding-left: 5px;" class="board1" value="${result.name}" />
			</td>
		</tr>
		
		<tr>
			<th scope="row"><label for="use_yn">상태</label></th>
			<td class="output" colspan="3">
				<select name="use_yn" id="use_yn" class="select">
					<option value="Y" <c:if test="${result.use_yn == 'Y'}">selected="selected"</c:if>>정상</option>
					<option value="N" <c:if test="${result.use_yn == 'N'}">selected="selected"</c:if>>폐업</option>
				</select>
			</td>
		</tr>
		
		<tr>
			<th scope="row">수정자</th>
			<td class="output">
				${adminUser.name}
			</td>
			<th scope="row">수정일자</th>
			<td class="output">
				<fmt:formatDate value="${CURR_DATE}" pattern="yyyy년MM월dd일"/>
			</td>
		</tr>
		
	</tbody>
</table>

<div class="board_btn_set mt13">
	<span class="btn_del"><input type="submit" value="수정하기" /></span>
	
		<c:url var="listUrl" value="/admin/freecheck/industry/select.do">
			<c:param name="industry_cd" value="${result.industry_cd}"/>
			<c:param name="pageIndex" value="${Bean.pageIndex}"/>
			<c:param name="searchCondition" value="${Bean.searchCondition}"/>
			<c:param name="searchKeyword" value="${Bean.searchKeyword}"/>
			<c:param name="year_cd" value="${Bean.year_cd}"/>
		</c:url>
	<span class="btn_list"><a href="${listUrl}">취소</a></span>
</div>			
</form>

</div>
</body>
</html>

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

<script type="text/javascript" src="/health/open_content/system/js/Calendar.js" ></script>

<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>

<script>

function setNum(obj) {
    var val=obj.value;
    var re=/[^0-9]/gi;
    obj.value=val.replace(re,"");
};

function checkAndSubmit(f) {
	var v = new MiyaValidator(f);

    v.add("type_cd", {
		required: true
    });
    v.add("title", {
		required: true
    });
    v.add("start_dt", {
		required: true
    });
    v.add("end_dt", {
		required: true
    });
    v.add("contents", {
		required: true
    });
    
	result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return false;
	} else {
		if (confirm('등록하시겠습니까?')) {
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
		의약업소 자율점검 (점검표관리)
</h2>
<p class="title_deco"></p>
<div class="body">

<form name="fm" method="post" action="<c:url value='/admin/freecheck/checkform/insert.do'/>" enctype="multipart/form-data" onsubmit="return checkAndSubmit(this);">

	<table summary="자율점검 (점검표관리) 페이지" class="default_write">
		<caption>자율점검 (점검표관리)</caption>
		<colgroup>
			<col width="20%" />
			<col width="30%" />
			<col width="20%" />
			<col width="30%" />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><label for="title">분류</label></th>
				<td class="output" colspan="3">
					<input type="radio" name="type_cd" id="type_cd" value="01"/> 약업소자율점검
					<input type="radio" name="type_cd" id="type_cd" value="02"/> 마약류자율점검
					<input type="radio" name="type_cd" id="type_cd" value="04"/> 의료법관련자율점검
					<input type="radio" name="type_cd" id="type_cd" value="03"/> 법령인지도
				</td>
			</tr>
			
			<tr>
				<th scope="row"><label for="year_cd">년도</label></th>
				<td class="output" colspan="3">
					<strong style="color: gray;">${fn:substring(Bean.year_cd, 0, 4)} 년도</strong>
					<input type="hidden" name="year_cd" value="${Bean.year_cd}" />
					<!-- 
					<select name="year_cd" id="year_cd" style="width: 100px;" style="select">
						<option value='201001' <c:if test="${Bean.year_cd == '201001'}">selected="selected"</c:if>>2010 년도</option>
						<option value='200901' <c:if test="${Bean.year_cd == '200901'}">selected="selected"</c:if>>2009 년도</option>
						<option value='200801' <c:if test="${Bean.year_cd == '200801'}">selected="selected"</c:if>>2008 년도</option>
					</select>
					 -->
				</td>
			</tr>
			
			<tr>
				<th scope="row"><label for="title">제목</label></th>
				<td class="output" colspan="3">
					<input type="text" name="title" id="title" style="width: 300px; padding-left: 5px;" class="board1"/>
				</td>
			</tr>
			
			<tr>
				<th scope="row">응모기간</th>
				<td class="output" colspan="3">
					<input type="text" name="start_dt" id="start_dt" title="응모기간 (시작일자)" style="width: 80px; padding-left: 5px;" class="board1"/><a href="javascript:Calendar_D(fm.start_dt)"><img src="/health/open_content/images/calendar.gif" class="vat" alt=""/></a>
					<span style="width: 5px;"></span> ~ <span style="width: 5px;"></span>
					<input type="text" name="end_dt" id="end_dt" title="응모기간 (종료일자)" style="width: 80px; padding-left: 5px;" class="board1"/><a href="javascript:Calendar_D(fm.end_dt)"><img src="/health/open_content/images/calendar.gif" class="vat" alt=""/></a>
				</td>
			</tr>
			
			<tr>
				<th scope="row"><label for="contents">내용</label></th>
				<td class="outputEditor" colspan="3">
					<textarea name="contents" id="contents" cols="50" rows="20" title="내용" style="width:100%;"></textarea>
				</td>
			</tr>
			
			<tr>
				<th scope="row"><label for="tel">첨부파일</label></th>
				<td class="output" colspan="3">
					<input name="file1" type="file" title="첨부파일1" class="board1" size="50" style="width:90%;  padding-left: 5px;" />
				</td>
			</tr>
			
			<tr>
				<th scope="row">등록자</th>
				<td class="output">
					${user.name}
				</td>
				<th scope="row">등록일자</th>
				<td class="output">
					<fmt:formatDate value="${CURR_DATE}" pattern="yyyy년MM월dd일"/>
				</td>
			</tr>
			
		</tbody>
	</table>

<div class="board_btn_set mt13">
		<input type="hidden" name="searchKeyword" value="${Bean.searchKeyword}"/>
	<span class="btn_del"><input type="submit" value="등록하기" /></span>
	
		<c:url var="list_action" value="/admin/freecheck/checkform/list.do">
			<c:param name="searchKeyword" value="${Bean.searchKeyword}"/>
			<c:param name="year_cd" value="${Bean.year_cd}"/>
		</c:url>
	<span class="btn_list"><a href="${list_action}">목록보기</a></span>
</div>
</form>

</div>
</body>
</html>

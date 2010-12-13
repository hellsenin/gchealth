<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
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

<script type="text/javascript" src="/health/open_content/system/js/Calendar.js" ></script>
<script type="text/javascript" src="/namo/js/namo_scripteditor.js"></script>
<script type="text/javascript" src="/admin/portal/edu/zipcode/zipcode.js" ></script>

<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>


<c:url value='/admin/checkform/checkform/deleteAttachFile.do' var='delete_action'>
	<c:param name="year_cd" value="${Bean.year_cd}"/>
	<c:param name="pageIndex" value="${Bean.pageIndex}"/>
	<c:param name="master_cd" value="${result.master_cd}"/>
	<c:param name='file' value='${result.attachfile1}' />
</c:url>

<c:if test="${message != null}">
	<script>
		alert('${message}');
	</script>
</c:if>


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
		if (confirm('수정하시겠습니까?')) {
			return true;
		} else {
			return false;
		}
	}
};

function deleteFile() {
	
	if (confirm('첨부된 파일을 삭제하시겠습니까?')) {
		document.fm.action = "${delete_action}";
		document.fm.submit();
		return true;
	} else {
		return false;
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


<c:url var="updateUrl" value="/admin/freecheck/checkform/update.do">
	<c:param name="year_cd" value="${Bean.year_cd}"/>
	<c:param name="pageIndex" value="${Bean.pageIndex}"/>
	<c:param name="searchKeyword" value="${Bean.searchKeyword}"/>
	<c:param name="master_cd" value="${result.master_cd}"/>
</c:url>
<form name="fm" method="post" action="${updateUrl}" enctype="multipart/form-data" onsubmit="return checkAndSubmit(this);">

<table summary="의약업소 자율점검 (점검표관리) 수정 페이지" class="default_write">
	<caption>의약업소 자율점검 (점검표관리) 수정</caption>
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
					<input type="radio" name="type_cd" id="type_cd" value="01" <c:if test="${result.type_cd == '01'}">checked</c:if>/> 약업소
					<input type="radio" name="type_cd" id="type_cd" value="02" <c:if test="${result.type_cd == '02'}">checked</c:if>/> 마약류
					<input type="radio" name="type_cd" id="type_cd" value="04" <c:if test="${result.type_cd == '04'}">checked</c:if>/> 의료법관련
					<input type="radio" name="type_cd" id="type_cd" value="03" <c:if test="${result.type_cd == '03'}">checked</c:if>/> 법령인지도
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="year_cd">년도</label></th>
				<td class="output" colspan="3">
					<strong style="color: gray;">${fn:substring(Bean.year_cd, 0, 4)} 년도</strong>
					<input type="hidden" name="year_cd" value="${Bean.year_cd}">
					<!-- 
					<select name="year_cd" id="year_cd" style="width: 100px;" style="select">
						<option value='201001' <c:if test="${result.year_cd == '201001'}">selected="selected"</c:if>>2010 년도</option>
						<option value='200901' <c:if test="${result.year_cd == '200901'}">selected="selected"</c:if>>2009 년도</option>
						<option value='200801' <c:if test="${result.year_cd == '200801'}">selected="selected"</c:if>>2008 년도</option>
					</select>
					 -->
				</td>
			</tr>
			
			<tr>
				<th scope="row"><label for="title">제목</label></th>
				<td class="output" colspan="3">
					<input type="text" name="title" id="title" style="width: 300px; padding-left: 5px;" class="board1" value="${result.title}"/>
				</td>
			</tr>
			
			
			<tr>
				<th scope="row">응모기간</th>
				<td class="output" colspan="3">
					<input value="<fmt:formatDate value="${result.start_dt}" pattern="yyyy-MM-dd"/>" type="text" name="start_dt" id="start_dt" title="응모기간 (시작일자)" style="width: 80px; padding-left: 5px;" class="board1"/><a href="javascript:Calendar_D(fm.start_dt)"><img src="/health/open_content/images/calendar.gif" class="vat" alt=""/></a>
					<span style="width: 5px;"></span> ~ <span style="width: 5px;"></span>
					<input value="<fmt:formatDate value="${result.end_dt}" pattern="yyyy-MM-dd"/>" type="text" name="end_dt" id="end_dt" title="응모기간 (종료일자)" style="width: 80px; padding-left: 5px;" class="board1"/><a href="javascript:Calendar_D(fm.end_dt)"><img src="/health/open_content/images/calendar.gif" class="vat" alt=""/></a>
				</td>
			</tr>
			
			<tr>
				<th scope="row"><label for="contents">내용</label></th>
				<td class="outputEditor" colspan="3">
					<textarea name="contents" id="contents" cols="50" rows="20" title="내용" style="width:100%;" class="board1">${result.contents}</textarea>
				</td>
			</tr>
			
			
			<tr>
				<th scope="row"><label for="tel">첨부파일</label></th>
				<td class="output" colspan="3">
					
					<c:if test="${result.attachfile1 == null}"><font style="color: lightgray;">첨부된 파일이 없습니다</font></c:if>
					<c:if test="${result.attachfile1 != null}">
						<c:url value="/health/freecheck/download.do" var="download_action">
							<c:param name="file" value="${result.attachfile1}" />
						</c:url>
						<a href="${download_action}"><strong style="color: gray;">${result.attachfile1}</strong></a>
						<input name="deleteFilename" type="checkbox" onclick="return deleteFile();" />삭제하기<br/>
					</c:if>
					
					<input name="file1" type="file" title="첨부파일1" class="board1" size="50" style="width:90%;  padding-left: 5px;" />
				</td>
			</tr>
			
			<tr>
				<th scope="row">수정자</th>
				<td class="output">
					${user.name}
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

		<c:url var="listUrl" value="/admin/freecheck/checkform/read.do">
			<c:param name="year_cd" value="${Bean.year_cd}"/>
			<c:param name="pageIndex" value="${Bean.pageIndex}"/>
			<c:param name="master_cd" value="${result.master_cd}"/>
		</c:url>
	<span class="btn_list"><a href="${listUrl}">취소하기</a></span>
</div>
</form>

</div>
</body>
</html>

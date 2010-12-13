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
<script type="text/javascript" src="/health/open_content/system/js/Calendar.js" ></script>
<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/util.js"></script>

<link href="/health/open_content/system/css/default.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/common.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/blue.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_blue.css" rel="stylesheet" type="text/css" />

<style type="text/css">
body { width:650px; }
</style>
<script>

function checkAndSubmit(f) {

	var v = new MiyaValidator(f);

    v.add("alert_nm", {
		required: true
    });
    v.add("alert_url", {
    	required: true
    });
    v.add("pub_sdate", {
    	required: true
    });
    v.add("pub_edate", {
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
<h3 class="tit_03">알림 관리</h3>


<form name="fm" method="post" action="<c:url value='/admin/health/portalAlert/update.do'/>" enctype="multipart/form-data" onsubmit="return checkAndSubmit(this);">

<table summary="알림 관리 수정 페이지" class="default_write">
	<caption>알림 관리 수정</caption>
	<colgroup>
		<col width="20%" />
		<col width="80%" />
	</colgroup>
	<tbody>
		<tr>
			<th scope="row"><label for="regDateStr">수정일</label></th>
			<td class="output">
				<input type="text" id="regDateStr" style="width: 125px" class="board1" value="<fmt:formatDate value="${Bean.last_mod_dt}" pattern="yyyy년MM월dd일"/>" readonly="readonly" />
			</td>
		</tr>
		<tr>
			<th scope="row">사용처</th>
			<td class="output" >
				<input type="radio" name="category" id="category" value="88" checked="checked"/>보건소
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="file1">알림 이미지</label></th>
			<td class="output">
				<img src="/health/open_content/images/alert/${result.img_nm}" style="border: 0px;"/>
				<br/>
				<input id="file1" name="file1" type="file" title="첨부파일1" class="board1" size="50" style="width:90%" />
			</td>
		</tr>
		
		<tr>
			<th scope="row"><label for="alert_nm">알림명</label></th>
			<td class="output">
				<input type="text" id="alert_nm" name="alert_nm" value="${result.alert_nm}" style="width: 125px" class="board1" />
			</td>
		</tr>
		
		<tr>
			<th scope="row"><label for="alert_url">알림 URL</label></th>
			<td class="output">
				<input type="text" id="alert_url" name="alert_url" value="${result.alert_url}" style="width: 250px" class="board1" />
			</td>
		</tr>
		
		<tr>
			<th scope="row">게시 기간</th>
			<td colspan="3" class="output">
				<input type="text" name="pub_sdate" value="<fmt:formatDate value='${result.pub_sdate}' pattern='yyyy-MM-dd'/>"/><a href="javascript:Calendar_D(fm.pub_sdate)"><img src="/health/open_content/images/calendar.gif" class="vat" alt=""/></a>
    			~
				<input type="text" name="pub_edate" value="<fmt:formatDate value='${result.pub_edate}' pattern='yyyy-MM-dd'/>"/><a href="javascript:Calendar_D(fm.pub_edate)"><img src="/health/open_content/images/calendar.gif" class="vat" alt=""/></a>
			</td>
		</tr>
		
		<tr>
			<th scope="row">팝업 여부</th>
			<td class="output">
				<label for="popup_Y">
					<input type="radio" id="popup_y" name="popup" value="Y" class="ra" <c:if test="${result.popup == 'Y'}">checked</c:if> /> 새창 (Y)
				</label>
				<label for="popup_N">
					<input type="radio" id="popup_N" name="popup" value="N" class="ra" <c:if test="${result.popup == 'N'}">checked</c:if> /> 현재창 (N)
				</label>
			</td>
		</tr>
		
		<tr>
			<th scope="row">표시 여부</th>
			<td class="output">
				<label for="publish_Y">
					<input type="radio" id="publish_Y" name="publish" value="Y" class="ra" <c:if test="${result.publish == 'Y'}">checked</c:if> /> 보이기 (Y)
				</label>
				<label for="publish_N">
					<input type="radio" id="publish_N" name="publish" value="N" class="ra" <c:if test="${result.publish == 'N'}">checked</c:if> /> 숨기기 (N)
				</label>
			</td>
		</tr>
		
	</tbody>
</table>

<div class="board_btn_set mt13">
	<input type="hidden" name="alert_cd" value="${result.alert_cd}"/>
	<input type="hidden" name="searchCondition" value="${Bean.searchCondition}"/>
	<input type="hidden" name="pageIndex" value="${Bean.pageIndex}"/>
	
		<span class="btn_del"><input type="submit" value="수정하기" /></span>
		
		<c:url value="/admin/health/portalAlert/List.do" var="list_url">
			<c:param name="pageIndex" value="${Bean.pageIndex}"/>
			<c:param name="searchCondition" value="${Bean.searchCondition}"/>
			<c:param name="category" value="${Bean.category}"/>
		</c:url>
		<span class="btn_list"><a href="${list_url}">목록보기</a></span>
	
</div>
</form>
</body>
</html>

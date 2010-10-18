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
<script type="text/javascript" src="/health/open_content/system/js/util.js"></script>

<script>

function checkAndSubmit() {
	
	if (confirm('삭제하시겠습니까?')) {
		return true;
	} else {
		return false;
	}
};
</script>

</head>
<body style="background:none;padding:10px;">
<h2 style="padding:15px 0 15px 0;">	
		배너 관리 
</h2>
<p class="title_deco"></p>
<div class="body">



<h3 class="tit_03">배너 관리</h3>



<table summary="배너 관리 페이지" class="default_view">
	<caption>배너 관리</caption>
	<colgroup>
		<col width="20%" />
		<col width="80%" />
	</colgroup>
	<tbody>
		<tr>
			<th scope="row"><label for="renew_date">변경일자</label></th>
			<td class="output">
				<fmt:formatDate value="${result.last_mod_dt}" pattern="yyyy년MM월dd일"/>
			</td>
		</tr>
		
		<tr>
			<th scope="row"><label for="renew_date">구분</label></th>
			<td class="output">
				<strong>
					<c:choose>
						<c:when test="${(result.dept == '00' and result.dong == '00')}">
							포탈
						</c:when>
						<c:when test="${(result.dept == '44' and result.dong == '44')}">
							외국어-Eng
						</c:when>
						<c:when test="${(result.dept == '55' and result.dong == '55')}">
							외국어-Cha
						</c:when>
						<c:when test="${(result.dept == '66' and result.dong == '66')}">
							외국어-Jpa
						</c:when>
						<c:when test="${(result.dept == '88' and result.dong == '88')}">
							보건소
						</c:when>
						<c:when test="${(result.dept != '00' and result.dong == '00') or (result.dept != '00' and result.dong != '00')}">
							산하부서
						</c:when>
						<c:when test="${(result.dept == '00' and result.dong != '00') or (result.dept != '00' and result.dong != '00')}">
							동주민센터
						</c:when>
					</c:choose>
				</strong>
			</td>
		</tr>
		<tr>
			<th scope="row">배너명</th>
			<td class="output">
				${result.bnr_nm}
			</td>
		</tr>
		
		<tr>
			<th scope="row">배너 URL</th>
			<td class="output">
				${result.bnr_url}
			</td>
		</tr>
		
		<tr>
			<th scope="row">배너 이미지</th>
			<td class="output">
				<img src="/health/open_content/images/banner/${result.bnr_img_nm}" style="border: 0px;"/>
			</td>
		</tr>
		
		<tr>
			<th scope="row">표시 여부</th>
			<td class="output">
				<c:choose>
					<c:when test="${result.publish == 'Y'}">보이기</c:when>
					<c:when test="${result.publish == 'N'}">숨기기</c:when>
				</c:choose>
			</td>
		</tr>
		
	</tbody>
</table>

		<form action="/admin/health/banner/delete.do" method="post" onsubmit="return checkAndSubmit();">
			<input type="hidden" name="bnr_cd" value="${result.bnr_cd}"/>
			<input type="hidden" name="pageIndex" value="${Bean.pageIndex}"/>
			
			<input type="hidden" name="searchKeyword" value="${Bean.searchKeyword}"/>
			<input type="hidden" name="searchCondition" value="${Bean.searchCondition}"/>
<div class="board_btn_set mt13">

	<span class="btn_del"><input type="submit" value="삭제하기" /></span>

	<c:url var="modify_action" value="/admin/health/banner/forUpdate.do">
		<c:param name="bnr_cd" value="${result.bnr_cd}"/>
		<c:param name="searchCondition" value="${Bean.searchCondition}"/>
		<c:param name="searchKeyword" value="${Bean.searchKeyword}"/>
		<c:param name="pageIndex" value="${Bean.pageIndex}"/>
	</c:url>
	<span class="btn_del"><a href="${modify_action}">수정하기</a></span>

	<c:url var="list_action" value="/admin/health/banner/List.do">
		<c:param name="searchKeyword" value="${Bean.searchKeyword}"/>
		<c:param name="searchCondition" value="${Bean.searchCondition}"/>
		<c:param name="pageIndex" value="${Bean.pageIndex}"/>
	</c:url>
	<span class="btn_list"><a href="${list_action}">목록보기</a></span>
</div>
		</form>
			

</div>
</body>
</html>
			
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
<link href="/health/open_content/system/css/default.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/common.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/blue.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_blue.css" rel="stylesheet" type="text/css" />

</head>
<body style="background:none;padding:10px;">
<div style="margin: 20px;"></div>

<h3 class="tit_03">알림 관리</h3>

<div class="board_top clearfix">
				<!-- 게시판 게시물검색 start -->
		<form method="post" name="frm" action="/admin/health/satisfaction/satisfactionList.do?siteId=${param.siteId}">
				<fieldset id="src">
					<legend>게시판 게시물검색</legend>		
							<span class="boardsearch">				
							롤링간격(밀리초) <input type="text" id="rolling_sec" name="rolling_sec"/> 
							<input type="button" id="btn" value="적용"/> 		
							</span>
				</fieldset><!-- 게시판 게시물검색 end -->
		</form>
</div>

<table class="default_list" summary="알림 관리 목록 테이블입니다">
	<caption>알림 관리 목록</caption>
	<colgroup>
		<col width="5%" />
		<col width="10%" />
		<col width="20%" />
		<col width="20%" />
		<col width="25%" />
		<col width="10%" />
	</colgroup>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">구분</th>
			<th scope="col">알림명</th>
			<th scope="col">알림 URL</th>
			<th scope="col">알림 이미지</th>
			<th scope="col">표시 여부</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${resultList}" var="item" varStatus="status">
			<tr>
				<!-- 번호 -->
				<td>
					${(resultListSize + 1) - ((Bean.pageIndex - 1) * Bean.pageSize + status.count)}
				</td>
				
				<!-- 구분 -->
				<td>
					<strong>
						<c:choose>
							<c:when test="${item.category == '00'}">포탈</c:when>
							<c:when test="${item.category == '88'}">보건소</c:when>
							<c:when test="${item.category == '99'}">구의회</c:when>
						</c:choose>
					</strong>
				</td>
				
				<!-- 알림명-->
				<td class="tal">
					<c:url value='/admin/health/portalAlert/Read.do' var="read_url">
						<c:param name="alert_cd" value="${item.alert_cd}"/>
						<c:param name="pageIndex" value="${Bean.pageIndex}"></c:param>
						<c:param name="searchCondition" value="${Bean.searchCondition}"></c:param>
						<c:param name="category" value="${Bean.category}"></c:param>
					</c:url>
					<a href="${read_url}">${item.alert_nm}</a>
				</td>
				
				<!-- 알림 URL -->
				<td class="tal">
					<a href="${item.alert_url}" target="_blank"><c:url value="${item.alert_url}"/></a>
				</td>
				
				<!-- 알림 이미지 -->
				<td>
					<img src="/health/open_content/images/alert/${item.img_nm}" style="border: 0px;" width="30" height="30"/>
				</td>
				
				<!-- 표시 여부 -->
				<td>
					<c:choose>
						<c:when test="${item.publish == 'Y'}">보이기</c:when>
						<c:when test="${item.publish == 'N'}">숨기기</c:when>
					</c:choose>
				</td>
				
			</tr>
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="6">데이터가없습니다.</td></tr></c:if>
	</tbody>
</table>
<!-- board list end //-->

<form action="<c:url value="/admin/health/portalAlert/forInsert.do"/>" method="post">
	<input type="hidden" name="searchCondition" value="${Bean.searchCondition}"/>
	<input type="hidden" name="category" value="${Bean.category}"/>
	
	<div class="board_btn_set mt13">
	    <span class="btn_del"><input type="submit" value="등록하기" /></span>
	</div>
</form>


<ol class="paging">
	${pagingInfoString}	
</ol>

</body>
</html>

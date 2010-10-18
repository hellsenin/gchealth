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
	
	<title>금천시 보건소</title>
<link href="/health/open_content/system/css/default.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/common.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/blue.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_blue.css" rel="stylesheet" type="text/css" />

<style type="text/css">
body { width:650px; }
</style>
</head>
<body style="background:none;padding:10px;">
<h3 class="tit_03">배너 관리</h3>


<div class="board_top clearfix">	
    <div class="fl_l"> <span>9건 [1 / 1Page]</span> </div>
    <fieldset class="fl_r">
	<form action="/admin/health/banner/List.do" method="post">
		<span style="float: right;">
		<label for="stributary" class="blind">게시물 분류 선택</label>
		
		<input type="image" alt="검색" src="/health/open_content/images/borad/btn_search.gif" style="float: right;"/>
		
		<select id="searchKeyword" name="searchKeyword" style="float: right; width: 100px; margin-right: 10px;" onchange="submit();" style="float: right; width: 200px;">
			<option value="0" <c:if test="${Bean.searchKeyword == '0'}">selected="selected"</c:if>>선택</option>
			<option value="5" <c:if test="${Bean.searchKeyword == '5'}">selected="selected"</c:if>>보건소</option>
		</select>

		<select name="searchCondition" class="select" style="width: 100px; float: right; margin-right: 10px;" onchange="submit();">
			<option value='1' <c:if test="${Bean.searchCondition == '1'}">selected="selected"</c:if>>구분</option>
		</select>
		
		</span>
	</form>
    </fieldset>
</div>


<table class="default_list" summary="배너 관리 목록 테이블입니다">
	<caption>배너 관리 목록</caption>
	<colgroup>
		<col width="5%" />
		<col width="13%" />
		<col width="15%" />
		<col width="*" />
		<col width="20%" />
		<col width="9%" />
	</colgroup>
	<thead>
		<tr>
			<th scope="col" class="number">번호</th>
			<th scope="col" class="title">구분</th>
			<th scope="col" class="title">배너명</th>
			<th scope="col" class="title">배너 URL</th>
			<th scope="col" class="title">배너 이미지</th>
			<th scope="col" class="title">표시 여부</th>
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
							<c:when test="${(item.dept == '00' and item.dong == '00')}">
								포탈
							</c:when>
							<c:when test="${(item.dept == '44' and item.dong == '44')}">
								외국어-Eng
							</c:when>
							<c:when test="${(item.dept == '55' and item.dong == '55')}">
								외국어-Cha
							</c:when>
							<c:when test="${(item.dept == '66' and item.dong == '66')}">
								외국어-Jpa
							</c:when>
							<c:when test="${(item.dept == '88' and item.dong == '88')}">
								보건소
							</c:when>
							<c:when test="${(item.dept != '00' and item.dong == '00') or (item.dept != '00' and item.dong != '00')}">
								산하부서
							</c:when>
							<c:when test="${(item.dept == '00' and item.dong != '00') or (item.dept != '00' and item.dong != '00')}">
								동주민센터
							</c:when>
						</c:choose>
					</strong>
				</td>
				
				<!-- 배너명-->
				<td class="tal" style="padding-left: 10px;">
					<c:url value='/admin/health/banner/Read.do' var="read_url">
						<c:param name="bnr_cd" value="${item.bnr_cd}"></c:param>
						<c:param name="pageIndex" value="${Bean.pageIndex}"></c:param>
						<c:param name="searchCondition" value="${Bean.searchCondition}"></c:param>
						<c:param name="searchKeyword" value="${Bean.searchKeyword}"></c:param>
					</c:url>
					<a href="${read_url}">${item.bnr_nm}</a>
				</td>
				
				<!-- 배너 URL -->
				<td class="tal">
					<a href="${item.bnr_url}" target="_blank"><c:url value="${item.bnr_url}"/></a>
				</td>
				
				<!-- 배너 이미지 -->
				<td>
					<img src="/health/open_content/images/banner/${item.bnr_img_nm}" style="border: 0px;"/>
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
	</tbody>
</table>
<!-- board list end //-->

<form action="<c:url value="/admin/health/banner/forInsert.do"/>" method="post">

	<input type="hidden" name="searchCondition" value="${Bean.searchCondition}"/>
	<input type="hidden" name="searchKeyword" value="${Bean.searchKeyword}"/>
	
	<div class="board_btn_set mt13">
	    <span class="btn_del"><input type="submit" value="등록하기" /></span>
	</div>
</form>

<ol class="paging">
	${pagingInfoString}	
</ol>

</body>
</html>

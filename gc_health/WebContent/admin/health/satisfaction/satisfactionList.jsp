<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
<h3 class="tit_03">페이지만족도</h3>
<div class="board_top clearfix">
    <div class="fl_l"> <span>9건 [1 / 1Page]</span> </div>
				<!-- 게시판 게시물검색 start -->
		<form method="post" name="frm" action="/admin/health/satisfaction/satisfactionList.do?siteId=${param.siteId}">
				<fieldset id="src">
					<legend>게시판 게시물검색</legend>		
							<span class="boardsearch">				
							<label for="stributary" class="blind">게시물 분류 선택</label>
								<select id="stributary" name="searchType" title="검색조건">
								   <option value="0" <c:if test="${param.searchType == 0}">selected</c:if>>메뉴이름</option>
								   <option value="1" <c:if test="${param.searchType == 1}">selected</c:if>>위치</option>
								</select>
							<label for="searchWrd">
								<input id="searchWrd" name="searchTxt" value="${param.searchTxt}" class="searchinput" type="text" title="검색어입력" style="width:150px" />
							</label>
							<label for="input2">
								<input id="input2" type="image" alt="검색" src="/health/open_content/images/borad/btn_search.gif" />
							</label>				
							</span>
				</fieldset><!-- 게시판 게시물검색 end -->
		</form>
</div>
				
				<!-- write form start -->
				<!-- board list start -->
				<table class="default_list" summary="게시판 목록입니다">
					<caption>게시판 목록</caption>
					<colgroup>
						<col width="10%" />
						<col width="10%" />
						<col width="20%" />
						<col width="10%" />
						<col width="*" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col" class="fir">번호</th>
							<th scope="col">메뉴이름</th>
							<th scope="col">위치</th>
							<th scope="col">만족도</th>
							<th scope="col">한줄의견내용</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td>${zvl.totCnt - (zvl.pageIndex-1)*zvl.pageUnit - (status.count-1)}</td>
							<td><a href="${result.fullMenuLink}" target="_blank">${result.name}</a></td>
							<td>${fn:replace(result.fullPath,'/', '>')}</td>
							<td>
								<c:if test="${result.status == 1}">매우불만족</c:if>
								<c:if test="${result.status == 2}">불만족</c:if>
								<c:if test="${result.status == 3}">보통</c:if>
								<c:if test="${result.status == 4}">만족</c:if>
								<c:if test="${result.status == 5}">매우만족</c:if>
							</td>
							<td>${result.opinion}</td>
						</tr>
					</c:forEach>		
					<c:if test="${fn:length(resultList) == 0}" >
						<tr><td colspan="5">데이터가 없습니다.</td></tr>
					</c:if>
					</tbody>
				</table>
				<!-- board list end //-->
				
				<c:if test="${fn:length(resultList) > 0}" >
				<ol class="paging">${pageNav}</ol>
				</c:if>

</body>
</html>
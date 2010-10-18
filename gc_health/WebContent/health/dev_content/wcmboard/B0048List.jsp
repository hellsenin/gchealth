<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<form name="searchFrm" method="post" action="/health/wcmboard/selectWcmboardList.do?communityId=${param.communityId}&amp;categoryId=${param.categoryId}">
<div class="board_top clearfix">
    <div class="fl_l"> <span>${pageInfo.totCnt}건 [${pageInfo.pageIndex} / ${pageInfo.totalPageCount}Page]</span> </div>
    <fieldset class="fl_r">
        <legend>게시물검색</legend>
        <select name="searchType" title="구분선택">
            <option value="3" <c:if test="${param.searchType == '3'}">selected</c:if>>시설명</option>
            <option value="4" <c:if test="${param.searchType == '4'}">selected</c:if>>소재지</option>
            <option value="5" <c:if test="${param.searchType == '5'}">selected</c:if>>전화번호</option>
        </select>
        <input type="text" title="검색어" class="text" name="searchTxt" value="${param.searchTxt}"/>
    <input type="image" src="/health/open_content/images/borad/btn_search.gif" alt="검색" />
    </fieldset>
</div>
</form>

<table class="default_list" summary="번호,제목,게시자,날짜,조회수 구성">
    <caption>
    게시물리스트
    </caption>
    <thead>
        <tr>
            <th width="7%" scope="col">번호</th>
            <th width="20%" scope="col">시설명</th>
            <th width="*" scope="col">소재지</th>
            <th width="20%" scope="col">전화번호</th>
            <th width="10%" scope="col">지도보기</th>
        </tr>
    </thead>
    <tbody>
	<c:if test="${fn:length(resultList) > 0}" >
	<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}">  
		<c:set var="_boardId" value="B${resultList[x].boardId}" />
		<c:set var="fileList" value="${fileMap[_boardId]}" />
        <tr>
            <td>${pageInfo.totCnt - (pageInfo.pageIndex-1)*pageInfo.pageUnit - x}</td>
            <td class="tal">${resultList[x].title}</td>
            <td>${resultList[x].etc1}</td>
            <td>${empty resultList[x].etc3 ? '-' :  resultList[x].etc3}</td>
            <td>
            	<c:if test="${not empty resultList[x].etc8}">
            	<a href="http://gis.seoul.go.kr/SeoulGis/LifeMap_gu.jsp?Mode=4&OfficeName=금천구&SisulName=&RetSisulX=${resultList[x].etc8}&RetSisulY=${resultList[x].etc9}" target="_blank"><img src="/health/open_content/images/btn/btn_s_mapview.gif" alt="지도보기" /></a>
            	</c:if>
            </td>
        </tr>
	</c:forEach>
	</c:if>
	<c:if test="${fn:length(resultList) == 0}" >
	<tr><td colspan="4">데이터가 없습니다</td></tr>
	</c:if>
    </tbody>
</table>
<ol class="paging">${pageNav}</ol>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="comment_box">
<div class="comment_box_top"></div>
<div class="comment_box_in" style="background:url(/health/open_content/images/comment/comment_img_s_001.gif) 580px top no-repeat;">
    <ul class="list">
        <li>자주 이용하시는 보건/위생 관련 민원 사무 내용을 확인하실 수 있습니다.</li>
        <li>보건/위생 서식 이외의 서식을 이용하시고자 할 경우에는 금천구청 홈페이지를 이용해 주세요.</li>
    </ul>
</div>
<div class="comment_box_bottom"></div>
</div>

<form name="searchFrm" method="post" action="/health/wcmboard/selectWcmboardList.do?communityId=${param.communityId}&amp;healthPosition=1&amp;categoryId=${param.categoryId}">
<div class="board_top clearfix">
    <div class="fl_l"> <span>${pageInfo.totCnt}건 [${pageInfo.pageIndex} / ${pageInfo.totalPageCount}Page]</span> </div>
    <fieldset class="fl_r">
        <select name="position" title="담당부서선택">
            <option value="">담당부서</option>
            <option value="보건위생과" <c:if test="${param.position == '보건위생과'}">selected</c:if>>보건위생과</option>
            <option value="건강증진과" <c:if test="${param.position == '건강증진과'}">selected</c:if>>건강증진과</option>
            <option value="의약과" <c:if test="${param.position == '의약과'}">selected</c:if>>의약과</option>
        </select>
        <legend>게시물검색</legend>
        <select name="searchType" title="구분선택">
            <option value="1" <c:if test="${param.searchType == '1'}">selected</c:if>>제목</option>
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
            <th width="53%" scope="col">제목</th>
            <th width="13%" scope="col">담당부서</th>
            <th width="7%" scope="col">서식</th>
            <th width="13%" scope="col">신청방법</th>
            <th width="7%" scope="col">신청</th>
        </tr>
    </thead>
    <tbody>
	<c:if test="${fn:length(resultList) > 0}" >
	<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}">  
		<c:set var="_boardId" value="B${resultList[x].boardId}" />
		<c:set var="fileList" value="${fileMap[_boardId]}" />
        <tr>
            <td>${pageInfo.totCnt - (pageInfo.pageIndex-1)*pageInfo.pageUnit - x}</td>
            <td class="tal"><a href="/health/wcmboard/selectWcmboard.do?categoryId=${param.categoryId}&amp;communityId=${param.communityId}&amp;boardId=${resultList[x].boardId}&amp;pageIndex=${param.pageIndex}">${resultList[x].title}</a></td>
            <td>${resultList[x].position}</td>
            <td>
            	<c:choose>
            	<c:when test="${resultList[x].fileCount == 1}">
            		<c:forEach var="file" items="${fileList}">
            	<a href="http://www.geumcheon.go.kr/cms/board/Download.jsp?fileId=${file.fileAppdId}" ><img src="http://www.geumcheon.go.kr/open_content/images/common/icon/icon_form.gif" alt="첨부파일" /></a>
            		</c:forEach>
            	</c:when>
            	<c:when test="${resultList[x].fileCount > 1}">
            		<a href="/health/wcmboard/selectWcmboard.do?categoryId=${param.categoryId}&amp;communityId=${param.communityId}&amp;boardId=${resultList[x].boardId}&amp;pageIndex=${param.pageIndex}"><img src="http://www.geumcheon.go.kr/skin/images/blt_file.gif" alt="첨부파일" /></a>
            	</c:when>
            	<c:otherwise>-</c:otherwise>
            	</c:choose>
            </td>
            <td>${empty resultList[x].etc16 ? '-' :  resultList[x].etc16}</td>
            <td>
            	<c:choose>
            		<c:when test="${empty resultList[x].etc21}">-</c:when>
            		<c:when test="${resultList[x].etc21 == '1'}"><a href="http://www.g4c.go.kr" target="_blank"><img src="http://www.geumcheon.go.kr/open_content/images/common/icon/icon_g4c.gif" alt="전자민원 G4C" /></a></c:when>
            		<c:when test="${resultList[x].etc21 == '2'}"><a href="http://www.scourt.go.kr" ><img src="http://www.geumcheon.go.kr/open_content/images/common/icon/icon_supreme_court.gif" alt="대법원" /></a></c:when>
            		<c:when test="${resultList[x].etc21 == '3'}"><a href="http://www.eais.go.kr" target="_blank"><img src="http://www.geumcheon.go.kr/open_content/images/common/icon/icon_seum.gif" alt="새움터" /></a></c:when>
            	</c:choose>
            </td>
        </tr>
	</c:forEach>
	</c:if>
	<c:if test="${fn:length(resultList) == 0}" >
	<tr><td colspan="6">데이터가 없습니다</td></tr>
	</c:if>
    </tbody>
</table>
<ol class="paging">${pageNav}</ol>

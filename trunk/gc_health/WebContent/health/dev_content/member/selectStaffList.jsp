<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="board_top clearfix">
    <div class="fl_l"> <span>${pageInfo.totCnt}건 [${pageInfo.pageIndex} / ${pageInfo.totalPageCount}Page]</span> </div>
<form name="searchFrm" method="post" action="/health/member/selectStaffList.do?categoryId=${param.categoryId}">
    <fieldset class="fl_r">
        <legend>게시물검색</legend>
        <select name="department" title="구분선택" style="width:150px;">
            <option value="">선택하세요</option>
            <option <c:if test="${param.department == '보건위생과'}">selected</c:if>>보건위생과</option>
            <option <c:if test="${param.department == '건강증진과'}">selected</c:if>>건강증진과</option>
            <option <c:if test="${param.department == '의약과'}">selected</c:if>>의약과</option>
        </select>
        
    <input type="image" src="/health/open_content/images/borad/btn_select.gif" alt="선택" />
    </fieldset>
</form>
</div>
<table class="default_list" summary="소속과, 소속팀, 성명, 직위, 전화번호, 이메일, 담당업무">
    <caption>
    업무안내표
    </caption>
    <thead>
        <tr>
            <th width="13%" scope="col">소속과</th>
          <th width="13%" scope="col">소속팀</th>
          <th width="10%" scope="col">성명</th>
          <th width="7%" scope="col">직위</th>
          <th width="15%" scope="col">전화번호</th>
          <th width="7%" scope="col">이메일</th>
          <th scope="col">담당업무</th>
      </tr>
    </thead>
    <tbody>
	<c:if test="${fn:length(resultList) > 0}" >
	<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}">  
        <tr>
            <td>${resultList[x].department}</td>
            <td>${resultList[x].organ}</td>
            <td>${resultList[x].name}</td>
            <td>${resultList[x].role}</td>
            <td>${resultList[x].officetelno}</td>
            <td><a href="mailto:${resultList[x].email}"><img src="/health/open_content/images/borad/icons/email.gif" alt="이메일"/></a></td>
            <td>${resultList[x].intrdt}</td>
      </tr>
	</c:forEach>
	</c:if>
    </tbody>
</table>
<ol class="paging">${pageNav}</ol>
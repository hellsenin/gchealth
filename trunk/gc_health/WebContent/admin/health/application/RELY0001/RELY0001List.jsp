<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/admin/health/application/applyStatus.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<title>금천시 보건소</title>
<link href="/health/open_content/system/css/default.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/common.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/blue.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_blue.css" rel="stylesheet" type="text/css" />
	
</head>
<body style="background:none;padding:10px;">
<h3 class="tit_03">상담</h3>
	
<p class="title_deco"></p>
<div class="body">
	
<div class="board_top clearfix">
    <div class="fl_l"> <span>${pageInfo.totCnt}건 [${pageInfo.pageIndex} / ${pageInfo.totalPageCount}Page]</span> </div>
    <fieldset class="fl_r">
        <legend>게시물검색</legend>
        <select name="searchType" title="구분선택">
            <option value="">전체</option>
            <option value="1" <c:if test="${param.searchTxt == '1'}" >selected</c:if>>제목</option>
            <option value="2" <c:if test="${param.searchTxt == '2'}" >selected</c:if>>작성자</option>
        </select>
        <input type="text" name="searchTxt" value="${param.searchTxt}" title="검색어" class="text"/>    
		<input type="image" alt="검색" src="/health/open_content/images/borad/btn_search.gif" style="float: right;"/>
    </fieldset>
</div>
<table class="default_list" summary="번호,제목,공개여부, 작성자, 등록일, 첨부파일 구성">
    <caption>
    게시물리스트
    </caption>
    <thead>
        <tr>
            <th width="7%" scope="col">번호</th>
            <th width="13%" scope="col">공개여부</th>
            <th width="37%" scope="col">제목</th>
            <th width="13%" scope="col">작성자</th>
            <th width="13%" scope="col">등록일</th>
            <th width="10%" scope="col">처리상황</th>
            <th width="7%" scope="col">조회수</th>
        </tr>
    </thead>
    <tbody>
	<c:if test="${fn:length(resultList) > 0}" >
	<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}">  
        <tr>
            <td>${pageInfo.totCnt - (pageInfo.pageIndex-1)*pageInfo.pageUnit - x}</td>
            <td>
				<c:if test="${resultList[x].openFlag == 'Y'}" >공개</c:if>
				<c:if test="${resultList[x].openFlag == 'N'}" >비공개</c:if>
			</td>
            <td class="tal"><a href="/admin/health/application/modifyPage.do?applyCode=${param.applyCode}&amp;applyId=${resultList[x].applyId}&amp;petiGubun=${param.petiGubun}">${resultList[x].title}</a></td>
            <td>${resultList[x].name}</td>
          <td>		
			<fmt:parseDate value='${resultList[x].applyDate}' var='applyDate' pattern='yyyy-mm-dd'/>
			<fmt:formatDate value='${applyDate}' pattern="yyyy년mm월dd일"/>	
          </td>
            <td>
				<c:if test="${empty resultList[x].status || resultList[x].status == RECEIPT_WAITING}">접수대기</c:if>
				<c:if test="${resultList[x].status == RECEIPT}">접수</c:if>
				<c:if test="${resultList[x].status == ASSIGNED_DEPT}">부서지정</c:if>
				<c:if test="${resultList[x].status == OFFICER_PROCESSING}">담당자지정/처리</c:if>
				<c:if test="${resultList[x].status == ANSWERING}">답변중</c:if>
				<c:if test="${resultList[x].status == COMPLETE_ANSWER}">답변완료</c:if>
				<c:if test="${resultList[x].status == COMPLETION}">완료</c:if>
				<c:if test="${resultList[x].status == DELETION}">신청취소</c:if>
				<c:if test="${resultList[x].status == TRANSFER}">이관</c:if>
            </td>
            <td>${resultList[x].hit}</td>
        </tr>
     </c:forEach>
     </c:if>
	<c:if test="${fn:length(resultList) == 0}" >
	<tr><td colspan="7">데이터가 없습니다</td></tr>
	</c:if>
    </tbody>
</table>
<ol class="paging">
<c:if test="${fn:length(resultList) > 0}" >
${pageNav}
</c:if>
</ol>
</div>
</body>
</html>

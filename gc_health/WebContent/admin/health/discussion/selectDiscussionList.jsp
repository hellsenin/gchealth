<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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


</head>
<body style="background:none;padding:10px;">
<h2 style="padding:15px 0 15px 0;">	
		정책토론방 
</h2>
<p class="title_deco"></p>
<div class="body">

				<table class="default_list" summary="현수막 지정게시대 신청결과 조회">
					<caption>현수막 지정게시대 신청결과 조회</caption>
					<colgroup>
						<col width="8%" />
						<col width="*" />
						<col width="20%" />
						<col width="25%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col" class="fir">번호</th>
							<th scope="col">제목</th>
							<th scope="col">기간</th>
							<th scope="col">상태</th>
						</tr>
					</thead>
					<tbody>
				<c:if test="${fn:length(resultList) > 0}" >
					<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}">  
						<tr>
							<td>${paginationInfo.totalRecordCount - (paginationInfo.currentPageNo-1)*paginationInfo.pageSize - x}</td>
							<td><a href="/admin/health/discussion/modifyDiscussionPage.do?disseq=${resultList[x].disseq}">${resultList[x].distitle}</a></td>
							<td>${resultList[x].dissdate} ~ ${resultList[x].disedate}</td>
							<td>
								<c:if test="${resultList[x].status == 1}">대기</c:if>
								<c:if test="${resultList[x].status == 2}">진행중</c:if>
								<c:if test="${resultList[x].status == 3}">종료</c:if>
							</td>
						</tr>
					</c:forEach>
					</c:if>
					<c:if test="${fn:length(resultList) == 0}" >
						<tr>
							<td colspan="4">데이터가 없습니다.</td>
						</tr>
					</c:if>						
					</tbody>
				</table>
				<!-- board list end //-->
				
				<c:if test="${fn:length(resultList) > 0}" >
<ol class="paging">${pageNav}</ol>
				</c:if>
				
<div class="board_btn_set mt13">
	<span class="btn_del"><a href="/admin/health/discussion/writeDiscussionPage.do">등록하기</a></span>
</div>

</div>
</body>
</html>

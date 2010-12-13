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

</head>
<body style="background:none;padding:10px;">
<h2 style="padding:15px 0 15px 0;">	
		설문
</h2>
<p class="title_deco"></p>
<div class="body">

<div style="float: right; height: 30px; margin-right: 10px;">
	<strong>리스트 : ${fn:length(resultList)} 건 / 전체 : ${fn:length(resultList)} 건</strong>
</div>

<table class="default_list" summary="의약업소 자율점검 (점검표관리) 목록 테이블입니다">
	<caption>설문 목록</caption>
	<colgroup>
<!--		<col width="5%" />-->
		<col width="5%" />
		<col width="*" />
		<col width="15%" />
		<col width="25%" />
		<col width="8%" />
	</colgroup>
	<thead>
		<tr>
<!--			<th scope="col">번호</th>-->
			<th scope="col">번호</th>
			<th scope="col">제목</th>
			<th scope="col">첨부</th>
			<th scope="col">설문기간</th>
			<th scope="col">응답수</th>
			<th scope="col">문제수</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${fn:length(resultList) > 0}">
			<c:set var="resultListSize" value="${fn:length(resultList)}" />
			<c:forEach items="${resultList}" var="item" varStatus="status">				
				<tr>
					<!-- 타입 -->
					<td>
						${(resultListSize + 1) - ((Bean.pageIndex - 1) * Bean.pageSize + status.count)}
					</td>
					
					<!-- 제목-->
					<td class="tal">
						<c:url var="actionUrl" value="/admin/health/poll/checkform/read.do">
							<c:param name="master_cd" value="${item.MASTER_CD}"/>
						</c:url>
						<a href="${actionUrl}">${item.TITLE}</a><label></label>
					</td>
					
					<!-- 첨부파일 -->
					<td>
						
						<c:if test="${item.ATTACHFILE1 == null}"><font style="color: lightdrakgray;">-</font></c:if>
						<c:if test="${item.ATTACHFILE1 != null}">
							<c:url value="/health/poll/download.do" var="download_action">
								<c:param name="file" value="${item.ATTACHFILE1}" />
							</c:url>
							<a href="${download_action}"><img src="http://www.geumcheon.go.kr/open_content/images/common/icon/icon_form.gif" border="0" alt="${item.ATTACHFILE1}"/></a>
						</c:if>
						
					</td>
					
					
					<!-- 점검기간 -->
					<td>
						<fmt:formatDate value="${item.START_DT}" pattern="yyyy년MM월dd일"/>
						 ~ <fmt:formatDate value="${item.END_DT}" pattern="yyyy년MM월dd일"/>
					</td>
							
					<td>
						<c:url var="answerList_url" value="/admin/health/poll/checkform/checkedList.do">
							<c:param name="year_cd" value="${Bean.year_cd}"/>
							<c:param name="master_cd" value="${item.MASTER_CD}"/>
							<c:param name="title" value="${item.TITLE}"/>
						</c:url>
						<a href="${answerList_url}"><strong style="color: drakgray;">${item.ANSWER_CNT}</strong></a>
					</td>			
					<!-- 문제수 -->
					<td>
						<c:url var="question_list_url" value="/admin/health/poll/checkform/list_question.do">
							<c:param name="year_cd" value="${Bean.year_cd}"/>
							<c:param name="master_cd" value="${item.MASTER_CD}"/>
							<c:param name="title" value="${item.TITLE}"/>
						</c:url>
						<a href="${question_list_url}"><strong style="color: drakgray;">${item.QUESTION_CNT} 문제</strong></a>
					</td>
				</tr>
			</c:forEach>
		</c:if>
		
		<c:if test="${fn:length(resultList) == 0}">
			<tr>
				<td colspan="8">검색된 리스트가 없습니다.</td>
			</tr>
		</c:if>
	</tbody>
</table>
<!-- board list end //-->

	<form action="<c:url value="/admin/health/poll/checkform/forInsert.do"/>" method="post">
		<input type="hidden" name="year_cd" value="${Bean.year_cd}" />
<div class="board_btn_set mt13">
	<span class="btn_del"><input type="submit" value="등록하기" /></span>
</div>
	</form>
	
<ol class="paging">${pagingInfoString}</ol>
		
</div>
</body>
</html>
			

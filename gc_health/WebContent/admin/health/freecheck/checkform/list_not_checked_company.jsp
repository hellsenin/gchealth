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
		의약업소 자율점검 (점검표관리)
</h2>
<p class="title_deco"></p>
<div class="body">


		<table summary="의약업소 자율점검 (점검표관리) 페이지" class="default_view">
			<caption>의약업소 자율점검 (점검표관리)</caption>
			<colgroup>
				<col width="20%" />
				<col width="80%" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="edu_nm">분류</label></th>
					<td class="output">
						<c:if test="${Bean.type_cd == '2'}">자율점검</c:if>
						<c:if test="${Bean.type_cd == '3'}">법령인지도</c:if>
					</td>
				</tr>
				
				<tr>
					<th scope="row">제목</th>
					<td class="output">
						${checkformInfo.title}
					</td>
				</tr>
				
				
				<tr>
					<th scope="row">응모기간</th>
					<td class="output">
						<fmt:formatDate value="${checkformInfo.start_dt}" pattern="yyyy년 MM월 dd일"/> ~ <fmt:formatDate value="${checkformInfo.end_dt}" pattern="yyyy년 MM월 dd일"/>
					</td>
				</tr>
				
				<tr>
					<td class="output" colspan="2">
						${checkformInfo.contents}
					</td>
				</tr>
				
				
				<tr>
					<th scope="row">첨부파일</th>
					<td class="output">
						<c:url value="/health/freecheck/download.do" var="download_action">
							<c:param name="file" value="${checkformInfo.attachfile1}" />
						</c:url>
						
						<a href="${download_action}"><strong style="color: gray;">${checkformInfo.attachfile1}</strong></a>
					</td>
				</tr>
				
			</tbody>
		</table>
		
	<div style="float: right; height: 30px; margin-right: 10px;">
		<strong>리스트 : ${fn:length(resultList)} 건 / 전체 : ${resultListSize} 건</strong>
	</div>

	
		
	<table class="default_list" summary="의약업소 자율점검 (점검표관리) 목록 테이블입니다">
		<caption>의약업소 자율점검 (점검표관리) 목록</caption>
<!--		<colgroup>-->
<!--			<col width="5%" />-->
<!--			<col width="*" />-->
<!--			<col width="15%" />-->
<!--			<col width="20%" />-->
<!--			<col width="10%" />-->
<!--			<col width="12%" />-->
<!--			<col width="15%" />-->
<!--			<col width="12%" />-->
<!--		</colgroup>-->
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">업소명</th>
				<th scope="col">아이디</th>
				<th scope="col">업종</th>
				<th scope="col">이름</th>
				<th scope="col">전화번호</th>
				<!-- 
				<th scope="col">점검일자</th>
				<th scope="col">관리</th>
				 -->
			</tr>
		</thead>
		<tbody>
			<c:if test="${fn:length(resultList) != 0}">
				<c:forEach items="${resultList}" var="item" varStatus="status">
					<tr>
						<!-- 번호 -->
						<td>
							 ${(resultListSize + 1) - ((Bean.pageIndex - 1) * Bean.pageSize + status.count)} 
						</td>
						
						<!-- 업소명-->
						<td class="tal">
							${item.COMPANY}
						</td>
						
						<!-- 아이디-->
						<td>
							${item.ID}
						</td>
						
						<!-- 업종 -->
						<td>
							${item.INDUSTRY_NAME}
						</td>
						
						<!-- 이름 -->
					<td>
							${item.CEO_NAME}
						</td>
						
						<!-- 전화번호 -->
						<td>
							${item.TEL}
						</td>
						
						<!-- 점검일자 -->
						<!-- 
						<td>
							<fmt:formatDate value="${item.INSERT_DT}" pattern="yyyy년MM월dd일"/>
						</td>
						 -->
						<!-- 관리 -->
						<!--
						<td>
							
						</td>
						 -->
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${fn:length(resultList) == 0}">
				<tr>
					<td colspan="7">검색된 리스트가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>

	
<ol class="paging">${pagingInfoString}</ol>


<div class="board_btn_set mt13">
	<c:url var="list_action" value="/admin/freecheck/checkform/list.do">
		<c:param name="searchKeyword" value="${Bean.searchKeyword}"/>
		<c:param name="year_cd" value="${Bean.year_cd}"/>
	</c:url>
	<span class="btn_list"><a href="${list_action}">목록보기</a></span>
</div>
		
</div>
</body>
</html>

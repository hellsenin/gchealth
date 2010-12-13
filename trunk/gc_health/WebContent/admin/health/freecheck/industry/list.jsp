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
<script>
function switch_search_keyword(val) {
	if(val== '1' || val=='') {
		document.getElementById('select_year_cd').style.display = "block";
		document.getElementById('searchKeyword').style.display = "none";
	} else if(val== '2') {
		document.getElementById('select_year_cd').style.display = "none";
		document.getElementById('searchKeyword').style.display = "block";
	} 
};
</script>

</head>
<body style="background:none;padding:10px;">

<h2 style="padding:15px 0 15px 0;">의약업소 자율점검 (업종관리)</h2>

<p class="title_deco"></p>
<div class="body">


<!--<script>-->
<!--switch_search_keyword('${Bean.searchCondition}');-->
<!--</script>-->

<div style="float: right; height: 30px; margin-right: 10px;">
	<strong>리스트 : ${fn:length(resultList)} 건 / 전체 : ${resultListSize} 건</strong>
</div>

<table class="default_list" summary="자율점검 (업종관리) 목록 테이블입니다">
	<caption>의약업소 자율점검 (업종관리) 목록</caption>
	<colgroup>
		<col width="5%" />
		<col width="12%" />
		<col width="*" />
		<col width="10%" />
		<col width="15%" />
		<col width="15%" />
	</colgroup>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">업종코드</th>
			<th scope="col">업종</th>
			<th scope="col">상태</th>
			<th scope="col">등록업소수</th>
			<th scope="col">등록일자</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${fn:length(resultList) > 0}">
			<c:forEach items="${resultList}" var="item" varStatus="status">
				<tr>
					<!-- 번호 -->
					<td>
						${item.industry_cd}
					</td>
					
					<!-- 분류-->
					<td>
						${item.divide_cd}
					</td>					
					<!-- 업종 -->
					<td class="tal">
						<c:url var="actionUrl" value="/admin/freecheck/industry/select.do">
							<c:param name="industry_cd" value="${item.industry_cd}"/>
							<c:param name="pageIndex" value="${Bean.pageIndex}"/>
							<c:param name="searchCondition" value="${Bean.searchCondition}"/>
							<c:param name="searchKeyword" value="${Bean.searchKeyword}"/>
							<c:param name="year_cd" value="${Bean.year_cd}"/>
						</c:url>
						<a href="${actionUrl}">${item.name}</a>
					</td>
					
					<!-- 상태 -->
					<td>
						${item.use_yn_name}
					</td>
					
					<!-- 등록업소수 -->
					<td>
						${item.industry_cnt}
					</td>
					
					<!-- 등록일 -->
					<td>
						<fmt:formatDate value="${item.insert_dt}" pattern="yyyy년MM월dd일"/>
					</td>
				</tr>
			</c:forEach>
		<tr>
			<td colspan="5"><strong>합계</strong></td>
			<td colspan="1"><strong>${resultListSize2}</strong></td>
			<td colspan="1"></td>
		</tr>
		</c:if>
		<c:if test="${fn:length(resultList) == 0}">
			<tr>
				<td colspan="7">검색된 리스트가 없습니다.</td>
			</tr>
		</c:if>
	</tbody>
</table>

<!-- board list end //-->
			<div class="board_btn_set mt13">
				<span class="btn_del"><a href="/admin/freecheck/industry/forInsert.do?year_cd=${Bean.year_cd}">등록하기</a></span>
			</div>
</div>
</body>
</html>

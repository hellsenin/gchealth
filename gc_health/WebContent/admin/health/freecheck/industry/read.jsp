<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	java.util.Calendar cal1 = java.util.Calendar.getInstance();
	int year = cal1.get(java.util.Calendar.YEAR);
	pageContext.setAttribute("year", year);
%>
		<c:url var="deleteUrl" value="/admin/freecheck/industry/delete.do">
			<c:param name="industry_cd" value="${result.industry_cd}"/>
			<c:param name="pageIndex" value="${Bean.pageIndex}"/>
			<c:param name="searchCondition" value="${Bean.searchCondition}"/>
			<c:param name="searchKeyword" value="${Bean.searchKeyword}"/>
			<!-- <c:param name="year_cd" value="${Bean.year_cd}"/> -->
		</c:url>
		
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<title>금천시 보건소</title>
<link href="/health/open_content/system/css/default.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/common.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/blue.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_blue.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="/health/open_content/system/js/Calendar.js" ></script>
<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/util.js"></script>

<script>

function del() {
	
	if (confirm('삭제하시겠습니까?')) {
		location.href = "${deleteUrl}";
	}
};
</script>

</head>
<body style="background:none;padding:10px;">
<h2 style="padding:15px 0 15px 0;">	
의약업소 자율점검 (업종관리)
</h2>
<p class="title_deco"></p>
<div class="body">

	<table summary="자율점검 (업종관리) 페이지" class="default_view">
		<caption>자율점검 (업종관리)</caption>
		<colgroup>
			<col width="20%" />
			<col width="30%" />
			<col width="20%" />
			<col width="30%" />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">업종코드</th>
				<td class="output" colspan="3">${result.divide_cd}</td>
			</tr>
			<tr>
				<th scope="row">업종명</th>
				<td class="output" colspan="3">
					${result.name}
				</td>
			</tr>
			
			
			<tr>
				<th scope="row">상태</th>
				<td class="output" colspan="3">
					<c:choose>
						<c:when test="${result.use_yn == 'Y'}">정상</c:when>
						<c:when test="${result.use_yn == 'N'}">폐업</c:when>
					</c:choose>
				</td>
			</tr>
			
			
			<tr>
				<th scope="row">등록자</th>
				<td class="output">
					${result.insert_name}
				</td>
				<th scope="row">등록일자</th>
				<td class="output">
					<fmt:formatDate value="${result.insert_dt}" pattern="yyyy년MM월dd일"/>
				</td>
			</tr>
			
			<tr>
				<th scope="row"><label for="regUserName">수정자</label></th>
				<td class="output">
					${result.update_name}
				</td>
				<th scope="row"><label for="renew_date">수정일자</label></th>
				<td class="output">
					<fmt:formatDate value="${result.update_dt}" pattern="yyyy년MM월dd일"/>
				</td>
			</tr>
			
		</tbody>
	</table>

<div class="board_btn_set mt13">
		<span class="btn_del"><a href="javascript:del();">삭제하기</a></span>
		
		<c:url var="forUpdateUrl" value="/admin/freecheck/industry/forUpdate.do">
			<c:param name="industry_cd" value="${result.industry_cd}"/>
			<c:param name="pageIndex" value="${Bean.pageIndex}"/>
			<c:param name="searchCondition" value="${Bean.searchCondition}"/>
			<c:param name="searchKeyword" value="${Bean.searchKeyword}"/>
			<!-- <c:param name="year_cd" value="${Bean.year_cd}"/> -->
		</c:url>		
		<span class="btn_del"><a href="${forUpdateUrl}">수정하기</a></span>
		
		<c:url var="listUrl" value="/admin/freecheck/industry/list.do">
			<c:param name="pageIndex" value="${Bean.pageIndex}"/>
			<c:param name="searchCondition" value="${Bean.searchCondition}"/>
			<c:param name="searchKeyword" value="${Bean.searchKeyword}"/>
		</c:url>
		<span class="btn_del"><a href="${listUrl}">목록보기</a></span>
</div>

<br/>
<br/>

<fieldset id="src">
	<legend>게시판 게시물검색</legend>	
	
	<form action="/admin/freecheck/industry/select.do?industry_cd=${result.industry_cd}" method="post">
		<span style="float: right;">
		<label for="stributary" class="blind">게시물 분류 선택</label>
		
		<input type="image" alt="검색" src="/health/open_content/images/borad/btn_search.gif" style="float: right;"/>
		
<!--		<select name="searchKeyword" onchange="submit();" style="float: right; width: 100px; margin-right: 10px;">-->
<!--			<option value='' <c:if test="${Bean.searchKeyword == ''}">selected="selected"</c:if>>선택하세요</option>-->
<!--			<option value='01' <c:if test="${Bean.searchKeyword == '01'}">selected="selected"</c:if>>의료기관</option>-->
<!--			<option value='02' <c:if test="${Bean.searchKeyword == '02'}">selected="selected"</c:if>>약업소</option>-->
<!--		</select>-->

		<select id="select_year_cd" name="year_cd" style="float: right; width: 100px; margin-right: 10px;" onchange="submit();" style="float: right; width: 200px;">
		
			<option value='${year}' <c:if test="${Bean.year_cd == year}">selected="selected"</c:if>>${year} 년도</option>
			<option value='${year-1}' <c:if test="${Bean.year_cd == year-1}">selected="selected"</c:if>>${year-1} 년도</option>
			<option value='${year-2}' <c:if test="${Bean.year_cd == year-2}">selected="selected"</c:if>>${year-2} 년도</option>
		</select>

		<select name="searchCondition" class="select" style="width: 100px; float: right; margin-right: 10px;" onchange="submit();">
			<option value='1' <c:if test="${Bean.searchCondition == '1'}">selected="selected"</c:if>>년도</option>
<!--			<option value='2' <c:if test="${Bean.searchCondition == '2'}">selected="selected"</c:if>>분류</option>-->
		</select>
		
		</span>
	</form>
</fieldset>

<div style="float: right; height: 30px; margin-right: 10px;">
	<strong>리스트 : ${fn:length(resultList)} 건 / 전체 : ${resultListSize} 건</strong>
</div>
<table class="default_list" summary="의약업소 자율점검 (업소관리) 목록 테이블입니다">
	<caption>의약업소 자율점검 (업소관리) 목록</caption>
	<!-- 
	<colgroup>
		<col width="8%" />
		<col width="*" />
		<col width="10%" />
		<col width="13%" />
		<col width="15%" />
		<col width="8%" />
		<col width="13%" />
	</colgroup>
	 -->
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">업소명</th>
			<th scope="col">아이디</th>
			<th scope="col">비번</th>
			<th scope="col">대표자</th>
<!--			<th scope="col">승인여부</th>-->
			<th scope="col">등록일자</th>
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
					<td class="tal">${item.company}
					</td>
					
					<!-- 아이디 -->
					<td>
						${item.id}
					</td>
					
					<!-- 비번 -->
					<td>
						${item.passwd}
					</td>
					
					<!-- 대표자 -->
					<td>
						${item.ceo_name}
					</td>
						
					<!-- 승인여부 -->
<!--					<td>-->
<!--						${item.grade_cd_name}-->
<!--					</td>-->
					
					
					<!-- 등록일자 -->
					<td>
						<fmt:formatDate value="${item.insert_dt}" pattern="yyyy년MM월dd일"/>
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

<ol class="paging">${pagingInfoString}</ol>

<div class="board_btn_set mt13">
		<c:url var="exlUrl" value="/admin/freecheck/forUploadExcel.do">
			<c:param name="industry_cd" value="${result.industry_cd}"/>
			<c:param name="industry_name" value="${result.name}"/>
		</c:url>
	<span class="btn_del"><a href="${exlUrl}">엑셀등록</a></span>
</div>

</div>
</body>
</html>
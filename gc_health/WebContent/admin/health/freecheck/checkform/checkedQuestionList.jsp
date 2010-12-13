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

<fieldset id="src">
	<legend>게시판 게시물검색</legend>	
	
	<form name="sfm" action="/admin/freecheck/checkform/list.do" method="post">
		<span style="float: right;">
		<label for="stributary" class="blind">게시물 분류 선택</label>
		
		<input type="image" alt="검색" src="/health/open_content/images/borad/btn_search.gif" style="float: right;"/>
		
		<select id="select_year_cd" name="year_cd" style="width: 100px; float: right; margin-right: 10px;" onchange="submit();" >
			<option value="201001" <c:if test="${Bean.year_cd == '201001'}">selected="selected"</c:if>>2010 년</option>
			<option value="200901" <c:if test="${Bean.year_cd == '200901'}">selected="selected"</c:if>>2009 년</option>
			<option value="200801" <c:if test="${Bean.year_cd == '200801'}">selected="selected"</c:if>>2008 년</option>
		</select>
		<select name="searchCondition" style="width: 100px; float: right; margin-right: 10px;" onchange="submit();">
			<option value='1' <c:if test="${Bean.searchCondition == '1' or Bean.searchCondition == ''}">selected="selected"</c:if>>년도</option>
		</select>
		
		</span>
	</form>
</fieldset>

<div style="float: right; height: 30px; margin-right: 10px;">
	<strong>리스트 : ${fn:length(resultList)} 건 / 전체 : ${fn:length(resultList)} 건</strong>
</div>

<table class="default_list" summary="의약업소 자율점검 (점검표관리) 목록 테이블입니다">
	<caption>의약업소 자율점검 (점검표관리) 목록</caption>
	<colgroup>
<!--		<col width="5%" />-->
		<col width="5%" />
		<col width="*" />
		<col width="5%" />
		<col width="25%" />
		<col width="8%" />
		<col width="8%" />
		<col width="8%" />
		<col width="8%" />
	</colgroup>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">업소명</th>
			<th scope="col">점검표</th>
			<th scope="col">문제수</th>
			<th scope="col">맞은문제수</th>
			<th scope="col">틀린문제수</th>
			<th scope="col">틀린문제</th>
			<th scope="col">점검일</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${fn:length(resultList) > 0}">
			<c:set var="resultListSize" value="${fn:length(resultList)}" />
			<c:forEach items="${resultList}" var="item" varStatus="status">
				<c:if test="${item.MASTER_CD == 47 or fn:contains(item.TITLE, '마약')}">
					<tr>
						<td colspan="4">
							<strong>계</strong>
						</td>
						<td colspan="1">
							<strong>${sum_type_tot_cnt_except_for_drug}</strong>
						</td>
						<td colspan="1">
							<strong>${sum_answer_cnt_except_for_drug}</strong>
						</td>
						<td colspan="1">
							<strong>${sum_noanswer_cnt_except_for_drug}</strong>
						</td>
						<td colspan="2"></td>
					</tr>
				</c:if>
				
				<tr>
					<!-- 타입 -->
					<td>
						<!-- ${(resultListSize + 1) - ((Bean.pageIndex - 1) * Bean.pageSize + status.count)} -->
						${item.TYPE_CD}
					</td>
					
					<!-- 제목-->
					<td class="tal">
						<c:url var="actionUrl" value="/admin/freecheck/checkform/read.do">
							<c:param name="year_cd" value="${Bean.year_cd}"/>
							<c:param name="master_cd" value="${item.MASTER_CD}"/>
							<c:param name="pageIndex" value="${Bean.pageIndex}"/>
						</c:url>
						<a href="${actionUrl}">${item.TITLE}</a><label></label>
					</td>
					
					<!-- 첨부파일 -->
					<td>
						
						<c:if test="${item.ATTACHFILEORG1 == null}"><font style="color: lightdrakgray;">-</font></c:if>
						<c:if test="${item.ATTACHFILEORG1 != null}">
							<c:url value="/health/freecheck/download.do" var="download_action">
								<c:param name="file" value="${item.ATTACHFILE1}" />
							</c:url>
							<a href="${download_action}">${item.ATTACHFILEORG1}</a>
						</c:if>
						
					</td>
					
					
					<!-- 점검기간 -->
					<td>
						<fmt:formatDate value="${item.START_DT}" pattern="yyyy년MM월dd일"/>
						 ~ <fmt:formatDate value="${item.END_DT}" pattern="yyyy년MM월dd일"/>
					</td>
					
					<!-- 총수 -->
					<td>
						${item.TYPE_TOT_CNT}
					</td>
					
					<!-- 점검수 -->
					<td>
						<c:url var="checked_company_list_url" value="/admin/freecheck/checkform/list_checked_company.do">
							<c:param name="year_cd" value="${Bean.year_cd}"/>
							<c:param name="master_cd" value="${item.MASTER_CD}"/>
							<c:param name="pageIndex" value="${Bean.pageIndex}"/>
						</c:url>
						<a href="${checked_company_list_url}"><strong style="color: drakgray;">${item.ANSWER_CNT}</strong></a>
					</td>
					
					<!-- 미점검 -->
					<td>
						<c:url var="not_checked_company_list_url" value="/admin/freecheck/checkform/list_not_checked_company.do">
							<c:param name="year_cd" value="${Bean.year_cd}"/>
							<c:param name="master_cd" value="${item.MASTER_CD}"/>
							<c:param name="pageIndex" value="${Bean.pageIndex}"/>
						</c:url>
						<a href="${not_checked_company_list_url}"><strong style="color: drakgray;">${item.NOANSWER_CNT}</strong></a>
					</td>
					
					<!-- 일자 -->
<!--					<td>-->
<!--						<fmt:formatDate value="${item.INSERT_DT}" pattern="yyyy년MM월dd일"/>-->
<!--					</td>-->
					
					<!-- 문제수 -->
					<td>
						<c:url var="question_list_url" value="/admin/freecheck/checkform/list_question.do">
							<c:param name="year_cd" value="${Bean.year_cd}"/>
							<c:param name="master_cd" value="${item.MASTER_CD}"/>
							<c:param name="pageIndex" value="${Bean.pageIndex}"/>
							<c:param name="title" value="${item.TITLE}"/>
						</c:url>
						<a href="${question_list_url}"><strong style="color: drakgray;">${item.QUESTION_CNT} 문제</strong></a>
					</td>
				</tr>
			</c:forEach>
		</c:if>
		
		<c:if test="${fn:length(resultList) != 0}">
			<tr>
				<td colspan="4">
					<strong>합계</strong>
				</td>
				<td colspan="1">
					<strong>${sum_type_tot_cnt}</strong>
				</td>
				<td colspan="1">
					<strong>${sum_answer_cnt}</strong>
				</td>
				<td colspan="1">
					<strong>${sum_noanswer_cnt}</strong>
				</td>
				<td colspan="1"></td>
			</tr>
		</c:if>
		
		<c:if test="${fn:length(resultList) == 0}">
			<tr>
				<td colspan="8">검색된 리스트가 없습니다.</td>
			</tr>
		</c:if>
	</tbody>
</table>
<!-- board list end //-->

	<form action="<c:url value="/admin/freecheck/checkform/forInsert.do"/>" method="post">
		<input type="hidden" name="year_cd" value="${Bean.year_cd}" />
<div class="board_btn_set mt13">
	<span class="btn_del"><input type="submit" value="등록하기" /></span>
</div>
	</form>

<ol class="paging">${pagingInfoString}</ol>
 
</div>
</body>
</html>

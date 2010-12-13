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

<script>

function selectCheckedHandleitemList(year_cd, company_cd, company_id) {
	var openParam = "dialogWidth:800px;dialogHeight:500px;scroll:yes;status:no;center:yes;resizable:no;";
	var varParam = new Object();
	window.showModalDialog('/admin/freecheck/checkform/checked_handleitem_list.do?year_cd='+year_cd+'&company_cd='+company_cd+'&company_id='+company_id, varParam, openParam);
	return false;
};


function viewAnswer(master_cd, company_cd, divide_cd) {
	var openParam = "dialogWidth:830px;dialogHeight:600px;scroll:yes;status:no;center:yes;resizable:yes;";
	var varParam = new Object();
	window.showModalDialog('/admin/freecheck/checkform/viewAnswer.do'+
			'?company_cd='+company_cd+
			'&master_cd='+master_cd+
			'&divide_cd='+divide_cd+
			'&view_state=readonly', varParam, openParam);
	return false;
};


</script>

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
	
<div class="board_btn_set mt13">
	<c:url var="list_action" value="/admin/freecheck/checkform/saveExcel.do">
		<c:param name="master_cd" value="${Bean.master_cd}"/>
	</c:url>
	<span class="btn_list"><a href="${list_action}">엑셀저장</a></span>
</div>
			
			<br/>
			<br/>
	
	<table class="default_list" summary="의약업소 자율점검 (점검표관리) 목록 테이블입니다">
		<caption>의약업소 자율점검 (점검표관리) 목록</caption>
<!--		<colgroup>-->
<!--			<col width="5%" />-->
<!--			<col width="*" />-->
<!--			<col width="10%" />-->
<!--			<col width="10%" />-->
<!--			<col width="8%" />-->
<!--			<col width="12%" />-->
<!--			<col width="15%" />-->
<!--			<col width="5%" />-->
<!--		</colgroup>-->
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">업소명</th>
				<th scope="col">아이디</th>
<!--				<th scope="col">업종</th>-->
				<th scope="col">이름</th>
				<th scope="col">전화번호</th>
				<th scope="col">점검일자</th>
				<c:if test="${checkformInfo.type_cd == '11'}"><th scope="col">취급품목</th></c:if>
				<th scope="col">관리</th>
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
						
						<!-- ID-->
						<td>
							${item.ID}
						</td>
						
						<!-- 업종 -->
<!--						<td>-->
<!--							${item.INDUSTRY_NAME}-->
<!--						</td>-->
						
						<!-- 이름 -->
						<td>
							${item.CEO_NAME}
						</td>
						
						<!-- 전화번호 -->
						<td>
							${item.TEL}
						</td>
						
						<!-- 점검일자 -->
						<td>
							<fmt:formatDate value="${item.INSERT_DT}" pattern="yyyy년MM월dd일"/>
						</td>
						
						<!-- 취급품목 -->
						<c:if test="${checkformInfo.type_cd == '11'}">
							<td>
								<c:if test="${item.CNT > 0}">
									<strong><a href="" onclick="selectCheckedHandleitemList(${Bean.year_cd},${item.COMPANY_CD},${item.ID}); return false;">${item.CNT} 개</a></strong>
								</c:if>
								<c:if test="${item.CNT == null}">
									취급안함
								</c:if>
								<c:if test="${item.CNT == 0}">
									${item.CNT} 개
								</c:if>
							</td>
						</c:if>
						
						<!-- 관리 -->
						<td>
							<c:url value="/admin/freecheck/checkform/list_checked_company/delete.do" var="delete_url">
								<c:param name="master_cd" value="${Bean.master_cd}"></c:param>
								<c:param name="year_cd" value="${Bean.year_cd}"></c:param>
								<c:param name="delete_company_id" value="${item.ID}"></c:param>
								<c:param name="type_cd" value="${checkformInfo.type_cd}"></c:param>
							</c:url>
							<a href="${delete_url}" onclick="return confirm('삭제한 내역은 복구되지 않습니다. [${item.COMPANY}]의 점검한 내역을 삭제하시겠습니까?');">삭제</a>
							
							<a href="" onclick="viewAnswer(${Bean.master_cd}, ${item.COMPANY_CD}, '${item.DIVIDE_CD}'); return false;">보기</a>
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
	<c:url var="list_action" value="/admin/freecheck/checkform/list.do">
		<c:param name="searchKeyword" value="${Bean.searchKeyword}"/>
		<c:param name="year_cd" value="${Bean.year_cd}"/>
	</c:url>
	<span class="btn_list"><a href="${list_action}">목록보기</a></span>
</div>
	
</div>
</body>
</html>

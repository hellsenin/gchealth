<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/admin/health/application/applyStatus.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
<link href="/health/open_content/system/css/default.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/common.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/blue.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_blue.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="/health/open_content/system/js/Calendar.js"></script>

</head>
<body style="background:none;padding:10px;">
<h3 class="tit_03">모범업소지정신청</h3>

<div class="board_top clearfix">
    <div class="fl_l"> <span>${pageInfo.totCnt}건 [${pageInfo.pageIndex} / ${pageInfo.totalPageCount}Page]</span> </div>
	<form id="searchFrm" name="searchFrm"  method="post"  action="/admin/health/application/selectApplicationList.do?applyCode=${param.applyCode}">
    <fieldset class="fl_r">
    		신청일
			<input type="text" id="receiptSdate" name="sdate" class="intext" value="${param.sdate}" style="width:125px"/><a href="javascript:Calendar_D(searchFrm.sdate)"><img src="/health/open_content/images/calendar.gif" class="vat" alt=""/></a> ~ 
			<input type="text" id="receiptEdate" name="edate" class="intext" value="${param.edate}" style="width:125px"/><a href="javascript:Calendar_D(searchFrm.edate)"><img src="/health/open_content/images/calendar.gif" class="vat" alt=""/></a>
        <legend>게시물검색</legend>
			<label for="searchType">검색 선택</label>
			<select id="searchType" name="searchType" >
			<option value="">전체</option>
				<option value="1">신청인</option>
			</select>
			<input type="text" id="searchTxt" name="searchTxt" title="검색어입력" class="intext" value="${param.searchTxt}"/>
			<input type="image" src="/health/open_content/images/borad/btn_search.gif" alt="검색" />
		</fieldset>	
	</form>
</div>

				<table class="default_list" cellspacing="1" cellpadding="0" width="600">
				<colgroup>
						<col width="80" /><col width="100" /><col width="*" /><col width="100" /><col width="100" /><col width="130" />
					</colgroup>
					<thead>
					<tr>
						<th id="board_num">번호</th>
						<th id="board_memid">신청인</th>
						<th id="board_birthday">업소및기관명</th>
						<th id="board_regedit">대표자명</th>
						<th id="board_regedit">신청일</th>
						<th id="board_regedit">상태</th>
					</tr>
					</thead>

		<!-- ##### 공지글 시작 ##### -->
				<tbody>
					<c:if test="${fn:length(resultList) > 0}" >
					<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}">  
					<tr>
						<td headers="board_num">${pageInfo.totCnt - (pageInfo.pageIndex-1)*pageInfo.pageUnit - x}</td>
						<td headers="board_memid"><span style="font-weight:bold"><a href="/admin/health/application/modifyPage.do?applyCode=${param.applyCode}&applyId=${resultList[x].applyId}">${resultList[x].name}</a></span></td>
						<td headers="board_memid"><span style="font-weight:bold">${resultList[x].etc1}</span></td>
						<td headers="board_linktype">${resultList[x].etc2}</td>
						<td headers="board_create">${resultList[x].applyDate}</td>
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
					</tr>
					</c:forEach>
					</c:if>
					<c:if test="${fn:length(resultList) == 0}" >
					<tr><td colspan="6">데이터가 없습니다</td></tr>
					</c:if>
		        </tbody>
      </table>

<ol class="paging">${pageNav}</ol>

			<div class="board_btn_set mt13">
				<span class="btn_del"><a href="/admin/health/application/writePage.do?applyCode=${param.applyCode}">등록하기</a></span>
			</div>
</body>
</html>
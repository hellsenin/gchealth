<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
<link href="/health/open_content/system/css/default.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/common.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/blue.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_blue.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="/admin/common/js/Calendar.js"></script>

<script type="text/javascript">
	function search()
	{			
		var form = $("frm");
		form.submit();
	}

</script>

</head>
<body style="background:none;padding:10px;">
<h3 class="tit_03">신청마스터</h3>

<div class="board_top clearfix">
    <div class="fl_l"> <span>${pageInfo.totCnt}건 [${pageInfo.pageIndex} / ${pageInfo.totalPageCount}Page]</span> </div>
	<form id="frm" name="frm"  method="post"  action="/admin/health/applyMst/selectApplyMstList.do">
		<input type="hidden" name="applyCode" value="${param.applyCode}" />
    <fieldset class="fl_r">
        <legend>게시물검색</legend>
			<label for="searchType">검색 선택</label>
			<select id="searchType" name="searchType" >
				<option value="1">신청명</option>
			</select>
			<input type="text" id="searchTxt" name="searchTxt" title="검색어입력" class="intext" value="${param.searchTxt}"/>
			<a href="javascript:search();"><img src="/health/open_content/images/borad/btn_search.gif" alt="검색" /></a>
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
						<th id="board_memid">신청코드</th>
						<th id="board_birthday">신청명</th>
						<th id="board_regedit">신청유형</th>
						<th id="board_regedit">등록일</th>
						<th id="board_regedit">사용여부</th>
					</tr>
					</thead>

		<!-- ##### 공지글 시작 ##### -->
				<tbody>
					<c:if test="${fn:length(resultList) > 0}" >
					<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}">  
					<tr>
						<td headers="board_num">${pageInfo.totCnt - (pageInfo.pageIndex-1)*pageInfo.pageUnit - x}</td>
						<td headers="board_memid"><span style="font-weight:bold"><a href="/admin/health/applyMst/modifyPage.do?applyCode=${resultList[x].applyCode}">${resultList[x].applyCode}</a></span></td>
						<td headers="board_memid"><span style="font-weight:bold"><a href="/admin/health/applyMst/modifyPage.do?applyCode=${resultList[x].applyCode}">${resultList[x].applyName}</a></span></td>
						<td headers="board_linktype">
							<c:if test="${resultList[x].applyAttrb == '1'}" >일반신청</c:if>
							<c:if test="${resultList[x].applyAttrb == '2'}" >교육신청</c:if>
						</td>
						<td headers="board_create">${resultList[x].regDate}</td>
						<td>
							<c:if test="${resultList[x].useYn == 'Y'}" >사용</c:if>
							<c:if test="${resultList[x].useYn == 'N'}" >미사용</c:if>
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
	<span class="btn_del"><a href="/admin/health/applyMst/writePage.do">등록하기</a></span>

</div>
			
</body>
</html>
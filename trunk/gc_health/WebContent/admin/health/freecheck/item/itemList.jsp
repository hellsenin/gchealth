<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	java.util.Calendar cal1 = java.util.Calendar.getInstance();
	int year = cal1.get(java.util.Calendar.YEAR);
	pageContext.setAttribute("year", year);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
<link href="/health/open_content/system/css/default.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/common.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/blue.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_blue.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="/health/open_content/system/js/Calendar.js"></script>

<script type="text/javascript" src="/health/open_content/system/js/prototype.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/jslb_ajax.js"></script>
<script type="text/javascript">

function checkForm(form)
{			
	var v = new MiyaValidator(form);
    v.add("itemName", {
        required: true
    });
	v.add("masterCd", {
        required: true
    });
	result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return false;
	} 
	else
	{
		return true;
	}
}
</script>
</head>
<body style="background:none;padding:10px;">
<h3 class="tit_03">취금품목관리</h3>

<fieldset id="src">
	<legend>게시판 게시물검색</legend>	
	
	<form action="/admin/freecheck/selectItemList.do" method="post">
		<span style="float: right;">
		<label for="stributary" class="blind">게시물 분류 선택</label>
		
		<input type="image" alt="검색" src="/health/open_content/images/borad/btn_search.gif" style="float: right;"/>
		
<!--		<select name="searchKeyword" onchange="submit();" style="float: right; width: 100px; margin-right: 10px;">-->
<!--			<option value='' <c:if test="${Bean.searchKeyword == ''}">selected="selected"</c:if>>선택하세요</option>-->
<!--			<option value='01' <c:if test="${Bean.searchKeyword == '01'}">selected="selected"</c:if>>의료기관</option>-->
<!--			<option value='02' <c:if test="${Bean.searchKeyword == '02'}">selected="selected"</c:if>>약업소</option>-->
<!--		</select>-->

		<select id="select_year_cd" name="year_cd" style="float: right; width: 100px; margin-right: 10px;" style="float: right; width: 200px;">
		<c:forEach var="x" begin="${year-2}" end="${year}">
			<option value="${x}" <c:if test="${zvl.yearCd == x}">selected="selected"</c:if>>${x} 년</option>
		</c:forEach>
		</select>

		<select name="searchCondition" class="select" style="width: 100px; float: right; margin-right: 10px;" onchange="submit();">
			<option value='1' <c:if test="${Bean.searchCondition == '1'}">selected="selected"</c:if>>년도</option>
<!--			<option value='2' <c:if test="${Bean.searchCondition == '2'}">selected="selected"</c:if>>분류</option>-->
		</select>
		
		</span>
	</form>
</fieldset>

		<table class="default_list" cellspacing="1" cellpadding="0" width="600">
				<colgroup>
					<col width="100" /><col width="*" /><col width="100" /><col width="100" /><col width="100" /><col width="50" />
				</colgroup>
				<thead>
				<tr>
					<th id="board_memid">취급품목명</th>
					<th id="board_birthday">연동된점검표</th>
					<!--<th id="board_regedit">점검제외항목</th>-->
					<th id="board_regedit">등록일</th>
					<th id="board_regedit">관리</th>
				</tr>
				</thead>

	<!-- ##### 공지글 시작 ##### -->
			<tbody>
				<c:if test="${fn:length(resultList) > 0}" >
				<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}">  
				<tr>
					<td headers="board_memid"><span style="font-weight:bold">${resultList[x].itemName}</span></td>
					<td headers="board_memid"><span style="font-weight:bold">${resultList[x].title}</span></td>
					<!--<td>${resultList[x].exceptNum}</td>-->
					<td headers="board_linktype">${resultList[x].regDate}</td>
					<td headers="board_memid"><span style="font-weight:bold"><a href="/admin/freecheck/delItem.do?itemId=${resultList[x].itemId}">삭제</a></span></td>
				</tr>
				</c:forEach>
				</c:if>
				<c:if test="${fn:length(resultList) == 0}" >
				<tr><td colspan="5">데이터가 없습니다</td></tr>
				</c:if>
	        </tbody>
      </table>
<br/>
<br/>
	<form id="searchFrm" name="searchFrm"  method="post" action="/admin/freecheck/addItem.do" onsubmit="return checkForm(this);">
		<input type="hidden" name="year_cd" value="${zvl.yearCd}" />
		<table class="default_write" cellspacing="1" cellpadding="0" width="300">
				<colgroup>
					<col width="150" /><col width="*" />
				</colgroup>
				<thead>
				<tr>
					<th id="board_num">취급품목명</th>
					<th id="board_memid">점검표선택</th>
				</tr>
				</thead>

	<!-- ##### 공지글 시작 ##### -->
			<tbody>
				<tr>
					<td headers="board_num">
						<input type="text" name="itemName" />
					</td>
					<td headers="board_memid">
			<select id="masterCd" name="masterCd" >
				<option value="">점검표선택</option>
				<c:if test="${fn:length(masterList) > 0}" >
				<c:forEach var="x" begin="0" end="${fn:length(masterList)-1}">  
					<option value="${masterList[x].masterCd}">${masterList[x].title}</option>
				</c:forEach>
				</c:if>
			</select>
					</td>
					<!--<td headers="board_num"><input type="text" name="exceptNum" /></td>-->
				</tr>
	        </tbody>
      </table>

			<div class="board_btn_set mt13">
	<span class="btn_del"><input type="submit" value="등록하기" /></span>
			</div>
	</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	java.util.Calendar cal1 = java.util.Calendar.getInstance();
	int year = cal1.get(java.util.Calendar.YEAR);
	pageContext.setAttribute("year", year);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<title>금천시 보건소</title>
<link href="/health/open_content/system/css/default.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/common.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/blue.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_blue.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="/health/open_content/system/js/prototype.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/jslb_ajax.js"></script>
<script type="text/javascript">
function selectMasterListByIndustry() 
{
	var url = "/admin/freecheck/selectMasterListByIndustry.do";
	var param = "&industryCd="+$F("industryCd");  
	sendRequest(callbackSelectLinkedMaster, param, 'POST', url, true, true);
}

function callbackSelectLinkedMaster(oj)
{
    try 
    {
    	var jsonData = oj.responseText;
        var j = eval('(' + jsonData + ')');
        var titleData = j.title ? j.title.split("|") : '';
        var masterCdData = j.masterCd ? j.masterCd.split("|") : '';
        var selectObj = $("masterCd");
		selectObj.innerHTML = "";

        for(i=0;i<masterCdData.length;i++)
        {
        	var opt = document.createElement("OPTION");
        	selectObj.options.add(opt);
        	opt.innerText = titleData[i];
        	opt.value = masterCdData[i];
        }
    } 
    catch (err)
    {
        alert("FUNCTION : callbackSelectLinkedMaster() " + err.description);
    }
}

function checkForm(f)
{
	f.masterTitle.value = $("masterCd").options[$("masterCd").selectedIndex].text;
	f.action = "/admin/freecheck/selectMasterCompanyPointList.do";
	return true;
}

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

function excelDown()
{
	var f = document.sfm;
	f.action = "/admin/freecheck/selectMasterCompanyPointListForExcel.do";
	f.submit();
}
</script>

</head>
<body style="background:none;padding:10px;">
<h2 style="padding:15px 0 15px 0;">	
점검표점수관리
</h2>
<p class="title_deco"></p>
<div class="body">

<fieldset id="src">
	<legend>게시판 게시물검색</legend>	
	
	<form name="sfm" action="/admin/freecheck/selectMasterCompanyPointList.do" method="post" onsubmit="return checkForm(this)">
<!--		<span style="float: left;">-->
<!--			<label for="select_year_cd">년도</label>-->
<!--		</span>-->
		<span style="float: right;">
		<label for="stributary" class="blind">게시물 분류 선택</label>
		<input type="image" alt="검색" src="/health/open_content/images/borad/btn_search.gif" style="float: right;"/>
		
		<input type="text" id="searchTxt" name="searchTxt" value="${param.searchTxt}" style="float: right; width: 150px; height: 18px; padding-left: 2px;" class="board1" />
		
		<select name="searchType" style="width: 100px; float: right; margin-right: 10px;">
			<option value=''>선택하세요</option>
			<option value='1' <c:if test="${param.searchCondition == '1'}">selected="selected"</c:if>>업소명</option>
			<option value='2' <c:if test="${param.searchCondition == '2'}">selected="selected"</c:if>>아이디</option>
			<option value='3' <c:if test="${param.searchCondition == '3'}">selected="selected"</c:if>>대표자</option>
		</select>
		
		<select name="masterCd" id="masterCd" style="float: right;">
		<c:choose>
		<c:when test="${empty param.masterCd}">
			<option value=''>점검표</option>
		</c:when>
		<c:otherwise>
			<option value='${param.masterCd}'>${param.masterTitle}</option>
		</c:otherwise>
		</c:choose>
		</select>
		<input type="hidden" name="masterTitle" value="" />
		
		<select name="industryCd" id="industryCd" style="float: right; width: 150px;" onchange="selectMasterListByIndustry();">
			<option value=''>업종</option>
			<c:forEach items="${industryAttrList}" var="industry_item">
			<option value='${industry_item.industryCd}' <c:if test="${param.industryCd == industry_item.industryCd}">selected="selected"</c:if>>${industry_item.name}</option>
			</c:forEach>
		</select>
			
		<select id="select_year_cd" name="year_cd" style="width: 100px; float: right; margin-right: 20px;">
			<option value='${year}' <c:if test="${Bean.year_cd == year}">selected="selected"</c:if>>${year} 년도</option>
			<option value='${year-1}' <c:if test="${Bean.year_cd == year-1}">selected="selected"</c:if>>${year-1} 년도</option>
			<option value='${year-2}' <c:if test="${Bean.year_cd == year-2}">selected="selected"</c:if>>${year-2} 년도</option>
		</select>
		
		</span>
	</form>
</fieldset>

<div class="board_btn_set mt13">
	
	<span class="btn_list"><a href="javascript:excelDown();">엑셀저장</a></span>
</div>

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
		<col width="10%" />
		<col width="13%" />
	</colgroup>
	 -->
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">업소명</th>
			<th scope="col">문제수</th>
			<th scope="col">맞은문제수</th>
			<th scope="col">틀린문제수[틀린문항]</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${fn:length(resultList) != 0}">
			<c:forEach items="${resultList}" var="item" varStatus="status">
				<c:set var="falseList" value="${falseMap[item.id]}" />
				<tr>
					<!-- 번호 -->
					<td>
						${fn:length(resultList) - status.count + 1}
					</td>
					
					<!-- 업소명-->
					<td class="tal">
						<a href="" onclick="viewAnswer(${item.masterCd}, ${item.companyCd}, '${item.divideCd}'); return false;">${item.company}</a>
					</td>
					
					<!-- 문제수 -->
					<td>
						<a href="${actionUrl}">${item.questionCnt}</a>
					</td>
					
					<!-- 맞은문제수 -->
					<td>
						${item.correctAnswerCnt}
					</td>
					
					<!-- 틀린문제수 -->
					<td>
						${item.wrongAnswerCnt}[
					<c:forEach items="${falseList}" var="f" varStatus="status">
						${f.qnum},
					</c:forEach>
						]
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

</div>
</body>
</html>

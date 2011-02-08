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
<script type="text/javascript" src="/health/open_content/system/js/prototype.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>
<link href="/health/open_content/system/css/default.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/common.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/blue.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_blue.css" rel="stylesheet" type="text/css" />

<script>
function switch_search_keyword(val) {
	if(val== '1' || val=='') {
		document.getElementById('industry_cd').style.display = "block";
		document.getElementById('company').style.display = "none";
		document.getElementById('ceo_name').style.display = "none";
		document.getElementById('id').style.display = "none";
		document.getElementById('grade_cd').style.display = "none";
	} else if(val== '2' || val=='') {
		document.getElementById('industry_cd').style.display = "none";
		document.getElementById('company').style.display = "none";
		document.getElementById('ceo_name').style.display = "none";
		document.getElementById('id').style.display = "none";
		document.getElementById('grade_cd').style.display = "none";
	} else if(val== '3') {
		document.getElementById('industry_cd').style.display = "none";
		document.getElementById('company').style.display = "block";
		document.getElementById('ceo_name').style.display = "none";
		document.getElementById('id').style.display = "none";
		document.getElementById('grade_cd').style.display = "none";
	} else if(val== '4') {
		document.getElementById('industry_cd').style.display = "none";
		document.getElementById('company').style.display = "none";
		document.getElementById('ceo_name').style.display = "block";
		document.getElementById('id').style.display = "none";
		document.getElementById('grade_cd').style.display = "none";
	} else if(val== '5') {
		document.getElementById('industry_cd').style.display = "none";
		document.getElementById('company').style.display = "none";
		document.getElementById('ceo_name').style.display = "none";
		document.getElementById('id').style.display = "block";
		document.getElementById('grade_cd').style.display = "none";
	} else if(val== '6') {
		document.getElementById('industry_cd').style.display = "none";
		document.getElementById('company').style.display = "none";
		document.getElementById('ceo_name').style.display = "none";
		document.getElementById('id').style.display = "none";
		document.getElementById('grade_cd').style.display = "block";
	} 
};

function checkForm2(form)
{			
	var v = new MiyaValidator(form);
    v.add("toYearCd", {
        required: true,
        message: "기준년도를 선택하세요"
    });
	v.add("fromYearCd", {
        required: true,
        message: "전년도를 선택하세요"
    });
	result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return false;
	} 
	else
	{
		var fromYear = form.fromYearCd.value;
		var toYear = form.toYearCd.value;
		if(confirm(toYear + "년도에 해당하는 데이터삭제후 등록됩니다. 등록하시겠습니까?"))
			return true;
		else
			return false;
	}
}
</script>

</head>
<body style="background:none;padding:10px;">
<h2 style="padding:15px 0 15px 0;">	
의약업소 자율점검 (업소관리)
</h2>
<p class="title_deco"></p>
<div class="body">

<fieldset id="src">
	<legend>게시판 게시물검색</legend>	
	
	<form name="sfm" action="/admin/freecheck/company/list.do" method="post">
<!--		<span style="float: left;">-->
<!--			<label for="select_year_cd">년도</label>-->
<!--		</span>-->
		<span style="float: right;">
		<label for="stributary" class="blind">게시물 분류 선택</label>
		<input type="image" alt="검색" src="/health/open_content/images/borad/btn_search.gif" style="float: right;"/>
		
		<select name="industry_cd" id="industry_cd" onchange="submit();" style="float: right; width: 250px;">
			<option value='0' <c:if test="${Bean.industry_cd == 0}">selected="selected"</c:if>>선택하세요</option>
			<c:forEach items="${resultIndustrySelection}" var="industry_item">
				<option value='${industry_item.industry_cd}' <c:if test="${Bean.industry_cd == industry_item.industry_cd}">selected="selected"</c:if>>${industry_item.divide_cd_name} - ${industry_item.name}</option>
			</c:forEach>
		</select>
		
		<input type="text" id="company" name="company" value="${Bean.company}" style="float: right; display: none; width: 250px; height: 18px; padding-left: 2px;" class="board1" />
		
		<input type="text" id="ceo_name" name="ceo_name" value="${Bean.ceo_name}" style="float: right; display: none; width: 250px; height: 18px; padding-left: 2px;" class="board1" />
		
		<input type="text" id="id" name="id" value="${Bean.id}" style="float: right; display: none; width: 250px; height: 18px; padding-left: 2px;" class="board1" />
		
		<select name="grade_cd" id="grade_cd" onchange="submit();" style="float: right; display: none; width: 250px;">
			<option value='' <c:if test="${Bean.grade_cd == ''}">selected="selected"</c:if>>선택하세요</option>
			<option value='01' <c:if test="${Bean.grade_cd == '01'}">selected="selected"</c:if>>휴업</option>
			<option value='02' <c:if test="${Bean.grade_cd == '02'}">selected="selected"</c:if>>영업</option>
			<option value='03' <c:if test="${Bean.grade_cd == '03'}">selected="selected"</c:if>>폐업</option>
		</select>
		
		<select name="searchCondition" style="width: 100px; float: right; margin-right: 10px;" onchange="submit();">
			<option value='1' <c:if test="${Bean.searchCondition == '1' or Bean.searchCondition == ''}">selected="selected"</c:if>>업종</option>
			<option value='3' <c:if test="${Bean.searchCondition == '3'}">selected="selected"</c:if>>업소명</option>
			<option value='5' <c:if test="${Bean.searchCondition == '5'}">selected="selected"</c:if>>아이디</option>
			<option value='4' <c:if test="${Bean.searchCondition == '4'}">selected="selected"</c:if>>대표자</option>
			<option value='6' <c:if test="${Bean.searchCondition == '6'}">selected="selected"</c:if>>영업형태</option>
		</select>
		
		<select id="select_year_cd" name="year_cd" onchange="submit();" style="width: 100px; float: right; margin-right: 20px;">
			<option value='${year}' <c:if test="${Bean.year_cd == year}">selected="selected"</c:if>>${year} 년도</option>
			<option value='${year-1}' <c:if test="${Bean.year_cd == year-1}">selected="selected"</c:if>>${year-1} 년도</option>
			<option value='${year-2}' <c:if test="${Bean.year_cd == year-2}">selected="selected"</c:if>>${year-2} 년도</option>
		</select>
		
		</span>
	</form>
</fieldset>

<script>
switch_search_keyword('${Bean.searchCondition}');
</script>


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
			<th scope="col">아이디</th>
			<th scope="col">대표자</th>
			<th scope="col">업종</th>
			<th scope="col">영업형태</th>
<!--			<th scope="col">등록일자</th>-->
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
						<c:url var="actionUrl" value="/admin/freecheck/company/select.do">
							<c:param name="company_cd" value="${item.company_cd}"/>
							<c:param name="pageIndex" value="${Bean.pageIndex}"/>
							<c:param name="searchCondition" value="${Bean.searchCondition}"/>
							<c:param name="industry_cd" value="${Bean.industry_cd}"/>
							<c:param name="type_cd" value="${Bean.type_cd}"/>
							<c:param name="company" value="${Bean.company}"/>
							<c:param name="ceo_name" value="${Bean.ceo_name}"/>
							<c:param name="id" value="${Bean.id}"/>
							<c:param name="grade_cd" value="${Bean.grade_cd}"/>
						</c:url>
						<a href="${actionUrl}">${item.company}</a>
					</td>
					
					<!-- 아이디 -->
					<td>
						<a href="${actionUrl}">${item.id}</a>
					</td>
					
					<!-- 대표자 -->
					<td>
						${item.ceo_name}
					</td>
					
					<!-- 업종 -->
					<td>
						${item.industry_name}
					</td>
					
					<!-- 영업형태 -->
					<td>
						${item.grade_cd_name}
					</td>					
					<!-- 등록일자 -->
<!--					<td>-->
<!--						<fmt:formatDate value="${item.insert_dt}" pattern="yyyy년MM월dd일"/>-->
<!--					</td>-->
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

	<form action="<c:url value="/admin/freecheck/company/forInsert.do"/>" method="post">
		<input type="hidden" name="pageIndex" value="${Bean.pageIndex}"/>
		<input type="hidden" name="searchCondition" value="${Bean.searchCondition}"/>
		<input type="hidden" name="industry_cd" value="${Bean.industry_cd}"/>
		<input type="hidden" name="type_cd" value="${Bean.type_cd}"/>
		<input type="hidden" name="company" value="${Bean.company}"/>
		<input type="hidden" name="ceo_name" value="${Bean.ceo_name}"/>
		<input type="hidden" name="id" value="${Bean.id}"/>
		<input type="hidden" name="grade_cd" value="${Bean.grade_cd}"/>
		<input type="hidden" name="year_cd" value="${Bean.year_cd}"/>
<div class="board_btn_set mt13">
	<span class="btn_del"><input type="submit" value="등록하기" /></span>
</div>
	</form>
			
<ol class="paging">${pagingInfoString}</ol>

<br/>
<br/>
<h3 style="padding:15px 0 15px 0;">	
이전자료 가져오기
</h3>
	<form id="f" name="f"  method="post" action="/admin/freecheck/addCompanyForMigration.do" onsubmit="return checkForm2(this);">
		<table class="default_write" cellspacing="1" cellpadding="0" width="500">
	<thead>
		<tr>
			<th scope="col">기준년도</th>
			<th scope="col">이전년도</th>
			<th scope="col">등록</th>
		</tr>
	</thead>
			<tbody>
				<tr>
					<td headers="board_num">
		<select id="toYearCd" name="toYearCd" style="width: 100px; float: right; margin-right: 20px;">
			<option value='' >기준년도선택</option>
			<option value='${year}' <c:if test="${Bean.year_cd == year}">selected="selected"</c:if>>${year} 년도</option>
			<option value='${year-1}' <c:if test="${Bean.year_cd == year-2}">selected="selected"</c:if>>${year-1} 년도</option>
		</select>
		
					</td>
					<td headers="board_num">
		<select id="fromYearCd" name="fromYearCd" style="width: 100px; float: right; margin-right: 20px;">
			<option value='' >전년도선택</option>
			<option value='${year-1}' <c:if test="${Bean.year_cd == year-1}">selected="selected"</c:if>>${year-1} 년도</option>
			<option value='${year-2}' <c:if test="${Bean.year_cd == year-2}">selected="selected"</c:if>>${year-2} 년도</option>
		</select>
		
					</td>
					<td headers="board_memid">
			<div class="board_btn_set mt13">
	<span class="btn_del"><input type="submit" value="등록하기" /></span>
			</div>
					</td>
				</tr>
	        </tbody>
      </table>

	</form>
</div>

</body>
</html>

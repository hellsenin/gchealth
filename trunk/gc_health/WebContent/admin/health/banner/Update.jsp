<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<title>금천시 보건소</title>
<script type="text/javascript" src="/health/open_content/system/js/Calendar.js" ></script>

<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/util.js"></script>

<link href="/health/open_content/system/css/default.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/common.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/blue.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_blue.css" rel="stylesheet" type="text/css" />

<style type="text/css">
body { width:650px; }
</style>
<script>

function checkAndSubmit(f) {

	var v = new MiyaValidator(f);

    v.add("bnr_nm", {
		required: true
    });
    v.add("bnr_url", {
    	required: true
    });
	result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return false;
	} else {
		if (confirm('수정하시겠습니까?')) {
			return true;
		} else {
			return false;
		}
	}
};

function useBlock(use){
	if(use == "dept"){
		document.getElementById("use_dept").style.display = "block";
		document.getElementById("use_dong").style.display = "none";
	} else if(use == "dong"){
		document.getElementById("use_dept").style.display = "none";
		document.getElementById("use_dong").style.display = "block";
	} else {
		document.getElementById("use_dept").style.display = "none";
		document.getElementById("use_dong").style.display = "none";
	}
}
</script>
</head>
<body style="background:none;padding:10px;">
<h3 class="tit_03">배너 관리</h3>


<form name="fm" method="post" action="<c:url value='/admin/health/banner/update.do'/>" enctype="multipart/form-data" onsubmit="return checkAndSubmit(this);">

<table summary="배너 관리 수정 페이지" class="default_write">
	<caption>배너 관리 수정</caption>
	<colgroup>
		<col width="20%" />
		<col width="80%" />
	</colgroup>
	<tbody>
		<tr>
			<th scope="row"><label for="regDateStr">수정일</label></th>
			<td class="output">
				<input type="text" id="regDateStr" style="width: 125px" class="board1" value="<fmt:formatDate value="${Bean.last_mod_dt}" pattern="yyyy년MM월dd일"/>" readonly="readonly" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="regUserName">수정자</label></th>
			<td class="output">
				<input type="text" id="regUserName" style="width: 125px" class="board1" value="${Bean.last_mod_user_name}" readonly="readonly" />
			</td>
		</tr>
		<tr>
			<th scope="row" rowspan="2">사용처</th>
			<td class="output" >
				<input type="radio" name="useBanner" id="useBanner" value="health" onclick="useBlock('health')" 
				<c:if test="${result.dept == '88' and result.dong == '88'}"> checked="checked"</c:if>
				/>보건소
			</td>
		</tr>
		<tr>
			<td style="padding:5px 15px;">
				<span id="use_Dept" style="<c:if test='${(result.dept != "00" and result.dong == "00") or (result.dept != "00" and result.dong != "00")}'>>display: none;</c:if>">
					<label for="dept" class="blind">산하부서 선택</label>
					<select name="dept" id="dept">
						<option value="00" > -- 산하부서 선택 -- </option>
						<option value="01" <c:if test="${result.dept == '01'}">selected="selected"</c:if>>감사담당관</option>
						<option value="02" <c:if test="${result.dept == '02'}">selected="selected"</c:if>>기획예산담당관</option>
						<option value="03" <c:if test="${result.dept == '03'}">selected="selected"</c:if>>총무과</option>
						<option value="04" <c:if test="${result.dept == '04'}">selected="selected"</c:if>>자치행정과</option>
						<option value="05" <c:if test="${result.dept == '05'}">selected="selected"</c:if>>재무과</option>
						<option value="06" <c:if test="${result.dept == '06'}">selected="selected"</c:if>>세무1과</option>
						<option value="07" <c:if test="${result.dept == '07'}">selected="selected"</c:if>>세무2과</option>
						<option value="08" <c:if test="${result.dept == '08'}">selected="selected"</c:if>>문화공보과</option>
						<option value="09" <c:if test="${result.dept == '09'}">selected="selected"</c:if>>관광산업과</option>
						<option value="10" <c:if test="${result.dept == '10'}">selected="selected"</c:if>>민원여권과</option>
						<option value="11" <c:if test="${result.dept == '11'}">selected="selected"</c:if>>교육체육과</option>
						<option value="12" <c:if test="${result.dept == '12'}">selected="selected"</c:if>>사회복지과</option>
						<option value="13" <c:if test="${result.dept == '13'}">selected="selected"</c:if>>가정복지과</option>
						<option value="14" <c:if test="${result.dept == '14'}">selected="selected"</c:if>>청소행정과</option>
						<option value="15" <c:if test="${result.dept == '15'}">selected="selected"</c:if>>산업환경과</option>
						<option value="16" <c:if test="${result.dept == '16'}">selected="selected"</c:if>>주택과</option>
						<option value="17" <c:if test="${result.dept == '17'}">selected="selected"</c:if>>도시개발과</option>
						<option value="18" <c:if test="${result.dept == '18'}">selected="selected"</c:if>>도시디자인과</option>
						<option value="19" <c:if test="${result.dept == '19'}">selected="selected"</c:if>>건축과</option>
						<option value="20" <c:if test="${result.dept == '20'}">selected="selected"</c:if>>공원녹지과</option>
						<option value="21" <c:if test="${result.dept == '21'}">selected="selected"</c:if>>토지정보과</option>
						<option value="22" <c:if test="${result.dept == '22'}">selected="selected"</c:if>>건설관리과</option>
						<option value="23" <c:if test="${result.dept == '23'}">selected="selected"</c:if>>도로과</option>
						<option value="24" <c:if test="${result.dept == '24'}">selected="selected"</c:if>>치수방재과</option>
						<option value="25" <c:if test="${result.dept == '25'}">selected="selected"</c:if>>교통행정과</option>
						<option value="26" <c:if test="${result.dept == '26'}">selected="selected"</c:if>>주차관리과</option>
						<option value="27" <c:if test="${result.dept == '27'}">selected="selected"</c:if>>보건위생과</option>
						<option value="28" <c:if test="${result.dept == '28'}">selected="selected"</c:if>>건강증진과</option>
						<option value="29" <c:if test="${result.dept == '29'}">selected="selected"</c:if>>의약과</option>
					</select>
				</span>
				<span id="use_Dong" style="<c:if test='${(result.dept == "00" and result.dong != "00") or (result.dept != "00" and result.dong != "00")}'>>display: none;</c:if>">
					<label for="dong" class="blind">동주민센터 선택</label>
					<select name="dong">
						<option value="00" > -- 동주민센터 선택 -- </option>
						<option value="01" <c:if test="${result.dong == '01'}">selected="selected"</c:if>>청운효자동</option>
						<option value="02" <c:if test="${result.dong == '02'}">selected="selected"</c:if>>사직동</option>
						<option value="03" <c:if test="${result.dong == '03'}">selected="selected"</c:if>>삼청동</option>
						<option value="04" <c:if test="${result.dong == '04'}">selected="selected"</c:if>>부암동</option>
						<option value="05" <c:if test="${result.dong == '05'}">selected="selected"</c:if>>평창동</option>
						<option value="06" <c:if test="${result.dong == '06'}">selected="selected"</c:if>>무악동</option>
						<option value="07" <c:if test="${result.dong == '07'}">selected="selected"</c:if>>교남동</option>
						<option value="08" <c:if test="${result.dong == '08'}">selected="selected"</c:if>>가회동</option>
						<option value="09" <c:if test="${result.dong == '09'}">selected="selected"</c:if>>종로1,2,3,4가동</option>
						<option value="10" <c:if test="${result.dong == '10'}">selected="selected"</c:if>>종로5,6가동</option>
						<option value="11" <c:if test="${result.dong == '11'}">selected="selected"</c:if>>이화동</option>
						<option value="12" <c:if test="${result.dong == '12'}">selected="selected"</c:if>>혜화동</option>
						<option value="13" <c:if test="${result.dong == '13'}">selected="selected"</c:if>>명륜3가동</option>
						<option value="14" <c:if test="${result.dong == '14'}">selected="selected"</c:if>>창신1동</option>
						<option value="15" <c:if test="${result.dong == '15'}">selected="selected"</c:if>>창신2동</option>
						<option value="16" <c:if test="${result.dong == '16'}">selected="selected"</c:if>>창신3동</option>
						<option value="17" <c:if test="${result.dong == '17'}">selected="selected"</c:if>>숭인1동</option>
						<option value="18" <c:if test="${result.dong == '18'}">selected="selected"</c:if>>숭인2동</option>
					</select>
				</span>
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="file1">배너 이미지</label></th>
			<td class="output">
				<input type="hidden" name="bnr_img_org_nm" value="${result.bnr_img_org_nm}" />
				<input type="hidden" name="bnr_img_nm" value="${result.bnr_img_nm}" />
				<img src="/health/open_content/images/banner/${result.bnr_img_nm}" style="border: 0px;"/>
				<br/>
				<input id="file1" name="file1" type="file" title="첨부파일1" class="board1" size="50" style="width:90%" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="bnr_nm">배너명</label></th>
			<td class="output">
				<input type="text" id="bnr_nm" name="bnr_nm" value="${result.bnr_nm}" style="width: 125px" class="board1" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="bnr_url">배너 URL</label></th>
			<td class="output">
				<input type="text" id="bnr_url" name="bnr_url" value="${result.bnr_url}" style="width: 250px" class="board1" />
			</td>
		</tr>
		<tr>
			<th scope="row">표시 여부</th>
			<td class="output">
				<label for="publish_Y">
					<input type="radio" id="publish_Y" name="publish" value="Y" class="ra" <c:if test="${result.publish == 'Y'}">checked</c:if> /> 보이기
				</label>
				<label for="publish_N">
					<input type="radio" id="publish_N" name="publish" value="N" class="ra" <c:if test="${result.publish == 'N'}">checked</c:if> /> 숨기기
				</label>
			</td>
		</tr>
		
	</tbody>
</table>


<div class="board_btn_set mt13">
	
	<input type="hidden" name="bnr_cd" value="${result.bnr_cd}"/>
	<input type="hidden" name="searchKeyword" value="${Bean.searchKeyword}"/>
	<input type="hidden" name="searchCondition" value="${Bean.searchCondition}"/>
	
		<span class="btn_del"><input type="submit" value="수정하기" /></span>
		
		<c:url value="/admin/health/banner/List.do" var="list_url">
			<c:param name="pageIndex" value="${Bean.pageIndex}"></c:param>
			<c:param name="searchCondition" value="${Bean.searchCondition}"/>
		</c:url>
		<span class="btn_list"><a href="${list_url}">목록보기</a></span>
	
</div>
</form>
</body>
</html>

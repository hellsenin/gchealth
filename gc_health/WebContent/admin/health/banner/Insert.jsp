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
<script type="text/javascript" src="<c:url value='/namo/js/namo_scripteditor.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/cmm/sym/zip/EgovZipPopup.js'/>" ></script>

<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/util.js"></script>


<link href="/health/open_content/system/css/default.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/common.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/blue.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_blue.css" rel="stylesheet" type="text/css" />

<script>

function checkAndSubmit(f) {
	
	var v = new MiyaValidator(f);

    v.add("file1", {
		required: true
    });
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
		if (confirm('등록하시겠습니까?')) {
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
<h3 class="tit_03">배너 관리 수정</h3>


<form name="fm" method="post" action="<c:url value='/admin/health/banner/insert.do'/>" enctype="multipart/form-data" onsubmit="return checkAndSubmit(this);">

<table summary="배너 관리 등록 페이지" class="default_write">
	<caption>배너 관리</caption>
	<colgroup>
		<col width="20%" />
		<col width="80%" />
	</colgroup>
	<tbody>
		<tr>
			<th scope="row"><label for="regDateStr">등록일</label></th>
			<td>
				<input type="text" id="regDateStr" style="width: 125px" class="board1" value="<fmt:formatDate value="${Bean.reg_dt}" pattern="yyyy년MM월dd일"/>" readonly="readonly" />
			</td>
		</tr>
		<!-- 
		<tr>
			<th scope="row"><label for="deptNameStr">작성자 부서</label></th>
			<td>
				<input type="text" id="deptNameStr" style="width: 125px" class="board1" value="${Bean.dept_name}" readonly="readonly" />
			</td>
		</tr>
		 -->
		<tr>
			<th scope="row"><label for="regUserName">작성자</label></th>
			<td>
				<input type="text" id="regUserName" style="width: 125px" class="board1" value="${Bean.reg_user_name}" readonly="readonly" />
			</td>
		</tr>
		<tr>
			<th scope="row" rowspan="2">사용처</th>
			<td >
				<input type="radio" name="useBanner" id="useBanner" value="health" checked />보건소
			</td>
		</tr>
		<tr>
			<td style="padding:5px 15px;">
				<span id="use_Dept" style="display:none">
					<label for="dept" class="blind">산하부서 선택</label>
					<select name="dept" id="dept">
						<option value="00" > -- 산하부서 선택 -- </option>
						<option value="01" <c:if test="${user.dept_id == '3000063'}">selected="selected"</c:if>>감사담당관</option>
						<option value="02" <c:if test="${user.dept_id == '3000140'}">selected="selected"</c:if>>기획예산담당관</option>
						<option value="03" <c:if test="${user.dept_id == '3000139'}">selected="selected"</c:if>>총무과</option>
						<option value="04" <c:if test="${user.dept_id == '3000141'}">selected="selected"</c:if>>자치행정과</option>
						<option value="05" <c:if test="${user.dept_id == '3000142'}">selected="selected"</c:if>>재무과</option>
						<option value="06" <c:if test="${user.dept_id == '3000143'}">selected="selected"</c:if>>세무1과</option>
						<option value="07" <c:if test="${user.dept_id == '3000144'}">selected="selected"</c:if>>세무2과</option>
						<option value="08" <c:if test="${user.dept_id == '3000154'}">selected="selected"</c:if>>문화공보과</option>
						<option value="09" <c:if test="${user.dept_id == '3000155'}">selected="selected"</c:if>>관광산업과</option>
						<option value="10" <c:if test="${user.dept_id == '3000156'}">selected="selected"</c:if>>민원여권과</option>
						<option value="11" <c:if test="${user.dept_id == '3000157'}">selected="selected"</c:if>>교육체육과</option>
						<option value="12" <c:if test="${user.dept_id == '3000147'}">selected="selected"</c:if>>사회복지과</option>
						<option value="13" <c:if test="${user.dept_id == '3000127'}">selected="selected"</c:if>>가정복지과</option>
						<option value="14" <c:if test="${user.dept_id == '3000128'}">selected="selected"</c:if>>청소행정과</option>
						<option value="15" <c:if test="${user.dept_id == '3000129'}">selected="selected"</c:if>>산업환경과</option>
						<option value="16" <c:if test="${user.dept_id == '3000080'}">selected="selected"</c:if>>주택과</option>
						<option value="17" <c:if test="${user.dept_id == '3000148'}">selected="selected"</c:if>>도시개발과</option>
						<option value="18" <c:if test="${user.dept_id == '3000149'}">selected="selected"</c:if>>도시디자인과</option>
						<option value="19" <c:if test="${user.dept_id == '3000082'}">selected="selected"</c:if>>건축과</option>
						<option value="20" <c:if test="${user.dept_id == '3000083'}">selected="selected"</c:if>>공원녹지과</option>
						<option value="21" <c:if test="${user.dept_id == '3000150'}">selected="selected"</c:if>>토지정보과</option>
						<option value="22" <c:if test="${user.dept_id == '3000085'}">selected="selected"</c:if>>건설관리과</option>
						<option value="23" <c:if test="${user.dept_id == '3000151'}">selected="selected"</c:if>>도로과</option>
						<option value="24" <c:if test="${user.dept_id == '3000130'}">selected="selected"</c:if>>치수방재과</option>
						<option value="25" <c:if test="${user.dept_id == '3000087'}">selected="selected"</c:if>>교통행정과</option>
						<option value="26" <c:if test="${user.dept_id == '3000152'}">selected="selected"</c:if>>주차관리과</option>
						<option value="27" <c:if test="${user.dept_id == '3000097'}">selected="selected"</c:if>>보건위생과</option>
						<option value="28" <c:if test="${user.dept_id == '3000153'}">selected="selected"</c:if>>건강증진과</option>
						<option value="29" <c:if test="${user.dept_id == '3000037'}">selected="selected"</c:if>>의약과</option>
					</select>
				</span>
				<span id="use_Dong" style="display:none">
					<label for="dong" class="blind">동주민센터 선택</label>
					<select name="dong">
						<option value="00" > -- 동주민센터 선택 -- </option>
						<option value="01" <c:if test="${user.dept_id == '3000136'}">selected="selected"</c:if>>청운효자동</option>
						<option value="02" <c:if test="${user.dept_id == '3000042'}">selected="selected"</c:if>>사직동</option>
						<option value="03" <c:if test="${user.dept_id == '3000043'}">selected="selected"</c:if>>삼청동</option>
						<option value="04" <c:if test="${user.dept_id == '3000044'}">selected="selected"</c:if>>부암동</option>
						<option value="05" <c:if test="${user.dept_id == '3000045'}">selected="selected"</c:if>>평창동</option>
						<option value="06" <c:if test="${user.dept_id == '3000046'}">selected="selected"</c:if>>무악동</option>
						<option value="07" <c:if test="${user.dept_id == '3000047'}">selected="selected"</c:if>>교남동</option>
						<option value="08" <c:if test="${user.dept_id == '3000049'}">selected="selected"</c:if>>가회동</option>
						<option value="09" <c:if test="${user.dept_id == '3000090'}">selected="selected"</c:if>>종로1,2,3,4가동</option>
						<option value="10" <c:if test="${user.dept_id == '3000091'}">selected="selected"</c:if>>종로5,6가동</option>
						<option value="11" <c:if test="${user.dept_id == '3000053'}">selected="selected"</c:if>>이화동</option>
						<option value="12" <c:if test="${user.dept_id == '3000054'}">selected="selected"</c:if>>혜화동</option>
						<option value="13" <c:if test="${user.dept_id == '3000055'}">selected="selected"</c:if>>명륜3가동</option>
						<option value="14" <c:if test="${user.dept_id == '3000056'}">selected="selected"</c:if>>창신1동</option>
						<option value="15" <c:if test="${user.dept_id == '3000057'}">selected="selected"</c:if>>창신2동</option>
						<option value="16" <c:if test="${user.dept_id == '3000058'}">selected="selected"</c:if>>창신3동</option>
						<option value="17" <c:if test="${user.dept_id == '3000059'}">selected="selected"</c:if>>숭인1동</option>
						<option value="18" <c:if test="${user.dept_id == '3000060'}">selected="selected"</c:if>>숭인2동</option>
					</select>
				</span>
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="file1">배너 이미지</label></th>
			<td>
				<input id="file1" name="file1" type="file" title="첨부파일1"  class="board1" size="50" style="width:90%" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="bnr_nm">배너명</label></th>
			<td>
				<input type="text" id="bnr_nm" name="bnr_nm" style="width: 125px" class="board1"/>
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="bnr_url">배너 URL</label></th>
			<td>
				<input type="text" id="bnr_url" name="bnr_url" style="width: 250px" class="board1" />
			</td>
		</tr>
		<tr>
			<th scope="row">표시 여부</th>
			<td>
				<label for="publish_Y">
					<input type="radio" id="publish_Y" name="publish" value="Y" class="ra" <c:if test="${Bean.publish == 'Y'}">checked</c:if> /> 보이기
				</label>
				<label for="publish_N">
					<input type="radio" id="publish_N" name="publish" value="N" class="ra" <c:if test="${Bean.publish == 'N'}">checked</c:if> /> 숨기기
				</label>
			</td>
		</tr>
	</tbody>
</table>

<div class="board_btn_set mt13">
		<input type="submit" value="등록하기" />
		<c:url value="/admin/health/banner/List.do" var="list_url">
			<c:param name="searchKeyword" value="${Bean.searchKeyword}"/>
			<c:param name="searchCondition" value="${Bean.searchCondition}"/>
			<c:param name="pageIndex" value="${Bean.pageIndex}"/>
		</c:url>
		<a href="${list_url}">목록보기</a>	
	</div>
</form>
</body>
</html>
		
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
<link href="/health/open_content/system/css/default.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/common.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/blue.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_blue.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>

<script>
function setNum(obj) {
    var val=obj.value;
    var re=/[^0-9]/gi;
    obj.value=val.replace(re,"");
};

var flagCheckId = false;

function checkAndSubmit(f) {
	/*
	if(flagCheckId == false) {
		alert('아이디 중복 여부를 체크해주세요.');
		return false;
	}
	*/
	var v = new MiyaValidator(f);

    v.add("passwd", {
		required: true
    });
    v.add("company", {
		required: true
    });
    v.add("ceo_name", {
		required: true
    });
    /*
    v.add("sa_no", {
		required: true
    });
    v.add("pharmacist_no", {
		required: true
    });
    v.add("tel", {
		required: true
    });
    v.add("fax", {
		required: true
    });
    v.add("hp", {
		required: true
    });
    v.add("email", {
		required: true
    });
    */
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


function fn_zipcode_search_type2(frm, zipcode1, zipcode2, addr1, addr2, post) {
	var result;
	var varParam = new Object();
	varParam.sZip = "";	
	// IE
	// var openParam = "dialogWidth:500px;dialogHeight:325px;scroll:no;status:no;center:yes;resizable:yes;";

	// firefox
	var openParam = "dialogWidth:520px;dialogHeight:480px;scroll:no;status:no;center:yes;resizable:no;";

	result = window.showModalDialog('/admin/health/eduLecturer/zipcode/list.do', varParam, openParam);
	if(result) {
		zipcode1.value = (result.zip).substring(0, 3);
		zipcode2.value = (result.zip).substring(3, 6);
		post.value = zipcode1.value + '-' + zipcode2.value; 
		addr1.value = result.emd_name;
		addr2.value = result.address;
	}
	return false;
};


function checkId() {
	var root = document.documentElement;
	var idVal = document.fm.id.value;
	if(idVal.length > 11) {
		alert('10자 이내로 아이디를 입력하세요');
	} else if(idVal.length == 0) {
		alert('아이디를 입력하세요');
	} else if(idVal != null && idVal.length < 11) {
		var returnVal = window.showModalDialog("/admin/freecheck/company/checkId.do?id="+idVal+"&company_cd=${result.company_cd}", '','');

		var message = '';
		if(returnVal) {
			if(returnVal.count == '0') {
				message = "["+ document.fm.id.value + "]는 사용 가능한 아이디 입니다.";
				document.fm.checkIdButton.disabled = 'disabled';
				flagCheckId = true;
			} else {
				message = "["+ document.fm.id.value + "]는 이미 사용 중입니다.";
				document.fm.checkIdButton.disabled = '';
				flagCheckId = false;	
			}
		} else {
			message = '아이디 중복 체크를 하는데 실패 했습니다.';
		}
		alert(message);
	}
};


function onkeyup_id() {
	document.fm.checkIdButton.disabled = '';
	flagCheckId = false;
};
</script>
</head>
<body style="background:none;padding:10px;">
<h2 style="padding:15px 0 15px 0;">	
		의약업소 자율점검 (업소관리)
</h2>
<p class="title_deco"></p>
<div class="body">

<c:url var="updateUrl" value="/admin/freecheck/company/update.do">
	<c:param name="company_cd" value="${result.company_cd}"/>
	<c:param name="pageIndex" value="${Bean.pageIndex}"/>
	<c:param name="searchCondition" value="${Bean.searchCondition}"/>
	<c:param name="industry_cd" value="${Bean.industry_cd}"/>
	<c:param name="type_cd" value="${Bean.type_cd}"/>
	<c:param name="company" value="${Bean.company}"/>
	<c:param name="ceo_name" value="${Bean.ceo_name}"/>
	<c:param name="id" value="${Bean.id}"/>
	<c:param name="grade_cd" value="${Bean.grade_cd}"/>
</c:url>
<form name="fm" method="post" action="${updateUrl}" enctype="multipart/form-data" onsubmit="return checkAndSubmit(this);">
<table summary="의약업소 자율점검 (업소관리) 수정 페이지" class="default_write">
	<caption>의약업소 자율점검 (업소관리) 수정</caption>
		<colgroup>
			<col width="20%" />
			<col width="30%" />
			<col width="20%" />
			<col width="30%" />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><label for="id">아이디</label></th>
				<td class="output">
					<input type="hidden" name="id" id="id" style="width: 97px;" value="${result.id}" class="board1" />${result.id}
					<!-- <input type="button" id="checkIdButton" onclick="return checkId();" value="중복 체크" class="board1"></input> -->
				</td>
				<th scope="row"><label for="passwd">비밀번호</label></th>
				<td class="output">
					<input type="text" name="passwd" id="passwd" style="width: 180px;" value="${result.passwd}" class="board1" />
				</td>
			</tr>
			
			<tr>
				<th scope="row"><label for="industry_cd">업종</label></th>
				<td class="output">
					<select name="industry_cd" id="industry_cd" style="width: 180px;" class="board1">
						<c:forEach items="${resultIndustrySelection}" var="industry_item">
							<option value='${industry_item.industry_cd}' <c:if test="${result.industry_cd == industry_item.industry_cd}">selected="selected"</c:if>>${industry_item.divide_cd_name} - ${industry_item.name}</option>
						</c:forEach>
					</select>
				</td>
				<th scope="row"><label for="company">업체명</label></th>
				<td class="output">
					<input type="text" name="company" id="company" style="width: 180px;" value="${result.company}" class="board1"/>
				</td>
			</tr>
			
			<tr>
				<th scope="row"><label for="ceo_name">대표자</label></th>
				<td class="output" colspan="3">
					<input type="text" name="ceo_name" id="ceo_name" style="width: 180px;" value="${result.ceo_name}" class="board1"/>
				</td>
				
				<!-- 
				<th scope="row"><label for="">대표자주민번호</label></th>
				<td class="output">
					---
				</td>
				 -->
			</tr>
			
			<tr>
				<th scope="row"><label for="sa_no">허가(등록·신고)번호</label></th>
				<td class="output">
					<input type="text" name="sa_no" id="sa_no" style="width: 180px;" value="${result.sa_no}" class="board1"/>
				</td>
				<th scope="row"><label for="pharmacist_no">면허번호</label></th>
				<td class="output">
					<input type="text" name="pharmacist_no" id="pharmacist_no" style="width: 180px;" value="${result.pharmacist_no}" class="board1"/>
				</td>
			</tr>
			
			<tr>
				<th scope="row"><label for="tel">전화번호</label></th>
				<td class="output">
					<input type="text" name="tel" id="tel" style="width: 180px;" value="${result.tel}" class="board1"/>
				</td>
				<th scope="row"><label for="fax">팩스번호</label></th>
				<td class="output">
					<input type="text" name="fax" id="fax" style="width: 180px;" value="${result.fax}" class="board1"/>
				</td>
			</tr>
			
			<tr>
				<th scope="row"><label for="hp">휴대폰</label></th>
				<td class="output">
					<input type="text" name="hp" id="hp" style="width: 180px;" value="${result.hp}" class="board1"/>
				</td>
				<th scope="row"><label for="email">e메일</label></th>
				<td class="output">
					<input type="text" name="email" id="email" style="width: 180px;" value="${result.email}" class="board1"/>
				</td>
			</tr>
			
			<tr>
				<th scope="row" style="vertical-align: middle;">주소</th>
				<td class="output" colspan="3">
					<input type="hidden" id="lect_addr_zipcode_sn" name="lect_addr_zipcode_sn" />
					<c:set value="${fn:split(result.post, '-')}" var="post_arr"></c:set>
						<input type="text" id="zipcode1" name="zipcode1" value="${post_arr[0]}" style="width: 30px; text-align: center;" class="board1" title="우편번호 앞자리 번호" /> -
						<input type="text" id="zipcode2" name="zipcode2" value="${post_arr[1]}" style="width: 30px; text-align: center;" class="board1" title="우편번호 뒷자리 번호" />
					<a href="/health/dev_content/zipcode/GC_member_zipcode.jsp?code1=zipcode1&amp;code2=zipcode2&amp;code3=addr1" onclick="window.open(this.href,'','width=400,height=400,location=no,toolbar=no,menubar=no,status=no,scrollbars=no,resizable=yes');return false;" onkeypress="if(event.keyCode==13) {this.onclick(); return false;}" title="우편번호검색 팝업"><img src="/health/open_content/images/btn/btn_s_zipcode.gif" alt="우편번호" align="absmiddle" /></a>
					<br/>
					<input type="text" name="addr1" id="addr1" value="${result.addr1}" style="width: 400px;" class="board1"/>
				</td>
			</tr>
			<tr>
				<th scope="row">접수/승인</th>
				<td class="output" colspan="3">
					<select name="grade_cd" id="grade_cd" style="width: 180px;" class="board1">
						<option value='01' <c:if test="${result.grade_cd == '01'}">selected="selected"</c:if>>휴업</option>
						<option value='02' <c:if test="${result.grade_cd == '02'}">selected="selected"</c:if>>영업</option>
						<option value='03' <c:if test="${result.grade_cd == '03'}">selected="selected"</c:if>>폐업</option>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row">수정자</th>
				<td class="output">
					${user.name}
				</td>
				<th scope="row">수정일자</th>
				<td class="output">
					<fmt:formatDate value="${CURR_DATE}" pattern="yyyy년MM월dd일"/>
				</td>
			</tr>
	</tbody>
</table>

		<input type="hidden" name="company_cd" value="${result.company_cd}"/>
		<input type="hidden" name="pageIndex" value="${Bean.pageIndex}"/>
		<input type="hidden" name="searchCondition" value="${Bean.searchCondition}"/>
		<input type="hidden" name="type_cd" value="${Bean.type_cd}"/>
<div class="board_btn_set mt13">
	<span class="btn_del"><input type="submit" value="수정하기" /></span>
	
		<c:url var="listUrl" value="/admin/freecheck/company/select.do">
			<c:param name="company_cd" value="${result.company_cd}"/>
			<c:param name="pageIndex" value="${Bean.pageIndex}"/>
			<c:param name="searchCondition" value="${Bean.searchCondition}"/>
			<c:param name="industry_cd" value="${Bean.industry_cd}"/>
			<c:param name="type_cd" value="${Bean.type_cd}"/>
			<c:param name="company" value="${Bean.company}"/>
			<c:param name="ceo_name" value="${Bean.ceo_name}"/>
			<c:param name="id" value="${Bean.id}"/>
			<c:param name="grade_cd" value="${Bean.grade_cd}"/>
		</c:url>
	<span class="btn_list"><a href="${listUrl}">취소하기</a></span>
</div>
</form>

</div>
</body>
</html>


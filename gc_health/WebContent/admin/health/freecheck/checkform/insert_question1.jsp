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

<script type="text/javascript" src="/health/open_content/system/js/Calendar.js" ></script>

<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>

<script>

function setNum(obj) {
    var val=obj.value;
    var re=/[^0-9]/gi;
    obj.value=val.replace(re,"");
};

function checkAndSubmit(f) {
	var v = new MiyaValidator(f);
	
    v.add("question", {
		required: true
    });

    v.add("quest_type_cd", {
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


function funTypeSelect(gubun){
  if(gubun == "A"){
    other_yn.style.visibility = "visible";
    multi_check_yn.style.visibility = "visible";
  }else{
    other_yn.style.visibility = "hidden";;
    multi_check_yn.style.visibility = "hidden";
  }
};

</script>
</head>
<body style="background:none;padding:10px;">
<h2 style="padding:15px 0 15px 0;">	
		의약업소 자율점검 (점검표관리) : 점검표별 문제
</h2>
<p class="title_deco"></p>
<div class="body">

<form name="fm" method="post" action="<c:url value='/admin/freecheck/checkform/insertQuestion1.do'/>" enctype="multipart/form-data" onsubmit="return checkAndSubmit(this);">

	<table summary="자율점검 (점검표관리) : 점검표별 문제 페이지" class="default_view">
		<caption>자율점검 (점검표관리)</caption>
		<colgroup>
			<col width="20%" />
			<col width="30%" />
			<col width="20%" />
			<col width="30%" />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><label for="question">문제</label></th>
				<td class="output" colspan="3">
					<textarea name="question" id="question" cols="50" rows="20" title="내용" style="width:100%;"></textarea>
					(4000자 이내로 작성하십시요)
				</td>
			</tr>
			
			<tr>
				<th scope="row"><label for="quest_type_cd_A">출제유형</label></th>
				<td class="output" colspan="3">
					<label for="quest_type_cd_A"><input type="radio" id="quest_type_cd_A" name="quest_type_cd" value="A" onclick="javascript:funTypeSelect('A');">객관식</label>&nbsp;&nbsp;
					<label for="quest_type_cd_B"><input type="radio" id="quest_type_cd_B" name="quest_type_cd" value="B" onclick="javascript:funTypeSelect('B');">주관식</label>&nbsp;&nbsp;
				</td>
			</tr>
			
			<tr>
				<th scope="row">기타문항사용</th>
				<td class="output" colspan="3">
					<div id="other_yn" style="visibility:hidden">
						<label for="other_yn_Y"><input type="radio" id="other_yn_Y" name="other_yn" value="Y">사용함</label>&nbsp;&nbsp; 
						<label for="other_yn_N"><input type="radio" id="other_yn_N" name="other_yn" value="N">사용안함</label>&nbsp;&nbsp;(객관식일 경우만 적용됨)
					</div> 
				</td>
			</tr>
			
			<tr>
				<th scope="row"><label for="contents">답변형식</label></th>
				<td class="outputEditor" colspan="3">
					<div id="multi_check_yn"  style="visibility:hidden">
						<label for="multi_check_yn_Y"><input type="radio" id="multi_check_yn_Y" name="multi_check_yn" value="N">단일선택</label>
						<label for="multi_check_yn_N"><input type="radio" id="multi_check_yn_N" name="multi_check_yn" value="Y">다중선택</label>&nbsp;&nbsp;(객관식일 경우만 적용됨)
					</div>
				</td>
			</tr>
			
			<tr>
				<th scope="row">등록자</th>
				<td class="output">
					${user.name}
				</td>
				<th scope="row">등록일자</th>
				<td class="output">
					<fmt:formatDate value="${CURR_DATE}" pattern="yyyy년MM월dd일"/>
				</td>
			</tr>
			
		</tbody>
	</table>


		<input type="hidden" name="searchKeyword" value="${Bean.searchKeyword}"/>
		<input type="hidden" name="year_cd" value="${Bean.year_cd}"/>
		<input type="hidden" name="master_cd" value="${Bean.master_cd}"/>
		<input type="hidden" name="title" value="${Bean.title}"/>
<div class="board_btn_set mt13">
	<span class="btn_del"><input type="submit" value="등록하기" /></span>

		<c:url var="list_action" value="/admin/freecheck/checkform/list_question.do">
			<c:param name="searchKeyword" value="${Bean.searchKeyword}"/>
			<c:param name="year_cd" value="${Bean.year_cd}"/>
			<c:param name="master_cd" value="${Bean.master_cd}"/>
			<c:param name="title" value="${Bean.title}"/>
		</c:url>
	<span class="btn_list"><a href="${list_action}">목록보기</a></span>
</div>	
</form>

</div>
</body>
</html>

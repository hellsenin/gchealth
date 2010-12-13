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
<h3 class="tit_03">의약업소 자율점검 (점검표관리) : 점검표별 문제</h3>

<form name="fm" method="post" action="<c:url value='/admin/freecheck/checkform/updateQuestion1.do'/>" enctype="multipart/form-data" onsubmit="return checkAndSubmit(this);">
	
			<table summary="의약업소 자율점검 (점검표관리) 페이지" class="default_view">
				<caption>의약업소 자율점검 (점검표관리)</caption>
				<colgroup>
					<col width="20%" />
					<col width="80%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="edu_nm">분류</label></th>
						<td class="output">
							<c:if test="${Bean.year_cd == '200901' or Bean.year_cd == '200801'}">
								<c:choose>
									<c:when test="${checkformInfo.type_cd == '01'}">[${fn:substring(Bean.year_cd, 0, 4)}] 약국 자율점검표</c:when>
									<c:when test="${checkformInfo.type_cd == '02'}">[${fn:substring(Bean.year_cd, 0, 4) }] 약업사 자율점검표</c:when>
									<c:when test="${checkformInfo.type_cd == '03'}">[${fn:substring(Bean.year_cd, 0, 4) }] 의약품도매상 자율점검표</c:when>
									<c:when test="${checkformInfo.type_cd == '04'}">[${fn:substring(Bean.year_cd, 0, 4) }] 한약업사 자율점검표</c:when>
									<c:when test="${checkformInfo.type_cd == '05'}">[${fn:substring(Bean.year_cd, 0, 4) }] 의료기기판매(임대)업소 자율점검표</c:when>
									<c:when test="${checkformInfo.type_cd == '06'}">[${fn:substring(Bean.year_cd, 0, 4) }] 의료기관(병/의원) 자율점검표</c:when>
									<c:when test="${checkformInfo.type_cd == '07'}">[${fn:substring(Bean.year_cd, 0, 4) }] 치과기공소 자율점검표</c:when>
									<c:when test="${checkformInfo.type_cd == '08'}">[${fn:substring(Bean.year_cd, 0, 4) }] 의료기관(치과병/의원) 자율점검표</c:when>
									<c:when test="${checkformInfo.type_cd == '09'}">[${fn:substring(Bean.year_cd, 0, 4) }] 의료기관(한방병/의원) 자율점검표</c:when>
									<c:when test="${checkformInfo.type_cd == '10'}">[${fn:substring(Bean.year_cd, 0, 4) }] 안경업소 자율점검표</c:when>
									<c:when test="${checkformInfo.type_cd == '11'}">[${fn:substring(Bean.year_cd, 0, 4) }] 마약류(향정신성의약품) 자율점검표</c:when>
								</c:choose>
							</c:if>
							<c:if test="${Bean.year_cd == '201001'}">
								<c:choose>
									<c:when test="${checkformInfo.type_cd == '01'}">[${fn:substring(Bean.year_cd, 0, 4) }] 약국 자율점검표</c:when>
									<c:when test="${checkformInfo.type_cd == '02'}">[${fn:substring(Bean.year_cd, 0, 4) }] 약업사 자율점검표</c:when>
									<c:when test="${checkformInfo.type_cd == '03'}">[${fn:substring(Bean.year_cd, 0, 4) }] 의약품도매상 자율점검표</c:when>
									<c:when test="${checkformInfo.type_cd == '04'}">[${fn:substring(Bean.year_cd, 0, 4) }] 한약업사 자율점검표</c:when>
									<c:when test="${checkformInfo.type_cd == '05'}">[${fn:substring(Bean.year_cd, 0, 4) }] 의료기기판매(임대)업소 자율점검표</c:when>
									<c:when test="${checkformInfo.type_cd == '07'}">[${fn:substring(Bean.year_cd, 0, 4) }] 치과기공소 자율점검표</c:when>
									<c:when test="${checkformInfo.type_cd == '08'}">[${fn:substring(Bean.year_cd, 0, 4) }] (종합,치과,한방,요양) 병원 자율점검표</c:when>
									<c:when test="${checkformInfo.type_cd == '09'}">[${fn:substring(Bean.year_cd, 0, 4) }] (의원,한의원,치과의원) 의료기관 자율점검표</c:when>
									<c:when test="${checkformInfo.type_cd == '10'}">[${fn:substring(Bean.year_cd, 0, 4) }] 안경업소 자율점검표</c:when>
									<c:when test="${checkformInfo.type_cd == '11'}">[${fn:substring(Bean.year_cd, 0, 4) }] 마약류(향정신성의약품) 자율점검표</c:when>
								</c:choose>
							</c:if>
						</td>
					</tr>
					
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
							<textarea name="question" id="question" cols="50" rows="20" title="내용" style="width:100%;">${result.QUESTION}</textarea>
							(4000자 이내로 작성하십시요)
						</td>
					</tr>
					
					<tr>
						<th scope="row">출제유형</th>
						<td class="output" colspan="3">
							<label for="quest_type_cd"><input type="radio" name="quest_type_cd" value="A" <c:if test="${result.QUEST_TYPE_CD == 'A'}">checked="checked" </c:if>onclick="javascript:funTypeSelect('A');">객관식</label>&nbsp;&nbsp;
							<label for="quest_type_cd"><input type="radio" name="quest_type_cd" value="B" <c:if test="${result.QUEST_TYPE_CD == 'B'}">checked="checked" </c:if>onclick="javascript:funTypeSelect('B');">주관식</label>&nbsp;&nbsp;
						</td>
					</tr>
					
					<tr>
						<th scope="row">기타문항사용</th>
						<td class="output" colspan="3">
							<div id="other_yn" <c:if test="${result.QUEST_TYPE_CD == 'B'}">style="visibility: hidden;"</c:if>>
								<label for="other_yn"><input type="radio" name="other_yn" value="Y" <c:if test="${result.OTHER_YN == 'Y'}">checked="checked" </c:if>>사용함</label>&nbsp;&nbsp; 
								<label for="other_yn"><input type="radio" name="other_yn" value="N" <c:if test="${result.OTHER_YN == 'N'}">checked="checked" </c:if>>사용안함</label>&nbsp;&nbsp;(객관식일 경우만 적용됨)
							</div> 
						</td>
					</tr>
					
					<tr>
						<th scope="row"><label for="contents">답변형식</label></th>
						<td class="outputEditor" colspan="3">
							<div id="multi_check_yn" <c:if test="${result.QUEST_TYPE_CD == 'B'}">style="visibility: hidden;"</c:if>>
								<label for="multi_check_yn"><input type="radio" name="multi_check_yn" value="N" <c:if test="${result.MULTI_CHECK_YN == 'N'}">checked="checked" </c:if>>단일선택</label>
								<label for="multi_check_yn"><input type="radio" name="multi_check_yn" value="Y" <c:if test="${result.MULTI_CHECK_YN == 'Y'}">checked="checked" </c:if>>다중선택</label>&nbsp;&nbsp;(객관식일 경우만 적용됨)
							</div>
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
		
				<input type="hidden" name="searchKeyword" value="${Bean.searchKeyword}"/>
				<input type="hidden" name="year_cd" value="${Bean.year_cd}"/>
				<input type="hidden" name="master_cd" value="${Bean.master_cd}"/>
				<input type="hidden" name="title" value="${Bean.title}"/>
				
				<input type="hidden" name="question_cd" value="${result.QUESTION_CD}"/>
<div class="board_btn_set mt13">
	<span class="btn_del"><input type="submit" value="수정하기" /></span>
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

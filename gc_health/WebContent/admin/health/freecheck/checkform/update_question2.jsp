<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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

<div style="margin: 20px;"></div>

<script>
function addItem() {
	fm.view_state.value='add';
};

function delItem(i) {
	fm.view_state.value='del';
	if(!fm.arr_status.length & i == 1) {
		if(fm.arr_status.value == 'Y') {
			fm.arr_status.value = 'N';
		} else if(fm.arr_status.value == 'N') {
			fm.arr_status.value = 'Y';
		}
	} else {
		if(fm.arr_status[i-1].value == 'Y') {
			fm.arr_status[i-1].value = 'N';
		} else if(fm.arr_status[i-1].value == 'N') {
			fm.arr_status[i-1].value = 'Y';
		}
	}
};

function save() {
	fm.view_state.value='save';
};

function modify() {
	fm.view_state.value='modify';
};

function checkAndSubmit(f) {
	if(fm.view_state.value=='save') {
		var v = new MiyaValidator(f);
	    v.add("question2", {
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
	}
	return true;
};
</script>

</head>
<body style="background:none;padding:10px;">
<h2 style="padding:15px 0 15px 0;">	
		의약업소 자율점검 (점검표관리)
</h2>
<p class="title_deco"></p>
<div class="body">

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
	
		<br/><br/>
		<table summary="자율점검 (점검표관리) : 점검표별 문제 페이지" class="default_view">
			<caption>자율점검 (점검표관리)</caption>
			<colgroup>
				<col width="20%" />
				<col width="80%" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">문제</th>
					<td class="output">
						${resultQuestion1.QUESTION}
					</td>
				</tr>
				
				<tr>
					<th scope="row">출제유형</th>
					<td class="output">
						<c:if test="${resultQuestion1.QUEST_TYPE_CD == 'A'}">객관식</c:if>
						<c:if test="${resultQuestion1.QUEST_TYPE_CD == 'B'}">주관식</c:if>
					</td>
				</tr>
				
				<tr>
					<th scope="row">기타문항사용</th>
					<td class="output">
						<div id="other_yn">
							<c:if test="${resultQuestion1.OTHER_YN == 'Y'}">사용함</c:if>
							<c:if test="${resultQuestion1.OTHER_YN == 'N'}">사용안함 (객관식일 경우만 적용됨)</c:if>
						</div> 
					</td>
				</tr>
				
				<tr>
					<th scope="row">답변형식</th>
					<td class="output">
						<div id="multi_check_yn">
							<c:if test="${resultQuestion1.MULTI_CHECK_YN == 'N'}">단일선택</c:if>
							<c:if test="${resultQuestion1.MULTI_CHECK_YN == 'Y'}">다중선택 (객관식일 경우만 적용됨)</c:if>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	<br/>
	<br/>
	<form name="fm" action="<c:url value="/admin/freecheck/checkform/selectQuestion2ForUpdate.do"/>" method="post" onsubmit="return checkAndSubmit(this);">
		<input type="hidden" name="master_cd" value="${Bean.master_cd}" />
		<input type="hidden" name="year_cd" value="${Bean.year_cd}" />
		<input type="hidden" name="question1_cd" value="${Bean.question1_cd}" />
		<input type="hidden" name="question_cd" value="${Bean.question1_cd}" />
		<input type="hidden" id="view_state" name="view_state" value="${Bean.view_state}" />
		
			<c:if test="${Bean.view_state != 'select'}">
<div class="board_btn_set mt13">
	<span class="btn_del"><input type="submit" value="추가하기" onclick="addItem();"/></span>
</div>
			</c:if>
			
		
		<table class="default_list" summary="의약업소 자율점검 (점검표관리) 목록 테이블입니다">
			<caption>의약업소 자율점검 (점검표관리) 목록</caption>
			<colgroup>
				<col width="20%" />
				<col width="*" />
			<c:if test="${resultQuestion1.MULTI_CHECK_YN == 'N'}">
				<col width="10%" />
			</c:if>
				<c:choose>
					<c:when test="${Bean.view_state != 'select'}">
						<col width="10%" />
					</c:when>
				</c:choose>
			</colgroup>
			<thead>
				<tr>
					<th scope="col">순번</th>
					<th scope="col">답변 항목</th>
				<c:if test="${resultQuestion1.MULTI_CHECK_YN == 'N'}">
					<th scope="col">정답</th>
				</c:if>
					<c:choose>
						<c:when test="${Bean.view_state != 'select'}">
							<th scope="col">삭제</th>
						</c:when>
					</c:choose>
				</tr>
			</thead>
			<tbody>
				<c:if test="${fn:length(resultList) != 0}">
					<c:forEach items="${resultList}" var="item" varStatus="status">
						<c:if test="${item.status == 'N'}">
							<tr>
								<!-- 순번 -->
								<td class="output">
									${status.count}
									<input type="hidden" name="arr_orderby" value="${status.count}" />
									<input type="hidden" name="arr_question2_cd" value="${item.question2_cd}" /> 
								</td>
								
								<!-- 제목-->
								<td class="output tal" style="padding-left: 20px;">
									<c:choose>
										<c:when test="${Bean.view_state == 'select'}">
											${item.question2}
										</c:when>
										<c:when test="${Bean.view_state != 'select'}">
											<input type="text" name="arr_question2" value="${item.question2}" style="width: 98%;" class="board1" />
										</c:when>
									</c:choose>
								</td>
								
							<c:if test="${resultQuestion1.MULTI_CHECK_YN == 'N'}">
								<!-- 정답 -->
								<td class="output">
									<c:choose>
										<c:when test="${Bean.view_state == 'select'}">
									${item.validation == 'Y' ? 'Y' : ''}
										</c:when>
										<c:when test="${Bean.view_state != 'select'}">
									<input type="radio" name="validation" value="${status.count}" <c:if test="${item.validation == 'Y'}">checked="checked"</c:if>/>
										</c:when>
									</c:choose>
								</td>
							</c:if>
								
								<c:choose>
									<c:when test="${Bean.view_state != 'select'}">
										<!-- 삭제 -->
										<td class="output">
											<input type="checkbox" onclick="delItem(${status.count}); submit();" <c:if test="${item.status == 'Y'}">checked="checked"</c:if>/>
											<input type="hidden" name="arr_status" value="${item.status}"/>
										</td>
									</c:when>
								</c:choose>
								
								
							</tr>
						</c:if>
						<c:if test="${item.status == 'Y'}">
							<tr>
								<!-- 순번 -->
								<td class="output">
									${status.count}
									<input type="hidden" name="arr_orderby" value="${status.count}" />
									<input type="hidden" name="arr_question2_cd" value="${item.question2_cd}" /> 
								</td>
								
								<!-- 제목-->
								<td class="output tal" style="padding-left: 20px;">
									<input type="text" value="${item.question2}" style="width: 98%;" class="board1" disabled="disabled"/>
									<input type="hidden" name="arr_question2" value="${item.question2}" />
								</td>
								
							<c:if test="${resultQuestion1.MULTI_CHECK_YN == 'N'}">
								<!-- 정답 -->
								<td class="output">
									<input type="radio" name="validation" value="${status.count}" <c:if test="${item.validation == 'Y'}">checked="checked"</c:if> disabled="disabled"/>
								</td>
							</c:if>
								
								<!-- 삭제 -->
								<td class="output">
									<input type="checkbox" onclick="delItem(${status.count}); submit();" <c:if test="${item.status == 'Y'}">checked="checked"</c:if>/>
									<input type="hidden" name="arr_status" value="${item.status}"/>
								</td>
								
								
							</tr>
						</c:if>
					</c:forEach>
				</c:if>
				<c:if test="${fn:length(resultList) == 0}">
					<tr>
						<c:choose>
							<c:when test="${resultQuestion1.QUEST_TYPE_CD == 'A'}">
								<td colspan="<c:if test="${Bean.view_state != 'select'}">3</c:if><c:if test="${Bean.view_state == 'select'}">2</c:if>">등록된 리스트가 없습니다.</td>		
							</c:when>
							<c:when test="${resultQuestion1.QUEST_TYPE_CD == 'B'}">
								<td colspan="2">주관식은 답변 항목을 추가 할 수 없습니다.</td>
							</c:when>
						</c:choose>
					</tr>
				</c:if>
				
				
			</tbody>
		</table>
		<!-- board list end //-->
		
	
<div class="board_btn_set mt13">
			<c:choose>
				<c:when test="${Bean.view_state != 'select'}">
						<c:url var="cancel_action" value="/admin/freecheck/checkform/selectQuestion2ForUpdate.do">
							<c:param name="searchKeyword" value="${Bean.searchKeyword}"/>
							<c:param name="question1_cd" value="${Bean.question1_cd}"/>
							<c:param name="question_cd" value="${Bean.question_cd}"/>
							<c:param name="master_cd" value="${Bean.master_cd}"/>
							<c:param name="year_cd" value="${Bean.year_cd}"/>
							<c:param name="view_state" value="select"/>
						</c:url>
	<span class="btn_list"><a href="${cancel_action}">취소하기</a></span>
	<span class="btn_del"><input type="submit" value="저장하기" onclick="save();"/></span>
				</c:when>
				<c:when test="${Bean.view_state == 'select'}">
					
					<c:if test="${resultQuestion1.QUEST_TYPE_CD == 'A'}">	
	<span class="btn_del"><input type="submit" value="수정하기" onclick="modify();"/></span>
					</c:if>

						<c:url var="list_action" value="/admin/freecheck/checkform/list_question.do">
							<c:param name="searchKeyword" value="${Bean.searchKeyword}"/>
							<c:param name="year_cd" value="${Bean.year_cd}"/>
							<c:param name="master_cd" value="${Bean.master_cd}"/>
						</c:url>
	<span class="btn_list"><a href="${list_action}">목록보기</a></span>
				</c:when>
			</c:choose>
</div>
			
	</form>
	
</div>
</body>
</html>
	
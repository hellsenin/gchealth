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

<script type="text/javascript">
function del()
{
	if(confirm("삭제하시겠습니까?"))
	{
		location.href = "${question_delete_url}";
	}
}
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

		<form action="/admin/freecheck/checkform/forInsertQuestion1.do" method="post">
			<input type="hidden" name="searchKeyword" value="${Bean.searchKeyword}"/>
			<input type="hidden" name="year_cd" value="${Bean.year_cd}"/>
			<input type="hidden" name="title" value="${Bean.title}"/>
			<input type="hidden" name="master_cd" value="${checkformInfo.master_cd}"/>
<div class="board_btn_set mt13">
	<span class="btn_del"><input type="submit" value="문제등록" /></span>

	<c:url var="list_action" value="/admin/freecheck/checkform/list.do">
		<c:param name="searchKeyword" value="${Bean.searchKeyword}"/>
		<c:param name="year_cd" value="${Bean.year_cd}"/>
	</c:url>
	<span class="btn_list"><a href="${list_action}">목록보기</a></span>
</div>
		</form>
			
<h4>문제/문항 입/수정/삭제는 응모기간 이전에만 가능합니다.</h4>
<br/>
<br/>

<c:if test="${fn:length(resultList) > 0}">
	<c:forEach items="${resultList}" var="questionItem" varStatus="status">
		<h5>&nbsp;&nbsp;${status.count}.&nbsp;${questionItem.QUESTION}</h5>
					
			<table summary="투표할 수 있는 항목입니다" class="default_view">
				<caption>투표할 수 있는 항목</caption>
				<colgroup>
					<col width="30%" />
					<col width="25%" />
					<col width="20%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">답변</th>
						<th scope="col">정답</th>
						<th scope="col">비율</th>
						<th scope="col">비율그래프</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${questionItem.ANSWER}" var="answerItem" varStatus="status">
					<tr>
						<td>
							${status.count}. ${answerItem.QUESTION2}
						</td>
						<td>${answerItem.VALIDATION}</td>
						<td class="tar">${answerItem.TC}/${answerItem.TOT} (${answerItem.PERCENT}%)</td>
						<td>
							<div class="grp">
							 <img src="/health/open_content/images/grp1.gif" style="width:${answerItem.PERCENT+1}%; height:8px" alt="" />
							</div>
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			
		<div class="board_btn_set mt13">
			<c:url value="/admin/freecheck/checkform/forUpdateQuestion1.do" var="question_modify_url">
				<c:param name="question_cd" value="${questionItem.QUESTION_CD}" />
				<c:param name="master_cd" value="${Bean.master_cd}" />
				<c:param name="title" value="${Bean.title}"/>
				<c:param name="year_cd" value="${Bean.year_cd}"/>
			</c:url>
			
			<span class="btn_del"><a href="${question_modify_url}">문제수정</a></span>	
			
			<c:url value="/admin/freecheck/checkform/selectQuestion2ForUpdate.do" var="question2_modify_url">
				<c:param name="question_cd" value="${questionItem.QUESTION_CD}" />
				<c:param name="question1_cd" value="${questionItem.QUESTION_CD}" />
				<c:param name="master_cd" value="${Bean.master_cd}" />
				<c:param name="year_cd" value="${Bean.year_cd}"/>
				<c:param name="view_state" value="select"/>
			</c:url>
			
			<span class="btn_del"><a href="${question2_modify_url}">문항입/수정</a></span>
			
			<c:url value="/admin/freecheck/checkform/deleteQuestion1.do" var="question_delete_url">
				<c:param name="question_cd" value="${questionItem.QUESTION_CD}" />
				<c:param name="master_cd" value="${Bean.master_cd}" />
				<c:param name="title" value="${Bean.title}"/>
				<c:param name="year_cd" value="${Bean.year_cd}"/>
			</c:url>
			
			<span class="btn_del"><a href="${question_delete_url}" onclick="return confirm('삭제하시겠습니까?');">삭제</a></span>
			
			<c:url value="/admin/freecheck/checkform/report_answer.do" var="download_xls_action">
				<c:param name="question_cd" value="${questionItem.QUESTION_CD}" />
				<c:param name="master_cd" value="${Bean.master_cd}" />
				<c:param name="file" value="${Bean.title}-${status.count}번 문제.xls" />
				<c:param name="title" value="${Bean.title}"/>
			</c:url>
			
			<span class="btn_del"><a href="${download_xls_action}">엑셀저장</a></span>
		</div>
	</c:forEach>
</c:if>
<c:if test="${fn:length(resultList) == 0}">
	등록된 문제 리스트가 없습니다.
</c:if>

</div>
</body>
</html>

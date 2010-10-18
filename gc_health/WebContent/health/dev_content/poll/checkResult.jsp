<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>

function viewEssayList(questionCd) {
	var openParam = "dialogWidth:830px;dialogHeight:600px;scroll:yes;status:no;center:yes;resizable:yes;";
	var varParam = new Object();
	var url = '/health/poll/selectEssayList.do?masterCd=${param.master_cd}&questionCd='+questionCd;
	window.showModalDialog(url, varParam, openParam);
};


function viewOtherList(questionCd) {
	var openParam = "dialogWidth:830px;dialogHeight:600px;scroll:yes;status:no;center:yes;resizable:yes;";
	var varParam = new Object();
	var url = '/health/poll/selectOtherList.do?masterCd=${param.master_cd}&questionCd='+questionCd;
	window.showModalDialog(url, varParam, openParam);
};


</script>
	
	<h4>설문 정보</h4>
	
	<table class="default_view" summary="제목, 주관부서, 등록일, 조회수, 첨부파일, 내용으로 구성되어 있습니다.">
		<caption>민원서식 상세내용</caption>
		<colgroup>
			<col style="width:20%;"/>
			<col style="width:80%;"/>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">제목</th>
				<td class="output tal">${checkformInfo.title}</td>
			</tr>
			<tr>
				<th scope="row">설문기간</th>
				<td class="output tal"><fmt:formatDate value="${checkformInfo.start_dt}" pattern="yyyy년 MM월 dd일"/> ~ <fmt:formatDate value="${checkformInfo.end_dt}" pattern="yyyy년 MM월 dd일"/></td>
			</tr>
			<tr >
				<th scope="row">설문내용</th>
				<td class="output tal">
					${checkformInfo.contents}
				</td>
			</tr>
			<tr>
				<th scope="row">첨부파일</th>
				<td class="output tal">&nbsp;
					<c:url value="/health/poll/download.do" var="download_action">
						<c:param name="file" value="${checkformInfo.attachfile1}" />
					</c:url>
					<a href="${download_url}"><strong>${checkformInfo.attachfile1}</strong></a>
				</td>
			</tr>
		</tbody>
	</table>
	
		<form action="/health/poll/list.do?categoryId=${param.categoryId}" method="post">
<div class="board_btn_set mt13">
	<span class="btn_del"><input type="submit" value="목록보기" /></span>
</div>
		</form>
	
		<h4>설문 항목</h4>
		
		<!-- write form start -->
		<table id="check_form" summary="응모 할 수 있는 항목입니다" class="default_view" style="display: ${display_questions}">
			<caption>응모 할 수 있는 항목</caption>
			<colgroup>
				<col style="width:7%;"/>
				<col style="width:93%;"/>
			</colgroup>
			<tbody>
			<c:forEach items="${resultList}" var="questionItem" varStatus="status">
				<tr>
					<th>${status.count}</th>
					<td class="tal">
						<dl>
							<dt style="margin-top: 6px;">
								${questionItem.QUESTION}
								<c:if test="${questionItem.QUEST_TYPE_CD == 'B'}">
								<a href="javascript:viewEssayList('${questionItem.QUESTION_CD}');">상세보기</a>
								</c:if> 
							</dt>
							<dd style="margin-top: 6px; margin-bottom: 6px;">
							<c:forEach items="${questionItem.ANSWER}" var="answerItem" varStatus="aStatus">
								${aStatus.count}. 
								${answerItem.QUESTION2}
								<c:if test="${answerItem.QUESTION2_CD == 9999}">
								<a href="javascript:viewOtherList('${answerItem.QUESTION_CD}');">상세보기</a>
								</c:if> 
								${answerItem.TC}/${answerItem.TOT} (${answerItem.PERCENT}%) <br/>
							</c:forEach>
							</dd>
						</dl>
						
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>

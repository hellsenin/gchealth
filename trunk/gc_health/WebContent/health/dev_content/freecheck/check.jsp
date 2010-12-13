<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% pageContext.setAttribute("crlf", "\r\n"); %>	
<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>
<script type="text/javascript">
function checkAndSubmit(f) {
	if('${Bean.view_state}' == 'readonly') {
		alert('이미 점검을 완료하셨거나 점검 기간이 아닙니다.');
		return false;
	} else {
		var v = new MiyaValidator(f);
		
	    v.add("sangho_name", {
			required: true
	    });
	    v.add("name1", {
			required: true
	    });
	    v.add("addr1", {
			required: true
	    });
		var result = v.validate();

		if (!result) {
			alert(v.getErrorMessage());
			return false;
		} else {
			if (confirm('점검 기간에는 언제든지 수정이 가능합니다. 저장하시겠습니까?')) {
				return true;
			} else {
				return false;
			}
		}

	}
	
	
};
</script>

	<h4>점검 정보</h4>
	
	<table class="default_view" summary="제목, 주관부서, 등록일, 조회수, 첨부파일, 내용으로 구성되어 있습니다.">
		<caption>민원서식 상세내용</caption>
		<colgroup>
			<col style="width:20%;"/>
			<col style="width:80%;"/>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">제목</th>
				<td class="output tal">${result.title}</td>
			</tr>
			<tr>
				<th scope="row">점검기간</th>
				<td class="output tal"><fmt:formatDate value="${result.start_dt}" pattern="yyyy년MM월dd일"/> ~ <fmt:formatDate value="${result.end_dt}" pattern="yyyy년MM월dd일"/></td>
			</tr>
			<tr >
				<th scope="row">점검내용</th>
				<td class="output tal">
					${result.contents}
				</td>
			</tr>
			<tr>
				<th scope="row">첨부파일</th>
				<td class="output tal">&nbsp;
					<c:url value="/health/freecheck/download.do" var="download_url">
						<c:param name="file" value="${result.attachfile1}"></c:param>
					</c:url>
					<a href="${download_url}"><strong>${result.attachfile1}</strong></a>
				</td>
			</tr>
		</tbody>
	</table>
	<br/>
	
	
	<form name="fm" action="/health/freecheck/check.do?categoryId=${param.categoryId}" method="post" onsubmit="return checkAndSubmit(this);">
		<input type="hidden" name="answer_cd" value="${answer.ANSWER_CD == null ? 0 : answer.ANSWER_CD}" />
		
		<c:if test="${result.type_cd == '02'}">
			<jsp:include page="/health/dev_content/freecheck/app/application.jsp"></jsp:include>
		</c:if>
		
		<br/>
		
		<h4>점검 항목</h4>
		
		<!-- write form start -->
		<table id="check_form" summary="응모 할 수 있는 항목입니다" class="default_view">
			<caption>응모 할 수 있는 항목</caption>
			<colgroup>
				<col style="width:7%;"/>
				<col style="width:93%;"/>
			</colgroup>
			<tbody>
				<c:if test="${fn:length(questionList) > 0}">
					<c:forEach items="${questionList}" var="questionItem" varStatus="qStatus">		
						<tr>
							<th>${qStatus.count}</th>
							<td class="tal">
								<dl>
									<dt style="margin-top: 6px;">${fn:replace(questionItem.QUESTION,crlf,"<br/>")}</dt>
									<dd style="margin-top: 6px; margin-bottom: 6px;">
										<!-- 주관식 -->
										<c:choose>
											<c:when test="${questionItem.QUEST_TYPE_CD == 'B'}">
												<input type="hidden" name="question_cd_${qStatus.count}" value="${questionItem.QUESTION_CD}"></input>
												<input type="hidden" name="question2_cd_${qStatus.count}" value="${questionItem.QUESTION2_CD}"></input>
												<input type="text" title="문제 ${qStatus.count}번" name="other_${qStatus.count}" value="${questionItem.OTHER}" class="t_text vam" style="width: 98%; padding-left: 3px;" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
											</c:when>
											
											<c:otherwise>
												<input type="hidden" name="question_cd_${qStatus.count}" value="${questionItem.QUESTION_CD}"></input>
												<input type="hidden" name="multi_check_yn_${qStatus.count}" value="${questionItem.MULTI_CHECK_YN}"></input>
												<input type="hidden" name="other_${qStatus.count}" value=""/>
												<c:forEach items="${questionItem.answerList}" var="answerItem" varStatus="aStatus">
													<!-- 객관식 --> <!-- questionItem.QUEST_TYPE_CD == 'A' 인지 체크를 해줘야하지만 그렇지 않아도 A만 나올 것임 -->
													
														<c:if test="${questionItem.MULTI_CHECK_YN == 'Y'}">
															<input type="hidden" name="checkbox_count_${qStatus.count}" value="${fn:length(questionItem.answerList)}" />
														</c:if>
														<c:choose>
															<c:when test="${questionItem.MULTI_CHECK_YN == 'Y'}">
																<input type="checkbox" title="문제 ${qStatus.count}번" name="question2_cd_${qStatus.count}_${aStatus.count}" value="${answerItem.QUESTION2_CD}" id="answer2_${qStatus.count}_${answerItem.QUESTION2_CD}" <c:if test="${fn:indexOf(questionItem.QUESTION2_CD, answerItem.QUESTION2_CD) >= 0}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
															</c:when>
															<c:when test="${questionItem.MULTI_CHECK_YN == 'N'}">
																<input type="radio" title="문제 ${qStatus.count}번" name="question2_cd_${qStatus.count}" value="${answerItem.QUESTION2_CD}" id="answer2_${qStatus.count}_${answerItem.QUESTION2_CD}" <c:if test="${fn:indexOf(questionItem.QUESTION2_CD, answerItem.QUESTION2_CD) >= 0}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
															</c:when>
														</c:choose>
														${answerItem.QUESTION2}
<!--													<label for="answer2_${qStatus.count}_${answerItem.QUESTION2_CD}">-->
<!--													</label>-->
													<br/>
												</c:forEach>
												<!-- 기타항목 -->
												<c:if test="${questionItem.OTHER_YN == 'Y'}">

														<c:choose>
															<c:when test="${questionItem.MULTI_CHECK_YN == 'Y'}">
																<input type="checkbox" title="문제 ${qStatus.count}번" name="question2_cd_${qStatus.count}" value="9999" id="answer2_${qStatus.count}_99}" <c:if test="${fn:indexOf(questionItem.QUESTION2_CD, ':9999:') >= 0}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
															</c:when>
															<c:when test="${questionItem.MULTI_CHECK_YN == 'N'}">
																<input type="radio" title="문제 ${qStatus.count}번" name="question2_cd_${qStatus.count}" value="9999" id="answer2_${qStatus.count}_99}" <c:if test="${fn:indexOf(questionItem.QUESTION2_CD, ':9999:') >= 0}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
															</c:when>
														</c:choose>
														기타
<!--													<label for="answer2_${qStatus.count}_99">														-->
<!--													</label>-->
												</c:if>
											</c:otherwise>
										</c:choose>
									</dd>
								</dl>
								
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${fn:length(questionList) == 0}">
					<tr>
						<td colspan="2">
							등록된 문제 리스트가 없습니다.
						</td>
					</tr>		
				</c:if>
			</tbody>
		</table>

		<c:if test="${message != null or fn:length(message) > 0}">
			<script>
				alert('${message}');
			</script>
		</c:if>
		
				<input type="hidden" name="company_cd" value="${Bean.company_cd}"/>
				<input type="hidden" name="company_id" value="${Bean.id}"/>
				<input type="hidden" name="master_cd" value="${result.master_cd}"/>
				<input type="hidden" name="find_type_cd" value="${Bean.find_type_cd}"/>
				<input type="hidden" name="type_cd" value="${result.type_cd}"/>
				<input type="hidden" name="year_cd" value="${Bean.year_cd}"/>
				
				<input type="hidden" name="type_cd_01_yn" value="${Bean.type_cd_01_yn}"/>
				<input type="hidden" name="type_cd_02_yn" value="${Bean.type_cd_02_yn}"/>
				<input type="hidden" name="type_cd_03_yn" value="${Bean.type_cd_03_yn}"/>
				<input type="hidden" name="type_cd_04_yn" value="${Bean.type_cd_04_yn}"/>
				<input type="hidden" name="type_cd_05_yn" value="${Bean.type_cd_05_yn}"/>
				<input type="hidden" name="type_cd_06_yn" value="${Bean.type_cd_06_yn}"/>
				<input type="hidden" name="type_cd_07_yn" value="${Bean.type_cd_07_yn}"/>
				<input type="hidden" name="type_cd_08_yn" value="${Bean.type_cd_08_yn}"/>
				<input type="hidden" name="type_cd_09_yn" value="${Bean.type_cd_09_yn}"/>
				<input type="hidden" name="type_cd_10_yn" value="${Bean.type_cd_10_yn}"/>
				<input type="hidden" name="type_cd_11_yn" value="${Bean.type_cd_11_yn}"/>
				
				<input type="hidden" name="questionListSize" value="${fn:length(questionList)}"/>
				<input type="hidden" name="view_state" value="${Bean.view_state == 'forUpdate' ? 'update' : 'writable'}"/>
				
<div class="board_btn_set mt13">
				<c:if test="${Bean.view_state != 'readonly'}">
	<span class="btn_del"><input type="submit" value="저장하기" /></span>
				</c:if>
	
				<c:if test="${Bean.view_state == 'readonly'}">
				<c:url value="/health/freecheck/forCheck.do?categoryId=${param.categoryId}" var="modify_action">
					<c:param name="company_cd" value="${Bean.company_cd}"/>
					<c:param name="find_type_cd" value="${Bean.find_type_cd}"/>
					<c:param name="year_cd" value="${Bean.year_cd}"/>
					<c:param name="company_id" value="${Bean.id}"/>
					<c:param name="id" value="${Bean.id}"/>
					<c:param name="pageIndex" value="${Bean.pageIndex}"/>
					
					<c:param name="view_state" value="forUpdate"/>
					
					<c:param name="type_cd_01_yn" value="${Bean.type_cd_01_yn}"/>
					<c:param name="type_cd_02_yn" value="${Bean.type_cd_02_yn}"/>
					<c:param name="type_cd_03_yn" value="${Bean.type_cd_03_yn}"/>
					<c:param name="type_cd_04_yn" value="${Bean.type_cd_04_yn}"/>
					<c:param name="type_cd_05_yn" value="${Bean.type_cd_05_yn}"/>
					<c:param name="type_cd_06_yn" value="${Bean.type_cd_06_yn}"/>
					<c:param name="type_cd_07_yn" value="${Bean.type_cd_07_yn}"/>
					<c:param name="type_cd_08_yn" value="${Bean.type_cd_08_yn}"/>
					<c:param name="type_cd_09_yn" value="${Bean.type_cd_09_yn}"/>
					<c:param name="type_cd_10_yn" value="${Bean.type_cd_10_yn}"/>
					<c:param name="type_cd_11_yn" value="${Bean.type_cd_11_yn}"/>
					
					<c:param name="master_cd" value="${result.master_cd}"/>
					<c:param name="type_cd" value="${Bean.type_cd}"/>
				</c:url>
	<span class="btn_del"><a href="${modify_action}">수정하기</a></span>
				</c:if>

				<c:url value="/health/freecheck/list.do?categoryId=${param.categoryId}" var="list_action">
					<c:param name="company_cd" value="${Bean.company_cd}"/>
					<c:param name="year_cd" value="${Bean.year_cd}"/>
					<c:param name="find_type_cd" value="${Bean.find_type_cd}"/>
					<c:param name="type_cd" value="${result.type_cd}"/>
					<c:param name="company_id" value="${Bean.id}"/>
					<c:param name="id" value="${Bean.id}"/>
					<c:param name="type_cd_01_yn" value="${Bean.type_cd_01_yn}"/>
					<c:param name="type_cd_02_yn" value="${Bean.type_cd_02_yn}"/>
					<c:param name="type_cd_03_yn" value="${Bean.type_cd_03_yn}"/>
					<c:param name="type_cd_04_yn" value="${Bean.type_cd_04_yn}"/>
					<c:param name="type_cd_05_yn" value="${Bean.type_cd_05_yn}"/>
					<c:param name="type_cd_06_yn" value="${Bean.type_cd_06_yn}"/>
					<c:param name="type_cd_07_yn" value="${Bean.type_cd_07_yn}"/>
					<c:param name="type_cd_08_yn" value="${Bean.type_cd_08_yn}"/>
					<c:param name="type_cd_09_yn" value="${Bean.type_cd_09_yn}"/>
					<c:param name="type_cd_10_yn" value="${Bean.type_cd_10_yn}"/>
					<c:param name="type_cd_11_yn" value="${Bean.type_cd_11_yn}"/>
					<c:param name="view_state" value="${Bean.view_state}"/>
					<c:param name="master_cd" value="${result.master_cd}"/>
				</c:url>
	<span class="btn_list"><a href="${list_action}">${Bean.view_state == writable ? '취소' : '목록'}보기</a></span>
</div>
			
			
	</form>

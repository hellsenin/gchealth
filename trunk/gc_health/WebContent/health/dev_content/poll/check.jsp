<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>

<script type="text/javascript">
<!--

function checkAndSubmit(f) 
{
		var v = new MiyaValidator(f);

		<c:forEach items="${questionList}" var="questionItem" varStatus="qStatus">
	    	<c:choose>
	    		<c:when test="${questionItem.QUEST_TYPE_CD == 'B'}">
		    		v.add("other_${qStatus.count}", {
		    			required: true
		    	    });
	    		</c:when>
	    		<c:otherwise>
	    			<c:forEach items="${questionItem.answerList}" var="answerItem" varStatus="aStatus">
	    				<c:choose>
	    					<c:when test="${questionItem.MULTI_CHECK_YN == 'N'}">
					    		v.add("question2_cd_${qStatus.count}", {
					    			required: true
					    	    });
	    					</c:when>
	    				</c:choose>
	    			</c:forEach>
	    			<c:choose>
	    				<c:when test="${questionItem.MULTI_CHECK_YN == 'N'}">
				    		v.add("question2_cd_${qStatus.count}", {
				    			required: true
				    	    });
	    				</c:when>
	    			</c:choose>
	    		</c:otherwise>
	    	</c:choose>
	    </c:forEach>
		    
		var result = v.validate();

		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();r
			return false;
		} else {
			return true;
		}

}

-->
</script>

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
				<th scope="row">설문기간</th>
				<td class="output tal"><fmt:formatDate value="${result.start_dt}" pattern="yyyy년MM월dd일"/> ~ <fmt:formatDate value="${result.end_dt}" pattern="yyyy년MM월dd일"/></td>
			</tr>
			<tr >
				<th scope="row">설문내용</th>
				<td class="output tal">
					${result.contents}
				</td>
			</tr>
			<tr>
				<th scope="row">첨부파일</th>
				<td class="output tal">
					<c:url value="/health/poll/download.do" var="download_url">
						<c:param name="file" value="${result.attachfile1}"></c:param>
					</c:url>
					<a href="${download_url}"><strong>${result.attachfile1}</strong></a>
				</td>
			</tr>
		</tbody>
	</table>
	
	<br/><br/>
	
	<form name="fm" action="/health/poll/check.do?categoryId=${param.categoryId}" method="post" onsubmit="return checkAndSubmit(this);">
		<input type="hidden" name="answer_cd" value="${answer.ANSWER_CD == null ? 0 : answer.ANSWER_CD}" />
				
		<h5 class="tit_05">설문 항목</h5>
		
		<!-- write form start -->
		<table id="check_form" summary="응모 할 수 있는 항목입니다" class="default_write" style="display: ${display_questions}">
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
									<dt style="margin-top: 6px;">${questionItem.QUESTION}</dt>
									<dd style="margin-top: 6px; margin-bottom: 6px;">
										<!-- 주관식 -->
										<c:choose>
											<c:when test="${questionItem.QUEST_TYPE_CD == 'B'}">
												<input type="hidden" name="question_cd_${qStatus.count}" value="${questionItem.QUESTION_CD}"></input>
												<input type="hidden" name="question2_cd_${qStatus.count}" value="${questionItem.QUESTION2_CD}"></input>
												<input type="text" title="문제 ${qStatus.count}번" name="other_${qStatus.count}" value="${questionItem.OTHER}" class="t_text vam" style="width: 98%; padding-left: 3px;"/>
											</c:when>
											
											<c:otherwise>
												<input type="hidden" name="question_cd_${qStatus.count}" value="${questionItem.QUESTION_CD}"></input>
												<input type="hidden" name="multi_check_yn_${qStatus.count}" value="${questionItem.MULTI_CHECK_YN}"></input>
												<c:forEach items="${questionItem.answerList}" var="answerItem" varStatus="aStatus">
													<!-- 객관식 --> <!-- questionItem.QUEST_TYPE_CD == 'A' 인지 체크를 해줘야하지만 그렇지 않아도 A만 나올 것임 -->
													
														<c:if test="${questionItem.MULTI_CHECK_YN == 'Y'}">
															<input type="hidden" name="checkbox_count_${qStatus.count}" value="${fn:length(questionItem.answerList)}" />
														</c:if>
														<c:choose>
															<c:when test="${questionItem.MULTI_CHECK_YN == 'Y'}">
																<input type="checkbox" title="문제 ${qStatus.count}번" name="question2_cd_${qStatus.count}_${aStatus.count}" value="${answerItem.QUESTION2_CD}" id="answer2_${qStatus.count}_${answerItem.QUESTION2_CD}"/>
															</c:when>
															<c:when test="${questionItem.MULTI_CHECK_YN == 'N'}">
																<input type="radio" title="문제 ${qStatus.count}번" name="question2_cd_${qStatus.count}" value="${answerItem.QUESTION2_CD}" id="answer2_${qStatus.count}_${answerItem.QUESTION2_CD}"/>
															</c:when>
														</c:choose>
														${answerItem.QUESTION2} <br/>
<!--													<label for="answer2_${qStatus.count}_${answerItem.QUESTION2_CD}">-->
<!--													</label>-->
												</c:forEach>
												<!-- 기타항목 -->
												<c:if test="${questionItem.OTHER_YN == 'Y'}">

												<input type="hidden" name="other_yn_${qStatus.count}" value="${questionItem.OTHER_YN}"></input>
														<c:choose>
															<c:when test="${questionItem.MULTI_CHECK_YN == 'Y'}">
																<input type="checkbox" title="문제 ${qStatus.count}번" name="question2_cd_${qStatus.count}" value="9999" id="answer2_${qStatus.count}_99}"/>
															</c:when>
															<c:when test="${questionItem.MULTI_CHECK_YN == 'N'}">
																<input type="radio" title="문제 ${qStatus.count}번" name="question2_cd_${qStatus.count}" value="9999" id="answer2_${qStatus.count}_99}"/>
															</c:when>
														</c:choose>
														기타 
												<input type="text" title="문제 ${qStatus.count}번" name="other_${qStatus.count}" value="${questionItem.OTHER}" class="t_text vam" style="width: 50%; padding-left: 3px;"/>
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

				<input type="hidden" name="master_cd" value="${result.master_cd}"/>				
				<input type="hidden" name="questionListSize" value="${fn:length(questionList)}"/>				
				<input type="hidden" name="view_state" value="writable"/>
<div class="board_btn_set mt13">
	<span class="btn_del"><input type="submit" value="등록하기" /></span>
	
	<span class="btn_list"><a href="/health/poll/list.do?categoryId=${param.categoryId}">목록보기</a></span>
</div>			
	</form>



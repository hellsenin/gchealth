<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

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
	
	<title>${answer.SANGHO_NAME} 점검내역</title>
<link href="/health/open_content/system/css/default.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/common.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/blue.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_blue.css" rel="stylesheet" type="text/css" />


</head>
<body style="background:none;padding:10px;">
<h2 style="padding:15px 0 15px 0;">	
		${answer.SANGHO_NAME} 점검내역
</h2>
<p class="title_deco"></p>
<div class="body">
	<c:if test="${result.type_cd == '02'}">
	<jsp:include page="/admin/health/freecheck/checkform/app/application.jsp"></jsp:include>
	</c:if>
	
	

	<c:choose>
		<c:when test="${result.type_cd == '11'}">
			<c:if test="${answer.ARTICLE9_YN == 'Y'}">
				<c:set var="display_questions" value="block"/>
			</c:if>
			<c:if test="${answer.ARTICLE9_YN != 'Y'}">
				<c:set var="display_questions" value="none"/>
			</c:if>
		</c:when>
		<c:otherwise>
			<c:set var="display_questions" value="block"/> 
		</c:otherwise>
	</c:choose>
	
	<c:choose>
		<c:when test="${result.type_cd == '11'}">
			<c:if test="${answer.ARTICLE9_YN == 'Y'}">
				<c:set var="dont_display_questions" value="none"/>
			</c:if>
			<c:if test="${answer.ARTICLE9_YN != 'Y'}">
				<c:set var="dont_display_questions" value="block"/>
			</c:if>
		</c:when>
		<c:otherwise>
			<c:set var="dont_display_questions" value="none"/> 
		</c:otherwise>
	</c:choose>
	
	<div id="tb_not2"  class="board_view mgb20" style="display: ${dont_display_questions}">
		<table summary="등록정보 테이블로 허가내용을 알 수 있습니다" class="view_type01">
			<caption>등록정보</caption>
			<colgroup>
				<col width="*" />
			</colgroup>
			<tbody>
				<tr style="height: 30px;">
					<td style="text-align: center;">해당 사항이 없습니다.</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	
	
	<!-- write form start -->
	<table id="check_form" summary="응모 할 수 있는 항목입니다" class="default_view" style="display: ${display_questions}; width: 778px; text-align: center;">
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
													<c:choose>
														<c:when test="${answerItem.VALIDATION == 'Y'}">
													<font color="red">${answerItem.QUESTION2}</font>
														</c:when>
														<c:otherwise>
													${answerItem.QUESTION2}
														</c:otherwise>
													</c:choose>
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
	
<div id="btn_area" class="board_btn_set mt13">
	<span class="btn_del"><a href="#btn_area" onclick="window.close();">닫기</a></span>
	<span class="btn_del"><a href="#btn_area" onclick="window.print();">출력</a></span>
</div>

</div>
</body>
</html>


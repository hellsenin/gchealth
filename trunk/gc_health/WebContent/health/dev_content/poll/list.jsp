<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


	<h4>진행중인 설문 리스트 입니다.</h4>
	<table class="default_list" summary="번호, 제목, 점검기간, 상태, 등록일자로 구성되어 있습니다. 목록 제목을 클릭하면 상세내용으로 이동합니다.">
		<caption>자율점검표 작성방법</caption>
		<colgroup>
				<col width="8%" />
				<col width="*" />
				<col width="30%" />
				<col width="10%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col" class="fir">번호</th>
				<th scope="col">제목</th>
				<th scope="col">설문기간</th>
				<th scope="col">문항</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${ongoingResultList}" var="item" varStatus="status">
				<tr>
					<td><c:out value="${status.count}"/></td>
					<td class="tal">
						<c:url value="/health/poll/view.do?categoryId=${param.categoryId}" var="view_url">
							<c:param name="master_cd" value="${item.MASTER_CD}"/>
						</c:url>
						<a href="${view_url}">${item.TITLE}</a>
					</td>
					<td>
						<fmt:formatDate value="${item.START_DT}" pattern="yyyy년MM월dd일"/> ~ <fmt:formatDate value="${item.END_DT}" pattern="yyyy년MM월dd일"/>
					</td>
					<td>
						${item.QUESTION_CNT}문항
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(ongoingResultList) == 0}">
				<tr>
					<td colspan="4">
						데이터가 없습니다.
					</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<br/>
	<br/>

	<h4>마감된 설문 리스트 입니다.</h4>
	<table class="default_list" summary="번호, 제목, 점검기간, 상태, 등록일자로 구성되어 있습니다. 목록 제목을 클릭하면 상세내용으로 이동합니다.">
		<caption>자율점검표 작성방법</caption>
		<colgroup>
				<col width="8%" />
				<col width="*" />
				<col width="30%" />
				<col width="10%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col" class="fir">번호</th>
				<th scope="col">제목</th>
				<th scope="col">설문기간</th>
				<th scope="col">문항</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${finishedResultList}" var="item" varStatus="status">
				<tr>
					<td><c:out value="${status.count}"/></td>
					<td class="tal">
						<c:url value="/health/poll/view.do?categoryId=${param.categoryId}" var="view_url">
							<c:param name="master_cd" value="${item.MASTER_CD}"/>
						</c:url>
						<a href="${view_url}">${item.TITLE}</a>
					</td>
					<td>
						<fmt:formatDate value="${item.START_DT}" pattern="yyyy년MM월dd일"/> ~ <fmt:formatDate value="${item.END_DT}" pattern="yyyy년MM월dd일"/>
					</td>
					<td>
						${item.QUESTION_CNT}문항
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(finishedResultList) == 0}">
				<tr>
					<td colspan="4">
						데이터가 없습니다.
					</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	
<c:if test="${fn:length(finishedResultList) > 0}">
<ol class="paging">${pageNav}</ol>
</c:if>
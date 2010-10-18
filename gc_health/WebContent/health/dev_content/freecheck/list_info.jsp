<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div class="content_area">

	<table class="list_type01" summary="번호, 제목, 점검기간, 상태, 등록일자로 구성되어 있습니다. 목록 제목을 클릭하면 상세내용으로 이동합니다.">
		<caption>자율점검표 작성방법</caption>
		<colgroup>
			<col width="5%" />
			<col width="*" />
			<col width="5%" />
			<col width="30%" />
			<col width="16%" />
			<col width="8%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">제목</th>
				<th scope="col">첨부</th>
				<th scope="col">점검기간</th>
				<th scope="col">기간 상태</th>
				<th scope="col">문제수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${resultList}" var="item" varStatus="status">
				
				<tr>
					<!-- 타입 -->
					<td>
						${status.count}
					</td>
					
					<!-- 제목-->
					<td class="tal">
						<c:url var="actionUrl" value="/health/freecheck/read_info.do">
							<c:param name="year_cd" value="${Bean.year_cd}"/>
							<c:param name="master_cd" value="${item.MASTER_CD}"/>
							<c:param name="pageIndex" value="${Bean.pageIndex}"/>
							<c:param name="menuId" value="${Bean.menuId}"/>
						</c:url>
						<a href="${actionUrl}">${item.TITLE}</a><label></label>
					</td>
					
					<!-- 첨부파일 -->
					<td>
						
						<c:if test="${item.ATTACHFILE1 == null}"><font style="color: lightdrakgray;">-</font></c:if>
						<c:if test="${item.ATTACHFILE1 != null}">
							<c:url value="/health/freecheck/download.do" var="download_action">
								<c:param name="file" value="${item.ATTACHFILE1}" />
							</c:url>
							<a href="${download_action}"><img src="/admin/images/common/icon/icon_disk.gif" border="0" alt="${item.ATTACHFILE1}"/></a>
						</c:if>
						
					</td>
					
					
					<!-- 점검기간 -->
					<td>
						<fmt:formatDate value="${item.START_DT}" pattern="yyyy년MM월dd일"/>
						 ~ <fmt:formatDate value="${item.END_DT}" pattern="yyyy년MM월dd일"/>
					</td>
					
					<!-- 기간 상태 -->
					<td>
						<c:choose>
							<c:when test="${CURR_DATE >= item.START_DT and CURR_DATE <= item.END_DT}">점검 기간 중</c:when>
							<c:otherwise>점검 기간이 아님</c:otherwise>
						</c:choose>
					</td>
					
					<!-- 문제수 -->
					<td>
						${item.QUESTION_CNT} 문제
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}">
				<tr>
					<td colspan="5">
						등록된 리스트가 없습니다.
					</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</div>
<br/><br/>


<!-- 
<strong>자동 로그 아웃 (의약업소 자율점검 테스트) : 로그아웃을 도와주는 버튼입니다. 사이트 오픈 시에는 제거 됩니다.</strong><br/><br/>
<center><a href="/portal/member/logout.do">로그아웃</a></center>
 -->
<c:if test="${view_state == 'checked'}">
	<c:forEach items="${resultList}" var="item" varStatus="status">
		<c:if test="${item.STATUS eq '미점검' and fn:contains(item.TITLE,'마약')}">
			<script>
				alert('${item.TITLE}이 미점검 상태입니다');
			</script>
		</c:if>
	</c:forEach>
</c:if>
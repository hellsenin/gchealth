<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


	<h4>${company.company} - ${company.ceo_name}님의 자율점검 리스트 입니다.</h4>
	<table class="default_list" summary="번호, 제목, 점검기간, 상태, 등록일자로 구성되어 있습니다. 목록 제목을 클릭하면 상세내용으로 이동합니다.">
		<caption>자율점검표 작성방법</caption>
		<colgroup>
				<col width="8%" />
				<col width="*" />
				<col width="30%" />
				<col width="10%" />
<!--				<col width="10%" />-->
				<col width="10%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col" class="fir">번호</th>
				<th scope="col">제목</th>
				<th scope="col">점검기간</th>
				<th scope="col">상태</th>
<!--				<th scope="col">점검문항</th>-->
				<th scope="col">문항</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${resultList}" var="item" varStatus="status">
				<tr>
					<td><c:out value="${status.count}"/></td>
					<td class="tal">
						<!-- /health/freecheck/view.do?menuId=0602010101 -->
						<!-- /health/freecheck/forCheck.do?menuId=0602010101 -->
						<c:url value="/health/freecheck/view.do?categoryId=${param.categoryId}" var="view_url">
							<c:param name="company_cd" value="${Bean.company_cd}"/>
							<c:param name="find_type_cd" value="${Bean.find_type_cd}"/>
							<c:param name="year_cd" value="${Bean.year_cd}"/>
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
							
							<c:param name="master_cd" value="${item.MASTER_CD}"/>
							<c:param name="type_cd" value="${item.TYPE_CD}"/>
							
							<c:choose>
								<c:when test="${item.ANSWER_CNT == 0}">
									<c:param name="view_state" value="writable"/>
								</c:when>
								<c:otherwise>
									<c:param name="view_state" value="forUpdate"/>
								</c:otherwise>
							</c:choose>
							
						</c:url>
						
						<c:choose>
							<c:when test="${CURR_DATE >= item.START_DT and CURR_DATE <= item.END_DT}">
								<a href="${view_url}" onclick="return true;">${item.TITLE}</a>
							</c:when>
							<c:otherwise>
								<a href="${view_url}" onclick="alert('점검기간이 아닙니다'); return false;">${item.TITLE}</a>
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<fmt:formatDate value="${item.START_DT}" pattern="yyyy년MM월dd일"/> ~ <fmt:formatDate value="${item.END_DT}" pattern="yyyy년MM월dd일"/>
					</td>
					<td>
						<c:choose>
							<c:when test="${item.ANSWER_CNT == 0}">
								미점검
							</c:when>
							<c:when test="${item.ANSWER2_CNT == item.QUESTION_CNT or (item.ARTICLE9_YN == 'N' and item.TYPE_CD == '11') or (item.ARTICLE9_YN == 'n' and item.TYPE_CD == '11')}">
								점검완료
							</c:when>
							<c:when test="${item.ANSWER_CNT == 1 and item.ANSWER2_CNT < item.QUESTION_CNT}">
								미완료
							</c:when>
						</c:choose>
					</td>
<!--					<td>-->
<!--						${item.ANSWER2_CNT}문항-->
<!--					</td>-->
					<td>
						${item.QUESTION_CNT}문항
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}">
				<tr>
					<td colspan="6">
						점검할 리스트가 없습니다.
					</td>
				</tr>
			</c:if>
		</tbody>
	</table>
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
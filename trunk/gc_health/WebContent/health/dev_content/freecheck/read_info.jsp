<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="content_area">
	<div class="board_view">
		<table class="view_type01" summary="제목, 주관부서, 등록일, 조회수, 첨부파일, 내용으로 구성되어 있습니다.">
			<caption>민원서식 상세내용</caption>
			<colgroup>
				<col style="width:20%;"/>
				<col style="width:80%;"/>
			</colgroup>
			<tbody>
				<tr class="fir">
					<th scope="row">분류</th>
					<td class="output">
						<c:choose>
								<c:when test="${result.type_cd == '02'}">자율점검표</c:when>
								<c:when test="${result.type_cd == '03'}">법령인지도</c:when>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th scope="row">제목</th>
					<td class="output">${result.title}</td>
				</tr>
				<tr>
					<th scope="row">점검기간</th>
					<td class="output"><fmt:formatDate value="${result.start_dt}" pattern="yyyy년MM월dd일"/> ~ <fmt:formatDate value="${result.end_dt}" pattern="yyyy년MM월dd일"/></td>
				</tr>
				<tr >
					<th scope="row">점검내용</th>
					<td class="output">
						${result.contents}
					</td>
				</tr>
				<tr>
					<th scope="row">첨부파일</th>
					<td class="output">
						<c:url value="/health/freecheck/download.do" var="download_url">
							<c:param name="file" value="${result.attachfile1}"></c:param>
						</c:url>
						<a href="${download_url}"><strong>${result.attachfile1}</strong></a>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>

<div id="btn_area">
	<div class="btn_right_fr" style="margin-right: 20px;">
		<form action="/health/freecheck/list_info.do?menuId=0602020101" method="post">
			<input type="image" src="/health/open_content/images/btn/btn_bbs_list.gif" alt="목록" />
		</form>
	</div>

	<div class="btn_right_fr" style="margin-right: 10px;">
		<form action="/health/freecheck/list.do?menuId=0602010101" method="post">
			<input type="image" src="/health/open_content/images/common/btn/btn_go_online.gif" alt="온라인 점검 바로가기" />
		</form>
	</div>
</div>

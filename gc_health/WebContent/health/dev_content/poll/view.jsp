<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

			<table class="default_view" summary="제목, 주관부서, 등록일, 조회수, 첨부파일, 내용으로 구성되어 있습니다.">
				<caption>민원서식 상세내용</caption>
				<colgroup>
					<col style="width:20%;"/>
					<col style="width:80%;"/>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">제목</th>
						<td class="output">${result.title}</td>
					</tr>
					<tr>
						<th scope="row">설문기간</th>
						<td class="output"><fmt:formatDate value="${result.start_dt}" pattern="yyyy년MM월dd일"/> ~ <fmt:formatDate value="${result.end_dt}" pattern="yyyy년MM월dd일"/></td>
					</tr>
					<tr >
						<th scope="row">설문내용</th>
						<td class="output">
							${result.contents}
						</td>
					</tr>
					<tr>
						<th scope="row">첨부파일</th>
						<td class="output">
							<c:url value="/health/poll/download.do" var="download_url">
								<c:param name="file" value="${result.attachfile1}"></c:param>
							</c:url>
							<a href="${download_url}"><strong>${result.attachfile1}</strong></a>
						</td>
					</tr>
				</tbody>
			</table>
		<form action="/health/poll/forCheck.do?categoryId=${param.categoryId}" method="post">
			<input type="hidden" name="year_cd" value="${Bean.year_cd}"/>			
			<input type="hidden" name="view_state" value="${Bean.view_state}"/>			
			<input type="hidden" name="master_cd" value="${result.master_cd}"/>
<div class="board_btn_set mt13">
	<c:if test="${result.gigan_open_yn == 'Y'}">
	<span class="btn_del"><input type="submit" value="참여하기" /></span>
	</c:if>
	<c:choose>
	<c:when test="${result.master_cd == '1'}">
		* 2010년 7월 1일부터 7월 15일 설문조사 완료하였습니다.
	</c:when>
	<c:otherwise>
	<span class="btn_del"><a href="/health/poll/checkResult.do?master_cd=${result.master_cd}&amp;categoryId=${param.categoryId}">결과보기</a></span>
	</c:otherwise>
	</c:choose>
</div>
		</form>
			
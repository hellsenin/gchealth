<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 메뉴검색 영역 시작 -->

	<div class="result_box1">
		<h4><strong>메뉴검색</strong> (해당 검색어에 대한 검색결과가 <strong>${menuListCnt}</strong>건입니다)</h4>
		<ul class="result_list1">
			<c:if test="${fn:length(menuList)>0}">
		 	<c:forEach var="x" begin="0" end="${fn:length(menuList)-1}">
			<li>
				<p class="result_text"><a href="${menuList[x].fullMenuLink}">${menuList[x].name}</a></p>
				<p class="result_link">
					<a href="${menuList[x].fullMenuLink}" class="blank" title="검색결과 새창보기" target="_blank">http://bogunso.geumcheon.go.kr${menuList[x].fullMenuLink}</a>
					<span>|</span>
					<a href="${menuList[x].fullMenuLink}">[현재창에서보기]</a>
				</p>
			</li>
			</c:forEach>
			</c:if>
		</ul>


<ol class="paging">${pageNav}</ol>
	</div>


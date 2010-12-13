<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 직원/업무 영역 시작 -->

	<div class="result_box1" id="tab6">
		<h4><strong>직원/업무</strong> (해당 검색어에 대한 검색결과가 <strong>${deptListCnt}</strong>건입니다)</h4>
		<div class="data_type1">

			<table summary="직원업무 검색결과 테이블입니다.부서명, 담당자명, 담당업무, 이메일, 연락처를 알 수 있습니다." border="1">
				<caption>직원업무 검색결과</caption>
				<col style="width:19%;" />
				<col style="width:12%;" />
				<col style="width:31%;" />
				<col style="width:17%;" />
				<col />
				<thead>
				<tr>
					<th scope="col">부서명</th>
					<th scope="col">담당자명</th>
					<th scope="col">담당업무</th>
					<th scope="col">이메일</th>
					<th scope="col">연락처</th>
				</tr>
				</thead>
				<tbody>
			<c:if test="${fn:length(deptList)>0}">
		 		<c:forEach var="x" begin="0" end="${fn:length(deptList)-1}">
				<tr>
					<th scope="row">${deptList[x].department}</th>
					<td>${deptList[x].name}</td>
					<td class="pd_left">${deptList[x].intrdt}</td>
					<td><a href="mailto:${deptList[x].email}"><img src="http://www.geumcheon.go.kr/open_content/images/common/btn/btn_search_email.gif" alt="${deptList[x].name} 담당자에게 이메일발송" /></a></td>
					<td class="pd_left">
						전화. ${deptList[x].officetelno}
					</td>
				</tr>
				</c:forEach>
			</c:if>
				</tbody>
			</table>
		</div>


<ol class="paging">${pageNav}</ol>

	</div>
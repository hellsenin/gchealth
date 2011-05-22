<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	response.setHeader("Content-Type", "application/vnd.ms-excel; charset=UTF-8");
	response.setHeader("Content-Disposition", "attachment; filename=applicant.xls"); 
	response.setHeader("Content-Description", "JSP Generated Data"); 
%>

<html> 
<head> 
<title></title> 
</head> 
<body> 
    <table border=1> <!-- border=1은 필수 excel 셀의 테두리가 생기게함 --> 
        <tr bgcolor="#CACACA"> <!-- bgcolor=#CACACA excel 셀의 바탕색을 회색으로 --> 
            <td colspan="11">
            <H3>점검표점수</H3></td> 
        </tr> 
        <tr bgcolor="yellow"> 
			<td>번호</td>
			<td>업소명</td>
			<td>아이디</td>
			<td>이름</td>
			<td>전화번호</td>
			<td>점검일자</td>
			<td>취급품목</td>
			<td>승인</td>
			<td>문제수</td>
			<td>맞은문제수</td>
			<td>틀린문제수[틀린문항]</td>
        </tr>
        
		<c:if test="${fn:length(resultList) != 0}">
			<c:forEach items="${resultList}" var="item" varStatus="status">
				<c:set var="falseList" value="${falseMap[item.id]}" />
				<tr>
					<!-- 번호 -->
					<td>
						${fn:length(resultList) - status.count + 1}
					</td>
					
					<!-- 업소명-->
					<td class="tal">
						${item.company}
					</td>
					
					<td class="tal">
						${item.id}
					</td>
					
					<td class="tal">
						${item.ceoName}
					</td>
					
					<td class="tal">
						${item.tel}
					</td>
					
					<td class="tal">
						<fmt:formatDate value="${item.insertDt}" pattern="yyyy년 MM월 dd일"/>
					</td>
					
					<td>
						${item.handleitemCnt}
					</td>
					<td>
						${item.approvalYn == 'Y' ? '승인' : '미승인'}
					</td>
					<!-- 문제수 -->
					<td>
						${item.questionCnt}
					</td>
					
					<!-- 맞은문제수 -->
					<td>
						${item.correctAnswerCnt}
					</td>
					
					<!-- 틀린문제수 -->
					<td>
						${item.wrongAnswerCnt}[
					<c:forEach items="${falseList}" var="f" varStatus="status">
						${f.qnum},
					</c:forEach>
						]
					</td>					
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${fn:length(resultList) == 0}">
			<tr>
				<td colspan="8">검색된 리스트가 없습니다.</td>
			</tr>
		</c:if>
    </table> 

</body> 
</html> 
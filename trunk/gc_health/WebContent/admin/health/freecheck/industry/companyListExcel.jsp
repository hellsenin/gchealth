<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
            <td colspan="6">
            <H3>업소목록</H3></td> 
        </tr> 
        <tr bgcolor="yellow"> 
			<td>번호</td>
			<td>업소명</td>
			<td>아이디</td>
			<td>비번</td>
			<td>대표자</td>
			<td>등록일</td>
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
					<td class="tal">${item.company}
					</td>
					
					<!-- 아이디 -->
					<td>
						${item.id}
					</td>
					
					<!-- 비번 -->
					<td>
						[${item.passwd}]
					</td>
					
					<!-- 대표자 -->
					<td>
						${item.ceoName}
					</td>
						
					<!-- 승인여부 -->
<!--					<td>-->
<!--						${item.grade_cd_name}-->
<!--					</td>-->
					
					
					<!-- 등록일자 -->
					<td>
						<fmt:formatDate value="${item.insertDt}" pattern="yyyy년MM월dd일"/>
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
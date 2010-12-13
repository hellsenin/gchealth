<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
            <td colspan="13">
            <H3>${applyMst.applyName} 신청인</H3></td> 
        </tr> 
        <tr bgcolor="yellow"> 
            <td>번호</td>
            <td>신청자</td>
            <td>전화번호</td>
            <td>휴대 전화번호</td>
            <td>이메일</td>
            <td>신청인 주소</td>
            <td>신청일</td> 
            <td>성별</td> 
            <td>상태</td> 
        </tr>
        
		<c:if test="${fn:length(resultList) > 0}" >
		<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}">  
        <tr> 
            <td>${fn:length(resultList) - x}</td>
            <td>${resultList[x].name}</td>
            <td>${resultList[x].tel}</td>
            <td>${resultList[x].cellPhone}</td> 
     		<td>${resultList[x].email}</td> 
     		<td>${resultList[x].zipcode} ${resultList[x].addr1} ${resultList[x].addr2}</td> 
     		<td>${resultList[x].applyDate}</td> 
     		<td>
				<c:if test="${resultList[x].etc1 == '1'}">남</c:if>
				<c:if test="${resultList[x].etc1 == '2'}">여</c:if>
     		</td> 
			<td>
				<c:if test="${resultList[x].status == '1'}">신청대기</c:if>
				<c:if test="${resultList[x].status == '2'}">당첨</c:if>
			</td>
        </tr>   
		</c:forEach>
		</c:if>
    </table> 

</body> 
</html> 
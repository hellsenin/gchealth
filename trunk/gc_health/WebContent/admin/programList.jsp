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
            <td colspan="7">
            <H3>포탈프로그램 목록서</H3></td> 
        </tr> 
        <tr bgcolor="yellow"> 
            <td>No</td>
            <td>1 Depth</td>
            <td>2 Depth</td>
            <td>3 Depth</td>
            <td>4 Depth</td>
            <td>5 Depth</td>
            <td>파일위치</td> 
        </tr>
        
		<c:if test="${fn:length(resultList) > 0}" >
		<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}">  
		<c:set var="depth" value="${fn:split(resultList[x].fullPath,'/')}" />	
        <tr> 
            <td>${x+1}</td>
            <td>${depth[0]}</td>
            <td>${depth[1]}</td>
            <td>${depth[2]}</td>
            <td>${depth[3]}</td>
            <td>${depth[4]}</td>
            <td>${resultList[x].contentsPath}</td>
        </tr>   
		</c:forEach>
		</c:if>
    </table> 

</body> 
</html> 
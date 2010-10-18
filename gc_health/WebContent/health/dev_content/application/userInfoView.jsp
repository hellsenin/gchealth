<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
		
<table summary="이름, 이메일, 휴대폰, 전화번호, 주소" class="default_view">
    <caption>
    신청인정보
    </caption>
    
    <tr>
        <th scope="row">이름</th>
        <td colspan="3">&nbsp;${result.name}</td>
    </tr>
    <tr>
      <th scope="row"><label for="email1">이메일</label></th>
      <td colspan="3">${result.email}</td>
    </tr>
    <tr>
      <th scope="row"><label for="cellPhone1">휴대폰</label></th>
      <td>${result.cellPhone} </td>
      <th scope="row"><label for="tel1">전화번호</label></th>
      <td>${result.tel}</td>
    </tr>
    <tr>
      <th rowspan="2" scope="row"><label for="zipcode1">주소</label></th>
      <td colspan="3">${result.zipcode}</td>
    </tr>
    <tr>
      <td colspan="3">${result.addr1} ${result.addr2}</td>
    </tr>
</table>
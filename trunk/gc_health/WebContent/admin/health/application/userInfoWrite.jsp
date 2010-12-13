<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
		
<table summary="이름, 이메일, 휴대폰, 전화번호, 주소" class="default_write">
    <caption>
    모범업소 지정신청
    </caption>
    
    <tr> 
        <th scope="row">이름</th>
        <td colspan="3"><input type="text" id="name" name="name" value="${result.name}" style="width:150px" class="txt" /></td>
    </tr>
    <tr>
		<c:set var="_email" value="${fn:split(result.email, '@')}"/>
      <th scope="row"><label for="email1">이메일</label></th>
      <td colspan="3">
        <input type="text" id="email1" name="email_E" value="${_email[0]}" style="width:150px" class="txt" />
        @
        <input type="text" id="email2" name="email_E" value="${_email[1]}" style="width:150px" class="txt" />
      </td>
    </tr>
    <tr>
      <th scope="row"><label for="cellPhone1">휴대폰</label></th>
      <td>
		<c:set var="_cellPhone" value="${fn:split(result.cellPhone, '-')}"/>
        <input type="text" id="cellPhone1" name="cellPhone_U" value="${_cellPhone[0]}" style="width:30px" class="txt" maxlength="4"/>
        - <input type="text" id="cellPhone2" name="cellPhone_U" value="${_cellPhone[1]}" style="width:30px" class="txt" maxlength="4"/> 
        - <input type="text" id="cellPhone3" name="cellPhone_U" value="${_cellPhone[2]}" style="width:27px" class="txt" maxlength="4">
      </td>
      <th scope="row"><label for="tel1">전화번호</label></th>
      <td>
		<c:set var="_tel" value="${fn:split(result.tel, '-')}"/>
        <input type="text" id="tel1" name="tel_U" value="${_tel[0]}" style="width:30px" class="txt" maxlength="4"/>
        - <input type="text" id="tel2" name="tel_U" value="${_tel[1]}" style="width:30px" class="txt" maxlength="4"/> 
        - <input type="text" id="tel3" name="tel_U" value="${_tel[2]}" style="width:27px" class="txt" maxlength="4" />
      </td>
    </tr>
    <tr>
      <th rowspan="2" scope="row"><label for="zipcode1">주소</label></th>
      <td colspan="3">
		<c:set var="_zipcode" value="${fn:split(result.zipcode, '-')}"/>
        <input type="text" id="zipcode1" name="zipcode_U" value="${_zipcode[0]}" style="width:50px" class="txt" maxlength="3"/>
-
<input type="text" id="zipcode2" name="zipcode_U" value="${_zipcode[1]}" style="width:50px" class="txt" maxlength="3" />
<a href="/health/dev_content/zipcode/GC_member_zipcode.jsp?code1=zipcode1&amp;code2=zipcode2" onclick="window.open(this.href,'','width=400,height=400,location=no,toolbar=no,menubar=no,status=no,scrollbars=no,resizable=yes');return false;" onkeypress="if(event.keyCode==13) {this.onclick(); return false;}" title="우편번호검색 팝업"><img src="/health/open_content/images/btn/btn_s_zipcode.gif" alt="우편번호" align="absmiddle" /></a></td>
    </tr>
    <tr>
      <td colspan="3"><input type="text" id="address1" name="addr1" value="${result.addr1}" style="width:200px" class="txt"/> 
      <input type="text" id="address2" name="addr2" value="${result.addr2}" style="width:200px" class="txt"/></td>
    </tr>
</table>
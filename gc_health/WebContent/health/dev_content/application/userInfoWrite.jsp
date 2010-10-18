<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
		
<c:if test="${empty result}" >		
<table summary="신청인의 이름, 이메일, 휴대폰, 전화번호, 주소" class="default_write">
    <caption>신청인정보</caption>
    <tbody>
    <tr>
        <th scope="row" width="20%">이름</th>
        <td colspan="3" width="80%">&nbsp;${user.memNm}<input type="hidden" id="name" name="name" value="${user.memNm}" /></td>
    </tr>
    <tr>
      <th scope="row">이메일</th>
      <td colspan="3">
		<c:set var="_email" value="${fn:split(user.otherEmail, '@')}"/>
		<label for="email1" class="blind">이메일 아이디</label>
        <input type="text" id="email1" name="email_E" value="${_email[0]}" style="width:150px" class="txt" />
        @
		<label for="email1" class="blind">이메일 도메인</label>
        <input type="text" id="email2" name="email_E" value="${_email[1]}" style="width:150px" class="txt" />
      </td>
    </tr>
    <tr>
      <th scope="row">휴대폰</th>
      <td>
		<c:set var="_handphone" value="${fn:split(user.handphone, '-')}"/>
		<label for="cellPhone1" class="blind">휴대폰번호(앞자리)</label>
        <input type="text" id="cellPhone1" name="cellPhone_U" value="${_handphone[0]}" style="width:30px" class="txt" maxlength="4"/> - 
		<label for="cellPhone2" class="blind">휴대폰번호(중간자리)</label>
		<input type="text" id="cellPhone2" name="cellPhone_U" value="${_handphone[1]}" style="width:30px" class="txt" maxlength="4"/> - 
		<label for="cellPhone3" class="blind">휴대폰(뒷자리)</label>
		<input type="text" id="cellPhone3" name="cellPhone_U" value="${_handphone[2]}" style="width:27px" class="txt" maxlength="4"/>
      </td>
      <th scope="row">전화번호</th>
      <td>
		<c:set var="_phone" value="${fn:split(user.phone, '-')}"/>
		<label for="tel1" class="blind">전화번호(지역번호)</label>
        <input type="text" id="tel1" name="tel_U" value="${_phone[0]}" style="width:30px" class="txt" maxlength="4"/> - 
		<label for="tel2" class="blind">전화번호(국번)</label>
		<input type="text" id="tel2" name="tel_U" value="${_phone[1]}" style="width:30px" class="txt" maxlength="4"/> - 
		<label for="tel3" class="blind">전화번호(뒷자리)</label>
		<input type="text" id="tel3" name="tel_U" value="${_phone[2]}" style="width:27px" class="txt" maxlength="4"/>
      </td>
    </tr>
    <tr>
      <th rowspan="2" scope="row">주소</th>
      <td colspan="3">
		<a href="/health/dev_content/zipcode/GC_member_zipcode.jsp?code1=zipcode1&amp;code2=zipcode2&amp;code3=address1" onclick="window.open(this.href,'','width=400,height=400,location=no,toolbar=no,menubar=no,status=no,scrollbars=no,resizable=yes');return false;" onkeypress="if(event.keyCode==13) {this.onclick(); return false;}" title="우편번호검색 팝업"><img src="/health/open_content/images/btn/btn_s_zipcode.gif" alt="우편번호" align="absmiddle" /></a>
		<c:set var="_zipcode" value="${fn:split(user.zipcode, '-')}"/>
		<label for="zipcode1" class="blind">우편번호 앞자리</label>
        <input type="text" id="zipcode1" name="zipcode_U" value="${_zipcode[0]}" style="width:50px" class="txt" maxlength="3"/> - 
		<label for="zipcode2" class="blind">우편번호 뒷자리</label>
		<input type="text" id="zipcode2" name="zipcode_U" value="${_zipcode[1]}" style="width:50px" class="txt" maxlength="3" />
</td>
    </tr>
    <tr>
      <td colspan="3">
	  <label for="address1" class="blind">주소(시,도,군,구,읍,면,동)</label>		  
	  <input type="text" id="address1" name="addr1" value="${user.address1}" style="width:200px" class="txt"/> 
      <label for="address2" class="blind">주소(번지, 나머지 주소동)</label>	
	  <input type="text" id="address2" name="addr2" value="${user.address2}" style="width:200px" class="txt"/></td>
    </tr>
	</tbody>
</table>
</c:if>

<c:if test="${not empty result}" >		
<table summary="신청인의 이름, 이메일, 휴대폰, 전화번호, 주소" class="default_write">
    <caption>신청인정보</caption>
    <tbody>
    <tr>
        <th scope="row" width="20%">이름</th>
        <td colspan="3" width="80%">&nbsp;${result.name}<input type="hidden" id="name" name="name" value="${result.name}" /></td>
    </tr>
    <tr>
		<c:set var="_email" value="${fn:split(result.email, '@')}"/>
      <th scope="row">이메일</th>
      <td colspan="3">
	  	<label for="email1" class="blind">이메일 아이디</label>
        <input type="text" id="email1" name="email_E" value="${_email[0]}" style="width:150px" class="txt" />
        @
		<label for="email1" class="blind">이메일 도메인</label>
        <input type="text" id="email2" name="email_E" value="${_email[1]}" style="width:150px" class="txt" />
      </td>
    </tr>
    <tr>
      <th scope="row">휴대폰</th>
      <td>
		<c:set var="_cellPhone" value="${fn:split(result.cellPhone, '-')}"/>
		<label for="cellPhone1" class="blind">휴대폰번호(앞자리)</label>
        <input type="text" id="cellPhone1" name="cellPhone_U" value="${_cellPhone[0]}" style="width:30px" class="txt" maxlength="4"/> - 
		<label for="cellPhone2" class="blind">휴대폰번호(중간자리)</label>
		<input type="text" id="cellPhone2" name="cellPhone_U" value="${_cellPhone[1]}" style="width:30px" class="txt" maxlength="4"/> - 
		<label for="cellPhone3" class="blind">휴대폰번호(뒷자리)</label>
		<input type="text" id="cellPhone3" name="cellPhone_U" value="${_cellPhone[2]}" style="width:27px" class="txt" maxlength="4"/>
      </td>
      <th scope="row">전화번호</th>
      <td>
		<c:set var="_tel" value="${fn:split(result.tel, '-')}"/>
		<label for="tel1" class="blind">전화번호(지역번호)</label>
        <input type="text" id="tel1" name="tel_U" value="${_tel[0]}" style="width:30px" class="txt" maxlength="4"/> - 
		<label for="tel2" class="blind">전화번호(국번)</label>
		<input type="text" id="tel2" name="tel_U" value="${_tel[1]}" style="width:30px" class="txt" maxlength="4"/> - 
		<label for="tel3" class="blind">전화번호(뒷자리)</label>
		<input type="text" id="tel3" name="tel_U" value="${_tel[2]}" style="width:27px" class="txt" maxlength="4"/>
      </td>
    </tr>
    <tr>
      <th rowspan="2" scope="row">주소</th>
      <td colspan="3">
		<a href="/health/dev_content/zipcode/GC_member_zipcode.jsp?code1=zipcode1&amp;code2=zipcode2" onclick="window.open(this.href,'','width=400,height=400,location=no,toolbar=no,menubar=no,status=no,scrollbars=no,resizable=yes');return false;" onkeypress="if(event.keyCode==13) {this.onclick(); return false;}" title="우편번호검색 팝업"><img src="/health/open_content/images/btn/btn_s_zipcode.gif" alt="우편번호" align="absmiddle" /></a>
		<c:set var="_zipcode" value="${fn:split(result.zipcode, '-')}"/>
		<label for="zipcode1" class="blind">우편번호 앞자리</label>
        <input type="text" id="zipcode1" name="zipcode_U" value="${_zipcode[0]}" style="width:50px" class="txt" maxlength="3"/> - 
		<label for="zipcode2" class="blind">우편번호 뒷자리</label>
		<input type="text" id="zipcode2" name="zipcode_U" value="${_zipcode[1]}" style="width:50px" class="txt" maxlength="3" />
</td>
    </tr>
    <tr>
      <td colspan="3">
	  <label for="address1" class="blind">주소(시,도,군,구,읍,면,동)</label>
	  <input type="text" id="address1" name="addr1" value="${result.addr1}" style="width:200px" class="txt"/> 
      <label for="address2" class="blind">주소(번지, 나머지 주소)</label>	  
      <input type="text" id="address2" name="addr2" value="${result.addr2}" style="width:200px" class="txt"/>
	  </td>
    </tr>
	</tbody>
</table>
</c:if>
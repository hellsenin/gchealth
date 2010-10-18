<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
		
<table summary="이름, 이메일, 휴대폰, 전화번호, 주소" class="default_write">
    <caption>
    SMS보내기
    </caption>
    <tr> 
        <th scope="row">받는 전화</th>
        <td colspan="3"><input type="text" id="callNo" name="callNo" value="" style="width:150px" class="txt" /></td>
    </tr>
    <tr> 
        <th scope="row">발신자 전화번호</th>
        <td colspan="3"><input type="text" id="callBack" name="callBack" value="" style="width:150px" class="txt" /></td>
    </tr>
    <tr> 
        <th scope="row">발신자 성명</th>
        <td colspan="3"><input type="text" id="caller" name="caller" value="" style="width:150px" class="txt" /></td>
    </tr>
    <tr> 
        <th scope="row">보낼 메시지</th>
        <td colspan="3"><input type="text" id="msg" name="msg" value="" style="width:150px" class="txt" /></td>
    </tr>
</table>
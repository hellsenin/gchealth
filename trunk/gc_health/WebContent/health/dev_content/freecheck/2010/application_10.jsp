<%@page contentType="text/html;charset=utf-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 안경업소 -->

<h4>허가정보</h4>

	<table summary="허가정보 테이블로 허가내용을 알 수 있습니다" class="view_type01">
		<caption>허가정보</caption>
		<colgroup>
			<col width="23%" />
			<col width="7%" />
			<col width="20%" />
			<col width="20%" />
			<col width="30%" />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">
					<label for="sangho_name">상호</label>
				</th>
				<td class="output" colspan="2">
					<input id="sangho_name" name="sangho_name" type="text" maxlength="14" style="width:150px;" value="${answer.SANGHO_NAME == null ? Bean.company : answer.SANGHO_NAME}" class="t_text vam" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
				<th scope="row">
					<label for="number1">개설등록번호</label>
				</th>
				<td class="output">
					제 <input id="number1" name="number1" type="text" style="width:43px; text-align: center; padding-left: 0px;" maxlength="5" class="t_text vam" value="${answer.NUMBER1 == null ? Bean.sa_no : answer.NUMBER1}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 호
				</td>
			</tr>
			<tr>
				<th scope="row">개설자</th>
				<th class="output depth2_th"><label for="name1">성명</label></th>
				<td class="output gubun">
					<input type="text" id="name1" name="name1" style="width:100px" maxlength="10" class="t_text vam" value="${answer.NAME1 == null ? Bean.ceo_name : answer.NAME1}" readonly="readonly" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
				<th scope="row">
					<label for="tel">전화번호</label>
				</th>
				<td class="output">
					<input type="text" id="tel" name="tel" style="width:100px" class="t_text vam" maxlength="14" title="전화번호" value="${answer.TEL}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
			</tr>
			
			
			<tr>
				<th class="output depth2_th"><label for="number2">면허번호</label></th>
				<td class="output gubun" colspan="4">
				안경사 제 <input type="text" id="number2" name="number2" value="${answer.NUMBER2 == null ? Bean.pharmacist_no : answer.NUMBER2}" maxlength="5" style="width:45px; text-align: center; padding-left: 0px;" onkeyup="setNum(this);" class="t_text vam" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 호
				</td>
			</tr>
			
			<tr>
				<th class="output depth2_th"><label for="email">e메일</label></th>
				<td class="output gubun" colspan="2"><input type="text" id="email" name="email" value="${answer.EMAIL}" style="width:150px" class="t_text vam" title="이메일" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/></td>
				<th scope="row"><label for="fax">팩스</label></th>
				<td class="output">
					<input type="text" id="fax" name="fax" value="${answer.FAX}" style="width:100px" maxlength="14" class="t_text vam" title="팩스" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>				
				</td>
			</tr>
			<tr>
				<th class="output depth2_th"><label for="hp">휴대전화번호</label></th>
				<td class="output gubun" colspan="4">
					<input type="text" id="hp" name="hp" value="${answer.HP}" style="width:100px" maxlength="14" class="t_text vam" title="휴대전화번호" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>				
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="addr2">소재지</label></th>
				<td class="output" colspan="2"><input type="text" id="addr2" name="addr2" value="${fn:replace(answer.ADDR2 == null ? Bean.addr2 : answer.ADDR2, '서울특별시 종로구 ', '')}" style="width:210px;" class="t_text" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/></td>
				<th scope="row"><label for="cnt1">종사 안경사</label></th>
				<td class="output">
					<input id="cnt1" type="text" style="width:25px;" class="t_text vam" name="cnt1" maxlength="3" onkeyup="setNum(this);" value="${answer.CNT1 == null ? 0 : answer.CNT1}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 명 
				</td>
			</tr>
			
			
		</tbody>
	</table>

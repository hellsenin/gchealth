<%@page contentType="text/html;charset=utf-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 약업사 -->
	
<h4>허가정보</h4>
	<table summary="허가정보 테이블로 허가내용을 알 수 있습니다" class="default_view">
		<caption>허가정보</caption>
		<colgroup>
			<col width="20%" />
			<col width="30%" />
			<col width="20%" />
			<col width="30%" />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">
					<label for="sangho_name">업소명</label>
				</th>
				<td class="output">
					<input id="sangho_name" name="sangho_name" type="text" maxlength="14" style="width:150px;" value="${answer.SANGHO_NAME == null ? Bean.company : answer.SANGHO_NAME}" readonly="readonly" class="t_text vam" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
				<th scope="row">
					<label for="number1">허가번호</label>
				</th>
				<td class="output">
					제 <input id="number1" name="number1" type="text" style="width:40px; text-align: center; padding-left: 0px;" maxlength="5" class="t_text vam" value="${answer.NUMBER1 == null ? Bean.sa_no : answer.NUMBER1}" readonly="readonly" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 호
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="name1">개설자</label>
				</th>
				<td class="output">
					<input type="text" id="name1" name="name1" style="width:100px" maxlength="10" class="t_text vam" value="${answer.NAME1 == null ? Bean.ceo_name : answer.NAME1}" readonly="readonly" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
				<th scope="row">
					<label for="addr2">소재지</label>
				</th>
				<td class="output">
					<input id="addr2" type="text" name="addr2" style="width:200px;" class="t_text vam" value="${fn:replace(answer.ADDR2 == null ? Bean.addr2 : answer.ADDR2, '서울특별시 종로구 ', '')}" readonly="readonly" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if> alt="${answer.ADDR2}"/>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="tel">전화번호</label>
				</th>
				<td class="output">
					<input type="text" id="tel" name="tel" style="width:100px" maxlength="14" class="t_text vam" title="전화번호" value="${answer.TEL == null ? Bean.tel : answer.TEL}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
				<th scope="row">
					<label for="fax">팩스번호</label>
				</th>
				<td class="output">
					<input type="text" id="fax" name="fax" style="width:100px" maxlength="14" class="t_text vam" title="팩스" value="${answer.FAX == null ? Bean.fax : answer.FAX}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>				
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="email">e메일</label>
				</th>
				<td class="output">
					<input type="text" id="email" name="email" style="width:90%" class="t_text vam" value="${answer.EMAIL}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
				<th scope="row">
					<label for="hp">휴대전화번호</label>
				</th>
				<td class="output">
					<input type="text" id="hp" name="hp" style="width:100px" maxlength="14" class="t_text vam" title="손전화" value="${answer.HP == null ? Bean.hp : answer.HP}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>		
				</td>
			</tr>
		</tbody>
	</table>
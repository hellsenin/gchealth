<%@page contentType="text/html;charset=utf-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!-- 의료기기판매업소 -->

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
					<label for="number1">신고번호</label>
				</th>
				<td class="output">
					제 <input id="number1" name="number1" type="text" style="width:43px; text-align: center; padding-left: 0px;" maxlength="5" class="t_text vam" value="${answer.NUMBER1 == null ? Bean.sa_no : answer.NUMBER1}" readonly="readonly" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 호
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
					<input id="addr2" type="text" name="addr2" style="width:200px;" class="t_text vam" value="${fn:replace(answer.ADDR1 == null ? Bean.addr1 : answer.ADDR1, '서울특별시 금천구 ', '')}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if> alt="${answer.ADDR1}"/>
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
					<input type="text" id="hp" name="hp" style="width:100px" maxlength="14" class="t_text vam" title="손전화" value="${answer.HP}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>		
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="homepage">홈페이지 주소</label>
				</th>
				<td class="output">
					<input type="text" id="homepage" name="homepage" style="width: 150px;" class="t_text vam" title="홈페이지 주소" value="${answer.HOMEPAGE}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
				<th scope="row">
					<label for="etc17">무료체험관 운영</label><font color="red">*</font>
				</th>
				<td class="output">
					<label for="etc17">운영<input id="etc17" name="article1_yn" type="radio" class="vam" value="Y" <c:if test="${answer.ARTICLE1_YN == 'Y'}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/></label>
					<label for="etc19">운영안함<input id="etc19" name="article1_yn" type="radio" class="vam" value="N" <c:if test="${answer.ARTICLE1_YN == 'N'}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/></label>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="other1">주요취급품목<br/>(2가지이상)</label>
				</th>
				<td class="output" colspan="3" style="vertical-align: middle;">
					<div>
					<input id="other1" type="text" style="width:500px" class="t_text vam" name="other1" value="${answer.OTHER1}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
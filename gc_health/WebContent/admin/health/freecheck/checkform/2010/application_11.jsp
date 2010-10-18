<%@page contentType="text/html;charset=utf-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!-- 마약류 취급자 -->


<!-- <h5 class="tit_05">허가정보</h5> -->

<div  class="board_view mgb20" style="width:778px;">
	<table summary="등록정보 테이블로 허가내용을 알 수 있습니다" class="view_type01">
		<caption>등록정보</caption>
		<colgroup>
			<col width="23%" />
			<col width="15%" />
			<col width="15%" />
			<col width="23%" />
			<col width="12%" />
			<col width="15%" />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">
					<label for="sangho_name">업소명</label>
				</th>
				<td class="output" colspan="2">
					<input id="sangho_name" name="sangho_name" type="text" maxlength="14" style="width:150px;" value="${answer.SANGHO_NAME == null ? Bean.company : answer.SANGHO_NAME}" readonly="readonly" class="t_text vam" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
				<th scope="row">
					<label for="addr2">소재지</label>
				</th>
				<td class="output" colspan="2">
					<input id="addr2" type="text" name="addr2" style="width:200px;" class="t_text vam" value="${fn:replace(answer.ADDR2 == null ? Bean.addr2 : answer.ADDR2, '서울특별시 종로구 ', '')}" readonly="readonly" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if> alt="${answer.ADDR2}"/>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="tel">전화번호</label>
				</th>
				<td class="output" colspan="2">
					<input type="text" id="tel" name="tel" style="width:100px" maxlength="14" class="t_text vam" title="전화번호" value="${answer.TEL == null ? Bean.tel : answer.TEL}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
				<th scope="row">
					<label for="number1">허가번호</label>
				</th>
				<td class="output" colspan="2">
					<input id="number1" name="number1" type="text" style="width:40px; text-align: center; padding-left: 0px;" maxlength="5" class="t_text vam" value="${answer.NUMBER1 == null ? Bean.sa_no : answer.NUMBER1}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
			</tr>
			<tr>
				<th scope="row">대표자</th>
				<th class="output depth2_th"><label for="name1">성명</label></th>
				<td class="output gubun">
					<input type="text" id="name1" name="name1" style="width:100px" maxlength="10" class="t_text vam" value="${answer.NAME1 == null ? Bean.ceo_name : answer.NAME1}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
				<th scope="row">관리자</th>
				<th class="output depth2_th"><label for="name2">성명</label></th>
				<td class="output gubun">
					<input type="text" id="name1" name="name2" style="width:100px" maxlength="10" class="t_text vam" value="${answer.NAME2}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
			</tr>
			
			
			
			<tr>
				<th scope="row">마약류 취급여부</th>
				<td class="output" colspan="5">
					<label for="article9_yn_Y"><input id="article9_yn_Y" type="radio" class="vam" name="article9_yn" value="Y" onclick="isCheckDrug(this);" <c:if test="${answer.ARTICLE9_YN == 'Y' or answer.ARTICLE9_YN == ''}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 자율점검일 현재 마약류 재고를 보유하고 사용, 관리</label><br/> 
					<label for="article9_yn_N2"><input id="article9_yn_N2" type="radio" class="vam" name="article9_yn" value="N" onclick="isCheckDrug(this);" <c:if test="${answer.ARTICLE9_YN == 'N'}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 마약류의 처방전만 발행</label><br/>
					<label for="article9_yn_n1"><input id="article9_yn_n1" type="radio" class="vam" name="article9_yn" value="n" onclick="isCheckDrug(this);" <c:if test="${answer.ARTICLE9_YN == 'n'}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 현재 마약류를 전혀 취급하지 않음</label>
				</td>
			</tr>
			
			<tr>
				<th scope="row">허가종별</th>
				<td class="output" colspan="5">
					<label for="other1_1"><input id="other1_1" type="checkbox" class="vam" name="other1" value="1" <c:if test="${fn:contains(answer.OTHER1, 1)}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 마약류도매업자</label> 
					<label for="other1_2"><input id="other1_2" type="checkbox" class="vam" name="other1" value="2" <c:if test="${fn:contains(answer.OTHER1, 2)}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 마약류취급의료업자</label> 
					<label for="other1_3"><input id="other1_3" type="checkbox" class="vam" name="other1" value="3" <c:if test="${fn:contains(answer.OTHER1, 3)}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 마약류소매업자</label> 
					<label for="other1_4"><input id="other1_4" type="checkbox" class="vam" name="other1" value="4" <c:if test="${fn:contains(answer.OTHER1, 4)}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 마약류관리자</label>
				</td>
			</tr>
			<tr>
				<th scope="row"><label id="other2_lbl" for="other2_1" <c:if test="${Bean.view_state == 'readonly' or answer.ARTICLE9_YN != 'Y'}"> disabled='disabled'</c:if>>취급품목 <font color="red">*</font></label></th>
				<td class="output" colspan="5">
					<label id="other2_1_lbl" for="other2_1"><input id="other2_1" type="checkbox" class="vam" name="other2" value="1" <c:if test="${fn:contains(answer.OTHER2, 1)}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly' or answer.ARTICLE9_YN != 'Y'}"> disabled='disabled'</c:if>/> 향정신성의약품</label> 
					<label id="other2_2_lbl" for="other2_2"><input id="other2_2" type="checkbox" class="vam" name="other2" value="2" <c:if test="${fn:contains(answer.OTHER2, 2)}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly' or answer.ARTICLE9_YN != 'Y'}"> disabled='disabled'</c:if>/> 마약</label>
				</td>
			</tr>
			
		</tbody>
	</table>
</div>



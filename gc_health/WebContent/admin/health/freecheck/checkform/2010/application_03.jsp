<%@page contentType="text/html;charset=utf-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 의약품도매상 -->


<!-- <h5 class="tit_05">허가정보</h5> -->

<!-- write form start -->
<div  class="board_view mgb20" style="width:778px;">
	<table summary="등록정보 테이블로 허가내용을 알 수 있습니다" class="view_type01" style="width: 778px;">
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
					제 <input id="number1" name="number1" type="text" style="width:43px; text-align: center; padding-left: 0px;" maxlength="5" class="t_text vam" value="${answer.NUMBER1 == null ? Bean.sa_no : answer.NUMBER1}" readonly="readonly" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 호
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="other2">종별</label>
				</th>
				<td class="output">
					<input id="other2" name="other2" type="text" style="width:60px; text-align: center; padding-left: 0px;" class="t_text vam" value="${answer.OTHER2 == null ? Bean.pharmacist_no : answer.OTHER2}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
				<th scope="row">
					<label for="name1">대표자</label>
				</th>
				<td class="output">
					<input type="text" id="name1" name="name1" style="width:100px" maxlength="10" class="t_text vam" value="${answer.NAME1 == null ? Bean.ceo_name : answer.NAME1}" readonly="readonly" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
			</tr>
			<tr>
				<th scope="row">소재지</th>
				<td class="output" colspan="3">
					<div>
					<label for="addr2">영업소</label> : <input id="addr2" type="text" name="addr2" style="width:210px;" class="t_text vam" value="${fn:replace(answer.ADDR2 == null ? Bean.addr2 : answer.ADDR2, '서울특별시 종로구  ', '')}" readonly="readonly" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
					
					<label for="other4">창고</label> : <input id="other4" type="text" name="other4" style="width:220px;" class="t_text vam" value="${fn:replace(answer.OTHER4 == null ? Bean.addr2 : answer.OTHER4, '서울특별시 종로구  ', '')}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
					
					</div>
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
				<th scope="row"><label for="etc17">생물학적제제취급</label><font color="red">*</font></th>
				<td class="output" colspan="3">
					<label for="etc17"><input id="etc17" name="article1_yn" type="radio" class="vam" value="Y" <c:if test="${answer.ARTICLE1_YN == 'Y'}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>예</label>&nbsp;&nbsp;
					<label for="etc19"><input id="etc19" name="article1_yn" type="radio" class="vam" value="N" <c:if test="${answer.ARTICLE1_YN == 'N'}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>아니오</label>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="name2">도매업무관리자</label><font color="red">*</font></th>
				<td class="output" colspan="3">
					<label for="name2">성명 <input type="text" id="name2" name="name2" style="width:120px" class="t_text vam" value="${answer.NAME2}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/></label>
					<label for="number3">면허번호 <input id="number3" name="number3" type="text" style="width:120px" class="t_text vam" value="${answer.NUMBER3}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/></label>
				</td>
			</tr>
			<tr>
				<th scope="row">마약류 취급<font color="red">*</font></th>
				<td class="output" colspan="3">
					<label for="etc24"><input id="etc24" type="checkbox" class="vam" name="other3" value="1" <c:if test="${fn:contains(answer.OTHER3, 1)}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>마약</label>&nbsp;&nbsp;
					<label for="etc20"><input id="etc20" type="checkbox" class="vam" name="other3" value="2" <c:if test="${fn:contains(answer.OTHER3, 2)}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>향정신성의약품</label>&nbsp;&nbsp;
					<label for="etc66"><input id="etc66" type="checkbox" class="vam" name="other3" value="3" <c:if test="${fn:contains(answer.OTHER3, 3)}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>해당 없음</label>
				</td>
			</tr>
			
		</tbody>
	</table>
</div>
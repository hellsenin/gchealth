<%@page contentType="text/html;charset=utf-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${company.divide_cd == 'k01'}">
<!-- 약국 -->

<h4>허가정보</h4>

	<table summary="등록정보 테이블로 허가내용을 알 수 있습니다" class="default_view">
		<caption>등록정보</caption>
		<colgroup>
			<col width="20%" />
			<col width="30%" />
			<col width="20%" />
			<col width="30%" />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">
					<label for="sangho_name">약국명</label>
				</th>
				<td class="output">
					<input id="sangho_name" name="sangho_name" type="text" maxlength="14" style="width:150px;" value="${answer.SANGHO_NAME}" readonly="readonly" class="t_text vam" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
				<th scope="row">
					<label for="number1">등록번호</label>
				</th>
				<td class="output" >
					<label for="number1">제 <input id="number1" name="number1" type="text" style="width:43px; text-align: center; padding-left: 0px;" maxlength="5" class="t_text vam" value="${answer.NUMBER1}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 호</label>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="name1">대표자</label>
				</th>
				<td class="output">
					<input type="text" id="name1" name="name1" style="width:100px" maxlength="10" class="t_text vam" value="${answer.NAME1}" readonly="readonly" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
				<th scope="row">
					<label for="tel">전화번호</label>
				</th>
				<td class="output">
					<input type="text" id="tel" name="tel" style="width:100px" maxlength="14" class="t_text vam" title="전화번호" value="${answer.TEL}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="addr1">소재지</label>
				</th>
				<td class="output">
					<input id="addr1" type="text" name="addr1" style="width:200px;" class="t_text vam" value="${answer.ADDR1}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if> alt="${answer.ADDR1}"/>
				</td>
				<th scope="row">
					<label for="fax">팩스번호</label>
				</th>
				<td class="output">
					<input type="text" id="fax" name="fax" style="width:100px" maxlength="14" class="t_text vam" title="팩스" value="${answer.FAX}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>				
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
					<label for="cnt1">종업원수</label>
				</th>
				<td class="output" colspan="3">
					<label for="cnt1">근무약사 <input id="cnt1" type="text" name="cnt1" maxlength="3" style="width:28px; text-align: center; padding-left: 0px;" class="t_text vam" value="${answer.CNT1 == null ? 0 : answer.CNT1}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 명</label>
					<label for="cnt2">종업원 <input id="cnt2" type="text" name="cnt2" maxlength="3" style="width:28px; text-align: center; padding-left: 0px;" class="t_text vam" value="${answer.CNT2 == null ? 0 : answer.CNT2}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 명</label>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="other2">한약조제자격번호</label>
				</th>
				<td class="output" colspan="3">
					<label for="other2">개설약사 <input id="other2" type="text" title="한약조제자격번호 (개설약사)" style="width:80px; text-align: center; padding-left: 0px;" class="t_text vam" name="other2" value="${answer.OTHER2 == '' ? 0 : answer.OTHER2}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> </label>  
					<label for="other3">근무약사 <input id="other3" type="text" title="한약조제자격번호 (근무약사)" style="width:80px; text-align: center; padding-left: 0px;" class="t_text vam" name="other3" value="${answer.OTHER3 == '' ? 0 : answer.OTHER3}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> </label> 
				</td>
			</tr>
		<c:if test="${fn:length(itemList) > 0}">
			<tr>
				<th scope="row">
					<label for="etc24">취급품목</label><font color="red">*</font>
				</th>
				<td class="output" colspan="3">
					<c:forEach items="${itemList}" var="item" varStatus="qStatus">	
						<label for="etc${qStatus.count}"><input id="etc${qStatus.count}" title="취급품목" type="checkbox" class="vam" name="item" value="${item.itemName}" <c:if test="${fn:contains(answer.OTHER5, item.itemName)}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>${item.itemName}</label> 
					</c:forEach>
				</td>
			</tr>
		</c:if>
		</tbody>
	</table>
</c:if>

<c:if test="${company.divide_cd == 'k02'}">

<!-- (종합, 치과, 한방, 요양) 병원 자율점검표 -->

<h4>허가정보</h4>

	<table summary="허가정보 테이블로 허가내용을 알 수 있습니다" class="default_view">
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
					<input id="sangho_name" name="sangho_name" type="text" maxlength="14" style="width:150px;" value="${answer.SANGHO_NAME}" class="t_text vam" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
				<th scope="row">
					<label for="number1">허가번호</label>
				</th>
				<td class="output">
					제 <input id="number1" name="number1" type="text" style="width:43px; text-align: center; padding-left: 0px;padding-left: 0px;" maxlength="5" class="t_text vam" value="${answer.NUMBER1}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 호
				</td>
			</tr>
			<tr>
				<th scope="row">대표자</th>
				<th class="output depth2_th"><label for="name1">성명</label></th>
				<td class="output gubun">
					<input type="text" id="name1" name="name1" style="width:100px" maxlength="10" class="t_text vam" value="${answer.NAME1}" readonly="readonly" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
				<th scope="row">
					<label for="tel">전화번호</label>
				</th>
				<td class="output">
					<input type="text" id="tel" name="tel" style="width:100px" class="t_text vam" title="전화번호" maxlength="14" value="${answer.TEL}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
			</tr>
			<tr>
				<th scope="row" rowspan="3">담당자<br/>(작성자)</th>
				<th class="output depth2_th"><label for="name2">성명</label></th>
				<td class="output gubun">
					<input type="text" id="name2" name="name2" style="width:100px" maxlength="10" class="t_text vam" value="${answer.NAME2}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
				<th scope="row">
					<label for="fax">팩스번호</label>
				</th>
				<td class="output">
					<input type="text" id="fax" name="fax" style="width:100px" class="t_text vam" title="팩스번호" maxlength="14" value="${answer.FAX}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
			</tr>
			<tr>
				<th class="output depth2_th"><label for="hp">H.P.</label></th>
				<td class="output gubun" colspan="4">
					<input type="text" id="hp" name="hp" value="${answer.HP}" style="width:100px" class="t_text vam" maxlength="14" title="휴대전화번호" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>				
				</td>
			</tr>
			<tr>
				<th class="output depth2_th"><label for="email">e메일</label></th>
				<td class="output gubun" colspan="4"><input type="text" id="email" name="email" value="${answer.EMAIL}" style="width:120px" class="t_text" title="이메일" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/></td>
			</tr>
			<tr>
				<th scope="row"><label for="addr1">소재지</label></th>
				<td class="output" colspan="2"><input type="text" id="addr1" name="addr1" value="${answer.ADDR1}" style="width:210px;" class="t_text" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/></td>
				<th scope="row"><label for="cnt1">병상수</label><font color="red">*</font></th>
				<td class="output">
					<input id="cnt1" type="text" name="cnt1" style="text-align: center; padding-left: 0px; width:25px;" class="t_text vam" maxlength="3" value="${answer.CNT1 == null ? 0 : answer.CNT1}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 실,  
					<input id="cnt2" type="text" name="cnt2" style="text-align: center; padding-left: 0px; width:25px;" class="t_text vam" maxlength="3" value="${answer.CNT2 == null ? 0 : answer.CNT2}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 병상
				</td>
			</tr>
		<c:if test="${fn:length(itemList) > 0}">
			<tr>
				<th scope="row">
					<label for="etc24">취급품목</label><font color="red">*</font>
				</th>
				<td class="output" colspan="3">
					<c:forEach items="${itemList}" var="item" varStatus="qStatus">	
						<label for="etc${qStatus.count}"><input id="etc${qStatus.count}" title="취급품목" type="checkbox" class="vam" name="item" value="${item.itemName}" <c:if test="${fn:contains(answer.OTHER5, item.itemName)}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>${item.itemName}</label> 
					</c:forEach>
				</td>
			</tr>
		</c:if>
		</tbody>
	</table>

</c:if>

<c:if test="${company.divide_cd == 'k03'}">

<!-- (의원,한의원,치과의원) 의료기관 -->

	
<h4>허가정보</h4>

	<table summary="허가정보 테이블로 허가내용을 알 수 있습니다" class="default_view">
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
					<label for="number1">허가번호</label><!-- 기존 테이블에 필드가 모자라서 어쩔수 없이 homepage 필드를 사용하게 되었음 -->
				</th>
				<td class="output">
					제 <input id="number1" name="number1" type="text" style="width:43px; text-align: center; padding-left: 0px;" maxlength="5" class="t_text vam" value="${answer.NUMBER1 == null ? Bean.sa_no : answer.NUMBER1}" readonly="readonly" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 호
				</td>
			</tr>
			<tr>
				<th scope="row" rowspan="3">개설자</th>
				<th class="output depth2_th"><label for="name1">성명</label></th>
				<td class="output gubun">
					<input type="text" id="name1" name="name1" style="width:100px" maxlength="10" class="t_text vam" value="${answer.NAME1 == null ? Bean.ceo_name : answer.NAME1}" readonly="readonly" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
				<th scope="row">
					<label for="tel">전화번호</label>
				</th>
				<td class="output">
					<input type="text" id="tel" name="tel" style="width:100px" class="t_text vam" title="전화번호" maxlength="14" value="${answer.TEL == null ? Bean.tel : answer.TEL}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
			</tr>
			
			<tr>
				<th class="output depth2_th"><label for="email">e메일</label></th>
				<td class="output gubun">
					<input type="text" id="email" name="email" style="width:120px" class="t_text vam" value="${answer.EMAIL}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
				<th scope="row">
					<label for="fax">팩스</label>
				</th>
				<td class="output">
					<input type="text" id="fax" name="fax" style="width:100px" class="t_text vam" title="전화번호" maxlength="14" value="${answer.FAX == null ? Bean.fax : answer.FAX}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
			</tr>
			<tr>
				<th class="output depth2_th"><label for="hp">H.P</label></th>
				<td class="output gubun" colspan="4">
					<input type="text" id="hp" name="hp" value="${answer.HP}" style="width:100px" class="t_text vam" maxlength="14" title="휴대전화번호" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>				
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="addr1">소재지</label> <font color="red">*</font></th>
				<td class="output" colspan="2"><input type="text" id="addr1" name="addr1" value="${fn:replace(answer.ADDR1 == null ? Bean.addr2 : answer.ADDR2, '서울특별시 종로구 ', '')}" style="width:210px;" class="t_text" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/></td>
				<th scope="row"><label for="etc14">병상수</label><font color="red">*</font></th>
				<td class="output">
					<input id="cnt1" type="text" name="cnt1" style="text-align: center; padding-left: 0px; width:25px;" class="t_text vam" maxlength="3" value="${answer.CNT1 == null ? 0 : answer.CNT1}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 실,  
					<input id="cnt2" type="text" name="cnt2" style="text-align: center; padding-left: 0px; width:25px;" class="t_text vam" maxlength="3" value="${answer.CNT2 == null ? 0 : answer.CNT2}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 병상
				</td>
			</tr>
		<c:if test="${fn:length(itemList) > 0}">
			<tr>
				<th scope="row">
					<label for="etc24">취급품목</label><font color="red">*</font>
				</th>
				<td class="output" colspan="3">
					<c:forEach items="${itemList}" var="item" varStatus="qStatus">	
						<label for="etc${qStatus.count}"><input id="etc${qStatus.count}" title="취급품목" type="checkbox" class="vam" name="item" value="${item.itemName}" <c:if test="${fn:contains(answer.OTHER5, item.itemName)}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>${item.itemName}</label> 
					</c:forEach>
				</td>
			</tr>
		</c:if>
		</tbody>
	</table>
</c:if>

<c:if test="${company.divide_cd == 'k04'}">

<!-- 의약품도매상 -->


<h4>허가정보</h4>

<!-- write form start -->
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
					<input id="sangho_name" name="sangho_name" type="text" maxlength="14" style="width:150px;" value="${answer.SANGHO_NAME == null ? Bean.company : answer.SANGHO_NAME}" class="t_text vam" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
				<th scope="row">
					<label for="number1">허가번호</label>
				</th>
				<td class="output">
					제 <input id="number1" name="number1" type="text" style="width:43px; text-align: center; padding-left: 0px;" maxlength="5" class="t_text vam" value="${answer.NUMBER1 == null ? Bean.sa_no : answer.NUMBER1}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 호
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
					<input type="text" id="name1" name="name1" style="width:100px" maxlength="10" class="t_text vam" value="${answer.NAME1 == null ? Bean.ceo_name : answer.NAME1}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
			</tr>
			<tr>
				<th scope="row">소재지</th>
				<td class="output" colspan="3">
					<div>
					<label for="addr1">영업소</label> : <input id="addr1" type="text" name="addr1" style="width:210px;" class="t_text vam" value="${fn:replace(answer.ADDR1 == null ? Bean.addr1 : answer.ADDR1, '서울특별시 금천구  ', '')}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
					
					<label for="other4">창고</label> : <input id="other4" type="text" name="other4" style="width:220px;" class="t_text vam" value="${fn:replace(answer.OTHER4 == null ? Bean.addr2 : answer.OTHER4, '서울특별시 금천구  ', '')}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
					
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
		<c:if test="${fn:length(itemList) > 0}">
			<tr>
				<th scope="row">
					<label for="etc24">취급품목</label><font color="red">*</font>
				</th>
				<td class="output" colspan="3">
					<c:forEach items="${itemList}" var="item" varStatus="qStatus">	
						<label for="etc${qStatus.count}"><input id="etc${qStatus.count}" title="취급품목" type="checkbox" class="vam" name="item" value="${item.itemName}" <c:if test="${fn:contains(answer.OTHER5, item.itemName)}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>${item.itemName}</label> 
					</c:forEach>
				</td>
			</tr>
		</c:if>
		</tbody>
	</table>
</c:if>

<c:if test="${company.divide_cd == 'k05'}">

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
					<input id="sangho_name" name="sangho_name" type="text" maxlength="14" style="width:150px;" value="${answer.SANGHO_NAME == null ? Bean.company : answer.SANGHO_NAME}" class="t_text vam" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
				<th scope="row">
					<label for="number1">신고번호</label>
				</th>
				<td class="output">
					제 <input id="number1" name="number1" type="text" style="width:43px; text-align: center; padding-left: 0px;" maxlength="5" class="t_text vam" value="${answer.NUMBER1 == null ? Bean.sa_no : answer.NUMBER1}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 호
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="name1">개설자</label>
				</th>
				<td class="output">
					<input type="text" id="name1" name="name1" style="width:100px" maxlength="10" class="t_text vam" value="${answer.NAME1 == null ? Bean.ceo_name : answer.NAME1}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
				<th scope="row">
					<label for="addr2">소재지</label>
				</th>
				<td class="output">
					<input id="addr1" type="text" name="addr1" style="width:200px;" class="t_text vam" value="${fn:replace(answer.ADDR1 == null ? Bean.addr1 : answer.ADDR1, '서울특별시 금천구 ', '')}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if> alt="${answer.ADDR1}"/>
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
				<td class="output" colspan="3">
					<input type="text" id="homepage" name="homepage" style="width: 150px;" class="t_text vam" title="홈페이지 주소" value="${answer.HOMEPAGE}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="other1">취급품목</label>
				</th>
				<td class="output" style="vertical-align: middle;">
					<div>
					<input id="other1" type="text" style="width:500px" class="t_text vam" name="other1" value="${answer.OTHER1}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
					</div>
				</td>
				<th scope="row">
					<label for="other1">의료기기외 취급품목 <br/>( 예: 화장품, 식품, 전자제품 등 )</label>
				</th>
				<td class="output" style="vertical-align: middle;">
					<div>
					<input id="other2" type="text" style="width:500px" class="t_text vam" name="other2" value="${answer.OTHER2}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="other3">의료기기판매업외 허가사항</label>
				</th>
				<td class="output" colspan="3">
					<input id="other3" type="text" style="width:500px" class="t_text vam" name="other3" value="${answer.OTHER3}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
			</tr>
		<c:if test="${fn:length(itemList) > 0}">
			<tr>
				<th scope="row">
					<label for="etc24">취급품목</label><font color="red">*</font>
				</th>
				<td class="output" colspan="3">
					<c:forEach items="${itemList}" var="item" varStatus="qStatus">	
						<label for="etc${qStatus.count}"><input id="etc${qStatus.count}" title="취급품목" type="checkbox" class="vam" name="item" value="${item.itemName}" <c:if test="${fn:contains(answer.OTHER5, item.itemName)}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>${item.itemName}</label> 
					</c:forEach>
				</td>
			</tr>
		</c:if>
		</tbody>
	</table>
</c:if>
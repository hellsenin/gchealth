<%@page contentType="text/html;charset=utf-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 약국 -->

<!-- <h5 class="tit_05">허가정보</h5> -->

<!-- write form start -->
<div  class="board_view mgb20" style="width:778px;">
	<table summary="등록정보 테이블로 허가내용을 알 수 있습니다" class="view_type01" style="width: 778px;">
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
					<input id="sangho_name" name="sangho_name" type="text" maxlength="14" style="width:150px;" value="${answer.SANGHO_NAME == null ? Bean.company : answer.SANGHO_NAME}" readonly="readonly" class="t_text vam" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
				<th scope="row">
					<label for="number1">등록번호</label>
				</th>
				<td class="output" >
					<label for="number1">제 <input id="number1" name="number1" type="text" style="width:43px; text-align: center; padding-left: 0px;" maxlength="5" class="t_text vam" value="${answer.NUMBER1 == null ? Bean.sa_no : answer.NUMBER1}" readonly="readonly" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 호</label>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="name1">대표자</label>
				</th>
				<td class="output">
					<input type="text" id="name1" name="name1" style="width:100px" maxlength="10" class="t_text vam" value="${answer.NAME1 == null ? Bean.ceo_name : answer.NAME1}" readonly="readonly" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
				<th scope="row">
					<label for="tel">전화번호</label>
				</th>
				<td class="output">
					<input type="text" id="tel" name="tel" style="width:100px" maxlength="14" class="t_text vam" title="전화번호" value="${answer.TEL == null ? Bean.tel : answer.TEL}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="addr2">소재지</label>
				</th>
				<td class="output">
					<input id="addr2" type="text" name="addr2" style="width:200px;" class="t_text vam" value="${fn:replace(answer.ADDR2 == null ? Bean.addr2 : answer.ADDR2, '서울특별시 금천구 ', '')}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if> alt="${answer.ADDR2 == null ? Bean.addr2 : answer.ADDR2}"/>
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
					<input type="text" id="email" name="email" style="width:90%" class="t_text vam" value="${answer.EMAIL == null ? Bean.email : answer.EMAIL}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
				<th scope="row">
					<label for="hp">휴대전화번호</label>
				</th>
				<td class="output">
					<input type="text" id="hp" name="hp" style="width:100px" maxlength="14" class="t_text vam" title="손전화" value="${answer.HP == null ? Bean.hp : answer.HP}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>		
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="cnt1">근무인원</label>
				</th>
				<td class="output" colspan="3">
					<label for="cnt1">근무약사 <input id="cnt1" type="text" name="cnt1" maxlength="3" style="width:28px; text-align: center; padding-left: 0px;" class="t_text vam" value="${answer.CNT1 == null ? 0 : answer.CNT1}" onkeyup="setNum(this);" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 명</label>
					<label for="cnt2">그 외 직원 <input id="cnt2" type="text" name="cnt2" maxlength="3" style="width:28px; text-align: center; padding-left: 0px;" class="t_text vam" value="${answer.CNT2 == null ? 0 : answer.CNT2}" onkeyup="setNum(this);" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 명</label>
				</td>
			</tr>
			<tr>
				<th scope="row">학교약사</th>
				<td class="output" colspan="3">
					<label for="etc17">예<input id="etc17" name="article1_yn" type="radio" class="vam" value="Y" <c:if test="${answer.ARTICLE1_YN == 'Y'}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/></label> 학교명 <input id="other1" name="other1" type="text" style="width:150px;" class="t_text vam" value="${answer.OTHER1}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
					<label for="etc19">아니오<input id="etc19" name="article1_yn" type="radio" class="vam" value="N" <c:if test="${answer.ARTICLE1_YN == 'N'}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/></label>
					<p class="import_info1">"예"일 경우 학교명 직접입력</p>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="etc20">한약조제여부</label><font color="red">*</font>
				</th>
				<td class="output" colspan="3">
					<label for="etc20"><input id="etc20" name="article2_yn" type="radio" class="vam" value="Y" title="한약조제여부" <c:if test="${answer.ARTICLE2_YN == 'Y'}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 한약조제(취급)함</label> 
					<label for="etc21"><input id="etc21" name="article2_yn" type="radio" class="vam" value="N" title="한약조제여부" <c:if test="${answer.ARTICLE2_YN == 'N'}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 한약조제 안함</label> 
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="other2">한약조제자격번호</label>
				</th>
				<td class="output" colspan="3">
					<label for="other2">개설약사 <input id="other2" type="text" title="한약조제자격번호 (개설약사)" onkeyup="setNum(this);" style="width:80px; text-align: center; padding-left: 0px;" class="t_text vam" name="other2" value="${answer.OTHER2 == '' ? 0 : answer.OTHER2}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> </label>  
					<label for="other3">근무약사 <input id="other3" type="text" title="한약조제자격번호 (근무약사)" onkeyup="setNum(this);" style="width:80px; text-align: center; padding-left: 0px;" class="t_text vam" name="other3" value="${answer.OTHER3 == '' ? 0 : answer.OTHER3}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> </label> 
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="other2">개문시간</label><font color="red">*</font>
				</th>
				<td class="output" colspan="4">
					
					<div class="pgb5">
						평일 : 시간
						<c:set var="arr_work_time1" value="${fn:split(answer.WORK_TIME1, ',')}" />
						<select class="vam" id="work_time1_1" name="work_time1" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>>
							 <c:choose>
						  		<c:when test="${fn:length(arr_work_time1) == 2}">
									<c:forTokens var="hour" items="선택,00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00" delims=",">
										<option <c:if test="${arr_work_time1[0] == hour}">selected="selected"</c:if>>${hour}</option>
									</c:forTokens>
						  		</c:when>
						  		<c:otherwise>
						  			<c:forTokens var="hour" items="선택,00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00" delims=",">
										<option>${hour}</option>
									</c:forTokens>
						  		</c:otherwise>
							 </c:choose>
						</select> ~ 
						<select class="vam" id="work_time1_2" name="work_time1" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>>
							 <c:choose>
						  		<c:when test="${fn:length(arr_work_time1) == 2}">
									<c:forTokens var="hour" items="선택,00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00" delims=",">
										<option <c:if test="${arr_work_time1[1] == hour}">selected="selected"</c:if>>${hour}</option>
									</c:forTokens>
						  		</c:when>
						  		<c:otherwise>
						  			<c:forTokens var="hour" items="선택,00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00" delims=",">
										<option>${hour}</option>
									</c:forTokens>
						  		</c:otherwise>
							 </c:choose>
						</select> 
						토요일 : 시간
						<c:set var="arr_work_time2" value="${fn:split(answer.WORK_TIME2, ',')}" />
						<select class="vam" id="work_time2_1" name="work_time2" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>>
							 <c:choose>
								<c:when test="${fn:length(arr_work_time2) == 2}">
									<c:forTokens var="hour" items="선택,00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00,근무 안함" delims=",">
										<option <c:if test="${arr_work_time2[0] == hour}">selected="selected"</c:if>>${hour}</option>
									</c:forTokens>
								</c:when>
								<c:otherwise>
									<c:forTokens var="hour" items="선택,00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00,근무 안함" delims=",">
										<option>${hour}</option>
									</c:forTokens>
								</c:otherwise>
							 </c:choose>
						</select> ~ 
						<select class="vam" id="work_time2_2" name="work_time2" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>>
							 <c:choose>
								<c:when test="${fn:length(arr_work_time2) == 2}">
									<c:forTokens var="hour" items="선택,00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00,근무 안함" delims=",">
										<option <c:if test="${arr_work_time2[1] == hour}">selected="selected"</c:if>>${hour}</option>
									</c:forTokens>
								</c:when>
								<c:otherwise>
									<c:forTokens var="hour" items="선택,00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00,근무 안함" delims=",">
										<option>${hour}</option>
									</c:forTokens>
								</c:otherwise>
							 </c:choose>
						</select>
					</div>
					<div>
						<script>
							function toggle_other4(chk) {
								if(chk) {
									document.getElementById('work_time3_1').disabled = "disabled";
									document.getElementById('work_time3_2').disabled = "disabled";
									for(var i=1; i<6; i++) {
										document.getElementById('other4_'+i).disabled = "disabled";
									}
								} else {
									document.getElementById('work_time3_1').disabled = "";
									document.getElementById('work_time3_2').disabled = "";
									for(var i=1; i<6; i++) {
										document.getElementById('other4_'+i).disabled = "";
									}
								}
							};
							
						</script>
						일요일 : 
						<input type="checkbox" title="일요일 근무" class="vam" id="other4_0" name="other4" value="0" onclick="toggle_other4(this.checked);" <c:if test="${fn:contains(answer.OTHER4, '0') or answer.OTHER4 == null}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>근무 안함
						<c:forTokens var="week" items="1,2,3,4,5" delims=",">
							<input type="checkbox" id="other4_${week}" title="일요일 근무" class="vam" name="other4" value="${week}" <c:if test="${fn:contains(answer.OTHER4, week)}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly' or fn:contains(answer.OTHER4, '0') or answer.OTHER4 == null}"> disabled='disabled'</c:if>/> ${week}주
						</c:forTokens>
						
						 
						(시간
						<c:set var="arr_work_time3" value="${fn:split(answer.WORK_TIME3, ',')}" />
						<select class="vam" id="work_time3_1" name="work_time3" <c:if test="${Bean.view_state == 'readonly' or fn:contains(answer.OTHER4, '0') or answer.OTHER4 == null}"> disabled='disabled'</c:if>>
							 <c:choose>
								<c:when test="${fn:length(arr_work_time3) == 2}">
									<c:forTokens var="hour" items="선택,00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00" delims=",">
										<option <c:if test="${arr_work_time3[0] == hour}">selected="selected"</c:if>>${hour}</option>
									</c:forTokens>
								</c:when>
								<c:otherwise>
									<c:forTokens var="hour" items="선택,00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00" delims=",">
										<option>${hour}</option>
									</c:forTokens>
								</c:otherwise>
							 </c:choose>
						</select> ~ 
						<select class="vam" id="work_time3_2" name="work_time3" <c:if test="${Bean.view_state == 'readonly' or fn:contains(answer.OTHER4, '0') or answer.OTHER4 == null}"> disabled='disabled'</c:if>>
							 <c:choose>
								<c:when test="${fn:length(arr_work_time3) == 2}">
									<c:forTokens var="hour" items="선택,00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00" delims=",">
										<option <c:if test="${arr_work_time3[1] == hour}">selected="selected"</c:if>>${hour}</option>
									</c:forTokens>
								</c:when>
								<c:otherwise>
									<c:forTokens var="hour" items="선택,00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00" delims=",">
										<option>${hour}</option>
									</c:forTokens>
								</c:otherwise>
							 </c:choose>
						</select>)
					</div>
					<p class="import_info1">
					토요일, 일요일 근무를 하지 않을 경우 <font color="red">근무 안함</font>을 입력해주세요, 개문시간은 당번약국 안내 등에 이용되니 정확하게 입력해주세요.
					</p>
	
				</td>
			</tr>
	
			<tr>
				<th scope="row">
					<label for="etc24">취급품목</label><font color="red">*</font>
				</th>
				<td class="output" colspan="3">
					<label for="etc24"><input id="etc24" title="취급품목" type="checkbox" class="vam" name="other5" value="1" <c:if test="${fn:contains(answer.OTHER5, 1)}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 한약(초제)</label> 
					<label for="etc25"><input id="etc25" title="취급품목" type="checkbox" class="vam" name="other5" value="2" <c:if test="${fn:contains(answer.OTHER5, 2)}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 의료기기</label> 
					<label for="etc26"><input id="etc26" title="취급품목" type="checkbox" class="vam" name="other5" value="3" <c:if test="${fn:contains(answer.OTHER5, 3)}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 향정신성의약품</label> 
					<label for="etc27"><input id="etc27" title="취급품목" type="checkbox" class="vam" name="other5" value="4" <c:if test="${fn:contains(answer.OTHER5, 4)}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 마약</label> 
					<label for="etc28"><input id="etc28" title="취급품목" type="checkbox" class="vam" name="other5" value="5" <c:if test="${fn:contains(answer.OTHER5, 5)}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 화장품</label> 
					<label for="etc29"><input id="etc29" title="취급품목" type="checkbox" class="vam" name="other5" value="6" <c:if test="${fn:contains(answer.OTHER5, 6)}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 의약품만</label> 
				</td>
			</tr>
			
		</tbody>
	</table>
</div>

<%@page contentType="text/html;charset=utf-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!-- (종합, 치과, 한방, 요양) 병원 자율점검표 -->

<!-- <h5 class="tit_05">허가정보</h5> -->


<div  class="board_view mgb20" style="width:778px;">
	<table summary="등록정보 테이블로 허가내용을 알 수 있습니다" class="view_type01" style="width: 778px;">
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
					<label for="number1">허가번호</label>
				</th>
				<td class="output">
					제 <input id="number1" name="number1" type="text" style="width:43px; text-align: center; padding-left: 0px;padding-left: 0px;" maxlength="5" class="t_text vam" value="${answer.NUMBER1 == null ? Bean.sa_no : answer.NUMBER1}" readonly="readonly" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 호
				</td>
			</tr>
			<tr>
				<th scope="row">대표자</th>
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
				<th scope="row" rowspan="3">담당자<br/>(작성자)</th>
				<th class="output depth2_th"><label for="name2">성명</label></th>
				<td class="output gubun">
					<input type="text" id="name2" name="name2" style="width:100px" maxlength="10" class="t_text vam" value="${answer.NAME2}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
				</td>
				<th scope="row">
					<label for="fax">팩스번호</label>
				</th>
				<td class="output">
					<input type="text" id="fax" name="fax" style="width:100px" class="t_text vam" title="팩스번호" maxlength="14" value="${answer.FAX == null ? Bean.fax : answer.FAX}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
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
				<th scope="row"><label for="addr2">소재지</label></th>
				<td class="output" colspan="2"><input type="text" id="addr2" name="addr2" value="${fn:replace(answer.ADDR2 == null ? Bean.addr2 : answer.ADDR2, '서울특별시 종로구 ', '')}" style="width:210px;" class="t_text" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/></td>
				<th scope="row"><label for="cnt1">병상수</label><font color="red">*</font></th>
				<td class="output">
					<input id="cnt1" type="text" name="cnt1" style="text-align: center; padding-left: 0px; width:25px;" class="t_text vam" maxlength="3" onkeyup="setNum(this);" value="${answer.CNT1 == null ? 0 : answer.CNT1}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 실,  
					<input id="cnt2" type="text" name="cnt2" style="text-align: center; padding-left: 0px; width:25px;" class="t_text vam" maxlength="3" onkeyup="setNum(this);" value="${answer.CNT2 == null ? 0 : answer.CNT2}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 병상
				</td>
			</tr>
			<tr>
				<th scope="row" rowspan="3">인력<font color="red">*</font></th>
				<td class="output" colspan="4">
					<p class="import_info1">대표자가 의사, 한의사, 치과의사인 경우 대표자 포함한 인력 입력 바랍니다.</p>
					
					<p class="pgb5">
						<c:set var="arr_other1" value="${fn:split(answer.OTHER1, ',')}" />
						<label for="etc91">의사 <input id="etc91" type="text" style="text-align: center; padding-left: 0px;width:20px;" class="t_text vam" name="other1" maxlength="2" onkeyup="setNum(this);" value="${arr_other1[0]}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 명</label>  
						(<label for="etc92">상근<input id="etc92" type="text" style="text-align: center; padding-left: 0px;width:20px;" class="t_text vam" name="other1" maxlength="2" onkeyup="setNum(this);" value="${arr_other1[1]}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/></label>, <label for="etc94">비상근<input id="etc94" type="text" style="text-align: center; padding-left: 0px;width:20px;" class="t_text vam" name="other1" maxlength="2" onkeyup="setNum(this);" value="${arr_other1[2]}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/></label>), 
						<label for="etc93">한의사 <input id="etc93" type="text" style="text-align: center; padding-left: 0px;width:20px;" class="t_text vam" name="other1" maxlength="2" onkeyup="setNum(this);" value="${arr_other1[3]}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 명</label> 
						(<label for="etc97">상근<input id="etc97" type="text" style="text-align: center; padding-left: 0px;width:20px;" class="t_text vam" name="other1" maxlength="2" onkeyup="setNum(this);" value="${arr_other1[4]}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/></label>, <label for="etc95">비상근<input id="etc95" type="text" style="text-align: center; padding-left: 0px;width:20px;" class="t_text vam" name="other1" maxlength="2" onkeyup="setNum(this);" value="${arr_other1[5]}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/></label>), 
						</p>
						<p>
						<label for="etc99">치과의사 <input id="etc99" type="text" style="text-align: center; padding-left: 0px;width:20px;" class="t_text vam" name="other1" maxlength="2" onkeyup="setNum(this);" value="${arr_other1[6]}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 명</label>
						(<label for="etc98">상근<input id="etc98" type="text" style="text-align: center; padding-left: 0px;width:20px;" class="t_text vam" name="other1" maxlength="2" onkeyup="setNum(this);" value="${arr_other1[7]}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/></label>, <label for="etc96">비상근<input id="etc96" type="text" style="text-align: center; padding-left: 0px;width:20px;" class="t_text vam" name="other1" maxlength="2" onkeyup="setNum(this);" value="${arr_other1[8]}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/></label>)
					</p>
				</td>
			</tr>
			<tr>
				<td class="output" colspan="4">
					<p>
						<c:set var="arr_other2" value="${fn:split(answer.OTHER2 == '' ? '0,0,0,0,0' : answer.OTHER2, ',')}" />
						<label for="etc19">간호사 <input id="etc19" type="text" style="text-align: center; padding-left: 0px;width:20px;" class="t_text vam" name="other2" maxlength="2" onkeyup="setNum(this);" value="${arr_other2[0]}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 명</label>, 
						<label for="etc20">조산사 <input id="etc20" type="text" style="text-align: center; padding-left: 0px;width:20px;" class="t_text vam" name="other2" maxlength="2" onkeyup="setNum(this);" value="${arr_other2[1]}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 명</label>, 
						<label for="etc21">간호조무사 <input id="etc21"  type="text" style="text-align: center; padding-left: 0px;width:20px;" class="t_text vam" name="other2" maxlength="2" onkeyup="setNum(this);" value="${arr_other2[2]}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/></label> 명, 
						<label for="etc22">약사 <input id="etc22" type="text" style="text-align: center; padding-left: 0px;width:20px;" class="t_text vam" name="other2" maxlength="2" onkeyup="setNum(this);" value="${arr_other2[3]}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 명</label>, 
						<label for="etc23">영양사 <input id="etc23" type="text" style="text-align: center; padding-left: 0px;width:20px;" class="t_text vam" name="other2" maxlength="2" onkeyup="setNum(this);" value="${arr_other2[4]}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 명</label>
					</p>
				</td>
			</tr>
			<tr>
				<td class="output" colspan="4">
					<p class="pgb5">
						<c:set var="arr_other3" value="${fn:split(answer.OTHER3 == '' ? '0,0,0,0,0,0,0,0' : answer.OTHER3, ',')}" />
						<label for="etc24">치과위생사 <input id="etc24" type="text" style="text-align: center; padding-left: 0px;width:20px;" class="t_text vam" name="other3" maxlength="2" onkeyup="setNum(this);" value="${arr_other3[0]}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 명</label>, 
						<label for="etc25">치과기공사 <input id="etc25" type="text" style="text-align: center; padding-left: 0px;width:20px;" class="t_text vam" name="other3" maxlength="2" onkeyup="setNum(this);" value="${arr_other3[1]}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 명</label>, 
						<label for="etc26">물리치료사 <input id="etc26" type="text" style="text-align: center; padding-left: 0px;width:20px;" class="t_text vam" name="other3" maxlength="2" onkeyup="setNum(this);" value="${arr_other3[2]}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 명</label>, 
						<label for="etc27">방사선사 <input id="etc27" type="text" style="text-align: center; padding-left: 0px;width:20px;" class="t_text vam" name="other3" maxlength="2" onkeyup="setNum(this);" value="${arr_other3[3]}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 명</label>,  
					</p>
					<p>
					<label for="etc28">임상병리사 <input id="etc28" type="text" style="text-align: center; padding-left: 0px;width:20px;" class="t_text vam" name="other3" maxlength="2" onkeyup="setNum(this);" value="${arr_other3[4]}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 명</label>,
					<label for="etc29">작업치료사 <input id="etc29" type="text" style="text-align: center; padding-left: 0px;width:20px;" class="t_text vam" name="other3" maxlength="2" onkeyup="setNum(this);" value="${arr_other3[5]}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 명</label>, 
					<label for="etc30">의무기록사 <input id="etc30" type="text" style="text-align: center; padding-left: 0px;width:20px;" class="t_text vam" name="other3" maxlength="2" onkeyup="setNum(this);" value="${arr_other3[6]}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 명</label>, 
					<label for="etc31">응급구조사 <input id="etc31" type="text" style="text-align: center; padding-left: 0px;width:20px;" class="t_text vam" name="other3" maxlength="2" onkeyup="setNum(this);" value="${arr_other3[7]}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/> 명</label>
					</p>
				</td>
			</tr>
			<tr>
				<th scope="row">근무시간<font color="red">*</font></th>
				<td class="output" colspan="4">
					<p class="import_info1">외래 환자 진료 가능한 시간 입력바랍니다. (근무를 하지 않을 경우<font color="red">근무 안함</font>을 선택해주세요)</p>

					<div class="pgb5">
						월~금 
						<c:set var="arr_work_time1" value="${fn:split(answer.WORK_TIME1, ',')}" />
						<select class="vam" name="work_time1" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>>
							 <c:choose>
						  		<c:when test="${fn:length(arr_work_time1) == 2}">
									<c:forTokens var="hour" items="00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00" delims=",">
										<option <c:if test="${arr_work_time1[0] == hour}">selected="selected"</c:if>>${hour}</option>
									</c:forTokens>
						  		</c:when>
						  		<c:otherwise>
						  			<c:forTokens var="hour" items="00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00" delims=",">
										<option>${hour}</option>
									</c:forTokens>
						  		</c:otherwise>
							 </c:choose>
						</select> ~ 
						<select class="vam" name="work_time1" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>>
							 <c:choose>
						  		<c:when test="${fn:length(arr_work_time1) == 2}">
									<c:forTokens var="hour" items="00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00" delims=",">
										<option <c:if test="${arr_work_time1[1] == hour}">selected="selected"</c:if>>${hour}</option>
									</c:forTokens>
						  		</c:when>
						  		<c:otherwise>
						  			<c:forTokens var="hour" items="00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00" delims=",">
										<option>${hour}</option>
									</c:forTokens>
						  		</c:otherwise>
							 </c:choose>
						</select> ,
						토 
						<c:set var="arr_work_time2" value="${fn:split(answer.WORK_TIME2, ',')}" />
						<select class="vam" name="work_time2" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>>
							 <c:choose>
								<c:when test="${fn:length(arr_work_time2) == 2}">
									<c:forTokens var="hour" items="00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00,근무 안함" delims=",">
										<option <c:if test="${arr_work_time2[0] == hour}">selected="selected"</c:if>>${hour}</option>
									</c:forTokens>
								</c:when>
								<c:otherwise>
									<c:forTokens var="hour" items="00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00,근무 안함" delims=",">
										<option>${hour}</option>
									</c:forTokens>
								</c:otherwise>
							 </c:choose>
						</select> ~ 
						<select class="vam" name="work_time2" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>>
							 <c:choose>
								<c:when test="${fn:length(arr_work_time2) == 2}">
									<c:forTokens var="hour" items="00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00,근무 안함" delims=",">
										<option <c:if test="${arr_work_time2[1] == hour}">selected="selected"</c:if>>${hour}</option>
									</c:forTokens>
								</c:when>
								<c:otherwise>
									<c:forTokens var="hour" items="00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00,근무 안함" delims=",">
										<option>${hour}</option>
									</c:forTokens>
								</c:otherwise>
							 </c:choose>
						</select> , <br/>
						일 
						<c:set var="arr_work_time3" value="${fn:split(answer.WORK_TIME3, ',')}" />
						<select class="vam" name="work_time3" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>>
							 <c:choose>
								<c:when test="${fn:length(arr_work_time3) == 2}">
									<c:forTokens var="hour" items="00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00,근무 안함" delims=",">
										<option <c:if test="${arr_work_time3[0] == hour}">selected="selected"</c:if>>${hour}</option>
									</c:forTokens>
								</c:when>
								<c:otherwise>
									<c:forTokens var="hour" items="00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00,근무 안함" delims=",">
										<option>${hour}</option>
									</c:forTokens>
								</c:otherwise>
							 </c:choose>
						</select> ~ 
						<select class="vam" name="work_time3" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>>
							 <c:choose>
								<c:when test="${fn:length(arr_work_time3) == 2}">
									<c:forTokens var="hour" items="00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00,근무 안함" delims=",">
										<option <c:if test="${arr_work_time3[1] == hour}">selected="selected"</c:if>>${hour}</option>
									</c:forTokens>
								</c:when>
								<c:otherwise>
									<c:forTokens var="hour" items="00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00,근무 안함" delims=",">
										<option>${hour}</option>
									</c:forTokens>
								</c:otherwise>
							 </c:choose>
						</select> ,
						
						공휴일 
						<c:set var="arr_other4" value="${fn:split(answer.OTHER4, ',')}" />
						<select class="vam" name="other4" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>>
							 <c:choose>
								<c:when test="${fn:length(arr_other4) == 4}">
									<c:forTokens var="hour" items="00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00,근무 안함" delims=",">
										<option <c:if test="${arr_other4[0] == hour}">selected="selected"</c:if>>${hour}</option>
									</c:forTokens>
								</c:when>
								<c:otherwise>
									<c:forTokens var="hour" items="00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00,근무 안함" delims=",">
										<option>${hour}</option>
									</c:forTokens>
								</c:otherwise>
							 </c:choose>
						</select> ~ 
						<select class="vam" name="other4" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>>
							 <c:choose>
								<c:when test="${fn:length(arr_other4) == 4}">
									<c:forTokens var="hour" items="00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00,근무 안함" delims=",">
										<option <c:if test="${arr_other4[1] == hour}">selected="selected"</c:if>>${hour}</option>
									</c:forTokens>
								</c:when>
								<c:otherwise>
									<c:forTokens var="hour" items="00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00,근무 안함" delims=",">
										<option>${hour}</option>
									</c:forTokens>
								</c:otherwise>
							 </c:choose>
						</select>
					</div>
					
					월~금 중 정기 휴일 
					<c:set var="arr_other5" value="${fn:split(answer.OTHER5, ',')}" />
					<select class="vam" id="holyday1" onchange="holyday();" name="other5" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>>
						 <c:choose>
							<c:when test="${fn:length(arr_other5) == 6}">
								<c:forTokens var="week" items="월요일,화요일,수요일,목요일,금요일,해당 없음" delims=",">
									<option <c:if test="${arr_other5[0] == week}">selected="selected"</c:if>>${week}</option>
								</c:forTokens>
							</c:when>
							<c:otherwise>
								<c:forTokens var="week" items="월요일,화요일,수요일,목요일,금요일,해당 없음" delims=",">
									<option>${week}</option>
								</c:forTokens>
							</c:otherwise>
						 </c:choose>
					</select>
					<select class="vam" id="holyday1_1" name="other5" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>>
						 <c:choose>
							<c:when test="${fn:length(arr_other5) == 6}">
								<c:forTokens var="hour" items="00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00" delims=",">
									<option <c:if test="${arr_other5[1] == hour}">selected="selected"</c:if>>${hour}</option>
								</c:forTokens>
							</c:when>
							<c:otherwise>
								<c:forTokens var="hour" items="00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00" delims=",">
									<option>${hour}</option>
								</c:forTokens>
							</c:otherwise>
						 </c:choose>
					</select> ~ 
					<select class="vam" id="holyday1_2" name="other5" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>>
						 <c:choose>
							<c:when test="${fn:length(arr_other5) == 6}">
								<c:forTokens var="hour" items="00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00" delims=",">
									<option <c:if test="${arr_other5[2] == hour}">selected="selected"</c:if>>${hour}</option>
								</c:forTokens>
							</c:when>
							<c:otherwise>
								<c:forTokens var="hour" items="00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00" delims=",">
									<option>${hour}</option>
								</c:forTokens>
							</c:otherwise>
						 </c:choose>
					</select>
					
					
					
					<select class="vam" id="holyday2" onchange="holyday();" name="other5" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>>
						 <c:choose>
							<c:when test="${fn:length(arr_other5) == 6}">
								<c:forTokens var="week" items="월요일,화요일,수요일,목요일,금요일,해당 없음" delims=",">
									<option <c:if test="${arr_other5[3] == week}">selected="selected"</c:if>>${week}</option>
								</c:forTokens>
							</c:when>
							<c:otherwise>
								<c:forTokens var="week" items="월요일,화요일,수요일,목요일,금요일,해당 없음" delims=",">
									<option>${week}</option>
								</c:forTokens>
							</c:otherwise>
						 </c:choose>
					</select>
					<select class="vam" id="holyday2_1" name="other5" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>>
						 <c:choose>
							<c:when test="${fn:length(arr_other5) == 6}">
								<c:forTokens var="hour" items="00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00" delims=",">
									<option <c:if test="${arr_other5[4] == hour}">selected="selected"</c:if>>${hour}</option>
								</c:forTokens>
							</c:when>
							<c:otherwise>
								<c:forTokens var="hour" items="00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00" delims=",">
									<option>${hour}</option>
								</c:forTokens>
							</c:otherwise>
						 </c:choose>
					</select> ~ 
					<select class="vam" id="holyday2_2" name="other5" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>>
						 <c:choose>
							<c:when test="${fn:length(arr_other5) == 6}">
								<c:forTokens var="hour" items="00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00" delims=",">
									<option <c:if test="${arr_other5[5] == hour}">selected="selected"</c:if>>${hour}</option>
								</c:forTokens>
							</c:when>
							<c:otherwise>
								<c:forTokens var="hour" items="00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00,22:00,23:00" delims=",">
									<option>${hour}</option>
								</c:forTokens>
							</c:otherwise>
						 </c:choose>
					</select>
					<!-- 
					<p class="import_info1">일요일 기본 설정  00:00~00:00으로 해주시고 수정 가능하게 해주세요.<br/>
						(월~금, 토는 비워주세요.)
					</p>

					<p class="import_info1">월~금 중 정기휴일은 일요일 00:00~00:00, 일요일 00:00~00:00로 기본설정 해주시고 수정가능하게 해주세요.</p>
					 -->
				</td>
			</tr>
			
		</tbody>
	</table>
</div>

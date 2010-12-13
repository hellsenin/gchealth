<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<form name="frm" method="post" action="/health/imagene/selectImagineMedical.do?categoryId=${param.categoryId}">

<div class="body_in">
<h4>진료비 항목을 추가 또는 변경을 원하시면 진료 항목을 선택하여 추가하여 주십시요.<br />
    다음 항목에서 원하시는 과목을 선택하시면 진료비 항목을 산출하실 수 있습니다.</h4>
<h4>1차 진료(내과) 및 기타 진료</h4>

<table class="data_table2" summary="1차 진료(내과) 및 기타 진료 가상진료비 산정 표로 진료내용, 진료비, 문의전화구성">
	<caption>1차 진료(내과) 및 기타 진료 가상 진료비 산정</caption>
	<thead>
		<tr>
			<th width="25%" scope="col">진료내용</th>
			<th width="55%" scope="col">진료비</th>
			<th width="20%" class="no_br" scope="col">문의전화</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td rowspan="2" class="title">1차 진료과<br />(내과)</td>
			<td><label>원외 처방전 발급 / 500원 <input name="int_issue" type="checkbox" value="500" <c:if test="${zvl.intIssue == 500}">checked="checked"</c:if> /></label></td>
			<td rowspan="2" class="tac no_br">02-867-6204</td>
		</tr>
		<tr>
			<td><label>1차 진료(처치) / 1,100원 <input name="int_pri" type="checkbox" value="1000" <c:if test="${zvl.intPri == 1000}">checked="checked"</c:if> /></label></td>
		</tr>
		<tr>
			<td rowspan="3" class="title">물리 치료</td>
			<td><label>1차 진료 / 1,600원<input name="phy_pri" type="checkbox" value="1600" <c:if test="${zvl.phyPri == 1600}">checked="checked"</c:if> /></label></td>
			<td rowspan="3" class="tac no_br">02-867-2035</td>
		</tr>
		<tr>
			<td><label>물리 치료 / 500원 <input name="phy_the" type="checkbox" value="500" <c:if test="${zvl.phyThe == 500}">checked="checked"</c:if> /></label></td>
		</tr>
		<tr>
			<td><label>원외처방전발급 / 1,000원 <input name="phy_issue" type="checkbox" value="1000" <c:if test="${zvl.phyIssue == 1000}">checked="checked"</c:if> /></label></td>
		</tr>
		<tr>
			<td rowspan="2" class="title">치과</td>
			<td><label>원외 처방전 발급 / 500원 <input name="den_issue" type="checkbox" value="500" <c:if test="${zvl.denIssue == 500}">checked="checked"</c:if> /></label></td>
			<td rowspan="2" class="tac no_br">02-866-9427</td>
		</tr>

		<tr>
			<td><label>치아 홈 메우기 (만 5세~8세) / 4,040원<input name="den_chi" type="checkbox" value="4040" <c:if test="${zvl.denChi == 4040}">checked="checked"</c:if> /></label></td>
		</tr>
		<tr>
			<td rowspan="2" class="title">영유아실</td>
			<td><label>산전산후 건강관리 영유아 / 무료<input name="baby_hc" type="checkbox" value="0" <c:if test="${zvl.babyHc == 0}">checked="checked"</c:if> /></label></td>
			<td rowspan="2" class="tac no_br">02-867-4637</td>
		</tr>
		<tr>
			<td><label>기본 예방 접종 (0세~만6세) / 무료 <input name="baby_vac" type="checkbox" value="0" <c:if test="${zvl.babyVac == 0}">checked="checked"</c:if> /></label></td>
		</tr>
		<tr>
			<td rowspan="5" class="title">기타</td>
			<td><label>간염 검사 / 4,040원 <input name="etc_hep" type="checkbox" value="4040" <c:if test="${zvl.etcHep == 4040}">checked="checked"</c:if> /></label></td>
			<td class="tac no_br">02-890-2425</td>
		</tr>
		<tr>
			<td><label>항 결핵제 (1개월분) / 2,000원 <input name="etc_anti" type="checkbox" value="2000" <c:if test="${zvl.etcAnti == 2000}">checked="checked"</c:if> /></label></td>
			<td class="tac no_br">02-890-2425</td>
		</tr>
		<tr>
			<td><label>X-선 필름 사본 교부 / 3,000원 <input name="etc_xfilm" type="checkbox" value="3000" <c:if test="${zvl.etcXfilm == 3000}">checked="checked"</c:if> /></label></td>
			<td class="tac no_br">02-867-4634</td>
		</tr>
		<tr>
			<td><label>X-선 촬영 / 무료 <input name="etc_x" type="checkbox" value="0" <c:if test="${zvl.etcX == 0}">checked="checked"</c:if> /></label></td>
			<td class="tac no_br">02-867-4634</td>
		</tr>
		<tr>
			<td><label>결핵 진단서 / 300원 <input name="etc_antiissue" type="checkbox" value="300" <c:if test="${zvl.etcAntiissue == 300}">checked="checked"</c:if> /></label></td>
			<td class="tac no_br">02-867-4633</td>
		</tr>
		<tr>
			<td class="title"><strong>진료비 합산</strong></td>
			<td colspan="2" class="no_br">
				<input type="image" src="/health/open_content/images/btn/btn_l_med.gif" value="진료비 합산" style="border:none"/>
				<c:if test="${tot1 != 0}">
					<fmt:formatNumber type="currency" currencySymbol="" minFractionDigits="0" value="${tot1}" groupingUsed="false"/>
				</c:if> 원
			</td>
		</tr>
	</tbody>
</table>

</div>

<div class="body_in">
<h4>임시 예방접종 및 건강진단서 관련</h4>
<table class="data_table2" summary="임시 예방접종 및 건강진단서 관련 가상 진료비 산정 표로 진료내용, 진료비, 문의전화로 구성">
	<caption>임시 예방접종 및 건강진단서 관련 가상 진료비 산정</caption>
	<thead>
		<tr>
			<th width="25%" scope="col">진료내용</th>
			<th width="55%" scope="col">진료비</th>
			<th width="20%" class="no_br" scope="col">문의전화</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td rowspan="8" class="title">임시예방접종</td>
			<td><label>일본 뇌염 3세 이상 / 2,890원 <input name="temp_enc3" type="checkbox" value="2890" <c:if test="${zvl.tempEnc3 == 2890}">checked="checked"</c:if> /></label></td>
			<td rowspan="8" class="tac no_br">02-890-2428</td>
		</tr>
		<tr>
			<td><label>일본 뇌염 3세 미만 / 무료<input name="temp_enc" type="checkbox" value="0" <c:if test="${zvl.tempEnc == 0}">checked="checked"</c:if> /></label></td>
		</tr>
		<tr>
			<td><label>B형 간염 성인 / 3,370 원<input name="temp_heb" type="checkbox" value="3370" <c:if test="${zvl.tempHeb == 3370}">checked="checked"</c:if> /></label></td>
		</tr>
		<tr>
			<td><label>B형 간염 소아 / 1,610 원<input name="temp_hebc" type="checkbox" value="1610" <c:if test="${zvl.tempHebc == 1610}">checked="checked"</c:if> /></label></td>
		</tr>
		<tr>
			<td><label>유행성 출혈열 / 6,940 원<input name="temp_epi" type="checkbox" value="6940" <c:if test="${zvl.tempEpi == 6940}">checked="checked"</c:if> /></label></td>
		</tr>
		<tr>
			<td><label>장티푸스(경구용) / 3,480원<input name="temp_typ" type="checkbox" value="3480" <c:if test="${zvl.tempTyp == 3480}">checked="checked"</c:if> /></label></td>
		</tr>
		<tr>
			<td><label>장티푸스(주사용) / 3,480원<input name="temp_typ2" type="checkbox" value="3480" <c:if test="${zvl.tempTyp2 == 3480}">checked="checked"</c:if> /></label></td>
		</tr>
		<tr>
			<td>인플루엔자(독감) </td>
		</tr>
		<tr>
			<td class="title">건강진단서</td>
			<td><label>수입인지 / 1,500원<input name="phy_sheet" type="checkbox" value="1500" <c:if test="${zvl.phySheet == 1500}">checked="checked"</c:if> /></label></td>
			<td class="tac no_br">02-890-2425</td>
		</tr>
		<tr>
			<td class="title">외국인 건강진단서</td>
			<td><label>수입인지 + 간염검사 / 5,440원<input name="fore_sheet" type="checkbox" value="5440" <c:if test="${zvl.foreSheet == 5440}">checked="checked"</c:if> /></label></td>
			<td class="tac no_br">02-890-2425</td>
		</tr>
		<tr>
			<td class="title">건강진단 수첩<br />(보건증)발급</td>
			<td><label>수입인지 / 1,500원<input name="phy_note" type="checkbox" value="1500" <c:if test="${zvl.phyNote == 1500}">checked="checked"</c:if> /></label></td>
			<td class="tac no_br">02-890-2425</td>
		</tr>
		<tr>
			<td rowspan="3" class="title">체력 증진센터</td>
			<td><label>종합검사 / 7,500원<input name="health_pro" type="checkbox" value="7500" <c:if test="${zvl.healthPro == 7500}">checked="checked"</c:if> /></label></td>
			<td rowspan="3" class="tac no_br">02-2627-2735</td>
		</tr>
		<tr>
			<td><label>체력검사 / 운동처방  / 4,040원<input name="str_exa" type="checkbox" value="4040" <c:if test="${zvl.strExa == 4040}">checked="checked"</c:if> /></label></td>
		</tr>
		<tr>
			<td><label>일반건강검진 / 6,500원<input name="checkup" type="checkbox" value="6500" <c:if test="${zvl.checkup == 6500}">checked="checked"</c:if> /></label></td>
		</tr>
		<tr>
			<td rowspan="2" class="title">한방 진료</td>
			<td><label>침시술 / 65세 이상 무료<input name="chn_st" type="checkbox" value="0" <c:if test="${zvl.chnSt == 0}">checked="checked"</c:if> /></label></td>
			<td rowspan="2" class="tac no_br">02-2627-2733</td>
		</tr>
		<tr>
			<td><label>5~6일분 / 65세 이상 무료<input name="chn_med" type="checkbox" value="0" <c:if test="${zvl.chnMed == 0}">checked="checked"</c:if> /></label></td>
		</tr>
		<tr>
			<td class="title"><strong>진료비 합산</strong></td>
			<td colspan="2" class="no_br">
				<input type="image" src="/health/open_content/images/btn/btn_l_med.gif" value="진료비 합산" style="border:none" /> 
				<c:if test="${tot2 != 0}">
					<fmt:formatNumber type="currency" currencySymbol="" minFractionDigits="0" value="${tot2}"/>
				</c:if> 원
			</td>
		</tr>
	</tbody>
</table>
<br  />

<table class="data_table2" summary="선택하신 전체 가상 진료비 합계입니다">
	<caption>가상 진료비 산정</caption>
	<tbody>
		<tr>
			<td width="25%" class="title"><strong>전체 진료비</strong></td>
			<td class="no_br">
			<input type="image" src="/health/open_content/images/btn/btn_l_tot.gif" value="전체진료비" style="border:none" /> 
				<c:if test="${tot3 != 0}">
					<fmt:formatNumber type="currency" currencySymbol="" minFractionDigits="0" value="${tot3}"/>
				</c:if> 원
			</td>
		</tr>
	</tbody>
</table>

</div>

</form>


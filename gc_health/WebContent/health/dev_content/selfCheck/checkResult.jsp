<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>

<h4> 비만도 자가진단 결과 </h4>

<ul class="list_tyle_1">
	<li>당신의 비만도는 <span style="color:#FD7201;font-weight:bold;">${sum}</span> (으)로 <span style="color:#FD7201;font-weight:bold;">${resultTxt}</span>입니다</li>
	<c:if test="${resultTxt2 != null}">
		<li>${resultTxt2}</li>
	</c:if>
	<li>비만도(BMI)=[체중(kg)÷(신장(cm)×신장(cm))]×10000</li>
</ul>

<table class="data_table" summary="흡연 진단 평가 결과표입니다.">
	<caption>흡연 진단 칼로리 평가 결과</caption>
	<colgroup>
		<col style="width:50%;"/>
		<col style="width:50%;"/>
	</colgroup>
	<thead>
		<tr>
			<th scope="col">비만도</th>
			<th scope="col">판정</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td class="tal">18.5 미만</td>
			<td class="spec">저체중</td>
		</tr>
		<tr>
			<td class="tal">18.5 ~ 22.9 </td>
			<td class="spec">정상</td>
		</tr>	
		<tr>
			<td class="tal">23 ∼ 24.9</td>
			<td class="spec">과체중</td>
		</tr>	
		<tr>
			<td class="tal">25 ∼ 29.9 </td>
			<td class="spec">비만</td>
		</tr>
		<tr>
			<td class="tal">30 이상</td>
			<td class="spec">고도 비만</td>
		</tr>
	</tbody>
</table>
<div class="tar mt20">
	<a href="/health/selfCheck/checkList.do?categoryId=${param.categoryId}"><img src="/health/open_content/images/sub_blue/btn_reset.gif" alt="수고하셨습니다." /></a>
</div>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="comment_box">
<div class="comment_box_top"></div>
<div class="comment_box_in">
    <dl class="dl">
        <dt><img src="/health/open_content/images/comment/comment_tit_01010601.gif" alt="금천 보건소의 건강상담실 입니다." /></dt>
        <dd>저희 금천구 보건소에서는 주민 여러분의 건강한 생활을 위하여 믿고 신뢰할 수 있는 
금천구 관내의 의료진들과 함께 주민 여러분의 건강 유지에 도움을 드립니다.</dd>
    </dl>
</div>

<div class="comment_box_bottom"></div>
</div>

<div class="body_in">
<h5>상담 전문의  (상담 가능 진료과목 :  <a href="/health/medicalTeam/selectMedicalTeamList.do?subject=%EC%82%B0%EB%B6%80%EC%9D%B8%EA%B3%BC&amp;categoryId=${param.categoryId}">산부인과</a>  |  <a href="/health/medicalTeam/selectMedicalTeamList.do?subject=%EB%82%B4%EA%B3%BC&amp;categoryId=${param.categoryId}">내과</a>   |   <a href="/health/medicalTeam/selectMedicalTeamList.do?subject=%EC%86%8C%EC%95%84%EA%B3%BC&amp;categoryId=${param.categoryId}">소아과</a>   |   <a href="/health/medicalTeam/selectMedicalTeamList.do?subject=%EC%A0%95%ED%98%95%EC%99%B8%EA%B3%BC&amp;categoryId=${param.categoryId}">정형외과</a>   |   <a href="/health/medicalTeam/selectMedicalTeamList.do?subject=%EA%B8%88%EC%B2%9C%EA%B5%AC&amp;categoryId=${param.categoryId}">한방과</a> )</h5>

<c:forEach items="${resultList}" var="medicalTeam" varStatus="status">
<div class="consult_s_box float_left">
<div class="consult_s_box_top"></div>
<div class="consult_s_box_in">
	<div class="photo"><img src="/health/open_content/images/medicalTeam/${medicalTeam.imgNm}" alt="${medicalTeam.name}사진" width="65" height="75" /><br />
	  <a href="/health/medicalTeam/selectApplyList.do?applyCode=RELY0001&amp;petiGubun=${medicalTeam.no}&amp;categoryId=${param.categoryId}"><img src="/health/open_content/images/btn/btn_s_consult.gif" alt="상담하기" /></a></div>
    <ul class="list">
        <li><strong>상담 전문의</strong> : ${medicalTeam.name}</li>
        <li><strong>진료과목</strong> : ${medicalTeam.subject}</li>
        <li><strong>의료기관</strong> : ${medicalTeam.institution}</li>
        <li><strong>전화번호</strong> : ${medicalTeam.tel}</li>
    </ul>
</div>
<div class="consult_s_box_bottom"></div>
</div>
</c:forEach>
</div>


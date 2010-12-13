<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
		
<div class="comment_box">
<div class="comment_box_top"></div>
<div class="comment_box_in" style="background:url(/health/open_content/images/comment/comment_img_s_001.gif) 580px top no-repeat;">
    <ul class="list">
        <li>자주 이용하시는 보건/위생 관련 민원 사무 내용을 확인하실 수 있습니다.</li>
        <li>보건/위생 서식 이외의 서식을 이용하시고자 할 경우에는 금천구청 홈페이지를 이용해 주세요.</li>
    </ul>
</div>
<div class="comment_box_bottom"></div>
</div>
<h4>신청인정보</h4>	
<c:if test="${accessable}">
<jsp:include page="/health/dev_content/application/userInfoView.jsp" flush="true" />
</c:if>

<br />
<h4>신청내용</h4>
<table summary="선택하신 모범업소 지정신청 신청내용으로 업소 및 기관명, 대표자명, 대표자 주민번호, 영업형태, 전화번호, 업소 소재지, 음식물종류, 처리결과 회신여부로 구성" class="default_write">
    <caption>모범업소 지정신청 신청내용</caption>
    <tbody>
    <tr>
      <th width="20%" scope="row">업소 및 기관명</th>
      <td width="85%" colspan="3">${result.etc1}</td>
    </tr>
    <tr>
      <th scope="row">대표자명</th>
      <td colspan="3">${result.etc2}</td>
    </tr>
    <tr>
      <th scope="row">대표자 주민번호</th>
      <td colspan="3">${result.etc3}</td>
    </tr>
    <tr>
      <th scope="row">영업형태</th>
      <td colspan="3">${result.etc4}</td>
    </tr>
    <tr>
      <th scope="row">전화번호</th>
      <td colspan="3">${result.etc5}</td>
    </tr>
    
    <tr>
      <th rowspan="2" scope="row">업소 소재지</th>
      <td colspan="3">${result.etc6}</td>
    </tr>
    <tr>
      <td colspan="3">${result.etc7} ${result.etc8}</td>
    </tr>
    <tr>
      <th scope="row">음식물 종류</th>
      <td colspan="3">${result.etc9}</td>
    </tr>
    <tr>
      <th scope="row">처리결과 회신</th>
      <td colspan="3">${result.smsFlag == 'Y' ? '동의' : '동의하지않음'}</td>
    </tr>
	</tbody>
</table>
<div class="board_btn_set mt13">
	<span class="btn_del"><a href="/health/application/cancelApply.do?applyCode=${param.applyCode}&amp;applyId=${param.applyId}&amp;categoryId=${param.categoryId}" onclick="return confirm('정말로 신청을 취소하시겠습니까?');">신청취소</a></span>
	<c:if test="${result.status == '1'}">
    <span class="btn_del"><a href="/health/application/modifyApplyPage.do?applyCode=${param.applyCode}&amp;applyId=${param.applyId}&amp;categoryId=${param.categoryId}">수정하기</a></span>
    </c:if>
    <span class="btn_del"><a href="/health/application/selectMyApplyList.do?applyCode=${param.applyCode}&amp;categoryId=${param.categoryId}">목록보기</a></span>
</div>


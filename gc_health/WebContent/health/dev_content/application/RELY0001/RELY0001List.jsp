<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/admin/health/application/applyStatus.jsp" %>

<div class="consult_box">
<div class="consult_box_img">
<div class="consult_box_top"></div>
<div class="consult_box_in">
	<div class="photo"><img src="/health/open_content/images/medicalTeam/${medicalTeam.imgNm}" alt="${medicalTeam.name}사진" width="65" height="75" /></div>
    <ul class="list">
        <li><strong>상담 전문의</strong> : ${medicalTeam.name}</li>
        <li><strong>진료과목</strong> : ${medicalTeam.subject}</li>
        <li><strong>의료기관</strong> : ${medicalTeam.institution}</li>
        <li><strong>전화번호</strong> : ${medicalTeam.tel}</li>
    </ul></div>
<div class="consult_box_bottom"></div>
</div>
</div>

<form name="frm" method="post" action="/health/medicalTeam/selectApplyList.do?applyCode=${param.applyCode}&amp;petiGubun=${param.petiGubun}&amp;categoryId=${param.categoryId}">	
<div class="board_top clearfix">
    <div class="fl_l"> <span>${pageInfo.totCnt}건 [${pageInfo.pageIndex} / ${pageInfo.totalPageCount}Page]</span> </div>
    <fieldset class="fl_r">
        <legend>게시물검색</legend>
		<label for="searchType" class="blind">구분선택</label>
        <select name="searchType" id="searchType">
            <option value="">전체</option>
            <option value="0" <c:if test="${param.searchType == '0'}" >selected</c:if>>제목</option>
            <option value="1" <c:if test="${param.searchType == '1'}" >selected</c:if>>작성자</option>
        </select>
		<label for="searchTxt" class="blind">검색어</label>
        <input type="text" name="searchTxt" id="searchTxt" value="${param.searchTxt}" class="text"/>
    <input type="image" src="/health/open_content/images/borad/btn_search.gif" alt="검색" />
    </fieldset>
</div>
</form>

<table class="default_list" summary="상담 전문의 ${medicalTeam.name} 게시판으로 번호, 공개여부, 제목, 작성자, 등록일, 처리상황, 조회수로 구성">
    <caption>건강상담</caption>
    <thead>
        <tr>
            <th width="7%" scope="col">번호</th>
            <th width="13%" scope="col">공개여부</th>
            <th width="37%" scope="col">제목</th>
            <th width="13%" scope="col">작성자</th>
            <th width="13%" scope="col">등록일</th>
            <th width="10%" scope="col">처리상황</th>
            <th width="7%" scope="col">조회수</th>
        </tr>
    </thead>
    <tbody>
	<c:if test="${fn:length(resultList) > 0}" >
	<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}">  
        <tr>
            <td>${pageInfo.totCnt - (pageInfo.pageIndex-1)*pageInfo.pageUnit - x}</td>
            <td>
				<c:if test="${resultList[x].openFlag == 'Y'}" >공개</c:if>
				<c:if test="${resultList[x].openFlag == 'N'}" >비공개</c:if>
			</td>
            <td class="tal"><a href="/health/medicalTeam/selectApplyView.do?applyCode=${param.applyCode}&amp;applyId=${resultList[x].applyId}&amp;petiGubun=${param.petiGubun}&amp;categoryId=${param.categoryId}">${resultList[x].title}</a></td>
            <td>${resultList[x].name}</td>
          <td>		
			<fmt:parseDate value='${resultList[x].applyDate}' var='applyDate' pattern='yyyy-mm-dd'/>
			<fmt:formatDate value='${applyDate}' pattern="yyyy년mm월dd일"/>	
          </td>
            <td>
				<c:if test="${empty resultList[x].status || resultList[x].status == RECEIPT_WAITING}">접수대기</c:if>
				<c:if test="${resultList[x].status == RECEIPT}">접수</c:if>
				<c:if test="${resultList[x].status == ASSIGNED_DEPT}">부서지정</c:if>
				<c:if test="${resultList[x].status == OFFICER_PROCESSING}">담당자지정/처리</c:if>
				<c:if test="${resultList[x].status == ANSWERING}">답변중</c:if>
				<c:if test="${resultList[x].status == COMPLETE_ANSWER}">답변완료</c:if>
				<c:if test="${resultList[x].status == COMPLETION}">완료</c:if>
				<c:if test="${resultList[x].status == DELETION}">신청취소</c:if>
				<c:if test="${resultList[x].status == TRANSFER}">이관</c:if>
            </td>
            <td>${resultList[x].hit}</td>
        </tr>
     </c:forEach>
     </c:if>
	<c:if test="${fn:length(resultList) == 0}" >
	<tr><td colspan="7">데이터가 없습니다</td></tr>
	</c:if>
    </tbody>
</table>
<ol class="paging">
<c:if test="${fn:length(resultList) > 0}" >
${pageNav}
</c:if>
</ol>
<div class="board_btn_set send_mg"> <span class="register"><a href="/health/medicalTeam/writePage.do?applyCode=${param.applyCode}&amp;petiGubun=${param.petiGubun}&amp;categoryId=${param.categoryId}">등록하기</a></span> </div>


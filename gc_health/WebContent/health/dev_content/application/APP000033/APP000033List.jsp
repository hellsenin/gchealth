<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
				
			<div class="comment_box">
			<div class="comment_box_top"></div>
			<div class="comment_box_in" style="background:url(/health/open_content/images/comment/comment_img_s_001.gif) 580px top no-repeat;">
			    <ul class="list">
							<li>모든 신고내용은 본인만 확인하실 수 있습니다.  (민원내용에는 개인정보를 작성하지 않습니다)</li>
							<li>저속한 표현, 타인의 명예훼손, 근거없는 비방, 반사회적인 글, 영리목적의 광고성 글, 게시판의 운영목적에 부적합한 내용 등은 사전양해없이 삭제될 수 있습니다.</li>
							<li>첨부파일(한글파일,사진파일등)을 올리시는 경우는 영문명으로 올려주시기 바랍니다.</li>
			    </ul>
			</div>
			<div class="comment_box_bottom"></div>
			</div>
			
				<table class="default_list" summary="선택, 교육일시, 교육시간, 교육장소, 신청일, 현황로 구성되어 있습니다. 선택 체크박스를 선택후 신청취소를 누르면 신청이 취소됩니다.">
					<caption>응급처치교육 신청 목록</caption>
					<colgroup>
						<col style="width:6%;"/>
						<col style="*"/>
						<col style="width:19%;"/>
						<col style="width:15%;"/>
						<col style="width:10%;"/>
					</colgroup>
					<thead>
						<tr>
							<th scope="col" class="fir">번호</th>
							<th scope="col">교육명</th>
							<th scope="col">신청인</th>
							<th scope="col">신청일</th>
							<th scope="col">상태</th>
						</tr>
					</thead>
					<tbody>
					<c:if test="${fn:length(resultList) > 0}" >
					<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}">  
						<tr>
							<td>${pageInfo.totCnt - (pageInfo.pageIndex-1)*pageInfo.pageUnit - x}</td>
							<td><a href="/health/application/selectApplyView.do?applyCode=${param.applyCode}&amp;applyId=${resultList[x].applyId}&amp;onlineId=${resultList[x].onlineId}&amp;categoryId=${param.categoryId}">${resultList[x].title}</a></td>
							<td><a href="/health/application/selectApplyView.do?applyCode=${param.applyCode}&amp;applyId=${resultList[x].applyId}&amp;onlineId=${resultList[x].onlineId}&amp;categoryId=${param.categoryId}">${resultList[x].name}</a></td>
							<td>						
								<fmt:parseDate value='${resultList[x].applyDate}' var='applyDate' pattern='yyyy-mm-dd'/>
								<fmt:formatDate value='${applyDate}' pattern="yyyy년mm월dd일"/>	
							</td>
							<td>
								<c:if test="${resultList[x].status == '1'}">신청대기</c:if>
								<c:if test="${resultList[x].status == '2'}">완료</c:if>
							</td>
						</tr>
					</c:forEach>
					</c:if>
					<c:if test="${fn:length(resultList) == 0}" >
					<tr><td colspan="6">신청목록이 없습니다.</td></tr>
					</c:if>
					</tbody>
				</table>
				
				<c:if test="${fn:length(resultList) > 0}" >
				<ol class="paging">${pageNav}</ol>
				</c:if>
				

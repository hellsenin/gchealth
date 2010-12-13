<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("crlf", "\r\n"); %>					
			
			<div class="comment_box">
			<div class="comment_box_top"></div>
			<div class="comment_box_in" style="background:url(/health/open_content/images/comment/comment_img_s_001.gif) 580px top no-repeat;">
			    <ul class="list">
					<li>생활 속 응급처치 요령에서부터 심폐소생술 등 개인의 응급상황대처능력의 향상을 위해 구민·보육시설·<br />어린이·청소년·장애인시설 종사자·보건 교사·학생 등 다양한 대상에게 교육의 기회를 제공하고 있습니다.</li>
					<li>교육을 희망하시는 분은 신청하여 주시기 바라며 기타 교육관련 문의 사항은 연락주시기 바랍니다.</li>
			    </ul>
			</div>
			<div class="comment_box_bottom"></div>
			</div>
			
				<table class="default_view" summary="선택하신 건강교실 내용보기 페이지로 제목, 기간, 모집인원, 교육일, 교육시간, 상세내용으로 구성">
					<caption>건강교실 상세보기</caption>
					<colgroup>
						<col width="18%" />
						<col width="*" />
						<col width="15%" />
						<col width="30%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">제 목</th>
							<td colspan="3" class="output">${result.title}</td>
						</tr>
						<tr>
							<th scope="row">기 간</th>
							<td class="output">		
								<fmt:parseDate value='${result.receiptSdate}' var='receiptSdate' pattern='yyyy-mm-dd'/>
								<fmt:formatDate value='${receiptSdate}' pattern="yyyy년mm월dd일"/>	~						
								<fmt:parseDate value='${result.receiptEdate}' var='receiptEdate' pattern='yyyy-mm-dd'/>
								<fmt:formatDate value='${receiptEdate}' pattern="yyyy년mm월dd일"/></td>
							<th scope="row">모집인원</th>
							<td class="output">${result.appInwon}</td>
						</tr>
						<tr>
							<th scope="row">교육일</th>
							<td colspan="3" class="output">
								<fmt:parseDate value='${result.eduSdate}' var='eduSdate' pattern='yyyy-mm-dd'/>
								<fmt:formatDate value='${eduSdate}' pattern="yyyy년mm월dd일"/>
							</td>
						</tr>
						<tr>
							<th scope="row">교육시간</th>
							<td colspan="3" class="output">${result.eduStime}</td>
						</tr>
						<tr>
							<th scope="row">상세 내용</th>
							<td colspan="3" class="outputEditer">${fn:replace(result.content,crlf,"<br/>")}</td>
						</tr>
					</tbody>
				</table>

<div class="board_btn_set mt13">
<c:if test="${result.status == '2'}">
	<span class="btn_del"><a href="/health/application/writePage.do?applyCode=${param.applyCode}&amp;onlineId=${result.onlineId}&amp;categoryId=${param.categoryId}">신청하기</a></span>
</c:if>
	<span class="btn_list"><a href="/health/onlineApply/listOnlineApply.do?applyCode=${param.applyCode}&amp;categoryId=${param.categoryId}&amp;pageIndex=${param.pageIndex}">목록보기</a></span>
</div>
		
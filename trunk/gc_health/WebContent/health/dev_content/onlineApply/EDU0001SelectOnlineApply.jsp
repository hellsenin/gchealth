<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("crlf", "\r\n"); %>					
			
				<table class="default_view" summary="대학생아르바이트 신청 모집 공고 상세보기 입니다">
					<caption>대학생아르바이트 신청 모집 공고 상세보기</caption>
					<colgroup>
						<col width="18%" />
						<col width="*" />
						<col width="15%" />
						<col width="30%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">제    목</th>
							<td colspan="3" class="output">${result.title}</td>
						</tr>
						<tr>
							<th scope="row">기    간</th>
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
							<td colspan="3" class="output">${result.eduSdate}</td>
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

	<span class="btn_del"><a href="/health/application/writePage.do?applyCode=${param.applyCode}&amp;onlineId=${result.onlineId}&amp;categoryId=${param.categoryId}">신청하기</a></span>

	<span class="btn_list"><a href="/health/onlineApply/listOnlineApply.do?applyCode=${param.applyCode}&amp;onlineId=${result.onlineId}&amp;categoryId=${param.categoryId}">목록보기</a></span>
</div>
		
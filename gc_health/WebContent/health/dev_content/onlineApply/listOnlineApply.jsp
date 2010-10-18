<%@page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>	
						
				<table class="default_list" summary="번호, 제목, 신청기간, 모집인원, 교육일, 진행사항으로 구성되어 있습니다. 신청하기 버튼을 클릭하면 신청입력화면으로 이동합니다.">
					<caption>건강교실 신청목록</caption>
					<colgroup>
						<col width="8%" />
						<col width="*" />
						<col width="18%" />
						<col width="15%" />
						<col width="15%" />
						<col width="10%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col" class="fir">번호</th>
							<th scope="col">제목</th>
							<th scope="col">신청기간</th>
							<th scope="col">모집인원</th>
							<th scope="col">교육일</th>
							<th scope="col">진행사항</th>
						</tr>
					</thead>
					<tbody>			
					<c:if test="${fn:length(resultList) > 0}" >
					<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}">  
						<tr>
							<td>${zvl.totCnt - (zvl.pageIndex-1)*zvl.pageUnit - x}</td>
							<td class="tal"><a href="/health/onlineApply/selectOnlineApply.do?applyCode=${resultList[x].applyCode}&amp;onlineId=${resultList[x].onlineId}&amp;categoryId=${param.categoryId}&amp;pageIndex=${param.pageIndex}">${resultList[x].title}</a></td>
							<td>						
								<fmt:parseDate value='${resultList[x].receiptSdate}' var='receiptSdate' pattern='yyyy-mm-dd'/>
								<fmt:formatDate value='${receiptSdate}' pattern="yyyy년mm월dd일"/>	~ <br/>						
								<fmt:parseDate value='${resultList[x].receiptEdate}' var='receiptEdate' pattern='yyyy-mm-dd'/>
								<fmt:formatDate value='${receiptEdate}' pattern="yyyy년mm월dd일"/>	
							</td>
							<td>${resultList[x].inwonCnt}/${resultList[x].appInwon}</td>
							<td><fmt:parseDate value='${resultList[x].eduSdate}' var='eduSdate' pattern='yyyy-mm-dd'/>
								<fmt:formatDate value='${eduSdate}' pattern="yyyy년mm월dd일"/>
							</td>
							<td>
							<c:if test="${resultList[x].status == '2'}">
							<a href="/health/application/writePage.do?applyCode=${resultList[x].applyCode}&amp;onlineId=${resultList[x].onlineId}&amp;categoryId=${param.categoryId}&amp;pageIndex=${param.pageIndex}">
							신청하기</a>
							</c:if>
							</td>
						</tr>
					</c:forEach>
					</c:if>
					<c:if test="${fn:length(resultList) <= 0}">
						<tr><td colspan="6">데이터가 없습니다.</td></tr>
					</c:if>
					</tbody>
				</table>
				
				<c:if test="${fn:length(resultList) > 0}" >
				<ol class="paging">${pageNav}</ol>
				</c:if>
				
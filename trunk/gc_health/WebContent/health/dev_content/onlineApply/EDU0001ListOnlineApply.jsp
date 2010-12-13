<%@page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>	
			
			<h4 class="tit_04">응급처치교육 신청하기</h4>
			<ul class="txt_list_type1 mgb20">
				<li>생활 속 응급처치 요령에서부터 심폐소생술 등 개인의 응급상황대처능력의 향상을 위해 구 주민, 보육시설·어린이·청소년·장애인시설 종사자, 보건 교사, 학생 등 다양한 대상에게 교육의 기회를 제공하고 있습니다.</li>
				<li>교육을 희망하시는 분은 신청하여 주시기 바라며 기타 교육관련 문의 사항은 연락주시기 바랍니다.<br/> (<img class="vam" src="/portal/open_content/images/common/bul/bul_tel2.gif" alt="전화번호" />02)731-0236)</li>
			</ul>
				<table class="default_list" summary="번호, 교육일시, 교육시간, 접수기관, 교육장소, 모집인원, 접수상태, 수강신청으로 구성되어 있습니다. 신청하기 버튼을 클릭하면 신청입력화면으로 이동합니다.">
					<caption>응급처치교육 신청목록</caption>
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
							<td class="tal"><a href="/health/onlineApply/selectOnlineApply.do?applyCode=${param.applyCode}&amp;onlineId=${resultList[x].onlineId}&amp;categoryId=${param.categoryId}">${resultList[x].title}</a></td>
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
							<a href="/health/application/writePage.do?applyCode=${param.applyCode}&amp;onlineId=${resultList[x].onlineId}&amp;categoryId=${param.categoryId}">
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
				
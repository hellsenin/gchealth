<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>	

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<title>금천시 보건소</title>
<link href="/health/open_content/system/css/default.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/common.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/blue.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_blue.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
	function delOnlineApply(onlineId)
	{		
		if(confirm("신청자 목록도 전부삭제됩니다.\n정말로 삭제하시겠습니까?"))
		{
			location.href="/admin/health/onlineApply/delOnlineApply.do?onlineId="+onlineId+"&applyCode=${param.applyCode}";
		}
	}

</script>
</head>
<body style="background:none;padding:10px;">
<h2 style="padding:15px 0 15px 0;">	
		응급처치교육신청
</h2>
<p class="title_deco"></p>
<div class="body">

				<!-- board list start -->
				<table class="default_list" summary="번호, 교육일시, 교육시간, 접수기관, 교육장소, 모집인원, 접수상태, 수강신청으로 구성되어 있습니다. 신청하기 버튼을 클릭하면 신청입력화면으로 이동합니다.">
					<caption>응급처치교육 신청목록</caption>
					<colgroup>
						<col width="8%" />
						<col width="8%" />
						<col width="*" />
						<col width="15%" />
						<col width="15%" />
						<col width="15%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col" class="fir">번호</th>
							<th scope="col">사용여부</th>
							<th scope="col">제목</th>
							<th scope="col">접수기간</th>
							<th scope="col">교육일</th>
							<th scope="col">신청인원</th>
							<th scope="col">기타</th>
						</tr>
					</thead>
					<tbody>			
					<c:if test="${fn:length(resultList) > 0}" >
					<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}">  
						<tr>
							<td>${zvl.totCnt - (zvl.pageIndex-1)*zvl.pageUnit - x}</td>
							<td>
								<c:if test="${resultList[x].status == '1'}">대기</c:if>
								<c:if test="${resultList[x].status == '2'}">진행</c:if>
								<c:if test="${resultList[x].status == '3'}">완료</c:if>
							</td>
							<td class="tal"><a href="/admin/health/onlineApply/selectApplicantList.do?onlineId=${resultList[x].onlineId}&amp;applyCode=${param.applyCode}">${resultList[x].title}</a></td>
							<td>	
								<fmt:parseDate value='${resultList[x].receiptSdate}' var='receiptSdate' pattern='yyyy-mm-dd'/>
								<fmt:formatDate value='${receiptSdate}' pattern="yyyy년mm월dd일"/> ~<br/>
								<fmt:parseDate value='${resultList[x].receiptEdate}' var='receiptEdate' pattern='yyyy-mm-dd'/>
								<fmt:formatDate value='${receiptEdate}' pattern="yyyy년mm월dd일"/>
							</td>
							<td>
								<fmt:parseDate value='${resultList[x].eduSdate}' var='eduSdate' pattern='yyyy-mm-dd'/>
								<fmt:formatDate value='${eduSdate}' pattern="yyyy년mm월dd일"/>
							</td>
							<td>${resultList[x].inwonCnt}/${resultList[x].appInwon}</td>
							<td><a href="/admin/health/onlineApply/modifyOnlineApplyPage.do?onlineId=${resultList[x].onlineId}&amp;applyCode=${param.applyCode}">수정</a> <a href="javascript:delOnlineApply(${resultList[x].onlineId});">삭제</a></td>
						</tr>
					</c:forEach>
					</c:if>
					<c:if test="${fn:length(resultList) <= 0}">
						<tr><td colspan="8">데이터가 없습니다.</td></tr>
					</c:if>
					</tbody>
				</table>
				<!-- board list end //-->	
				
<ol class="paging">${pageNav}</ol>
				
<div class="board_btn_set mt13">
	<span class="btn_del"><a href="/admin/health/onlineApply/registOnlineApplyPage.do?applyCode=${param.applyCode}">등록하기</a></span>

</div>
			
</div>
</body>
</html>
			
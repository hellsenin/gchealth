<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="action" value="/admin/health/application/apply.do" />
<c:if test="${not empty result}" >
	<c:set var="action" value="/admin/health/application/modify.do" />
</c:if>	

<%pageContext.setAttribute("crlf", "\n"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<title>금천시 보건소</title>
<link href="/health/open_content/system/css/default.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/common.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/blue.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_blue.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="/health/open_content/system/js/prototype.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/util.js"></script>
<script type="text/javascript" src="/admin/common/js/apply.js"></script>
<script type="text/javascript">
	function checkForm(form)
	{			
			var v = new MiyaValidator(form);
		    v.add("cellPhone_U", {
		        required: true,
	            span: 3,
	            glue: "-",
		        option: "handphone"     
		    });
			result = v.validate();
			if (!result) {
				alert(v.getErrorMessage());
				v.getErrorElement().focus();
				return false;
			}
			else
			{
				return true;
			}
		}

</script>
		
</head>
<body style="background:none;padding:10px;">
<h2 style="padding:15px 0 15px 0;">	
		${applyMst.applyName}
</h2>
<p class="title_deco"></p>
<div class="body">
					
		<form name="frm" method="post" action="${action}" onsubmit="return checkForm(this);">
			<input type="hidden" name="applyCode" value="${param.applyCode}" />
			<input type="hidden" name="applyId" value="${param.applyId}" />
			<input type="hidden" name="onlineId" value="${onlineResult.onlineId}" />	
			
				<h4>교육신청정보</h4>	
						<table class="default_view" summary="기관명(시설명), 소재지, 시설장, 교육담당자 연락처로 구성되어 있습니다.">
							<caption>기관정보 글쓰기</caption>
							<colgroup>
								<col style="width:20%;"/>
								<col style="width:30%;"/>
								<col style="width:20%;"/>
								<col style="width:30%;"/>
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">제    목</th>
									<td colspan="3" class="output">${onlineResult.title}</td>
								</tr>
								<tr>
									<th scope="row">기    간</th>
									<td class="output">		
										<fmt:parseDate value='${onlineResult.receiptSdate}' var='receiptSdate' pattern='yyyy-mm-dd'/>
										<fmt:formatDate value='${receiptSdate}' pattern="yyyy년mm월dd일"/>	~						
										<fmt:parseDate value='${onlineResult.receiptEdate}' var='receiptEdate' pattern='yyyy-mm-dd'/>
										<fmt:formatDate value='${receiptEdate}' pattern="yyyy년mm월dd일"/></td>
									<th scope="row">모집인원</th>
									<td class="output">${onlineResult.appInwon}</td>
								</tr>
								<tr>
									<th scope="row">교육일</th>
									<td colspan="3" class="output">${onlineResult.eduSdate}</td>
								</tr>
								<tr>
									<th scope="row">교육시간</th>
									<td colspan="3" class="output">${onlineResult.eduStime}</td>
								</tr>
								<tr>
									<th scope="row">상세 내용</th>
									<td colspan="3" class="outputEditer">${fn:replace(onlineResult.content,crlf,"<br/>")}</td>
								</tr>
							</tbody>
						</table>
			
<br/>
<br/>
				<!-- 신청인 정보 -->
<jsp:include page="/admin/health/application/userInfoWrite.jsp" flush="true" />

<br/>
<br/>
				<h4>신청인추가정보</h4>	
				<!-- board write start -->
						<table class="default_write" summary="기관명(시설명), 소재지, 시설장, 교육담당자 연락처로 구성되어 있습니다.">
							<caption>기관정보 글쓰기</caption>
							<colgroup>
								<col style="width:20%;"/>
								<col style="width:80%;"/>
							</colgroup>
							<tbody>
								<tr class="fir">
									<th scope="row"><label for="etc1">성별</label></th>
									<td>
										<input id="etc1_1" type="radio" name="etc1" value="1" <c:if test="${result.etc1 == '1'}">checked</c:if>/> 남
										<input id="etc1_2" type="radio" name="etc1" value="2" <c:if test="${result.etc1 == '2'}">checked</c:if>/> 여
									</td>
								</tr>
							</tbody>
						</table>
			
						
<div class="board_btn_set mt13">

	<span class="btn_del"><input type="submit" value="${empty result ? '등록' : '수정'}하기" /></span>

	<span class="btn_list"><a href="/admin/health/onlineApply/listOnlineApply.do?applyCode=${param.applyCode}">목록보기</a></span>
</div>
		
		</form>

</div>
</body>
</html>


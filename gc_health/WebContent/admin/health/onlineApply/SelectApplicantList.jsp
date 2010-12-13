<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% pageContext.setAttribute("crlf", "\r\n"); %>	
	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<title>금천시 보건소</title>
<link href="/health/open_content/system/css/default.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/common.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/blue.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_blue.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/prototype.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/jslb_ajax.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/apply.js"></script>
<script type="text/javascript">
	function delOnlineApply(onlineId)
	{		
		if(confirm("신청자 목록도 전부삭제됩니다.\n정말로 삭제하시겠습니까?"))
		{
			location.href="/admin/health/onlineApply/delOnlineApply.do?onlineId="+onlineId;
		}
	}

	function lottery(onlineId)
	{	
		var f = $("frm");
		var v = new MiyaValidator(f);
	    v.add("degree", {
	        required: true,
	        message: "추첨방법을 선택하세요."
	    });
	    v.add("inwon", {
	        required: true,
	        option: "number"     
	    });
	    var result = v.validate();
	    if (!result) {
	        alert(v.getErrorMessage());
	        v.getErrorElement().focus();
			return;
	    } 

		var url = "/admin/health/onlineApply/lotteryOnlineApply.do";
		var param = 
			"&onlineId=${result.onlineId}"+
			"&applyCode=${param.applyCode}"+
			"&inwon="+$F("inwon")+
			"&degree="+$F("degree");
		sendRequest(callbackLottery, param, 'POST', url, true, true);
	}

	function callbackLottery(oj)
	{
		try 
		{
			var jsonData = oj.responseText;
			var j = eval('(' + jsonData + ')');
			var code = j.resultCode;
			if(code == "1")
			{	
				 alert("성공적으로 수정되었습니다.");
				 location.href = 
					"/admin/health/onlineApply/selectApplicantList.do"+
				 	"?applyCode=${param.applyCode}"+
				 	"&onlineId=${result.onlineId}"+
				 	"&status=2";
			}
			else if(code == "0")
			{
				 alert("알수없는 오류입니다.");
			}
		}	
		catch (err) 
		{
			alert("알수없는 오류입니다.");
		}
	}


	function goUrl(status)
	{
		location.href=
			"/admin/health/onlineApply/selectApplicantList.do"+
			"?onlineId=${result.onlineId}"+
			"&applyCode=${param.applyCode}"+
			"&status="+status;
	}

	function delApplicant(objName)
	{
		if(getCheckedCount(objName) == 0)
		{
			alert("삭제할 신청자를 선택하세요.");
			return;
		}
		else
		{
			document.frm.action = "/admin/health/application/cancelApply.do";
			document.frm.submit();
		}
	}
	
</script>
</head>
<body style="background:none;padding:10px;">
<h2 style="padding:15px 0 15px 0;">	
		${result.title}
</h2>
<p class="title_deco"></p>
<div class="body">

			<!-- title -->
		<form name="frm">
			<input type="hidden" name="applyCode" value="${param.applyCode}" />
			<input type="hidden" name="onlineId" value="${result.onlineId}" />
					<table class="default_view">
						<caption>동요축제신청</caption>
						<colgroup>
							<col width="20%" />
							<col width="0%" />
							<col width="50%" />
							<col width="30%" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row">제목(*)</th>
							<td class="output" colspan="3">${result.title}</td>
						</tr>
						<tr>
							<th scope="row">신청기간(*)</th>
							<td class="output" colspan="3">${result.receiptSdate} ~ ${result.receiptEdate}</td>
						</tr>
						<tr>
							<th scope="row">모집인원(*)</th>
							<td class="output" colspan="3">${result.appInwon}</td>
						</tr>
						<tr>
							<th scope="row">내용</th>
							<td colspan="3" class="output">${fn:replace(result.content,crlf,"<br/>")}</td>
						</tr>
						</tbody>
					</table>
				
				<br/><br/>
				<h3 class="tit_03">추첨하기</h3>
					<table class="default_view">
						<caption>아르바이트신청</caption>
						<colgroup>
							<col width="20%" />
							<col width="0%" />
							<col width="50%" />
							<col width="30%" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row">추첨방법</th>
							<td class="output" colspan="3">
							<input type="radio" name="degree" title="구분항목 선택" value="1"/> 선착순추첨
							<input type="radio" name="degree" title="구분항목 선택" value="2"/> 무작위추첨
							</td>
						</tr>
						<tr>
							<th scope="row">추첨인원</th>
							<td class="output" colspan="3">
								<input id="inwon" class="searchinput" type="text" title="추첨인원" style="width:40px" name="inwon" value="${param.inwon}" />
							</td>
						</tr>
						</tbody>
					</table>
					
<div class="board_btn_set mt13">
	<span class="btn_del"><a href="javascript:lottery();">추첨하기</a></span>
	<span class="btn_del"><a href="/admin/health/onlineApply/excelApplicantList.do?onlineId=${result.onlineId}&amp;applyCode=${param.applyCode}">엑셀다운</a></span>
</div>
				<br/><br/>
				
				<div>
					<select name="applyStateCondition" title="구분항목 선택" class="vam" style="width: 100px; float: right; margin-top: 2px;" onchange="goUrl(this.value);">
						<option value="">
							선택하세요
						</option>
						<option value="1" <c:if test="${param.status == 1}">selected="selected"</c:if>>
							대기
						</option>
						<option value="2" <c:if test="${param.status == 2}">selected="selected"</c:if>>
							당첨
						</option>
					</select>
				</div>
				<c:choose>
				<c:when test="${param.status == 2}" >
				<h3 class="tit_03">당첨자목록</h3>
				</c:when>
				<c:otherwise>
				<h3 class="tit_03">대기자목록</h3>
				</c:otherwise>
				</c:choose>
				<!-- board list start -->
				<table class="default_list" summary="게시판 목록입니다">
					<caption>게시판 목록</caption>
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
							<th scope="col">선택<input type="checkbox" name="checkAll" onclick="checkbox_toggle('applyIdData_A',this.checked);" /></th>
							<th scope="col">신청인</th>
							<th scope="col">전화번호</th>
							<th scope="col">휴대폰번호</th>
							<th scope="col">상태</th>
						</tr>
					</thead>
					<tbody>
					<c:if test="${fn:length(resultList) > 0}" >
					<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}">  
						<tr>
							<td>${zvl.totCnt - (zvl.pageIndex-1)*zvl.pageUnit - x}</td>
							<td><input type="checkbox" name="applyIdData_A" value="${resultList[x].applyId}" /></td>
							<td><a href="/admin/health/application/modifyPage.do?applyCode=${param.applyCode}&applyId=${resultList[x].applyId}&onlineId=${result.onlineId}">${resultList[x].name}</a></td>
							<td>${resultList[x].tel}</td>
							<td>${resultList[x].cellPhone}</td>
							<td>
								<c:choose>
								<c:when test="${resultList[x].delFlag == 'Y'}">삭제</c:when>
								<c:otherwise>
								<c:if test="${resultList[x].status == 1}">대기</c:if>
								<c:if test="${resultList[x].status == 2}">당첨</c:if>
								</c:otherwise>
								</c:choose>
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
					
<div class="board_btn_set mt13">

					<c:if test="${fn:length(resultList) > 0}" >
	<span class="btn_del"><a href="javascript:delApplicant('applyIdData_A');">삭제하기</a></span>
					</c:if>

	<span class="btn_del"><a href="/admin/health/application/writePage.do?applyCode=${param.applyCode}&onlineId=${result.onlineId}">등록하기</a></span>
	<span class="btn_list"><a href="/admin/health/onlineApply/listOnlineApply.do?applyCode=${param.applyCode}">목록보기</a></span>
</div>
			
		</form>
		
</div>
</body>
</html>
		
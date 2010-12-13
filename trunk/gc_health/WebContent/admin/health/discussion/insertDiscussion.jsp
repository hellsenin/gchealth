<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%pageContext.setAttribute("crlf", "\n"); %> 
<c:set var="action" value="/admin/health/discussion/insertDiscussion.do" />
<c:if test="${not empty result.disseq}" >
	<c:set var="action" value="/admin/health/discussion/modifyDiscussion.do" />
</c:if>

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
<script type="text/javascript" src="/health/open_content/system/js/util.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/Calendar.js"></script>
<script type="text/javascript">
	function checkForm(form)
	{	
		var v = new MiyaValidator(form);
	    v.add("distitle", {
	        required: true
	    });
	    v.add("discont", {
	        required: true
	    });
	    v.add("dissdate", {
	        required: true
	    });
	    v.add("disedate", {
	        required: true
	    });
	    var result = v.validate();
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
		정책토론방 
</h2>
<p class="title_deco"></p>
<div class="body">

			<form name="frm" method="post" action="${action}" onsubmit="return checkForm(this);">
			<c:if test="${not empty result.disseq}" >
				<input type="hidden" name="disseq" value="${result.disseq}" />	
			</c:if>
				<input type="hidden" name="dept" value="${result.deptId}" />	
				
				<table summary="정책토론방글쓰기" class="default_write">
					<caption>칭찬글쓰기</caption>
					<colgroup>
						<col width="20%" />
						<col width="80%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">토론주제(*)</th>
							<td class="output"><input type="text" id="distitle" name="distitle" value="${result.distitle}" style="width:90%" class="board1" /></td>
						</tr>
						<tr>
							<th scope="row">토론 내용(*)</th>
							<td class="output">		
								<textarea name="discont" id="discont" cols="50" rows="5" style="width:90%;" onkeydown="textCounter(this.form.discont,this.form.remLen,800);" onkeyup="textCounter(this.form.discont,this.form.remLen,800);" onmousedown="this.onkeydown();" onmouseup="this.onkeyup();">${result.discont}</textarea><br/>
								<input type="text" name="remLen" id="remLen" value="800" class="intext" style="width:30px;" readonly="readonly" />자남음
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="dissdate">토론 기간(*)</label></th>
							<td class="output">
								<input value="${result.dissdate}" type="text" name="dissdate" id="dissdate" style="width:200px" class="board1"/><a href="javascript:Calendar_D(frm.dissdate)"><img src="/health/open_content/images/calendar.gif" class="vat" alt=""/></a>
								<span style="width: 20px;"></span> ~ <span style="width: 20px;"></span>
								<input value="${result.disedate}" type="text" name="disedate" id="disedate" style="width:200px" class="board1"/><a href="javascript:Calendar_D(frm.disedate)"><img src="/health/open_content/images/calendar.gif" class="vat" alt=""/></a>
							</td>
						</tr>
						<tr>
							<th scope="row">담당부서</th>
							<td class="output">${result.deptName}</td>
						</tr>
					</tbody>
				</table>
			
<div class="board_btn_set mt13">
	<span class="btn_del"><input type="submit" value="${empty result.disseq ? '등록' : '수정'}하기" /></span>
	<span class="btn_list"><a href="/admin/health/discussion/selectDiscussionList.do">목록보기</a></span>
</div>
							
				<c:if test="${fn:length(divisionList) > 0}" >
				<h5 class="tit_05">토론 참여 의견</h5>
				<table class="list_type01 mgb20" summary="토론 참여 의견 목록 테이블입니다">
						<caption>토론 참여 의견 목록</caption>
						<colgroup>
							<col width="8%" />
							<col width="*" />
							<col width="20%" />
							<col width="12%" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col" class="fir">번호</th>
								<th scope="col">의견</th>
								<th scope="col">글쓴이</th>
								<th scope="col">입력일자</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach var="x" begin="0" end="${fn:length(divisionList)-1}">  
							<tr>
								<td>${zvl.divisionCnt - (zvl.pageIndex-1)*zvl.pageUnit - x}</td>
								<td class="tal">${fn:replace(divisionList[x].divcont, crlf, "<br/>")}</td>
								<td>${divisionList[x].name}</td>
								<td><fmt:parseDate value='${divisionList[x].rdate}' var='rdate' pattern='yyyy-mm-dd'/>
							<fmt:formatDate value='${rdate}' pattern="yyyy년mm월dd일"/></td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
		
<ol class="paging">${pageNav}</ol>

					</c:if>
				
			</form><!-- write form end -->
</div>
</body>
</html>

				
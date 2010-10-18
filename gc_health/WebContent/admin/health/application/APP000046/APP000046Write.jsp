<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("crlf", "\r\n"); %>	
	
<c:set var="action" value="/admin/health/application/apply.do" />
<c:if test="${not empty result}" >
	<c:set var="action" value="/admin/health/application/modify.do" />
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
	
<script type="text/javascript" src="/health/open_content/system/js/prototype.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>
<script type="text/javascript">

function checkForm()
{			
	var form = $("frm");
	var v = new MiyaValidator(form);
    v.add("etc1", {
        required: true
    });
	result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	} 
	else
	{
		form.submit();
	}
}
</script>

</head>
<body style="background:none;padding:10px;">
<h2 style="padding:15px 0 15px 0;">	
		대사증후군관리 
</h2>
<p class="title_deco"></p>
<div class="body">
					
<form id="frm" name="frm" method="post" onsubmit="return checkForm(this);" action="${action}">
	<input type="hidden" name="applyCode" value="${param.applyCode}" />
	<input type="hidden" name="applyId" value="${param.applyId}" />		
				<h4>기본정보</h4>	
						<table class="default_write" summary="기관명(시설명), 소재지, 시설장, 교육담당자 연락처로 구성되어 있습니다.">
							<caption>기관정보 글쓰기</caption>
							<colgroup>
								<col style="width:20%;"/>
								<col style="width:30%;"/>
								<col style="width:20%;"/>
								<col style="width:30%;"/>
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">등록번호</th>
									<td colspan="3" class="output"><input type="text" id="etc1" name="etc1" class="intext" style="width:203px;" value="${result.etc1}" /></td>
								</tr>
								<tr>
									<th scope="row">검진일자</th>
									<td colspan="3" class="output"><input type="text" id="etc7" name="etc7" class="intext" style="width:203px;" value="${result.etc7}" /></td>
								</tr>
								<tr>
									<th scope="row">이름</th>
									<td colspan="3" class="output"><input type="text" id="name" name="name" class="intext" style="width:203px;" value="${result.name}" /></td>
								</tr>
								<tr>
									<th scope="row">주민번호</th>
									<td colspan="3" class="output"><input type="text" id="etc2" name="etc2" class="intext" style="width:203px;" value="${result.etc2}" /></td>
								</tr>
								<tr>
									<th scope="row">전화번호</th>
									<td colspan="3" class="output"><input type="text" id="tel" name="tel" class="intext" style="width:203px;" value="${result.tel}" /></td>
								</tr>
								<tr>
									<th scope="row">주소</th>
									<td colspan="3" class="output"><input type="text" id="addr1" name="addr1" class="intext" style="width:203px;" value="${result.addr1}" /></td>
								</tr>
							</tbody>
						</table>
								
<br/>
<br/>
				<h4>등록정보</h4>	
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
									<th scope="row">관리센터</th>
									<td colspan="3" class="output"><input type="text" id="etc3" name="etc3" class="intext" style="width:203px;" value="${result.etc3}" /></td>
								</tr>
								<tr>
									<th scope="row">등록일자</th>
									<td colspan="3" class="output"><input type="text" id="etc4" name="etc4" class="intext" style="width:203px;" value="${result.etc4}" /></td>
								</tr>
								<tr>
									<th scope="row">내소동기</th>
									<td colspan="3" class="output"><input type="text" id="etc5" name="etc5" class="intext" style="width:203px;" value="${result.etc5}" /></td>
								</tr>
							</tbody>
						</table>
					
<br/>
<br/>
				<h4>복부비만</h4>	
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
									<th scope="row">허리둘레</th>
									<td colspan="3" class="output"><input type="text" id="etc8" name="etc8" class="intext" style="width:203px;" value="${result.etc8}" /></td>
								</tr>
							</tbody>
						</table>
					
<br/>
<br/>
				<h4>고지혈증</h4>	
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
									<th scope="row">중성지방</th>
									<td colspan="3" class="output"><input type="text" id="etc9" name="etc9" class="intext" style="width:203px;" value="${result.etc9}" /></td>
								</tr>
								<tr>
									<th scope="row">HDL</th>
									<td colspan="3" class="output"><input type="text" id="etc10" name="etc10" class="intext" style="width:203px;" value="${result.etc10}" /></td>
								</tr>
								<tr>
									<th scope="row">약복용</th>
									<td colspan="3" class="output"><input type="text" id="etc11" name="etc11" class="intext" style="width:203px;" value="${result.etc11}" /></td>
								</tr>
							</tbody>
						</table>
					
<br/>
<br/>
				<h4>고혈압</h4>	
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
									<th scope="row">혈압</th>
									<td colspan="3" class="output"><input type="text" id="etc12" name="etc12" class="intext" style="width:203px;" value="${result.etc12}" /></td>
								</tr>
								<tr>
									<th scope="row">약복용</th>
									<td colspan="3" class="output"><input type="text" id="etc13" name="etc13" class="intext" style="width:203px;" value="${result.etc13}" /></td>
								</tr>
								<tr>
									<th scope="row">공복혈당</th>
									<td colspan="3" class="output"><input type="text" id="etc14" name="etc14" class="intext" style="width:203px;" value="${result.etc14}" /></td>
								</tr>
								<tr>
									<th scope="row">약복용</th>
									<td colspan="3" class="output"><input type="text" id="etc15" name="etc15" class="intext" style="width:203px;" value="${result.etc15}" /></td>
								</tr>
							</tbody>
						</table>
					
<br/>
<br/>
				<h4>대사증후군</h4>	
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
									<th scope="row">판정일자</th>
									<td colspan="3" class="output"><input type="text" id="etc16" name="etc16" class="intext" style="width:203px;" value="${result.etc16}" /></td>
								</tr>
								<tr>
									<th scope="row">진단기준</th>
									<td colspan="3" class="output"><input type="text" id="etc17" name="etc17" class="intext" style="width:203px;" value="${result.etc17}" /></td>
								</tr>
								<tr>
									<th scope="row">행동stage</th>
									<td colspan="3" class="output"><input type="text" id="etc18" name="etc18" class="intext" style="width:203px;" value="${result.etc18}" /></td>
								</tr>
								<tr>
									<th scope="row">복부둘레</th>
									<td colspan="3" class="output"><input type="text" id="etc19" name="etc19" class="intext" style="width:203px;" value="${result.etc19}" /></td>
								</tr>
								<tr>
									<th scope="row">혈압</th>
									<td colspan="3" class="output"><input type="text" id="etc20" name="etc20" class="intext" style="width:203px;" value="${result.etc20}" /></td>
								</tr>
								<tr>
									<th scope="row">혈당</th>
									<td colspan="3" class="output"><input type="text" id="etc21" name="etc21" class="intext" style="width:203px;" value="${result.etc21}" /></td>
								</tr>
								<tr>
									<th scope="row">HDL</th>
									<td colspan="3" class="output"><input type="text" id="etc22" name="etc22" class="intext" style="width:203px;" value="${result.etc22}" /></td>
								</tr>
								<tr>
									<th scope="row">TG</th>
									<td colspan="3" class="output"><input type="text" id="etc23" name="etc23" class="intext" style="width:203px;" value="${result.etc23}" /></td>
								</tr>
							</tbody>
						</table>
					
<br/>
<br/>
				<h4>검사방법</h4>	
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
									<th scope="row">검사장비</th>
									<td colspan="3" class="output"><input type="text" id="etc24" name="etc24" class="intext" style="width:203px;" value="${result.etc24}" /></td>
								</tr>
								<tr>
									<th scope="row">검사기관명</th>
									<td colspan="3" class="output"><input type="text" id="etc25" name="etc25" class="intext" style="width:203px;" value="${result.etc25}" /></td>
								</tr>
							</tbody>
						</table>
</form>
			<div class="board_btn_set mt13">
				<span class="btn_del"><a href="javascript:checkForm();">${empty result ? '등록' : '수정'}하기</a></span>
				<span class="btn_list"><a href="/admin/health/application/selectApplicationList.do?applyCode=${param.applyCode}">목록보기</a></span>
			</div>
</div>
</body>
</html>
			

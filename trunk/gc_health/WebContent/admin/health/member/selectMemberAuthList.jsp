<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/admin/health/application/applyStatus.jsp" %>

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
<script type="text/javascript" src="/health/open_content/system/js/apply.js"></script>

<script type="text/javascript">
<!--

function applyAuthor() {
	var form = document.searchFrm;
	var v = new MiyaValidator(form);
    v.add("webMemId_A", {
        required: true
    });
    v.add("authCode", {
        required: true
    });
	result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	} 

	var optionObj=form.authCode.options;
	var index = optionObj.selectedIndex;
	var authNm = optionObj[index].text;
	form.authName.value = authNm;
	form.action = "/admin/health/member/applyUsersAuth.do";
	form.submit();
}

//-->
</script>
</head> 
<body style="background:none;padding:10px;">
<h3 class="tit_03">상담</h3>
	
<p class="title_deco"></p>
<div class="body">

<form id="searchFrm" name="searchFrm"  method="post"  action="/admin/health/member/selectMemberAuthList.do">
	<input type="hidden" id="authName" name="authName" value="" />
<div class="board_top clearfix">
    <div class="fl_l"> <span>${pageInfo.totCnt}건 [${pageInfo.pageIndex} / ${pageInfo.totalPageCount}Page]</span> </div>
    <fieldset class="fl_r">
        <legend>게시물검색</legend>
        <select name="searchType" title="구분선택">
            <option value="">전체</option>
            <option value="1" <c:if test="${param.searchType == '1'}" >selected</c:if>>아이디</option>
            <option value="2" <c:if test="${param.searchType == '2'}" >selected</c:if>>이름</option>
        </select>
        <input type="text" name="searchTxt" value="${param.searchTxt}" title="검색어" class="text"/>    
		<input type="image" alt="검색" src="/health/open_content/images/borad/btn_search.gif"/>		
		
        <select id="authCode" name="authCode" title="권한">
            <option value="">권한선택</option>
            <option value="ROLE_FOOD" <c:if test="${param.searchTxt == '2'}" >selected</c:if>>식품위생감시원권한</option>
        <c:forEach items="${mtList}" var="mt">
            <option value="ROLE_MT${mt.no}" <c:if test="${param.searchTxt == '1'}" >selected</c:if>>${mt.institution}권한</option>
        </c:forEach>
        </select>
        <input type="button" name="btn" value="권한적용" onclick="applyAuthor();" />
    </fieldset>
</div>

<table class="default_list" summary="번호,제목,공개여부, 작성자, 등록일, 첨부파일 구성">
    <caption>
    게시물리스트
    </caption>
    <thead>
        <tr>
            <th width="7%" scope="col">번호</th>
            <th width="7%" scope="col">선택<input type="checkbox" name="checkAll" onclick="checkbox_toggle('chk',this.checked);" /></th>
            <th width="13%" scope="col">아이디</th>
            <th width="37%" scope="col">이름</th>
            <th width="13%" scope="col">전화번호</th>
            <th width="13%" scope="col">핸드폰</th>
            <th width="10%" scope="col">권한명</th>
        </tr>
    </thead>
    <tbody>
	<c:if test="${fn:length(resultList) > 0}" >
	<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}">  
        <tr>
            <td>${pageInfo.totCnt - (pageInfo.pageIndex-1)*pageInfo.pageUnit - x}</td>
            <td><input type="checkbox" name="webMemId_A" value="${resultList[x].webMemId}" /></td>
            <td>${resultList[x].webMemId}</td>
            <td class="tal">${resultList[x].memNm}</td>
            <td>${resultList[x].phone}</td>
            <td>${resultList[x].handphone}</td>
            <td>${resultList[x].authName}</td>
        </tr>
     </c:forEach>
     </c:if>
	<c:if test="${fn:length(resultList) == 0}" >
	<tr><td colspan="7">데이터가 없습니다</td></tr>
	</c:if>
    </tbody>
</table>
</form>
<ol class="paging">
<c:if test="${fn:length(resultList) > 0}" >
${pageNav}
</c:if>
</ol>
</div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<script type="text/javascript" src="/health/open_content/system/js/jslb_ajax.js"></script>
<script type="text/javascript">
	function updateCstmMenu(cstmId, menuNo)
	{
		var prefix = cstmId + "_" + menuNo + "_";
		var url = "/admin/health/infoCustomMade/updateCstmMenu.do";
		var param="&cstmId="+cstmId+
			"&cstmMenuNo="+menuNo+
			"&cstmMenuNm="+$(prefix+"cstmMenuNm").value+
			"&cstmMenuOrder="+$(prefix+"cstmMenuOrder").value;
		sendRequest(callbackUpdateCstmMenu, param, 'POST', url, true, true);
	}

	function callbackUpdateCstmMenu(oj)
	{
		try 
		{
			var jsonData = oj.responseText;
			var j = eval('(' + jsonData + ')');
			var code = j.resultCode;
			if(code == "1")
			{	
				 alert("성공적으로 수정되었습니다.");
			}
			else if(code == "0")
			{
				 alert(j.resultMsg);
			}
		}	
		catch (err) 
		{
			alert("알수없는 오류입니다.");
		}
	}

	function delCstmMenu(cstmId, menuNo)
	{
		var prefix = cstmId + "_" + menuNo + "_";
		var url = "/admin/health/infoCustomMade/delCstmMenu.do";
		var param="&cstmId="+cstmId+
			"&cstmMenuNo="+menuNo;
		sendRequest(callbackDelCstmMenu, param, 'POST', url, true, true);
	}

	function callbackDelCstmMenu(oj)
	{
		try 
		{
			var jsonData = oj.responseText;
			var j = eval('(' + jsonData + ')');
			var code = j.resultCode;
			if(code == "1")
			{	
				 alert("성공적으로 삭제되었습니다.");
				 location.href="/admin/health/infoCustomMade/selectCustomMainMenuCategoryList.do";
			}
			else if(code == "0")
			{
				 alert(j.resultMsg);
			}
		}	
		catch (err) 
		{
			alert("알수없는 오류입니다.");
		}
	}
	function modifyCategoryPage(cstmId)
	{
		location.href="/admin/health/infoCustomMade/modifyCustomMainMenuCategoryPage.do?cstmId="+cstmId;
	}

	function addChildPage(cstmId)
	{
		location.href="/admin/health/infoCustomMade/selectCustomMainMenuCategory.do?cstmId="+cstmId;
	}

	function delCategory(cstmId)
	{
		if(confirm("하위메뉴 모두 삭제됩니다.삭제하시겠습니까?"))
		{	
			var url = "/admin/health/infoCustomMade/delCustomMainMenuCategory.do";
			var param="&siteId=${param.siteId}&cstmId="+cstmId;
			sendRequest(callbackDelCategory, param, 'POST', url, true, true);
		}
	}

	function callbackDelCategory(oj)
	{
		try 
		{
			var jsonData = oj.responseText;
			var j = eval('(' + jsonData + ')');
			var code = j.resultCode;
			if(code == "1")
			{	
				 alert("성공적으로 삭제되었습니다.");
				 location.href = "/admin/health/infoCustomMade/selectCustomMainMenuCategoryList.do?siteId=${param.siteId}";
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
	
	function toggleChild(cstmId, size)
	{
		for(var i=0; i<size; i++)
		{
			if($("tr_"+ cstmId + "_" + i).style.display == 'none')
				$("tr_"+ cstmId + "_" + i).show();
			else
				$("tr_"+ cstmId + "_" + i).hide();
		}
	}

</script>
</head>
<body style="background:none;padding:10px;">
<h2 style="padding:15px 0 15px 0;">	
			주요서비스
</h2>
<p class="title_deco"></p>
<div class="body">

			
				<!-- write form start -->
				<!-- board list start -->
				<table class="default_list" summary="게시판 목록입니다">
					<caption>게시판 목록</caption>
					<colgroup>
						<col width="10%" />
						<col width="*" />
						<col width="20%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col" class="fir">번호</th>
							<th scope="col">카테고리이름</th>
							<th scope="col">기타</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="sortedResult" items="${sortedResultList}" varStatus="status">
						<c:set var="key" value="cstmId_${sortedResult.cstmId}" />
						<c:set var="resultList" value="${resultMap[key]}" />
						<tr>
							<td>${fn:length(sortedResultList) - status.count + 1}</td>
							<td class="tal" onmouseover="this.style.backgroundColor='#FFFFCC'" onmouseout="this.style.backgroundColor=''" style="cursor:hand;" onclick="toggleChild('${sortedResult.cstmId}', ${fn:length(resultList)})">
								${sortedResult.categoryNm}
							</td>
							<td>
								<a href="javascript:addChildPage('${sortedResult.cstmId}')">하위메뉴등록</a> 
								<a href="javascript:modifyCategoryPage('${sortedResult.cstmId}')">수정</a> 
								<a href="javascript:delCategory('${sortedResult.cstmId}');">삭제</a>
							</td>
						</tr>
						<c:if test="${fn:length(resultList) > 0}" >
						<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}">  
							<c:set var="prefix" value="${resultList[x].cstmId}_${resultList[x].cstmMenuNo}_" />
						<tr id="tr_${resultList[x].cstmId}_${x}" style="display:none">
							<td></td>
							<td class="tal">
								메뉴명 <input id="subject" name="${prefix}cstmMenuNm" value="${resultList[x].cstmMenuNm}" type="text" style="width:200px" class="board1" /> 
								순서 <input id="subject" name="${prefix}cstmMenuOrder" value="${resultList[x].cstmMenuOrder}" type="text" style="width:50px" class="board1" /> 
							</td>
							<td>
								<a href="javascript:updateCstmMenu('${resultList[x].cstmId}','${resultList[x].cstmMenuNo}')">수정</a> 
								<a href="javascript:delCstmMenu('${resultList[x].cstmId}','${resultList[x].cstmMenuNo}')">삭제</a> 
							</td>
						</tr>
						</c:forEach>
						</c:if>
					</c:forEach>		
					<c:if test="${fn:length(sortedResultList) == 0}" >
						<tr><td colspan="3">데이터가 없습니다.</td></tr>
					</c:if>
					</tbody>
				</table>
				<!-- board list end //-->
				
<div class="board_btn_set mt13">

	<span class="btn_del"><a href="/admin/health/infoCustomMade/addCustomMainMenuCategoryPage.do">등록하기</a></span>

</div>
			
</div>
</body>
</html>


<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
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


</head>
<body style="background:none;padding:10px;">
<h2 style="padding:15px 0 15px 0;">	
		기타내용
</h2>
<p class="title_deco"></p>
<div class="body">

	<!-- write form start -->
	<table id="check_form" summary="응모 할 수 있는 항목입니다" class="default_view" style="width: 778px; text-align: center;">
		<caption>응모 할 수 있는 항목</caption>
		<colgroup>
			<col style="width:7%;"/>
			<col style="width:93%;"/>
		</colgroup>
		<tbody>
			<c:if test="${fn:length(otherList) > 0}">
				<c:forEach items="${otherList}" var="otherItem" varStatus="qStatus">		
					<tr>
						<th>${qStatus.count}</th>
						<td class="tal">
							${otherItem.other}
						</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${fn:length(otherList) == 0}">
				<tr>
					<td colspan="2">
						데이터가 없습니다.
					</td>
				</tr>		
			</c:if>
		</tbody>
	</table>
	
<div id="btn" class="board_btn_set mt13">
	<span class="btn_del"><a href="#btn" onclick="window.close();event.returnValue=false;">닫기</a></span>
</div>
			
</div>
</body>
</html>
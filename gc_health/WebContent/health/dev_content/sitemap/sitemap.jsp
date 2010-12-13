<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	HashMap healthMenuCategoryMap = (HashMap)application.getAttribute("healthMenuCategoryMap");
	pageContext.setAttribute("healthMenuCategoryMap", healthMenuCategoryMap);
%>
<HTML>
 <HEAD>
  <TITLE> New Document </TITLE>
  <META NAME="Generator" CONTENT="EditPlus">
  <META NAME="Author" CONTENT="">
  <META NAME="Keywords" CONTENT="">
  <META NAME="Description" CONTENT="">
  <link href="/health/open_content/system/css/sitemap.css" rel="stylesheet" type="text/css" />
 </HEAD>

 <BODY>


<c:set var="topCategories" value="${healthMenuCategoryMap['menu_0']}" />
<c:if test="${fn:length(topCategories)>0}">
<c:forEach var="x" begin="0" end="3">
<h4>${topCategories[x].name}</h4>
<div class="site_01 mt10">
	<c:set var="d02MenuKey" value="menu_${topCategories[x].categoryId}" />
	<c:set var="d02Categories" value="${healthMenuCategoryMap[d02MenuKey]}" />
	<c:if test="${fn:length(d02Categories)>0}">
	<c:forEach var="y" begin="0" end="${fn:length(d02Categories)-1}">
<div class="sitemap_box">
<h5>${d02Categories[y].name}</h5>
		<dl class="sitemap_list">
		<c:set var="d03MenuKey" value="menu_${d02Categories[y].categoryId}" />
		<c:set var="d03Categories" value="${healthMenuCategoryMap[d03MenuKey]}" />
		<c:if test="${fn:length(d03Categories)>0}">
		<c:forEach var="z" begin="0" end="${fn:length(d03Categories)-1}">
			<dt><a href="${d02Categories[y].fullMenuLink}">${d02Categories[y].name}</a></dt>
		</c:forEach>
		</c:if>
		</dl>
</div>
	</c:forEach>
	</c:if>
</div>
	</c:forEach>
	</c:if>

 </BODY>
</HTML>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>
<%
	HashMap healthMenuCategoryMap = (HashMap)application.getAttribute("healthMenuCategoryMap");
	pageContext.setAttribute("healthMenuCategoryMap", healthMenuCategoryMap);
%>
  <link href="/health/open_content/system/css/sitemap.css" rel="stylesheet" type="text/css" />
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
			<dt><a href="${d03Categories[z].fullMenuLink}">${d03Categories[z].name}</a></dt>
		</c:forEach>
		</c:if>
		</dl>
</div>
	</c:forEach>
	</c:if>
</div>
	</c:forEach>
	</c:if>

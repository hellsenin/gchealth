<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="topCategories" value="${menuCategoryMap['menu_0']}" />
		
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<title>금천시 보건소</title>
    <link rel="stylesheet" type="text/css" href="/admin/health/infoCustomMade/tree.css" />
<link href="/health/open_content/system/css/default.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/common.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/blue.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_blue.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/health/open_content/system/js/jquery-1.4.2.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>
<script type="text/javascript">
	function goUrl(categoryId)
	{
		var url = "/admin/main/selectContent.do?categoryId=" + categoryId;
		document.getElementById("contentFrame").src = url;
	}
	
	
	function autoResize(i){
	     var iframeHeight=
	     (i).contentWindow.document.body.scrollHeight;
	     var iframeWidth=
	     (i).contentWindow.document.body.scrollWidth;     
	     (i).height=iframeWidth+20;
	     (i).height=iframeHeight+20;
	 }
	 
    $(function($){
    	var tree = $('.tree');
    	var togglePlus = '\<button type=\"button\" class=\"toggle plus\"\>+\<\/button\>';
    	var toggleMinus = '\<button type=\"button\" class=\"toggle minus\"\>-\<\/button\>';
    	
    	// defalt
    	tree.find('li>ul').css('display','none');
    	tree.find('ul>li:last-child').addClass('last');
    	tree.find('li>ul:hidden').parent('li').prepend(togglePlus);
    	tree.find('li>ul:visible').parent('li').prepend(toggleMinus);
    	
    	// active
    	tree.find('li.active').parents('li').addClass('open');
    	tree.find('li.open').parents('li').addClass('open');
    	tree.find('li.open>.toggle').text('-').removeClass('plus').addClass('minus');
    	tree.find('li.open>ul').slideDown(100);
    	
    	// click toggle
    	$('.tree .toggle').click(function(){
    		t = $(this);
    		t.parent('li').toggleClass('open');
    		if(t.parent('li').hasClass('open')){
    			t.text('-').removeClass('plus').addClass('minus');
    			t.parent('li').find('>ul').slideDown(100);
    		} else {
    			t.text('+').removeClass('minus').addClass('plus');
    			t.parent('li').find('>ul').slideUp(100);
    		}
    	});
    	
    });
    </script>
    <style>
      fieldset { width: 320px }
    </style>

</head>
<body style="background:none;padding:10px;">
<h2 style="padding:15px 0 15px 0;">	
		메뉴구조 
</h2>
<p class="title_deco"></p>
<div class="body">

    <fieldset>
      <legend>하위메뉴등록</legend>
	<div class="tree">
      <ul>
		<c:if test="${fn:length(topCategories)>0}">		 
	 	<c:forEach var="x" begin="0" end="${fn:length(topCategories)-1}">
				<c:set var="d01MenuKey" value="menu_${topCategories[x].categoryId}" />
				<c:set var="d01Categories" value="${menuCategoryMap[d01MenuKey]}" />
        <li>
          <a href="javascript:goUrl('${topCategories[x].categoryId}');">${topCategories[x].name}</a>
          <ul>
				<c:if test="${fn:length(d01Categories)>0}">
		 		<c:forEach var="y" begin="0" end="${fn:length(d01Categories)-1}">	
            <li>
              <a href="javascript:goUrl('${d01Categories[y].categoryId}');">${d01Categories[y].name}</a>
              <ul>
			<c:set var="menuKey" value="menu_${d01Categories[y].categoryId}" />
			<c:set var="d02Categories" value="${menuCategoryMap[menuKey]}" />
			<c:if test="${fn:length(d02Categories)>0}">
	 			<c:forEach var="z" begin="0" end="${fn:length(d02Categories)-1}">
                <li><a href="javascript:goUrl('${d02Categories[z].categoryId}');">${d02Categories[z].name}</a>
              		<ul>
			<c:set var="d03menuKey" value="menu_${d02Categories[z].categoryId}" />
			<c:set var="d03Categories" value="${menuCategoryMap[d03menuKey]}" />
			<c:if test="${fn:length(d03Categories)>0}">
	 			<c:forEach var="l" begin="0" end="${fn:length(d03Categories)-1}">
						<li>
						<a href="javascript:goUrl('${d03Categories[l].categoryId}');">${d03Categories[l].name}</a>
              		<ul>
			<c:set var="d04menuKey" value="menu_${d03Categories[l].categoryId}" />
			<c:set var="d04Categories" value="${menuCategoryMap[d04menuKey]}" />
			<c:if test="${fn:length(d04Categories)>0}">
	 			<c:forEach var="m" begin="0" end="${fn:length(d04Categories)-1}">
						<li>
						<a href="javascript:goUrl('${d04Categories[m].categoryId}');">${d04Categories[m].name}</a>
              		<ul>
			<c:set var="d05menuKey" value="menu_${d04Categories[m].categoryId}" />
			<c:set var="d05Categories" value="${menuCategoryMap[d05menuKey]}" />
			<c:if test="${fn:length(d05Categories)>0}">
	 			<c:forEach var="n" begin="0" end="${fn:length(d05Categories)-1}">
						<li>
						<a href="javascript:goUrl('${d05Categories[n].categoryId}');">${d05Categories[n].name}</a>
							</li>
				</c:forEach>
			</c:if>
					</ul>
							</li>
				</c:forEach>
			</c:if>
					</ul>
							</li>
				</c:forEach>
			</c:if>
					</ul>
							</li>
				</c:forEach>
			</c:if>
					</ul>
				</li>
			</c:forEach>
			</c:if>
				</ul>
			</li>
		</c:forEach>
		</c:if>
		</ul>
	</div>
    </fieldset>
    
	<iframe src="/admin/main/selectContent.do" width="100%" scrolling="no" frameborder="0" name="contentFrame" onload='javascript:autoResize(this);'></iframe>
	
</div>
</body>
</html>

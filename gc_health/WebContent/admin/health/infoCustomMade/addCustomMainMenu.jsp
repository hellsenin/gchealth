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
    /*
      $(function(){
        $('li:has(ul)')
          .click(function(event){
            if (this == event.target) {
              $(this).children().toggle();
              $(this).css('list-style-image',
                ($(this).children().is(':hidden')) ?
                  'url(plus.gif)' : 'url(minus.gif)');
            }
            return false;
          })
          .css('cursor','pointer')
          .click();
        $('li:not(:has(ul))').css({
          cursor: 'default',
          'list-style-image':'none'
        });
      });
   */  
      function fInsertMenuCreat() {
		var form = document.menuCreatManageForm;
		var v = new MiyaValidator(form);
          v.add("checkField", {
              required: true,
              message: "적용할 메뉴를 선택하세요."
          });
          var result = v.validate();
          if (!result) {
              alert(v.getErrorMessage());
              //v.getErrorElement().focus();
          } 
          else
          {
      	    document.menuCreatManageForm.action = "<c:url value='/admin/health/infoCustomMade/addCustomMainMenu.do'/>";
      	    document.menuCreatManageForm.submit(); 
          }
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
		주요서비스 
</h2>
<p class="title_deco"></p>
<div class="body">

<form name="menuCreatManageForm" action ="/admin/health/infoCustomMade/addCustomMainMenu.do" method="post">
	<input type="hidden" name="cstmId" value="${param.cstmId}" />
    <fieldset>
      <legend>하위메뉴등록</legend>
	<div class="tree">
      <ul>
		<c:if test="${fn:length(topCategories)>0}">		 
	 	<c:forEach var="x" begin="0" end="${fn:length(topCategories)-1}">
				<c:set var="d01MenuKey" value="menu_${topCategories[x].categoryId}" />
				<c:set var="d01Categories" value="${menuCategoryMap[d01MenuKey]}" />
        <li>
          ${topCategories[x].name}
          <ul>
				<c:if test="${fn:length(d01Categories)>0}">
		 		<c:forEach var="y" begin="0" end="${fn:length(d01Categories)-1}">	
            <li>
              <input type='checkbox' name='checkField' class='check2' value="${d01Categories[y].categoryId}" <c:if test="${d01Categories[y].chkYeoBu > 0}">checked="checked" disabled</c:if> />${d01Categories[y].name}
              <ul>
			<c:set var="menuKey" value="menu_${d01Categories[y].categoryId}" />
			<c:set var="d02Categories" value="${menuCategoryMap[menuKey]}" />
			<c:if test="${fn:length(d02Categories)>0}">
	 			<c:forEach var="z" begin="0" end="${fn:length(d02Categories)-1}">
                <li><input type='checkbox' name='checkField' class='check2' value="${d02Categories[z].categoryId}" <c:if test="${d02Categories[z].chkYeoBu > 0}">checked="checked" disabled</c:if> />${d02Categories[z].name}
              		<ul>
			<c:set var="d03menuKey" value="menu_${d02Categories[z].categoryId}" />
			<c:set var="d03Categories" value="${menuCategoryMap[d03menuKey]}" />
			<c:if test="${fn:length(d03Categories)>0}">
	 			<c:forEach var="l" begin="0" end="${fn:length(d03Categories)-1}">
						<li>
						<input type='checkbox' name='checkField' class='check2' value="${d03Categories[l].categoryId}" <c:if test="${d03Categories[l].chkYeoBu > 0}">checked="checked" disabled</c:if> />${d03Categories[l].name}
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
    
<div class="board_btn_set mt13">
	<span class="btn_del"><a href="javascript:fInsertMenuCreat();">등록하기</a></span>
</div>
			
</form>
</div>
</body>
</html>

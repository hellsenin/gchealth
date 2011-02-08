<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK" %>
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
    function save() {
		var form = document.frm;
		var v = new MiyaValidator(form);
        v.add("content", {
            required: true,
            message: "내용을 입력하세요."
        });
        var result = v.validate();
        if (!result) {
            alert(v.getErrorMessage());
            v.getErrorElement().focus();
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
		컨텐츠 수정 
</h2>
<p class="title_deco"></p>
<div class="body">
<form name="frm" action ="/admin/main/saveContent.do" method="post">
	<input type="hidden" name="categoryId" value="${param.categoryId}" />
	<input type="hidden" name="contentsPath" value="${result.contentsPath}" />
			<table class="default_write">
						<caption>응급처치교육신청</caption>
						<colgroup>
							<col width="20%" />
							<col width="0%" />
							<col width="50%" />
							<col width="30%" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row"><label for="writecontents">내용</label></th>
							<td colspan="3" class="output">		
							<FCK:editor id="content"  basePath="/fckeditor/" height="350">${result.content}</FCK:editor>			
							</td>
						</tr>
						</tbody>
					</table>			
</form>
<div class="board_btn_set mt13">
	<span class="btn_del"><a href="javascript:save();">저장하기</a></span>
</div>
	
</div>
</body>
</html>

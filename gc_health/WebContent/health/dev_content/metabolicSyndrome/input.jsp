<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/util.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/Calendar.js"></script>
<script type="text/javascript">
	function checkForm(form)
	{	
		var v = new MiyaValidator(form);
	    v.add("regno", {
	        required: true,
	        message: "등록번호를 입력해주세요."
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

<h4>검사결과</h4>
<form name="form1" method="post" action="/health/metabolicSyndrome/read.do?applyCode=APP000046&amp;categoryId=${param.categoryId}" onsubmit="return checkForm(this);">
<table class="default_write" width="100%" border="0">
<tr><td height="15"></td></tr>
<tr>
  <td><b>* 등록번호를 입력해주세요.</b></td>
</tr>
<tr>
	<td><input type="text" id="regno" name="regno" size="30"/>&nbsp;<input type="submit" value="전송" /></td>
</tr>
</table>

</form>
	
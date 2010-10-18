<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="year" value="${company.year_cd}" />
<script type="text/javascript" src="/health/open_content/system/js/Calendar.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/jquery-1.4.2.js"></script>
<script type="text/javascript">

var rows = ${fn:length(handleItemList) > 0 ? fn:length(handleItemList) : 0};

function checkNumber(wcntObj, i)
{
	var val = wcntObj.value;
	if(isNaN(val))
	{
		alert("숫자만 가능합니다.");
		wcntObj.value=0;
	}
	else
	{
		$("#field5_"+i)[0].value =
			parseInt($("#field1_"+i)[0].value) + parseInt($("#field2_"+i)[0].value)
			 - $("#field3_"+i)[0].value - $("#field4_"+i)[0].value;
	}
}

function jaddRow()
{	
	rows++;
	$("#tbl tr:last").after(
		"<tr id='tr"+(rows)+"'>"+
			"<td>"+(rows)+"</td>" +
			"<td><input type=\"text\" id=\"itemName"+(rows)+"\" name=\"itemName_A\" value=\"\" class=\"txt\" style=\"width:50px\" /></td>" +
			"<td><input type=\"text\" id=\"unit"+(rows)+"\" name=\"unit_A\" value=\"\" class=\"txt\" style=\"width:50px\" /></td>" +
			"<td><input type=\"text\" id=\"field1_"+(rows)+"\" name=\"field1_A\" value=\"0\" onblur=\"checkNumber(this, "+(rows)+")\" class=\"txt\" style=\"width:30px\" /></td>" +
			"<td><input type=\"text\" id=\"field2_"+(rows)+"\" name=\"field2_A\" value=\"0\" onblur=\"checkNumber(this, "+(rows)+")\" class=\"txt\" style=\"width:30px\" /></td>" +
			"<td><input type=\"text\" id=\"field3_"+(rows)+"\" name=\"field3_A\" value=\"0\" onblur=\"checkNumber(this, "+(rows)+")\" class=\"txt\" style=\"width:30px\" /></td>" +
			"<td><input type=\"text\" id=\"field4_"+(rows)+"\" name=\"field4_A\" value=\"0\" onblur=\"checkNumber(this, "+(rows)+")\" class=\"txt\" style=\"width:30px\" /></td>" +
			"<td><input type=\"text\" id=\"field5_"+(rows)+"\" name=\"field5_A\" value=\"0\" readonly=\"readonly\" class=\"txt\" style=\"width:30px\" /></td>" +
		"</tr>"
	);
}

function jdelRow(itemId)
{
	if(rows > 0)
	{
		rows--;
		$("#tbl tr:last").remove();
	}
}

function checkForm(form)
{		
	var condition = true;
	$("input[name=itemName_A]").each(function(){
		if(!$(this).attr("value"))
		{
			alert("품명은 필수사항입니다.");
			this.focus();
			condition = false;
			return false;
		}
	});

	return condition;
}


</script>
<div class="comment_box">
<div class="comment_box_top"></div>
<div class="comment_box_in" style="background:url(/health/open_content/images/comment/comment_img_s_001.gif) 580px top no-repeat;">
    <ul class="list">
        <li>정, 앰플 단위로 수량을 작성하고, 품명마다 규격및단위를 반드시 기재하세요.${year}</li>
        <li>(예: 품명 아티반정 규격및단위 0.5mg/정 수량 5000)</li>
    </ul>
</div>
<div class="comment_box_bottom"></div>
</div>

	<form name="fm" action="/health/freecheck/checkHandleitem.do?categoryId=${param.categoryId}" method="post" onsubmit="return checkForm(this);">
		<input type="hidden" name="company_cd" value="${company.company_cd}" />
		<input type="hidden" name="company_id" value="${company.id}" />
		<input type="hidden" name="company_name" value="${company.company}" />
	<table class="default_view" summary="제목, 주관부서, 등록일, 조회수, 첨부파일, 내용으로 구성되어 있습니다.">
		<caption>민원서식 상세내용</caption>
		<colgroup>
			<col style="width:20%;"/>
			<col style="width:80%;"/>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">업소명</th>
				<td class="output tal">${company.company}</td>
			</tr>
			<tr>
				<th scope="row">전화번호</th>
				<td class="output tal">${company.tel}</td>
			</tr>
			<tr >
				<th scope="row">작성자</th>
				<td class="output tal">
					${company.ceo_name}
				</td>
			</tr>
		</tbody>
	</table>
<br/>
<br/>
	
<table id="tbl" class="default_list" summary="번호,제목,공개여부, 작성자, 등록일, 첨부파일 구성">
    <caption>
    게시물리스트
    </caption>
    <thead>
        <tr>
            <th width="7%" scope="col">번호</th>
            <th width="*" scope="col">품명</th>
            <th width="15%" scope="col">규격및단위</th>
            <th width="15%" scope="col">${year-2}년도<br/>이월량</th>
            <th width="15%" scope="col">${year-1}년도<br/>구입량</th>
            <th width="15%" scope="col">${year-1}년도<br/>판매(사용)량</th>
            <th width="15%" scope="col">${year-1}년도<br/>반품또는폐기량</th>
            <th width="10%" scope="col">${year-1}.12.31<br/>재고량</th>
        </tr>
    </thead>
    <tbody>
	<c:if test="${fn:length(handleItemList) > 0}" >
	<c:forEach var="x" begin="0" end="${fn:length(handleItemList)-1}">  
        <tr id="tr${x+1}">
            <td>${x+1}</td>
            <td><input type="text" id="itemName${x+1}" name="itemName_A" value="${handleItemList[x].itemName}" style="width:50px" class="txt" /></td>
            <td><input type="text" id="unit${x+1}" name="unit_A" value="${handleItemList[x].unit}" style="width:50px" class="txt" /></td>
            <td><input type="text" id="field1_${x+1}" name="field1_A" value="${handleItemList[x].field1}" style="width:30px" onblur="checkNumber(this, ${x+1})" class="txt" /></td>
            <td><input type="text" id="field2_${x+1}" name="field2_A" value="${handleItemList[x].field2}" style="width:30px" onblur="checkNumber(this, ${x+1})" class="txt" /></td>
            <td><input type="text" id="field3_${x+1}" name="field3_A" value="${handleItemList[x].field3}" style="width:30px" onblur="checkNumber(this, ${x+1})" class="txt" /></td>
            <td><input type="text" id="field4_${x+1}" name="field4_A" value="${handleItemList[x].field4}" style="width:30px" onblur="checkNumber(this, ${x+1})" class="txt" /></td>
            <td><input type="text" id="field5_${x+1}" name="field5_A" value="${handleItemList[x].field5}" style="width:30px" readonly="readonly" class="txt" /></td>
        </tr>
     </c:forEach>
     </c:if>
    </tbody>
</table>
<br/>
<br/>
<div class="board_btn_set send_mg"> 
	<span class="register">
		<a href="javascript:jaddRow();">품목추가</a>
	</span> 
	<span class="register">
		<a href="javascript:jdelRow();">품목삭제</a>
	</span> 
	<span class="btn_del"><input type="submit" value="${empty result ? '등록' : '수정'}하기" /></span>
</div>
</form>

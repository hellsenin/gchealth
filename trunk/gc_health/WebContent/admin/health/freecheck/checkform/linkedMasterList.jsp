<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
<link href="/health/open_content/system/css/default.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/common.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/blue.css" rel="stylesheet" type="text/css" />
<link href="/health/open_content/system/css/board_blue.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="/health/open_content/system/js/Calendar.js"></script>

<script type="text/javascript" src="/health/open_content/system/js/prototype.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/miya_validator.js"></script>
<script type="text/javascript" src="/health/open_content/system/js/jslb_ajax.js"></script>
<script type="text/javascript">

function selectLinkedMasterByIndustry() 
{
	var url = "/admin/freecheck/selectLinkedMasterByIndustry.do";
	var param = "&industryCd="+$F("industryCd");  
	sendRequest(callbackSelectLinkedMaster, param, 'POST', url, true, true);
}

function callbackSelectLinkedMaster(oj)
{
    try 
    {
    	var jsonData = oj.responseText;
        var j = eval('(' + jsonData + ')');
        var titleData = j.title ? j.title.split("|") : '';
        var masterCdData = j.masterCd ? j.masterCd.split("|") : '';
        var selectObj = $("masterCd");
		selectObj.innerHTML = "";
	  	var opt = document.createElement("OPTION");
	  	selectObj.options.add(opt);
	  	opt.innerText = "점검표선택";
	  	opt.value = "";

        for(i=0;i<masterCdData.length;i++)
        {
        	var opt = document.createElement("OPTION");
        	selectObj.options.add(opt);
        	opt.innerText = titleData[i];
        	opt.value = masterCdData[i];
        }
    } 
    catch (err)
    {
        alert("FUNCTION : callbackSelectLinkedMaster() " + err.description);
    }
}

function checkForm(form)
{			
	var v = new MiyaValidator(form);
    v.add("industryCd", {
        required: true
    });
	v.add("masterCd", {
        required: true
    });
	result = v.validate();
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
</head>
<body style="background:none;padding:10px;">
<h3 class="tit_03">업종,점검표연동관리</h3>

		<table class="default_list" cellspacing="1" cellpadding="0" width="600">
				<colgroup>
					<col width="80" /><col width="100" /><col width="*" /><col width="100" /><col width="100" /><col width="130" />
				</colgroup>
				<thead>
				<tr>
					<th id="board_num">번호</th>
					<th id="board_memid">업종명</th>
					<th id="board_birthday">연동된점검표</th>
					<th id="board_regedit">등록일</th>
					<th id="board_regedit">사용여부</th>
					<th id="board_regedit">관리</th>
				</tr>
				</thead>

	<!-- ##### 공지글 시작 ##### -->
			<tbody>
				<c:if test="${fn:length(resultList) > 0}" >
				<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}">  
				<tr>
					<td headers="board_num">${fn:length(resultList) - x}</td>
					<td headers="board_memid"><span style="font-weight:bold">${resultList[x].name}</span></td>
					<td headers="board_memid"><span style="font-weight:bold">${resultList[x].title}</span></td>
					<td headers="board_linktype">${resultList[x].regDate}</td>
					<td>
						<c:if test="${resultList[x].useYn == 'Y'}" >사용</c:if>
						<c:if test="${resultList[x].useYn == 'N'}" >미사용</c:if>
					</td>
					<td headers="board_memid"><span style="font-weight:bold"><a href="/admin/freecheck/delLinkedMaster.do?masterCd=${resultList[x].masterCd}&industryCd=${resultList[x].industryCd}">삭제</a></span></td>
				</tr>
				</c:forEach>
				</c:if>
				<c:if test="${fn:length(resultList) == 0}" >
				<tr><td colspan="5">데이터가 없습니다</td></tr>
				</c:if>
	        </tbody>
      </table>
<br/>
<br/>
	<form id="searchFrm" name="searchFrm"  method="post" action="/admin/freecheck/addLinkedMaster.do" onsubmit="return checkForm(this);">
		<input type="hidden" name="useYn" value="Y" />	
		<table class="default_write" cellspacing="1" cellpadding="0" width="600">
				<colgroup>
					<col width="80" /><col width="100" /><col width="*" /><col width="100" /><col width="100" /><col width="130" />
				</colgroup>
				<thead>
				<tr>
					<th id="board_num">업종선택</th>
					<th id="board_memid">점검표선택</th>
				</tr>
				</thead>

	<!-- ##### 공지글 시작 ##### -->
			<tbody>
				<tr>
					<td headers="board_num">
						<select id="industryCd" name="industryCd" onchange="selectLinkedMasterByIndustry()">
							<option value="">업종선택</option>
						<c:forEach items="${industryAttrList}" var="industry" varStatus="qStatus">
							<option value="${industry.industryCd}">${industry.name}</option>  
						</c:forEach>
						</select>
					</td>
					<td headers="board_memid">
			<select id="masterCd" name="masterCd" >
				<option value="">점검표선택</option>
			</select>
					</td>
				</tr>
	        </tbody>
      </table>

			<div class="board_btn_set mt13">
	<span class="btn_del"><input type="submit" value="등록하기" /></span>
			</div>
	</form>
</body>
</html>
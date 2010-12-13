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

</head>
<body style="background:none;padding:10px;">
<h3 class="tit_03">모범업소지정신청</h3>

				<table class="default_list" cellspacing="1" cellpadding="0" width="600">
				<colgroup>
						<col width="80" />
						<col width="100" />
						<col width="100" />
						<col width="100" />
						<col width="130" />
						<col width="*" />
					</colgroup>
					<thead>
					<tr>
						<th id="board_num">번호</th>
						<th id="board_memid">이미지</th>
						<th id="board_birthday">이름</th>
						<th id="board_regedit">상담진료과목</th>
						<th id="board_regedit">의료기관명</th>
						<th id="board_regedit">권한</th>
						<th id="board_regedit">게시판보기</th>
					</tr>
					</thead>

		<!-- ##### 공지글 시작 ##### -->
				<tbody>
					<c:if test="${fn:length(resultList) > 0}" >
					<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}">  
					<tr>
						<td headers="board_num">${fn:length(resultList) - x}</td>
						<td headers="board_memid"><a href="/admin/health/medicalTeam/updateMedicalTeamPage.do?no=${resultList[x].no}"><img src="/health/open_content/images/medicalTeam/${resultList[x].imgNm}"/></a></td>
						<td headers="board_memid"><span style="font-weight:bold"><a href="/admin/health/medicalTeam/updateMedicalTeamPage.do?no=${resultList[x].no}">${resultList[x].name}</a></span></td>
						<td headers="board_linktype">${resultList[x].subject}</td>
						<td headers="board_create">${resultList[x].institution}</td>
						<td headers="board_create">ROLE_MT${resultList[x].no}</td>
						<td><a href="/admin/health/application/selectApplicationList.do?applyCode=RELY0001&petiGubun=${resultList[x].no}">게시판보기</a></td>
					</tr>
					</c:forEach>
					</c:if>
					<c:if test="${fn:length(resultList) == 0}" >
					<tr><td colspan="6">데이터가 없습니다</td></tr>
					</c:if>
		        </tbody>
      </table>

			<div class="board_btn_set mt13">
				<span class="btn_del"><a href="/admin/health/medicalTeam/addMedicalTeamPage.do">등록하기</a></span>
			</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("crlf", "\r\n"); %>	
<HTML>
<HEAD>
<TITLE> ${result.title} </TITLE>
<style>

	body { width:100%; padding:0px; margin:0px; text-align:center; font-size: 12pt; font-family: '굴림'; }
	/*
	.cb { clear:both; }
	.fl { float:left; }
	.b_set { border:1px solid gray; 
				margin-left:2px; 
				margin-right:2px; 
				margin-bottom:2px; 
	}

	.set_menu {
		height:30px;
		border:1px solid gray;
		padding-top:6px;
		margin:3px;
		cursor:pointer;
	}
	
	#top { 
		width:1000px; 
		margin:0px; 
		padding:0px; 
		height:100px;
	}

	#center {
		width:1000px;
		margin:0px;
		padding:0px;
		margin-top:5px;
	}

	#center #c_left {
		width:150px;
		margin:0px;
		padding:0px;
		float:left;
		border:1px solid gray;
	}

	#center #c_right {
		width:850px;
		margin:0px;
		padding:0px;
		float:left;
	}
	*/
</style>

<SCRIPT LANGUAGE="JavaScript">
<!--
	mouseOver = function( obj ) {
		obj.style.backgroundColor = '#B7B7B7';
	}

	mouseOut = function( obj ) {
		obj.style.backgroundColor = '';
	}

	overlapRemove = function( arr ) {
		var returnArray = new Array();
		for( var i = 0 ; i < arr.length ; i++ ) {
			var chkOverlap = 0;

			for( var j = 0 ; j < arr.length ; j++ ) {
				if( arr[i] != arr[j] ) {
					continue;
				}

				chkOverlap++;

				if( chkOverlap > 1 ) {
					arr.splice(j,1);
				}
			}
		}
		return arr;
	}

	notChk = function() {
		var useItem = document.getElementsByName("useItem[]");
		var notSunbun = document.getElementsByName("userItemNotSunbun[]");
		var viewGbn = document.getElementsByName("viewGbn[]");
		var notChk = new Array();

		if( showMenu() ) {
			//alert("향정신성의약품 취급현황을 작성하기 전에 필히 저장하여 주십시오.");
			document.getElementById("menu3").style.display = "";
		} else {
			document.getElementById("menu3").style.display = "none";
		}

		for( var i = 0 ; i < useItem.length ; i++ ) {
			if( useItem[i].checked ) {
				for( var j = 0 ; j < notSunbun[i].value.split(",").length; j++ ) {
					if( notSunbun[i].value.split(",")[j] != "" ) {
						if( viewGbn[i].value == "Y" ) {
							notChk.push(notSunbun[i].value.split(",")[j]);
						}
					}
				}
			} else {
				if( viewGbn[i].value == "N" ) {
					for( var j = 0 ; j < notSunbun[i].value.split(",").length; j++ ) {
						if( notSunbun[i].value.split(",")[j] != "" ) {
							notChk.push(notSunbun[i].value.split(",")[j]);
						}
					}
				}
			}

			for( var j = 0 ; j < notSunbun[i].value.split(",").length; j++ ) {
				if( notSunbun[i].value.split(",")[j] != "" ) {
					document.getElementById("chk_"+notSunbun[i].value.split(",")[j]).style.display = "";
					document.getElementById("notChk_"+notSunbun[i].value.split(",")[j]).style.display = "none";
					if( document.getElementsByName(notSunbun[i].value.split(",")[j]+"_chkRes")[2].checked ) {
						document.getElementsByName(notSunbun[i].value.split(",")[j]+"_chkRes")[1].checked = true;
					}
				}
			}
		}

		
		notChk = overlapRemove( notChk );
		//alert(notChk);
		for( var i = 0 ; i < notChk.length ; i++ ) {
			document.getElementById("chk_"+notChk[i]).style.display = "none";
			document.getElementById("notChk_"+notChk[i]).style.display = "";
			document.getElementsByName(notChk[i]+"_chkRes")[2].checked = true;
/*
			if( document.getElementById("chk_"+notChk[i]).style.display == "" ) {
				document.getElementById("chk_"+notChk[i]).style.display = "none";
				document.getElementById("notChk_"+notChk[i]).style.display = "";
				document.getElementsByName(notChk[i]+"_chkRes")[2].checked = true;
			} else {
				document.getElementById("chk_"+notChk[i]).style.display = "";
				document.getElementById("notChk_"+notChk[i]).style.display = "none";
				document.getElementsByName(notChk[i]+"_chkRes")[1].checked = true;
			}*/
		}
	}

	showMenu = function() {
		var useItem = document.getElementsByName("useItem[]");
		var usePage = document.getElementsByName("usePage[]");

		for( var i = 0 ; i < useItem.length ; i++ ) {
			if( useItem[i].checked ) {
				if( usePage[i].value == "Y" ) {
					return true;
				}
			}
		}
		return false;
	}

	chkForm = function(f) {
		var tempItem = document.getElementsByName("useItem[]");
		var arrItem = new Array();
		
		for( var i = 0 ; i < tempItem.length ; i++ ) {
			if( tempItem[i].checked ) {
				arrItem.push(tempItem[i].value);
			}
		}
		f.useItem.value = arrItem;

		for( var i = 0 ; i < arrItem.length ; i++ ) {
			
		}
		
		f.method = "post";
		f.action = "./report_result.php";
		f.submit();
	}

	userMod = function(f) {

		f.method = "post";
		f.action = "./user_action.php";
		f.submit();
	}

	radioChk = function( f ) {
		var input = document.getElementsByTagName("INPUT");
		var chkRadio = false;
		for( var i = 0 ; i < input.length ; i++ ) {
			if( input[i].type == "radio" ) {
				var radio = document.getElementsByName( input[i].name );
				for( var j = 0 ; j < radio.length ; j++ ) {
					if( radio[j].checked ) {
						chkRadio = true;
						break;
					}
				}

				if( !chkRadio ) {
					alert("모든 항목은 체크하셔야 합니다.");
					return false;
				}
				chkRadio = false;
			}
		}
		
		var tempItem = document.getElementsByName("useItem[]");
		var arrItem = new Array();
		
		for( var i = 0 ; i < tempItem.length ; i++ ) {
			if( tempItem[i].checked ) {
				arrItem.push(tempItem[i].value);
			}
		}
		f.useItem.value = arrItem;

		f.method = "post";
		f.action = "./report_result.php?allChk=Y";
		f.submit();
	}

	conf = function( f ){
		sure = confirm("이상 점검한 내용을 제출합니다");
		if(sure){		radioChk(document.myform); }
		else return false;
	}

	var initBody 
    function beforePrint(){ 
        initBody = document.body.innerHTML; 
        document.body.innerHTML = pnt_dv.innerHTML; 
    } 
    function afterPrint(){ 
        document.body.innerHTML = initBody; 
    } 
    function printArea() { 
        window.print(); 
    } 
        window.onbeforeprint = beforePrint; 
        window.onafterprint = afterPrint; 

//-->
</SCRIPT>
</HEAD>

<BODY>

<style>
#fRoot { width:978px; }
#fTitle { font-weight:bold; font-size:30px; }
#fTitle_sub { font-weight:bold; font-size:18px; margin-top:8px; }
#fTitle_info { font-weight:bold; font-size:16px; text-align:left; margin-top:20px; margin-bottom:10px; }
#tRoot { border-collapse: collapse; border-color:black; width:978px; text-align:center; border-style:solid; }
.titleName { width:150px; }
.titleField { width:339px; }
input { border:1px solid gray; }
</style>
  <br>
	<div style="display:"; align="right">
		<input type="button" name="Button" value=" 인 쇄 " class="input01" style="cursor:hand; height:20;width:80"  onclick="javascript:printArea();">
		<input type="button" name="Button" value=" 닫  기 " class = "input01" style = "cursor:hand; hegith:20; width:80" onclick="javascript:self.close();">&nbsp;&nbsp;&nbsp;&nbsp;
	</div><br>

<div id = pnt_dv>
<div id="fRoot" style ="width:978px" >
	<div id="fTitle" style = "font-weight:bold; font-size:30px"><U>${result.title}</U></div>
	<div id="fTitle_sub" style = "font-weight:bold; font-size:18px; margin-top:8px;">( 업소보관용 )</div>
	<div id="fTitle_info" style = "font-weight:bold; font-size:16px; text-align:left; margin-top:20px; margin-bottom:10px">
	※ 대표자께서 직접 검검하시고 점검결과 란에 <u>직접 기재</u>하십시오<br/>
	<font color="red">익스플로러6의 경우, 용지를 가로로 설정해서 출력하여 주십시오.</font>
	</div>
</div>
<div ID="center" style="margin-top:2px">
<form name="userInfoFrm" style="margin:0px; padding:0px">
<input type="hidden" name="url" value="/site/medicine/php/p_view.php">
<input type="hidden" name="mode" value="update">
<!-- 약국 -->
		<table cellpadding="0" cellspacing="0" border="1" id="tRoot" bordercolor="black" style="border-collapse: collapse; border-color:black; width:978px; text-align:center; border-style:solid">
			<tr>
				<td colspan="9" style="height:30px; font-size:18px; font-weight:bold; background-color:#EFEFEF">신 고 사 항</td>
			</tr>
			<tr height="25">
				<td class="titleName">상&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;호</td>
				<td class="titleField"><input type="text" style="width:250px" name="userComName" value="${answer.SANGHO_NAME}"></td>
				<td class="titleName">등&nbsp;&nbsp;록&nbsp;&nbsp;번&nbsp;&nbsp;호</td>
				<td class="titleField">제 <input type="text" style="width:100px;" name="userLeaveNum" value="${answer.NUMBER1}"> 호</td>
			</tr>
			<tr height="25">
				<td >대&nbsp;&nbsp;&nbsp;표&nbsp;&nbsp;&nbsp;자</td>
				<td><input type="text" style="width:250px" name="userName" value="${answer.NAME1}"></td>
				<td >전 화 번 호</td>
				<td><input type="text" style="width:250px" name="userTel" value="${answer.TEL}"></td>
			</tr>
			<tr height="25">
				<td >소&nbsp;&nbsp;&nbsp;재&nbsp;&nbsp;&nbsp;지</td>
				<td><input type="text" style="width:250px" name="userFax" value="${answer.ADDR1}"></td>
				<td >홈페이지주소</td>
				<td><input type="text" style="width:250px;" name="userHomePage" value="${answer.HOMEPAGE}"></td>
			</tr>
		<c:if test="${company.divide_cd == 'k01'}">
			<tr height="25">
				<td>종 업 원 수</td>
				<td>
					<table cellpadding="0" cellspacing="0" width="100%" style="text-align:center">
						<tr height="24">
							<td>근무약사</td>
							<td><input type="text" style="width:30px" name="userOtherNum" value="${answer.CNT1 == null ? 0 : answer.CNT1}">명</td>
							<td>종업원</td>
							<td><input type="text" style="width:30px" name="userOtherNum2" value="${answer.CNT2 == null ? 0 : answer.CNT2}">명</td>
						</tr>
					</table>
				</td>
				<td >한약조제자격번호</td>
				<td>
					<table cellpadding="0" cellspacing="0" width="100%" style="text-align:center">
						<tr height="24">
							<td>개설약사</td>
							<td>( <input type="text" style="width:50px" name="userOtherRegNum" value="${answer.OTHER2 == '' ? 0 : answer.OTHER2}"> )</td>
							<td>근무약사</td>
							<td>( <input type="text" style="width:50px" name="userOtherRegNum2" value="${answer.OTHER3 == '' ? 0 : answer.OTHER3}"> )</td>
						</tr>
					</table>
				</td>
			</tr>
		</c:if>
		<c:if test="${company.divide_cd == 'k04' || company.divide_cd == 'k06'}">
			<tr height="25">
				<td><label for="etc17">생물학적제제취급</label></td>
				<td class="output">
					<label for="etc17"><input id="etc17" name="article1_yn" type="radio" class="vam" value="Y" <c:if test="${answer.ARTICLE1_YN == 'Y'}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>예</label>&nbsp;&nbsp;
					<label for="etc19"><input id="etc19" name="article1_yn" type="radio" class="vam" value="N" <c:if test="${answer.ARTICLE1_YN == 'N'}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>아니오</label>
				</td>
				<td><label for="name2">도매업무관리자</label></td>
				<td class="output">
					<label for="name2">성명 <input type="text" id="name2" name="name2" style="width:100px" class="t_text vam" value="${answer.NAME2}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/></label>
					<label for="number3">면허번호 <input id="number3" name="number3" type="text" style="width:60px" class="t_text vam" value="${answer.NUMBER3}" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/></label>
				</td>
			</tr>
		</c:if>
		<c:if test="${fn:length(itemList) > 0}">
			<tr height="25">
				<td colspan='0'>취급품목</td>
				<td colspan='10' style='text-align:left; padding-left:5px'>
					<c:forEach items="${itemList}" var="item" varStatus="qStatus">	
						<label for="etc${qStatus.count}"><input id="etc${qStatus.count}" title="취급품목" type="checkbox" class="vam" name="item" value="${item.itemName}" <c:if test="${fn:contains(answer.OTHER5, item.itemName)}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>${item.itemName}</label> 
					</c:forEach>
				</td>
			</tr>
		</c:if>
		</table>

</form>
</div>


<div ID="center" style="margin-top:2px">
	<form name="myform" style="font-size:0px; margin:0px ; padding:0px">
	<input type="hidden" name="infoseq" value="17">
	<input type="hidden" name="useItem" value="">
	<input type="hidden" name="mode" value="insert">
	<input type="hidden" name="url" value="/site/medicine/php/p_view.php">
	<table cellpadding="0" cellspacing="0" border="1" style="border-collapse: collapse; border-color:black;table-layout:fixed">
		<tr height="35" valign="middle" align="center" style="background-color:#EFEFEF">
			<td style="width:715px;"><span style="font-size:16px">점 검 사 항</span></td>
			<td style="width:130px"><span style="font-size:16px">점검결과(1~6월)</span></td>
			<td style="width:130px"><span style="font-size:16px">점검결과(7~12월)</span></td>
		</tr>

				<c:if test="${fn:length(questionList) > 0}">
					<c:forEach items="${questionList}" var="questionItem" varStatus="qStatus">		
		<tr>
			<td style="width:715px;">
				<div style="float:left; margin-top:8px; margin-left:8px; margin-bottom:8px;">${qStatus.count}. </div>
				<div  style="float:left" style="margin-top:8px; margin-left:5px; margin-right:5px; margin-bottom:8px; word-break:break-all;">${fn:replace(questionItem.QUESTION,crlf,"<br/>")}</div>
			</td>
			
			<td style="width:130px; display:none" align="center"><div id="chk_1" style="display:"><input type="radio" name="1_chkRes" value="Y" > 예 <input type="radio" name="1_chkRes" value="N" > 아니오 <input type="radio" style="display:none" name="1_chkRes" value="S" ></div><div id="notChk_1" style="display:none">해당사항 없음</div></td>
			<td style="width:130px; display:" align="center">&nbsp;
										<c:choose>
											<c:when test="${questionItem.QUEST_TYPE_CD == 'B'}">
			${questionItem.OTHER}
											</c:when>
											
											<c:otherwise>
												<c:forEach items="${questionItem.answerList}" var="answerItem" varStatus="aStatus">
														<c:if test="${fn:indexOf(questionItem.QUESTION2_CD, answerItem.QUESTION2_CD) >= 0}">
			${answerItem.QUESTION2}
														</c:if>
												</c:forEach>
											</c:otherwise>
										</c:choose>
			</td>
			<td style="width:130px; " align="center">&nbsp;</td>
		</tr>
				</c:forEach>
			</c:if>
		
		<tr>
			<td colspan="3" style="">
				<p style="font-weight:bold; width:99%; word-break:break-all; text-align:left; margin-left:10px;margin-top:3px">
				<!-- 상기 자율점검 내용은 사실과 틀림없으며, 만약 위의 점검사항과 다르거나 위반사항이 있을 경우 관계규정에 의한 행정처분을 감수하겠습니다. -->상기 자율점검 내용은 사실과 틀림없으며, 만약 위의 점검사항과 다르거나 위반사항이 있을 경우 약사법등 관계규정에 의한 행정처분을 감수하겠습니다.
				</p>
				<p style="text-align:center;">
				2011. &nbsp;&nbsp;. &nbsp;&nbsp;<br>
                위 점검자 (대표자)&nbsp;&nbsp; <b>${answer.NAME1}</b> &nbsp;&nbsp;(인)
				</p>
				<p style="font-weight:bold; font-size:1.5em; margin-left:10px">금천구보건소장 귀하</p>

※ 이하공란(보건소 기재)

			</td>
		</tr>

	</table>
	</form><br>
<div ID="center" style="margin-top:2px">
	<form name="talkAbout" style="margin:0px; padding:0px">
		<input type="hidden" name="url" value="/site/medicine/php/p_view.php">
		<input type="hidden" name="mode" value="update">
		<!-- 마약류 자율점검표 -->
		<table cellpadding="0" cellspacing="0" border="1" id="tRoot"  bordercolor="black" topmargin="0" style="border-collapse: collapse; border-color:black; width:978px; text-align:center; border-style:solid">
			<tr><td style="height:30px; font-size:14px; font-weight:bold; background-color:#EFEFEF" colspan= "5">
			<b>점&nbsp;&nbsp;검&nbsp;&nbsp;자</b></tr>
			</td>
			<tr>
				<td style="height:30px; font-size:14px; text-align:center;"> 점 검 일 자</td>
				<td style="height:30px; font-size:14px; text-align;center;">소&nbsp;&nbsp;&nbsp;속</td>
				<td style="height:30px; font-size:14px; text-align:center;">직&nbsp;&nbsp;&nbsp;위</td>
				<td style="height:30px; font-size:14px; text-align:center;">성&nbsp;&nbsp;&nbsp;명</td>
				<td style="height:30px; font-size:14px; text-align:center;">점&nbsp;검&nbsp;결&nbsp;과</td>
			</tr>
				<tr>
				<td style="height:30px; font-size:14px; text-align:center;"></td>
				<td style="height:30px; font-size:14px; text-align:center;">&nbsp;&nbsp;&nbsp;</td>
				<td style="height:30px; font-size:14px; text-align:center;">&nbsp;&nbsp;&nbsp;</td>
				<td style="height:30px; font-size:14px; text-align:center;">&nbsp;&nbsp;&nbsp;</td>
				<td style="height:30px; font-size:14px; text-align:center;">&nbsp;&nbsp;&nbsp;</td>
			</tr>
				<tr>
				<td style="height:30px; font-size:14px; text-align:center;"></td>
				<td style="height:30px; font-size:14px; text-align:center;">&nbsp;&nbsp;&nbsp;</td>
				<td style="height:30px; font-size:14px; text-align:center;">&nbsp;&nbsp;&nbsp;</td>
				<td style="height:30px; font-size:14px; text-align:center;">&nbsp;&nbsp;&nbsp;</td>
				<td style="height:30px; font-size:14px; text-align:center;">&nbsp;&nbsp;&nbsp;</td>
			</tr>
				<tr>
				<td style="height:30px; font-size:14px; text-align:center;"></td>
				<td style="height:30px; font-size:14px; text-align:center;">&nbsp;&nbsp;&nbsp;</td>
				<td style="height:30px; font-size:14px; text-align:center;">&nbsp;&nbsp;&nbsp;</td>
				<td style="height:30px; font-size:14px; text-align:center;">&nbsp;&nbsp;&nbsp;</td>
				<td style="height:30px; font-size:14px; text-align:center;">&nbsp;&nbsp;&nbsp;</td>
			</tr>

		</table>
	</form>
</div>
</div>
</div>


</BODY>
</HTML>


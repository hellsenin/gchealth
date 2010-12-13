<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
//<![CDATA[
	function print(printThis){
		win = window.open();
		self.focus();
		win.document.open();
		win.document.write('<'+'html'+'><'+'head'+'>');

		win.document.write('<link href='+'/health/open_content/system/css/default.css'+' rel='+'stylesheet'+' type='+'text/css'+' />');
		win.document.write('<link href='+'/health/open_content/system/css/common.css'+' rel='+'stylesheet'+' type='+'text/css'+' />');


		//win.document.write('<style>td,th{font-size:0.75em;}</style>');
		win.document.write('<'+'/'+'head'+'><'+'body'+' style="background:none;"><br /><br />');
		win.document.write(printThis);
		win.document.write('<'+'/'+'body'+'><'+'/'+'html'+'>');
		win.document.close();
		win.print();
		win.close();
	}
//]]>
</script>

<div class="comment_box">
<div class="comment_box_top"></div>
<div class="comment_box_in">
	<ul class="list">
		<li>아기의 출생일을 선택하신 후 검색 버튼을 누르시면 우리 아기의 <strong>표준예방접종일</strong>을 확인 할 수 있습니다.</li>
	</ul>
</div>
<div class="comment_box_bottom"></div>
</div>

<form name="frm" action="/health/schedule/selectArticleBabySchedule.do?categoryId=${param.categoryId}" method="post" >
<div class="board_top clearfix">
    <fieldset class="fl_r mb05">
        <legend>아기출생일 검색</legend>
        <strong class="h5">아기출생일</strong>
        <select name="selYear" title="년 선택">
        	<c:forEach var ="i" begin="${todayYear-13}" end = "${todayYear}">
        		<option value="${i}" <c:if test="${i ==  todayYear}">selected="selected"</c:if>>${i} </option>
        	</c:forEach>
        </select> 년
        
        <select name="selMonth" title="월 선택">
        	<c:forEach var ="i" begin="1" end = "12">
        		<option value="${i}" <c:if test="${i ==  todayMonth}">selected="selected"</c:if>>${i} </option>
        	</c:forEach>
        </select> 월
        
        <select name="selDay" title="일 선택">
        	<c:forEach var ="i" begin="1" end = "31">
        		<option value="${i}" <c:if test="${i ==  todayDay}">selected="selected"</c:if>>${i} </option>
        	</c:forEach>
        </select> 일
        <input type="image" src="/health/open_content/images/borad/btn_search.gif" alt="검색" />
    </fieldset>
</div>
</form>

<div id="subContent">
<table border="0" class="vaccine_tbl" summary="0개월, 1개월, 2개월, 4개월, 6개월, 12개월, 15개월, 18개월, 24개월, 36개월, 만4세, 만11세, 만12세" style="width:650px;">
<caption>
연령별 대상전염병 예방접종일 확인
</caption>
  <tr>
	<th width="10%" class="t no_bl">대상전염병</th>
	<th>0개월</th>
	<th>1개월</th>
	<th>2개월</th>
	<th>4개월</th>
	<th>6개월</th>
	<th>12개월</th>
	<th>15개월</th>
	<th>18개월</th>
	<th>24개월</th>
	<th>36개월</th>
	<th>만4세</th>
	<th>만6세</th>
	<th>만11세</th>
	<th>만12세</th>
  </tr>
  <tr>
	<td class="title">결핵</td>
	<td colspan="2" class="cell">1회</td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
  </tr>
  <tr>
	<td class="title">B형간염</td>
	<td class="cell">1차</td>
	<td class="cell">2차</td>
	<td></td>
	<td></td>
	<td class="cell">3차</td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
  </tr>
  <tr>
	<td class="title">DTaP<br />
	  (디프테리아, 파상풍, 백일해)</td>
	<td></td>
	<td></td>
	<td class="cell">1차</td>
	<td class="cell">2차</td>
	<td class="cell">3차</td>
	<td></td>
	<td colspan="2" class="cell">4차(추가1)</td>
	<td></td>
	<td></td>
	<td colspan="2" class="cell">5차(추가2)</td>
	<td></td>
	<td></td>
  </tr>
  <tr>
	<td class="title">Td<br />
	  (파상풍, 디프테리아)</td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td colspan="2" class="cell">Td6차(추가3)</td>
	</tr>
  <tr>
	<td class="title">폴리오<br />
	  (소아마비)</td>
	<td></td>
	<td></td>
	<td class="cell">1차</td>
	<td class="cell">2차</td>
	<td class="cell">3차</td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td colspan="2" class="cell">4차(추가)</td>
	<td></td>
	<td></td>
  </tr>
  <tr>
	<td class="title">MMR<br />
	  (홍역, 유행성이하선염,풍진)</td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td colspan="2" class="cell">1차</td>
	<td></td>
	<td></td>
	<td></td>
	<td colspan="2" class="cell">2차</td>
	<td></td>
	<td></td>
  </tr>
  <tr>
	<td class="title">일본뇌염</td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td colspan="4" class="cell">1차. 1주일후 2차</td>
	<td class="cell">3차</td>
	<td></td>
	<td class="cell">4차</td>
	<td></td>
	<td class="cell">5차</td>
  </tr>
  <tr>
	<td class="title">수두</td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td colspan="2" class="cell">1차</td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
  </tr>
</table>
</div>
<br>

<div><a href="#print" onclick="print(document.getElementById('subContent').innerHTML);" onkeypress="if(event.keyCode==13) {this.onclick(); return false;}"><img src="/health/open_content/images/borad/btn_print.gif" alt="프린트" /></a></div>

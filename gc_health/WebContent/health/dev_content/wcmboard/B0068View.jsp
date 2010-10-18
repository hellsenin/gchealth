<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	
<div class="comment_box">
<div class="comment_box_top"></div>
<div class="comment_box_in" style="background:url(/health/open_content/images/comment/comment_img_001.gif) 470px top no-repeat;">
    <ul class="list">
        <li class="tit"><img src="/health/open_content/images/comment/comment_tit_01010201.gif" alt="신청.신고 내용은 본인만 확인이 가능합니다." /></li>
        <li>민원 신청, 신고 내용에는 개인정보를 기재하지 않습니다.</li>
        <li>저속한 표현이나, 타인의 명예훼손, 비방, 반사회적인 글, 영리목적의 광고글 및 <br />홈페이지 운영 목적에 부적합 내용등은 사전 양해 없이 관리자에 의해 삭제될 수 있습니다.
</li>
        <li>파일을 첨부하실 경우 첨부파일명은 영문으로 올려주시기 바라며, 용량은 5MB 이하로 <br />등록하여 주시기 바랍니다. 
</li>
    </ul>
</div>
<div class="comment_box_bottom"></div>
</div>

<div style="margin:0 0 40px 0;">
<table class="data_table" summary="사무명, 관련부서, 처리부서, 지도감독, 주무기관, 처리과정, 신청방법, 구비서류, 근거법규, 서식">
  <caption>
    민원 사무 서식
  </caption>
  <thead>
    <tr>
      <th width="15%" rowspan="2" scope="col">사무명</th>
      <th colspan="2" rowspan="2" scope="col">${result.title}</th>
      <th width="15%" rowspan="2" scope="col">관련부서</th>
      <th scope="col">처리부서</th>
      <th scope="col">지도감독</th>
      <th scope="col" class="no_br">주무기관</th>
    </tr>
    <tr>
      <th scope="col">${result.position}</th>
      <th scope="col">${empty result.etc1 ? '-' :  result.etc1}</th>
      <th scope="col" class="no_br">${empty result.etc2 ? '-' :  result.etc2}</th>
      </tr>
  </thead>
  <tbody>
    <tr>
      <td rowspan="7" class="title">처리과정</td>
      <td width="15%" class="title">접수처</td>
      <td width="20%">경유처</td>
      <td class="title">처분청</td>
      <td>${empty result.etc3 ? '-' :  result.etc3}</td>
      <td>${empty result.etc4 ? '-' :  result.etc4}</td>
      <td class="no_br">${empty result.etc5 ? '-' :  result.etc5}</td>
      </tr>
    <tr>
      <td class="title">대조공부</td>
      <td></td>
      <td class="title">비치대장</td>
      <td>${empty result.etc6 ? '-' :  result.etc6}</td>
      <td>${empty result.etc7 ? '-' :  result.etc7}</td>
      <td class="no_br">${empty result.etc8 ? '-' :  result.etc8}</td>
    </tr>
    <tr>
      <td class="title">최종결재</td>
      <td></td>
      <td class="title">수수료</td>
      <td>${empty result.etc9 ? '-' :  result.etc9}</td>
      <td>${empty result.etc10 ? '-' :  result.etc10}</td>
      <td class="no_br">${empty result.etc11 ? '-' :  result.etc11}</td>
    </tr>
    <tr>
      <td class="title">현장조사사항</td>
      <td colspan="5" class="no_br">${empty result.etc12 ? '-' :  result.etc12}</td>
      </tr>
    <tr>
      <td class="title">처리요건</td>
      <td colspan="5" class="no_br">${empty result.etc13 ? '-' :  result.etc13}</td>
      </tr>
    <tr>
      <td class="title">후속민원</td>
      <td colspan="5" class="no_br">${empty result.etc14 ? '-' :  result.etc14}</td>
      </tr>
    <tr>
      <td class="title">처리흐름</td>
      <td colspan="5" class="no_br">${empty result.etc15 ? '-' :  result.etc15}</td>
      </tr>
    <tr>
      <td class="title">신청방법</td>
      <td>${empty result.etc16 ? '-' :  result.etc16}</td>
      <td></td>
      <td class="title">신청하기</td>
      <td colspan="3" class="no_br">
         	<c:choose>
         		<c:when test="${empty result.etc21}">-</c:when>
         		<c:when test="${result.etc21 == '1'}"><a href="http://www.g4c.go.kr" target="_blank"><img src="http://www.geumcheon.go.kr/open_content/images/common/icon/icon_g4c.gif" alt="전자민원 G4C" /></a></c:when>
         		<c:when test="${result.etc21 == '2'}"><a href="http://www.scourt.go.kr" ><img src="http://www.geumcheon.go.kr/open_content/images/common/icon/icon_supreme_court.gif" alt="대법원" /></a></c:when>
         		<c:when test="${result.etc21 == '3'}"><a href="http://www.eais.go.kr" target="_blank"><img src="http://www.geumcheon.go.kr/open_content/images/common/icon/icon_seum.gif" alt="새움터" /></a></c:when>
         	</c:choose>
      </td>
      </tr>
    <tr>
      <td class="title">구비서류</td>
      <td colspan="6" class="no_br">${empty result.etc18 ? '-' :  result.etc18}</td>
      </tr>
    <tr>
      <td class="title">근거법규</td>
      <td colspan="6" class="no_br">${empty result.etc19 ? '-' :  result.etc19}</td>
      </tr>
    <tr>
      <td class="title">처리요령 및 <br />
        유의사항</td>
      <td colspan="6" class="no_br">${empty result.etc20 ? '-' :  result.etc20}</td>
      </tr>
    <tr>
      <td class="title">서식</td>
      <td colspan="6" class="no_br">
      	<c:forEach var="file" items="${fileList}">
      	<a href="http://www.geumcheon.go.kr/cms/board/Download.jsp?fileId=${file.fileAppdId}" >${file.appdFileName}</a>&nbsp;(${file.fileSize} Bytes) <br/>
      	</c:forEach>
      </td>
      </tr>
  </tbody>
</table>
</div>
<div class="board_btn_set send_mg"> <span class="register"><a href="/health/wcmboard/selectWcmboardList.do?communityId=${param.communityId}&amp;healthPosition=1&categoryId=${param.categoryId}&amp;pageIndex=${param.pageIndex}">목록보기</a></span></div>



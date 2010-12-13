<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 메뉴검색 영역 시작 -->

	<div class="result_box1">
		<h4><strong>메뉴검색</strong> (해당 검색어에 대한 검색결과가 <strong>${menuListCnt}</strong>건입니다)</h4>
		<ul class="result_list1">
			<c:if test="${fn:length(menuList)>0}">
		 	<c:forEach var="x" begin="0" end="${fn:length(menuList)-1}">
			<li>
				<p class="result_text"><a href="${menuList[x].fullMenuLink}">${menuList[x].name}</a></p>
				<p class="result_link">
					<a href="${menuList[x].fullMenuLink}" class="blank" title="검색결과 새창보기" target="_blank">http://bogunso.geumcheon.go.kr${menuList[x].fullMenuLink}</a>
					<span>|</span>
					<a href="${menuList[x].fullMenuLink}">[현재창에서보기]</a>
				</p>
			</li>
			</c:forEach>
			</c:if>
		</ul>


		<div class="result_more">
			<a href="#search_tab" onclick="javascript:goMore('1');" class="more">메뉴검색 검색결과 더보기</a>
			<span>|</span>
			<a href="#container" class="top">맨위로</a>
		</div>

	</div>




<!-- 메뉴검색 영역 끝 -->


<!-- 게시판 영역 시작 -->

	<div class="result_box1">
		<h4><strong>게시판</strong> (해당 검색어에 대한 검색결과가 <strong>317</strong>건입니다)</h4>
		<ul class="result_list1">

			<li>
				<dl>
					<dt><a href="http://www.geumcheon.go.kr/board.do?communityKey=B0020&pageKey=03040101&boardId=4516&act=VIEW">행정사무감사와 구의회 방청 소감(회원 글)</a></dt>
					<dd class="result_text">
						<a href="http://www.geumcheon.go.kr/board.do?communityKey=B0020&pageKey=03040101&boardId=4516&act=VIEW">... 4. 진정 긴장한 것은 구의원들? - 구청 직원의 태도는 너무 불성실하고 구의원들은 오히려 긴장 5. 너무나 짧은 감사와 <strong>구정</strong>질문 시간 (특히 <strong>구정</strong>질문은 채 1-2 시간을 채우지 못함 6. 주민에 홍보를 못하는 이유는 본회의장 방청석이 좁아서일까? (불성실한 감사와 회의를 주민 ... </a>
					</dd>
					<dd class="location">금천구청>함께하는 참여광장>이야기마당>자유게시판</dd>
					<dd class="result_link">
						<a href="http://www.geumcheon.go.kr/board.do?communityKey=B0020&pageKey=03040101&boardId=4516&act=VIEW" class="blank" title="검색결과 새창보기" target="_blank">http://www.geumcheon.go.kr/board.do?communityKey=B0020&pageKey=03040101&boardId=4516&act=VIEW</a>
						<span>|</span>
						<a href="http://www.geumcheon.go.kr/board.do?communityKey=B0020&pageKey=03040101&boardId=4516&act=VIEW">[현재창에서보기]</a>
					</dd>
				</dl>
			</li>

			<li>
				<dl>
					<dt><a href="http://www.geumcheon.go.kr/board.do?communityKey=B0036&pageKey=05030101&boardId=1146&act=VIEW">생활 속 생생 아이디어로‘함께 행복한 금천구’만들어요.</a></dt>
					<dd class="result_text">
						<a href="http://www.geumcheon.go.kr/board.do?communityKey=B0036&pageKey=05030101&boardId=1146&act=VIEW">... 8월 22일까지 <strong>구정</strong>혁신 아이디어 공모 실시 - 금천구(구청장 차성수)는 생활 속 생생한 아이디어를 <strong>구정</strong>에 반영하여 수요자 중심의 맞춤형 행정서비스를 제공하여 ‘함께 행복한 금천구’를 만들고자 이달 23일부터 8월 22일까지 민선5기 <strong>구정</strong>운영의 기틀이 될 ... </a>
					</dd>
					<dd class="location">금천구청>희망도시 금천소식>보도>해명자료</dd>
					<dd class="result_link">
						<a href="http://www.geumcheon.go.kr/board.do?communityKey=B0036&pageKey=05030101&boardId=1146&act=VIEW" class="blank" title="검색결과 새창보기" target="_blank">http://www.geumcheon.go.kr/board.do?communityKey=B0036&pageKey=05030101&boardId=1146&act=VIEW</a>
						<span>|</span>
						<a href="http://www.geumcheon.go.kr/board.do?communityKey=B0036&pageKey=05030101&boardId=1146&act=VIEW">[현재창에서보기]</a>
					</dd>
				</dl>
			</li>

			<li>
				<dl>
					<dt><a href="http://www.geumcheon.go.kr/board.do?communityKey=B0020&pageKey=03040101&boardId=15317&act=VIEW">금천<strong>구정</strong>지기단(준) 제5차 정기회의 보고</a></dt>
					<dd class="result_text">
						<a href="http://www.geumcheon.go.kr/board.do?communityKey=B0020&pageKey=03040101&boardId=15317&act=VIEW">... 한다. 시흥지역과 독산지역으로 나누어 같은 내용을 2차 실시하며, 직작인을 위한 저녁 혹은 주말 교육도 고려한다. - 대상 금천구민중 <strong>구정</strong>에 관심있는 구민대상 적극적ㅇ니 홍보와 캠페인 등을 통해 교육을 알리며, 교육참여자는 철저하게 조직적으로 모은다. (회원단체 회원, 부녀회 등 지역 ... </a>
					</dd>
					<dd class="location">금천구청>함께하는 참여광장>이야기마당>자유게시판</dd>
					<dd class="result_link">
						<a href="http://www.geumcheon.go.kr/board.do?communityKey=B0020&pageKey=03040101&boardId=15317&act=VIEW" class="blank" title="검색결과 새창보기" target="_blank">http://www.geumcheon.go.kr/board.do?communityKey=B0020&pageKey=03040101&boardId=15317&act=VIEW</a>
						<span>|</span>
						<a href="http://www.geumcheon.go.kr/board.do?communityKey=B0020&pageKey=03040101&boardId=15317&act=VIEW">[현재창에서보기]</a>
					</dd>
				</dl>
			</li>

		</ul>


		<div class="result_more">
			<a href="#search_tab" onclick="javascript:goMore('3');" class="more">게시판 검색결과 더보기</a>
			<span>|</span>
			<a href="#container" class="top">맨위로</a>
		</div>

	</div>


<!-- 게시판 영역 끝 -->

<!-- 직원/업무 영역 시작 -->

	<div class="result_box1" id="tab6">
		<h4><strong>직원/업무</strong> (해당 검색어에 대한 검색결과가 <strong>${deptListCnt}</strong>건입니다)</h4>
		<div class="data_type1">

			<table summary="직원업무 검색결과 테이블입니다.부서명, 담당자명, 담당업무, 이메일, 연락처를 알 수 있습니다." border="1">
				<caption>직원업무 검색결과</caption>
				<col style="width:19%;" />
				<col style="width:12%;" />
				<col style="width:31%;" />
				<col style="width:17%;" />
				<col />
				<thead>
				<tr>
					<th scope="col">부서명</th>
					<th scope="col">담당자명</th>
					<th scope="col">담당업무</th>
					<th scope="col">이메일</th>
					<th scope="col">연락처</th>
				</tr>
				</thead>
				<tbody>
			<c:if test="${fn:length(deptList)>0}">
		 		<c:forEach var="x" begin="0" end="${fn:length(deptList)-1}">
				<tr>
					<th scope="row">${deptList[x].department}</th>
					<td>${deptList[x].name}</td>
					<td class="pd_left">${deptList[x].intrdt}</td>
					<td><a href="mailto:${deptList[x].email}"><img src="http://www.geumcheon.go.kr/open_content/images/common/btn/btn_search_email.gif" alt="${deptList[x].name} 담당자에게 이메일발송" /></a></td>
					<td class="pd_left">
						전화. ${deptList[x].officetelno}
					</td>
				</tr>
				</c:forEach>
			</c:if>
				</tbody>
			</table>
		</div>


		<div class="result_more">
			<a href="#search_tab" onclick="javascript:goMore('3');" class="more">직원/업무 검색결과 더보기</a>
			<span>|</span>
			<a href="#container" class="top">맨위로</a>
		</div>

	</div>
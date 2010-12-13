<%@page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

${calendarStr}
<br />
<c:choose>
	<c:when test="${dayAfter == 1}">
		<strong>D-1</strong> &nbsp;드디어 출산 당일입니다. 모자수첩, 의료보험증, 진찰권 등 입원 처리를 합니다. 병원에서는 의사와 간호사의 지시대로 따라 합니다.곧 아기를 품안에 안을 수 있습니다.
	</c:when>
	<c:when test="${dayAfter == 2}">
		<strong>D-2</strong> &nbsp;소화가 잘되는 유동식으로 식사를 합니다.규칙적으로 배의 당김이 있다면 시계를 가지고 정확히 간격을 재도록 합니다. 초산부인 경우 10분, 경산부인 경우 15-30분 간격으로 진통이 오면 병원에 가야 합니다. 주변 가족들에게 알리고 출산에 대비를 합니다.
	</c:when>
	<c:when test="${dayAfter == 3}">
		<strong>D-3</strong> &nbsp;이슬이 비쳤다 해도 금방 아기가 나오는 것은 아닙니다. 침착하게 기다리며 다니던 병원의 야간 진료 여부를 체크해 둡니다.
	</c:when>
	<c:when test="${dayAfter == 4}">
		<strong>D-4</strong> &nbsp;이슬이 보이고 배에 갑작스러운 통증이 올 수 있습니다. 배의 상태를 자주 점검하며 출산의 징후를 놓치지 않도록 합니다.
	</c:when>
	<c:when test="${dayAfter == 5}">
		<strong>D-5</strong> &nbsp;진통의 조짐인지 가진통인지 좀처럼 구분하기 힘든 땅김이 와서 임신부의 마음을 불안하고 초조하게 만듭니다. 지나친 긴장과 불안은 임신부나 태아에게 모두 좋지 않으므로 동화책이나 동요를 들으며 마음을 가라앉히도록 합니다.
	</c:when>
	<c:when test="${dayAfter == 6}">
		<strong>D-6</strong> &nbsp;마지막 정기 검진일입니다. 최종적으로 임신부와 태아의 건강상태를 점검합니다. 출산이 닥쳤을 때 어떻게 해야하는지 상세히 알아둡니다.
	</c:when>
	<c:when test="${dayAfter == 7}">
		<strong>D-7</strong> &nbsp;이슬이나 소량의 양수가 흐르는 등 분만의 시작을 알리는 출산의 징후를 잘 체크합니다. 그래야 출산이 순조롭게 이루어질 수 있겠지요.
	</c:when>
	<c:when test="${dayAfter == 8}">
		<strong>D-8</strong> &nbsp;아기가 태어날 날이 정말 얼마 남지 않았습니다. 노래를 부르며 아기가 태어나 처음 살게 될 곳인 아이 방을 예쁘게 꾸며 봅니다. 
	</c:when>
	<c:when test="${dayAfter == 9}">
		<strong>D-9</strong> &nbsp;허리나 등, 엉덩이가 당기고 아프며 다리에 쥐가 날 때는 남편에게 마사지를 부탁합니다. 뭉친 근육을 풀고 혈액순환을 좋게 하면 통증이 가라앉고 부기도 빠지게 됩니다. 
	</c:when>
	<c:when test="${dayAfter == 10}">
		<strong>D-10</strong> &nbsp;예정일이 한날한날 가까워 오면 누구나 다 불안해집니다. 적극적으로 릴렉스 타임을 갖습니다. 아이를 생각하며 기분 좋은 일만 떠올리세요. 
	</c:when>
	<c:when test="${dayAfter == 11}">
		<strong>D-11</strong> &nbsp;출산 일이 가까워 올수록 점점 분비물이 증가를 합니다. 속옷을 자주 갈아입고 샤워를 자주 하여 청결에 유의합니다. 
	</c:when>
	<c:when test="${dayAfter == 12}">
		<strong>D-12</strong> &nbsp;검진 일입니다. 아기가 얼마나 내려 왔는지 체크를 합니다. 순산을 위해 어떤 준비를 해야 할지 담당의사에게 잘 물어 봅니다.
	</c:when>
	<c:when test="${dayAfter == 13}">
		<strong>D-13</strong> &nbsp;출산 일이 가까워질수록 변비가 심해집니다. 변비가 심해지면 치질이 될 수 있으므로 조심합니다. 요구르트, 과일, 채소 등을 듬뿍 섭취해 변비를 예방해 둡니다. 
	</c:when>
	<c:when test="${dayAfter == 14}">
		<strong>D-14</strong> &nbsp;만일의 경우를 대비하여 출산을 급하게 알려야 될 사람들의 목록을 미리 만들어 옮겨 적습니다.
	</c:when>
	<c:when test="${dayAfter == 15}">
		<strong>D-15</strong> &nbsp;무리하지 않은 범위 내에서 집안일을 정리합니다. 입원을 대비해 남편이나 아이들이 입을 옷을 꺼내 놓거나, 냉장고 정리를 통해 상할 음식을 미리 버려 두면 마음도 홀가분합니다.
	</c:when>
	<c:when test="${dayAfter == 16}">
		<strong>D-16</strong> &nbsp;태어날 아기를 기다리며 아기 출생 카드를 만들거나, 육아 일기를 위한 준비를 해보는 것도 좋겠어요. 육아일기는 병원에 입원해서도 쓸 수 있도록 따로 챙겨 두어도 좋아요. 
	</c:when>
	<c:when test="${dayAfter == 17}">
		<strong>D-17</strong> &nbsp;아기 앨범을 준비합니다. 아기가 태어나는 순간을 담을 수 있도록 카메라와 필름도 챙겨둡니다. 지금까지 찍었던 초음파 사진도 순서대로 예쁘게 정리해 둡니다.
	</c:when>
	<c:when test="${dayAfter == 18}">
		<strong>D-18</strong> &nbsp;병원에 가서 정기검진을 받아요. 초음파 검사 등을 통해 태아의 하강, 아기의 위치나 자세, 태반의 위치와 양수의 양 등을 체크하세요. 
	</c:when>
	<c:when test="${dayAfter == 19}">
		<strong>D-19</strong> &nbsp;몸이 붓고 팔, 다리에 쥐가 나며 배가 불러 잠이 잘 안 오게 됩니다. 그래도 태아의 건강을 위해 숙면을 취하도록 노력하는 것이 좋아요. 잠을 충분히 자두는 것도 순산을 위한 필수조건이 됩니다. 잠이 잘 안 올 때는 우유를 따뜻하게 데워 한 잔 마시는 것도 도움이 됩니다.
	</c:when>
	<c:when test="${dayAfter == 20}">
		<strong>D-20</strong> &nbsp;태아가 골반 쪽으로 하강하면서 위의 압박감이 줄어 식사하기가 한결 편해졌어요. 우유와 두부, 생선 등 단백질을 충분히 섭취하여 막달의 산모 체력를 키워둬요.
	</c:when>
	<c:when test="${dayAfter == 21}">
		<strong>D-21</strong> &nbsp;남편과 육아 방법에 대해 구체적인 이야기를 나눠 봐요. 육아에 대한 기본적인 방침을 세우고 산모의 몸조리와 아기 기저귀 채우기, 분유 타기, 목욕시키기, 아기 옷 입히기, 우는 아기 달래기 등 신생아 돌보기에 대한 구체적인 연습을 함께 해보는 것도 도움이 됩니다.
	</c:when>
	<c:when test="${dayAfter == 22}">
		<strong>D-22</strong> &nbsp;배가 뭉치거나 당기는 느낌이 들면 아이 낳는 일이 멀지 않았다는 생각을 하게 됩니다. 출산을 생각하면 가슴이 두근거리고 걱정입니다. 어른들이나 언니, 선배들에게 출산을 맞는 자세에 대해 대화를 나눠봐요. 아니면 임신 관련 책을 다시 한번 읽어보며 차분히 출산에 대한 마음의 준비를 해요.
	</c:when>
	<c:when test="${dayAfter == 23}">
		<strong>D-23</strong> &nbsp;입원에 대비해 남편에게 미리 집안일에 대해 일러둡니다. 아내가 없어도 당황하지 않도록 주요 생필품이 있는 자리, 자주 사용하는 전화번호 등에 대해 미리 일러두고 메모를 해서 붙여 둡니다.
	</c:when>
	<c:when test="${dayAfter == 24}">
		<strong>D-24</strong> &nbsp;정기검진을 받아요. 불편한 사항이나 의문점을 적어 두었다가 담당의사에게 물어보고 분만예정일도 확인하세요.
	</c:when>
	<c:when test="${dayAfter == 25}">
		<strong>D-25</strong> &nbsp;아기 피부는 연약하답니다. 신생아 의류나 기저귀, 이불 등을 미리 빨아 햇빛에 말려두면 화학약품이 빠져나가 아기에게 보다 안심하고 사용할 수 있습니다. 
	</c:when>
	<c:when test="${dayAfter == 26}">
		<strong>D-26</strong> &nbsp;태어날 아기를 위해 구입한 신생아용품 중 빠진 것이 없는지 다시 한번 체크해 봅니다. 빠진 것이 있다면 채워 넣고 퇴원할 때 아기에게 입힐 옷과 우유병, 속싸개, 겉싸개 등을 따로 가방에 챙겨둡니다. 
	</c:when>
	<c:when test="${dayAfter == 27}">
		<strong>D-27</strong> &nbsp;태아가 약간씩 내려앉음에 따라 방광이 눌려 화장실에 자주 들락거리고 배가 딱딱하게 뭉치면서 옆구리 부분에 통증을 느끼게 됩니다. 기분이 우울해지기 쉬운데 샤워나 산책 등을 통해 기분을 전환해 보세요. 병원에서 찍어준 초음파 사진을 들여다보며 아기와 대화를 나누어도 좋겠지요.
	</c:when>
	<c:when test="${dayAfter == 28}">
		<strong>D-28</strong> &nbsp;분만에 대비해 남편과 함께 연습을 해봅니다. 라마즈 호흡법이나 소프롤로지 호흡법 등을 반복해서 익히게 되면 실제 출산에서 침착하게 대처할 수 있습니다. 하루 10-20분 간 일정 시간을 정해 놓고 연습하면 좋겠지요. 
	</c:when>
	<c:when test="${dayAfter == 29}">
		<strong>D-29</strong> &nbsp;신호가 오면 언제라도 병원에 갈 수 있도록  입원용품을 준비해두세요. 체크리스트를 보면서 하나하나 점검하여 가방에 담아 둡니다. 
	</c:when>
	<c:when test="${dayAfter == 30}">
		<strong>D-30</strong> &nbsp;한달 후면 엄마가 되어요. 예쁘고 건강한 아기를 낳을 수 있다는 자신감을 가지고 마음의 준비를 하세요.
	</c:when>
</c:choose>

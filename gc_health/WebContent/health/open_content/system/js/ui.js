var tabnavi = function(target){
	var old=$(target+" ul").eq(0);
	var cur;
	var curimg;
	var oldimg;
	var cidx;
	var oidx = -1;
	var menuA = $(target+" .title a");
	var curclass;

	old.addClass("open");

	this.run = function(){
		menuA.click(function(){			
			cur = $(this).attr("href");
			curimg = $("img:first",$(this));
			cidx = $(this).parent().parent().index()-1;
			curimg.attr("src", curimg.attr("src").replace("_off","_on"));

			if(oidx != -1 && oidx !=cidx){
				oldimg = $("img:first",$(target+" .title a").eq(oidx));
				oldimg.attr("src", oldimg.attr("src").replace("_on","_off"));
			};

			if(oidx == -1){
				$("img:first", $(target+" .title").eq(0)).attr("src", $("img:first", $(target+" .title").eq(0)).attr("src").replace("_on","_off"));
			};

			if($(old) && old!=cur){
				$(old).removeClass("open");
				$(target).removeClass();
			};

			curclass = "t0"+(parseInt(cidx)+1);
			$(cur).addClass("open");
			$(target).addClass(curclass);

			old=cur;
			oidx=cidx;
			return false;
		});
	};
};

var imgChanger = function(target){
	var cur;
	var obj = $(target+" a");

	this.init = function(){
		$(obj).bind("mouseover focus", overEvt);
		$(obj).bind("mouseout blur", outEvt);
	}

	function overEvt(){
		img = $("img:first", this);
		img.attr("src", img.attr("src").replace("_off","_on"));
	}

	function outEvt(){
		img = $("img:first", this);
		img.attr("src", img.attr("src").replace("_on","_off"));
	}
}

var msgbox = function(elm){
	var obj;
	var oWidth;
	var oHeight;	

	this.init = function(){
		var cssopt = {
			'position' : 'absolute',
			'width' : '500px',
			'min-height' : '300px',
			'border' : '1px solid #CCC',
			'background-color' : '#CCC'
		}
		$("#footer").append("<div id='msg'></div>");
		//alert(elm.replace("#",""));
		//alert($(elm).attr("id"));
		//alert($(elm).css("position"));
		//alert($(elm).attr("id"));
	}
}

var mbox = new msgbox("#msg");
mbox.init();

var popupzoneClass = Class.create({
	obj : null,
	auto : true,		
	loop : true,
	vertical : true,
	pause : 0,
	speed : null,
	
	init : function(arg){
		this.obj = $(arg);
	},

	start : function(){
		var opts = {
			auto : this.auto,
			loop : this.loop,
			vertical : this.vertical,
			pause : this.pause,
			speed : this.speed,
			clickspeed : this.clickspeed
		};

		$(this.obj).popupzone(opts);
	}
});

(function($){
	$.fn.popupzone = function(option){
		var defaultOpt={
			auto		: true,
			pause	: 2000,
			speed	: 800,
			loop		: true,
			vertical	: true,
			clickspeed : 500,
			btnNext	: ".next",
			btnPrev	: ".prev",
			btnStop	: ".stop",
			btnStart	: ".start"
		};
		//data Mapping
		var opts = $.extend(defaultOpt, option);
		var timeout = 0;		//타이머변수
		var over_timer = null;
		var out_timer = null;

		//alert(opts.auto);

		this.each(function(){
			var thisObj = $(this);
			var obj = $("#popuplist", obj);
			var banner = $("li", obj);
			var navi = $("#bannerPaging li", thisObj);
			var bannerLink = $("a", obj);
			var len = banner.length;
			var w = banner.width();
			var h = banner.height();
			var idx = 0;		//현재인덱스
			var pidx = -1;	//이전인덱스
			var click = true;
			var tcount = len-1;
			var outInterval = 2000;	//mouseout intervel time
			var mouseOutTimer = 0;
			opts.initSpeed = opts.speed;	//사용자가 지정한 speed값 저장

			if (banner.length == 0){
				return false;
			}

			//초기화
			if(opts.loop) $("ul", obj).append(banner.eq(0).clone());
			$("ul", obj).css({height: h*(len+1)});
			
			//자동 재생인경우 초기애니메이션 시작
			if(opts.auto){
				timer = setTimeout(function(){
					animate("next", false);
				}, opts.pause);
			};

			$(navi).bind("click", controlNavi);

			//banner control button bind click event
			$(opts.btnNext, thisObj).bind("click","next", control);
			$(opts.btnPrev, thisObj).bind("click","prev", control);
			$(opts.btnStop, thisObj).bind("click","stop", control);
			$(opts.btnStart, thisObj).bind("click","start", control);
			//$(navi).bind("click", $(navi).index(), control);
			
			$(obj).hover(overEvt, outEvt);

			function overEvt(){
				if(click) click = false;
				if(opts.loop) opts.loop = false;
				if(opts.auto) opts.auto = false;							
				animate(idx, false);
				return false;
			}

			function outEvt(){
				clearTimeout(mouseOutTimer);
				//if (opts.loop){
					mouseOutTimer = setTimeout(function(){
						if(!click) click = true;
						if(!opts.loop) opts.loop = true;
						if(!opts.auto) opts.auto = true;
						opts.speed = opts.initSpeed;
						animate("next",false);
					}, outInterval);
				//}
				return false;
			}

			function controlNavi(){
				if(!click) click = true;
				if(opts.loop) opts.loop = false;
				if(opts.auto) opts.auto = false;
				opts.speed = opts.clickspeed;
				animate($(this).index(), false);
				return false;
			};

			//이벤트에 따른 제어
			function control(e){

				switch(e.data){
					case "start":
						if(!opts.loop) opts.loop = true;
						if(!opts.auto) opts.auto = true;
						opts.speed = opts.initSpeed;							
						animate("next", false);
						return false;
						break;

					case "stop":
						if(opts.loop) opts.loop = false;
						if(opts.auto) opts.auto = false;
						opts.speed = opts.initSpeed;							
						animate(idx, false);
						return false;
						break;
/*
					case "over":
						if(click) click = false;
						if(opts.loop) opts.loop = false;
						if(opts.auto) opts.auto = false;							
						animate(idx, false);
						return false;

					case "out":							
						clearTimeout(mouseOutTimer);
						if (opts.loop){
							mouseOutTimer = setTimeout(function(){
								if(!click) click = true;
								if(!opts.loop) opts.loop = true;
								if(!opts.auto) opts.auto = true;
								opts.speed = opts.initSpeed;
								animate("next",false);
							}, outInterval);
						}
						return false;
						break;
*/	
					case "next", "prev":
						if(opts.loop) opts.loop = false;
						if(opts.auto) opts.auto = false;
						opts.speed = opts.initSpeed;
						animate(e.data, false);
						return false;
						break;

					default:						
						if(opts.loop) opts.loop = false;
						if(opts.auto) opts.auto = false;
						opts.speed = opts.clickspeed;
						animate(e.data, false);
						return false;
						break;
				};
			}

			//배너이동 animate완료시 호출
			function scroll(){
				if(idx > tcount) idx = 0;
				if(idx < 0) idx = tcount;
				$("ul", obj).css("margin-top",(idx*h*-1));
				click = true;
			};
		
			//애니메이션을 위한 재귀함수 setTimeout
			function animate(dir, clicked){	
				if(click){						
					click = false;
					pidx = idx;	//이전index
					
					switch(dir){
						case "next":
							//마지막배너이거나 클경우 루프가 아닌경우는 마지막으로 이동
							idx = (pidx >= tcount) ? (opts.loop ? idx+1 : tcount) : idx+1;								
							break; 
						case "prev":
							//처음인경우
							idx = (idx<=0) ? (opts.loop ? idx-1 : 0) : idx-1;
							break; 
						case "first":
							idx = 0;
							break; 
						case "last":
							idx = tcount;
							break; 
						default:
							idx = dir;
							break; 
					};
					
					//현재선택한 메뉴와 현재위치가 같지 않을 경우에 작동
					var diff = Math.abs(pidx-idx);
					var speed = diff*opts.speed;
					
					var p = (idx*h*-1);
					clearTimeout(timeout);
					
					$("ul", obj).animate(
						{ marginTop: p }, 
						{ queue:false, duration:speed, complete:scroll }
					);						
		
					if(!clicked) clearTimeout(timeout);
										
					if(opts.auto && dir=="next" && !clicked){
						timeout = setTimeout(function(){
							animate("next", false);
						},opts.pause+opts.speed);
					};
				}
				else {
					clearTimeout(timeout);
				}
			};
		});
	}
})(jQuery);
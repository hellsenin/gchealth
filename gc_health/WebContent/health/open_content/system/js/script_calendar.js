var _year = 0 , _month = 0 , _day = 0;
var _hour = "00" , _min = "00";
var _time_f = 1;
var _mth_str = new Array('S','M','T','W','T','F','S');
var sel_obj = null;
var mf = null;
var type_d = null;

function init_cal (th, time_f, ty)
{
	type_d = ty;
	if( mf == null )
		makeIframe(0,0);
	var x,y;

	if ( _year == 0 || _month == 0 || _day == 0 ) {
		cur_date = new Date();
		_year = cur_date.getYear();
		_month = cur_date.getMonth() + 1
		_day = cur_date.getDate();

		_hour = cur_date.getHours()
		_min =  cur_date.getMinutes()
	}
	
	// scroll axis search
	nowScroll = getNowScroll();

	x = window.event.clientX  ;
	y = window.event.clientY  ;

	//x = document.searchForm.startDate.clientX  ;
	//y = document.searchForm.startDate.clientY  ;

//alert(x +'/' +y);

	div_calendar.style.pixelTop = y + nowScroll.Y; // y + scroll axis 
	div_calendar.style.pixelLeft = x + nowScroll.X - 130; // x + scroll axis 

	mf.style.left = x + nowScroll.X;
	mf.style.top = y + nowScroll.Y;

	sel_obj =  th
	if (time_f ==1 ) {
		_time_f = 1;
	} else {
		_time_f = 0;
	}


	show_cal(_year, _month, _day, _hour, _min)

}



function re_cal ( el )
{

	if (el == -2) {
		_year--;
	} else if ( el == -1) {
		if (_month == 1) {
			_year--;
			_month = 12;
		} else {
			_month--;
		}
	} else if (el == 1 ) {
		if (_month == 12) {
			_year++;
			_month = 1;
		} else {
		_month++;
		}
	} else if (el ==2 ) {
		_year++;
	} else {
		return ;
	}

	show_cal(_year, _month, _day, _hour, _min );
}

var stime

function mouse_over() {
	var el = window.event.srcElement;
	sel_day = el.title;

	if (sel_day.length > 7) {
		el.style.backgroundColor='#FFFF00';
	}

	window.clearTimeout(stime);
}

function mouse_click() {
	sel_day = window.event.srcElement.title;
	if (sel_day.length > 7) {
		if (sel_obj != null ) {
			tmp  = sel_day;
			if (_time_f == 1 ){
				tmp  += "-" + document.all("cal_sel_hour").value + "" + document.all("cal_sel_min").value  + "01";
			}

			if (_time_f != 1 && type_d == 0)
			{
				sel_obj.value = tmp.substring(0,4) + "-" + tmp.substring(4,6) + "-" + tmp.substring(6,8);
			}
			else{
				sel_obj.value = tmp;
			}
			div_calendar.style.visibility='hidden';
			mf.style.visibility='hidden';

		}
	}

}

function mouse_out() {
	var el = window.event.fromElement;
	sel_day = el.title;

	if (sel_day.length > 7) {
		if ( el.className  =='css_sun') {
			el.style.backgroundColor = '#FFDFDF';
		} else if ( el.className =='css_sat' ) {
			el.style.backgroundColor = '#DDF1FF';
		} else {
			el.style.backgroundColor = '#FFFFFF';
		}
	}

	if ( el.tagName != "SELECT" ) {
		// stime=window.setTimeout("div_calendar.style.visibility='hidden';", 300);
	}
}

function is_leap_year(year){
	if((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)){
		return 1
	} else {
		return -1
	}
}

function get_last_day(e_year, e_month)
{
	rtval = 31;
	tp1 = e_year % 4;
	tp2 = e_year % 100;

	if (e_month == 4 || e_month == 6 || e_month == 9 || e_month == 11) {
		rtval = 30;
	} else if (e_month == 2 && tp1 != 0 ) {
		rtval = 28;
	} else if (e_month == 2 && tp1 == 0 ) {
		if (tp2 == 0 ) {
			rtval = (tp2 == 0 ? 29 : 28 );
		} else {
			rtval=29;
		}
	}
	return  rtval;
}

function hidden_cal()
{
	div_calendar.style.visibility='hidden';
	mf.style.visibility='hidden';
}


function show_cal(e_year, e_month, e_day, e_hour, e_min)
{
	cur_date = new Date();

	today_year = cur_date.getYear();
	today_month = cur_date.getMonth() + 1 ;
	today_day = cur_date.getDate();

	if ( e_year == "" || e_year <= 0 || e_month == "" || e_month <= 0 || e_day == "" || e_day <= 0 ) {
		e_year = cur_date.getYear();
		e_month = cur_date.getMonth() + 1
		e_day = cur_date.getDate();
	} else {
		cur_date.setYear(e_year);
		cur_date.setMonth(e_month-1);
		cur_date.setDate(e_day);
	}

	str = "<table width='180' align='center' border='0' cellspacing='2' cellpadding='0' bgcolor='#333333' id='cal_table' class='cal_table' onSelectstart='return false' onSelect='return false' ";
	str += "  	onmouseover='mouse_over()' onmouseout='mouse_out()' ondblclick ='mouse_click()' > \n";
	str += "  <tr> \n";
	str += "    <td bgcolor='#FFFFFF'> \n";
	str += "      <table width='100%' border='0' cellspacing='0' cellpadding='0'> \n";
	str += "        <tr>  \n";
	str += "          <td>  \n";
	str += "            <table width='100%' border='0' cellspacing='0' cellpadding='0'> \n";
	str += "              <tr height='20'>  \n";
	str += "                <td width='15%' valign='center'>  \n";
	str += "                  <table border='0' cellspacing='1' cellpadding='0'> \n";
	str += "                    <tr>  \n";
	str += "                      <td width='30'><a href='javascript:re_cal(-2)'><img src='/health/open_content/images/common/bul/bul_pyear.gif' border=0></a></td> \n";
	str += "                      <td width='10'><a href='javascript:re_cal(-1)'><img src='/health/open_content/images/common/bul/bul_pmonth.gif' border=0></a></td> \n";
	str += "                    </tr> \n";
	str += "                  </table> \n";
	str += "                </td> \n";
	str += "                <td width='70%' valign='center' align='center'><font face='Tahoma' size='1'><b>" + _year + " / " + _month + "</b></font></td> \n";
	str += "                <td width='15%' valign='center'>  \n";
	str += "                  <table border='0' cellspacing='1' cellpadding='0'> \n";
	str += "                    <tr>  \n";
	str += "                      <td width='30'><a href='javascript:re_cal(1)'><img src='/health/open_content/images/common/bul/bul_nmonth.gif'' border=0></a></td> \n";
	str += "                      <td width='10'><a href='javascript:re_cal(2)'><img src='/health/open_content/images/common/bul/bul_nyear.gif' border=0></a></td> \n";
	str += "                    </tr> \n";
	str += "                  </table> \n";
	str += "                </td> \n";
	str += "              </tr> \n";
	str += "            </table> \n";
	str += "          </td> \n";
	str += "        </tr> \n";
	str += "        <tr>  \n";
	str += "          <td><img src='/application/administrator/common/js/calendar_image/d_line.gif' width='100%' height='1'></td> \n";
	str += "        </tr> \n";
	str += "        <tr> \n";
	str += "          <td> \n";
	str += "            <table width='100%' border='0' cellspacing='1' cellpadding='1'> \n";
	str += "              <tr bgcolor='#FFFFFF' align='center'>  \n";
	str += "                <td class='cal_week'><font size='1' face='Verdana, Tahoma'>S</font></td> \n";
	str += "                <td class='cal_week'><font size='1' face='Verdana, Tahoma'>M</font></td> \n";
	str += "                <td class='cal_week'><font size='1' face='Verdana, Tahoma'>T</font></td> \n";
	str += "                <td class='cal_week'><font size='1' face='Verdana, Tahoma'>W</font></td> \n";
	str += "                <td class='cal_week'><font size='1' face='Verdana, Tahoma'>T</font></td> \n";
	str += "                <td class='cal_week'><font size='1' face='Verdana, Tahoma'>F</font></td> \n";
	str += "                <td class='cal_week'><font size='1' face='Verdana, Tahoma'>S</font></td> \n";
	str += "              </tr> \n";
	str += "              <tr bgcolor='#FFFFFF'> \n";
	str += "                <td colspan='7'><font size='1' face='Verdana, Tahoma'><img src='/application/administrator/common/js/calendar_image/d_line2.gif' width='100%' height='1'></font></td> \n";
	str += "              </tr> \n";

	count_day = 1;

	last_day = get_last_day(e_year, e_month)
	row_cnt = 0;

	for ( week=0 ; week < 6 ; week++ ) {

		tmp_cur_date = new Date(e_year, e_month-1, count_day);

		if (last_day==29 && today_day > 29){
			s_day_of_week = tmp_cur_date.getDay()-1;
		} else {
			s_day_of_week = tmp_cur_date.getDay();
		}


		row_cnt++;
		str += "<tr height='12'>"
		for (dow=0; dow <= 6 ; dow++) {
			if (dow == 0 ) {
				small_css = "css_sun";
			} else if ( dow == 6) {
				small_css = "css_sat";
			} else {
				small_css = "css_def";
			}
			if ( dow < s_day_of_week ) {
				str += "<td class='" + small_css + "'>&nbsp;</td>"
			} else {
				if (count_day > last_day) {
					str += "<td class='" + small_css + "'>&nbsp;</td>"
					week = 10;
				} else {
					tmp_month  = (_month < 10) ? "0" + _month : _month;
					tmp_count_day = (count_day < 10 ) ? "0" + count_day : count_day;
					if (_year == today_year && tmp_month == today_month && tmp_count_day == today_day ){
						str += "<td class='css_tod' title='" + _year + "" + tmp_month + "" + tmp_count_day + "' ";
						str += "	onmouseover=\"this.style.backgroundColor='#FFFF00'\">" + count_day + "</td>"
					} else {
						str += "<td class='" + small_css + "' title='" + _year + "" + tmp_month + "" + tmp_count_day + "' ";
						str += "	onmouseover=\"this.style.backgroundColor='#FFFF00'\">" + count_day + "</td>"
					}

				}
				count_day++;
			}


		}
		str += "</tr>\n"
	}
	if(row_cnt == 5)
		t_height = 178;
	else if(row_cnt == 6)
		t_height = 198;
	else
		t_height = 178;


	if (_time_f ==1 ){
		str += show_time(e_hour, e_min);
		t_height += 23;
	}


	str += "            </table> \n";
	str += "          </td> \n";
	str += "        </tr> \n";
	str += "        <tr>  \n";
	str += "          <td><img src='/application/administrator/common/js/calendar_image/d_line.gif' width='100%' height='1'></td> \n";
	str += "        </tr> \n";
	str += "        <tr> \n";
	str += "          <td align='center' height='25'><font size='1' face='Tahoma'><a href='javascript:hidden_cal()'><img src='/health/open_content/images/btn/btn_closing.gif' alt='창닫기'></a></font></td> \n";
	str += "        </tr> \n";
	str += "      </table> \n";
	str += "    </td> \n";
	str += "  </tr> \n";
	str += "</table> \n";

	document.all("div_calendar").innerHTML = str
	mf.style.visibility = "visible";
	mf.style.height = t_height -20;
	document.all("div_calendar").style.visibility = "visible";

	_year = e_year;
	_month = e_month;
	_day = e_day;
}

function show_time(hour, min)
{

	if ( hour == 0 || hour == "0" || hour == "00" )	{
		tmp_date = new Date();
		hour = tmp_date.getHours();
		min =  tmp_date.getMinutes();
	}

	min =  min - (min % 10 )

	_hour = hour
	_min = min

	str = " <tr bgcolor='#FFFFFF'> \n";
	str += " <td colspan='7' align='center' NOWRAP> <b > </b > \n";
	str += " <select id='cal_sel_hour' class='cal_td'>\n";

	for ( h=0; h <24 ; h++ ){
		tmp = (h<10 ? "0"+h : h );
		if ( hour == tmp){
			str += " <option value='" + tmp + "' selected>" + tmp + "</option>\n";
		} else {
			str += " <option value='" + tmp + "' >" + tmp + "</option>\n";
		}
	}

	str += "  </select> H \n";
	str += "  <select id='cal_sel_min' class='cal_td'>\n";

	for ( h=0; h <60 ; h += 10 ){
		tmp = (h<10 ? "0"+h : h );
		if (min == tmp){
			str += " <option value='" + tmp + "' selected>" + tmp + "</option>\n";
		} else {
			str += " <option value='" + tmp + "' >" + tmp + "</option>\n";
		}
	}

	str += "    </select> M</td>\n";
	str += "  </tr>\n";
	return str;
}

function makeIframe(leftPos, topPos) {
	mf = document.createElement("IFRAME");
	mf.id = "calendarObj";
	mf.name = "calendarObj";
	mf.frameBorder = 0;
//	mf.src="../../common/html/blank.html";
	mf.src="";

	mf.marginWidth=0 ;
	mf.marginHeight=0 ;
	var mfs = mf.style;
	mfs.position = "absolute";
	mfs.visibility = "hidden";
	mfs.left = leftPos;
	mfs.top = topPos;
	mfs.width = "1px";
	mfs.height = "1px";

	document.body.appendChild( mf );
}


// now scroll axis search func.
var getNowScroll = function(){

	var de = document.documentElement;
	var b = document.body;
	var now = {};

	now.X = document.all ? (!de.scrollLeft ? b.scrollLeft : de.scrollLeft) : (window.pageXOffset ? window.pageXOffset : window.scrollX);
	now.Y = document.all ? (!de.scrollTop ? b.scrollTop : de.scrollTop) : (window.pageYOffset ? window.pageYOffset : window.scrollY);

	return now;

}


//////////////////////////////////////////////////////////////////////////////////////

str = " <style> \n";
str += " 	.cal_table {font-size: 8pt; background-color: #666666; color: #333333;cursor:hand };  \n";
str += " 	.cal_td    {font-size: 8pt }; \n";
str += " 	.cal_week  {font-size: 8pt; background-color: #CCCCCC;text-align: center;cursor:hand };  \n";
str += " 	.css_sun   {font-size: 8pt; background-color: #FFDFDF; color: #FF0000 ;text-align: center;cursor:hand };  \n";
str += " 	.css_sat   {font-size: 8pt; background-color: #DDF1FF; color: #003399 ;text-align: center;cursor:hand };  \n";
str += " 	.css_def   {font-size: 8pt; background-color: #FFFFFF; color: #000000 ;text-align: center;cursor:hand };  \n";
str += " 	.css_tod   {font-size: 8pt; background-color: #FFFFFF; color: #0000FF ;text-align: center;cursor:hand;font-weight: bold };  \n";
str += " </style> \n";

str += " <div id='div_calendar' style=\"background : buttonface;width:50;left:0;visibility:hidden;position: absolute; z-index: 999\" ";
str += "	onSelect='return false'>";
str += " </div> \n";

document.write(str)

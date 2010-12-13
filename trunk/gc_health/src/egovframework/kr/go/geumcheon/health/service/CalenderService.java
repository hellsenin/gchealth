package egovframework.kr.go.geumcheon.health.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import egovframework.com.utl.DateUtil;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.kr.go.geumcheon.health.dao.OnlineApplyDAO;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.rte.fdl.string.EgovStringUtil;

@Service("calenderService")
public class CalenderService
{
    Logger log = Logger.getLogger(this.getClass());

	@Resource(name="onlineApplyDAO")
	private OnlineApplyDAO onlineApplyDAO;
	
	public HashMap<String, List<ZValue>> getOnlineApplyMapByDate(ZValue zvl) throws Exception
	{
		String date = zvl.getString("date");
		String applyCode = zvl.getString("applyCode");
		HashMap<String, List<ZValue>> map = new HashMap<String, List<ZValue>>();
		List<ZValue> list = null;
		ZValue param = new ZValue();
		if(applyCode != null && !"".equals(applyCode))
			param.put("applyCode", applyCode);
		param.put("date", date);
		List<ZValue> onlineList = onlineApplyDAO.selectOnlineApplyListByDate(param);

		Calendar _sdate = Calendar.getInstance();
		_sdate.set(Calendar.YEAR, Integer.parseInt(date.substring(0,4)));	
		_sdate.set(Calendar.MONTH, Integer.parseInt(date.substring(4,6))-1);	
		_sdate.set(Calendar.DATE, 1);		

		Calendar _edate = Calendar.getInstance();
		_edate.set(Calendar.YEAR, Integer.parseInt(date.substring(0,4)));	
		_edate.set(Calendar.MONTH, Integer.parseInt(date.substring(4,6))-1);	
		_edate.set(Calendar.DATE, _edate.getActualMaximum(Calendar.DATE));		

		Calendar _eduSday = Calendar.getInstance();
		Calendar _eduEday = Calendar.getInstance();
		
		Calendar actualSday = null;
		Calendar actualEday = null;
		
		Calendar d = Calendar.getInstance();
		d.set(Calendar.YEAR, Integer.parseInt(date.substring(0,4)));	
		d.set(Calendar.MONTH, Integer.parseInt(date.substring(4,6))-1);
		
		for(ZValue val : onlineList)
		{
			String eduSday = val.getString("eduSday");
			String eduEday = val.getString("eduEday");
			if(eduSday.equals(eduEday))
			{
				String key = EgovStringUtil.lPad(String.valueOf(eduSday.substring(6,8)), 2, '0');
				list = map.get(String.valueOf(key));
				if(list == null)
				{
					list = new ArrayList<ZValue>();
					list.add(val);
				}
				else
				{
					list.add(val);
				}
				map.put(key, list);
			}
			else
			{
				_eduSday.set(Calendar.YEAR, Integer.parseInt(eduSday.substring(0,4)));	
				_eduSday.set(Calendar.MONTH, Integer.parseInt(eduSday.substring(4,6))-1);
				_eduSday.set(Calendar.DATE, Integer.parseInt(eduSday.substring(6,8)));	
	
				_eduEday.set(Calendar.YEAR, Integer.parseInt(eduEday.substring(0,4)));	
				_eduEday.set(Calendar.MONTH, Integer.parseInt(eduEday.substring(4,6))-1);
				_eduEday.set(Calendar.DATE, Integer.parseInt(eduEday.substring(6,8)));	
				
				if(_eduSday.after(_sdate))
					actualSday = _eduSday;
				else
					actualSday = _sdate;
				if(_eduEday.before(_edate))
					actualEday = _eduEday;
				else
					actualEday = _edate;
				
				int sday = actualSday.get(Calendar.DATE);
				int eday = actualEday.get(Calendar.DATE);
				log.debug("sday," + sday + " eday," + eday);
				while(eday >= sday)
				{
					d.set(Calendar.DATE, sday);
					int weekOfMonth = d.get(Calendar.WEEK_OF_MONTH);
					int dayOfWeek = d.get(Calendar.DAY_OF_WEEK);
					log.debug("weekOfMonth," + weekOfMonth + " dayOfWeek," + dayOfWeek);
					if(val.getString("weekOfMonth").indexOf(String.valueOf(weekOfMonth)) != -1 && 
					   val.getString("dayOfWeek").indexOf(String.valueOf(dayOfWeek)) != -1)
					{
						String key = EgovStringUtil.lPad(String.valueOf(sday), 2, '0');
						list = map.get(String.valueOf(key));
						if(list == null)
						{
							list = new ArrayList<ZValue>();
							list.add(val);
						}
						else
						{
							list.add(val);
						}
						map.put(key, list);
					}
					sday++;
				}
			}
		}
		log.debug(">>>>>>>>>>>map : " + map);
		return map;
	}

	public HashMap<String, List<ZValue>> getEventMapByDate(ZValue zvl) throws Exception
	{
		String date = zvl.getString("date");
		String bbsId = zvl.getString("bbsId");
		HashMap<String, List<ZValue>> map = new HashMap<String, List<ZValue>>();
		List<ZValue> list = null;
		ZValue param = new ZValue();
		param.put("date", date);
		param.put("bbsId", bbsId);
		List<ZValue> evtList = onlineApplyDAO.selectEventListByDate(param);
		for(ZValue val : evtList)
		{
			String evtSday = val.getString("evtSday");
			list = map.get(evtSday);
			if(list == null)
			{
				list = new ArrayList<ZValue>();
				list.add(val);
			}
			else
			{
				list.add(val);
			}
			map.put(evtSday, list);
		}
		return map;
	}

	public String getOnlineApplyMainCalendar(String date)  throws Exception
	{		
		if(date == null)
		{
	    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			date = sdf.format(new Date());			
		}
		int nYear =Integer.parseInt(date.substring(0,4));
		int nMonth =Integer.parseInt(date.substring(4));
		
		StringBuffer dataList = new StringBuffer();
		dataList.append("<table id=\"edu_id\" width=\"100%\" border=\"1\" class=\"calendar open\" summary=\"요일별 교육 캘린더 정보제공\">\n");
		dataList.append("<caption>교육 캘린더</caption>\n");
		dataList.append("	<thead>\n");
		dataList.append("		<tr>\n");
		dataList.append("			<th scope=\"col\"><img src=\"/health/open_content/images/main/date_1.gif\" alt=\"일\" /></th>\n");
		dataList.append("			<th scope=\"col\"><img src=\"/health/open_content/images/main/date_2.gif\" alt=\"월\" /></th>\n");
		dataList.append("			<th scope=\"col\"><img src=\"/health/open_content/images/main/date_3.gif\" alt=\"화\" /></th>\n");
		dataList.append("			<th scope=\"col\"><img src=\"/health/open_content/images/main/date_4.gif\" alt=\"수\" /></th>\n");
		dataList.append("			<th scope=\"col\"><img src=\"/health/open_content/images/main/date_5.gif\" alt=\"목\" /></th>\n");
		dataList.append("			<th scope=\"col\"><img src=\"/health/open_content/images/main/date_6.gif\" alt=\"금\" /></th>\n");
		dataList.append("			<th scope=\"col\"><img src=\"/health/open_content/images/main/date_7.gif\" alt=\"토\" /></th>\n");
		dataList.append("		</tr>\n");
		dataList.append("	</thead>\n");
		
		int fwcm = DateUtil.getFirstWeekday(nYear, nMonth);	//월의 첫번째주일
		int ldcm = DateUtil.getLastDay(nYear, nMonth);				//월의 마지막 날짜
		int cw = DateUtil.getWeekCount(fwcm,ldcm);				//월의 주 개수

		ZValue param = new ZValue();
		param.put("date", date);
		HashMap<String, List<ZValue>> map = getOnlineApplyMapByDate(param);

		int k = 1;
		for(int i = 1; i <= cw * 7; i++)
		{
			String className = "";
			if(i % 7 == 1)
			{
				dataList.append("<tr>");
			}
			if(i < fwcm)
			{
				dataList.append("<td>&nbsp;</td>");
			}
			else
			{
				if(k <= ldcm)
				{				
					if(i % 7 == 0)
					{
						className = "class=\"blue\"";
					}
					else if(i % 7 == 1)
					{
						className = "class=\"red\"";
					}	
					dataList.append("<td "+className+">");
					List<ZValue> values = map.get(EgovStringUtil.lPad(String.valueOf(k), 2, '0'));
					if(values == null)
					{
						dataList.append(k);
					} 
					else
					{
						String title = "";
						for(ZValue val : values)
						{	
							title += val.getString("title") + ",";
						}
						dataList.append("<a href=\"/health/onlineApply/selectOnlineApplyCalendar.do?categoryId=2434\" title=\""+title+"\">" + k + "</a>");
					}
					dataList.append("</td>");
					
				}
				else
				{
					dataList.append("<td>&nbsp;</td>");
				}
				k++;
			}

			if(i % 7 == 0)
			{
				dataList.append("</tr>");
			}
			
		}

		dataList.append("</table>");
		
		return dataList.toString();
	}    

	public String getEventMainCalendar(String date)  throws Exception
	{		
		if(date == null)
		{
	    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			date = sdf.format(new Date());			
		}
		int nYear =Integer.parseInt(date.substring(0,4));
		int nMonth =Integer.parseInt(date.substring(4));
		
		StringBuffer dataList = new StringBuffer();
		dataList.append("<table id=\"eve_id\" width=\"100%\" border=\"1\" class=\"calendar\" summary=\"요일별 행사 캘린더 정보제공\">\n");
		dataList.append("<caption>행사 캘린더</caption>\n");
		dataList.append("	<thead>\n");
		dataList.append("		<tr>\n");
		dataList.append("			<th scope=\"col\"><img src=\"/health/open_content/images/main/date_1.gif\" alt=\"일\" /></th>\n");
		dataList.append("			<th scope=\"col\"><img src=\"/health/open_content/images/main/date_2.gif\" alt=\"월\" /></th>\n");
		dataList.append("			<th scope=\"col\"><img src=\"/health/open_content/images/main/date_3.gif\" alt=\"화\" /></th>\n");
		dataList.append("			<th scope=\"col\"><img src=\"/health/open_content/images/main/date_4.gif\" alt=\"수\" /></th>\n");
		dataList.append("			<th scope=\"col\"><img src=\"/health/open_content/images/main/date_5.gif\" alt=\"목\" /></th>\n");
		dataList.append("			<th scope=\"col\"><img src=\"/health/open_content/images/main/date_6.gif\" alt=\"금\" /></th>\n");
		dataList.append("			<th scope=\"col\"><img src=\"/health/open_content/images/main/date_7.gif\" alt=\"토\" /></th>\n");
		dataList.append("		</tr>\n");
		dataList.append("	</thead>\n");
		
		int fwcm = DateUtil.getFirstWeekday(nYear, nMonth);	//월의 첫번째주일
		int ldcm = DateUtil.getLastDay(nYear, nMonth);				//월의 마지막 날짜
		int cw = DateUtil.getWeekCount(fwcm,ldcm);				//월의 주 개수

		String bbsId = "BBSMSTR_000000001153";
		
		ZValue param = new ZValue();
		param.put("date", date);
		param.put("bbsId", bbsId);
		HashMap<String, List<ZValue>> map = getEventMapByDate(param);

		int k = 1;
		for(int i = 1; i <= cw * 7; i++)
		{
			String className = "";
			if(i % 7 == 1)
			{
				dataList.append("<tr>");
			}
			if(i < fwcm)
			{
				dataList.append("<td>&nbsp;</td>");
			}
			else
			{
				if(k <= ldcm)
				{				
					if(i % 7 == 0)
					{
						className = "class=\"blue\"";
					}
					else if(i % 7 == 1)
					{
						className = "class=\"red\"";
					}	
					dataList.append("<td "+className+">");
					List<ZValue> values = map.get(EgovStringUtil.lPad(String.valueOf(k), 2, '0'));
					if(values == null)
					{
						dataList.append(k);
					} 
					else
					{
						String title = "";
						for(ZValue val : values)
						{	
							title += val.getString("nttSj") + ",";
						}
						dataList.append("<a href=\"/health/onlineApply/selectEventCalendar.do?bbsId="+bbsId+"&amp;categoryId=2570"+"\" title=\""+title+"\">" + k + "</a>");
					}
					dataList.append("</td>");
					
				}
				else
				{
					dataList.append("<td>&nbsp;</td>");
				}
				k++;
			}

			if(i % 7 == 0)
			{
				dataList.append("</tr>");
			}
			
		}

		dataList.append("</table>");
		
		return dataList.toString();
	}    

	public String getOnlineApplyCalendar(ZValue zvl)  throws Exception
	{
		String date = zvl.getString("date");
		String categoryId = zvl.getString("categoryId");
		
		int day = 0;
		if("".equals(date))
		{
	    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			date = sdf.format(new Date());
			zvl.put("date", date);
			day = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
		}
		int year =Integer.parseInt(date.substring(0,4));
		int month =Integer.parseInt(date.substring(4));

		int nYear = 0;
		int nMonth = 0;
		int pYear = 0;
		int pMonth = 0;

	      if (month == 1) {
	    	  pMonth = 12 ;
	          pYear = year - 1 ;
	          nMonth = month + 1 ;
	          nYear =  year;
	      }
	      else if (month == 12) {
	    	  nMonth = 1;
	          nYear = year + 1;
	          pMonth = month - 1;
	          pYear = year;
	      }
	      else{
	    	  nMonth = month + 1 ;
	          nYear =  year;
	          pMonth = month - 1;
	          pYear = year;
	      }
	      String pYearDate = (year-1) + EgovStringUtil.lPad(String.valueOf(month), 2, '0');
	      String nYearDate = (year+1) + EgovStringUtil.lPad(String.valueOf(month), 2, '0');
	      String pDate = pYear + EgovStringUtil.lPad(String.valueOf(pMonth), 2, '0');
	      String nDate = nYear + EgovStringUtil.lPad(String.valueOf(nMonth), 2, '0');
	      String calLink = 
				"/health/onlineApply/selectOnlineApplyCalendar.do" +
				"?categoryId="+categoryId;
	      String pYLink = calLink + "&amp;date="+ pYearDate;
	      String nYLink = calLink + "&amp;date="+ nYearDate;
	      String pMLink = calLink + "&amp;date="+ pDate;
	      String nMLink = calLink + "&amp;date="+ nDate;
	      
		StringBuffer dataList = new StringBuffer();
		dataList.append("<div class=\"calender_index_box\">");
		dataList.append("<ul class=\"calender_index\">");
		dataList.append("<li class=\"cal_pre\">");
		dataList.append("<a href=\""+pYLink+"\"><img src=\"/health/open_content/images/common/cal_pre.gif\" alt=\"이전 년도\" /></a>");
		dataList.append("</li>");
		dataList.append("<li>" + year+"년</li>");
		dataList.append("<li class=\"cal_next\"><a href=\""+nYLink+"\"><img src=\"/health/open_content/images/common/cal_next.gif\" alt=\"다음 년도\" /></a>");
		dataList.append("</li>");
//2010-09-17		dataList.append("<li class=\"cal_next\">");
		dataList.append("<li class=\"cal_pre2\"><a href=\""+pMLink+"\"><img src=\"/health/open_content/images/common/cal_pre.gif\" alt=\"이전 달\" /></a>");
		dataList.append("</li>");
		dataList.append("<li>"+month+"월</li>");
		dataList.append("<li class=\"cal_next2\">");
		dataList.append("<a href=\""+nMLink+"\"><img src=\"/health/open_content/images/common/cal_next.gif\" alt=\"다음 달\" /></a>");
		dataList.append("</li>");
		dataList.append("</ul>");
		dataList.append("</div>");
		dataList.append("<table class=\"calender_view\" summary=\"월간 주요일정을 한 눈에 보실수 있습니다.\">");
		dataList.append("<caption>");
		dataList.append("교육 캘린더");
		dataList.append("</caption>");
		dataList.append("<colgroup span=\"7\" width=\"14.28%\" />");
		dataList.append("<thead>");
		dataList.append("<tr>");
		dataList.append("<th scope=\"col\" class=\"sun\">일</th>");
		dataList.append("<th scope=\"col\">월</th>");
		dataList.append("<th scope=\"col\">화</th>");
		dataList.append("<th scope=\"col\">수</th>");
		dataList.append("<th scope=\"col\">목</th>");
		dataList.append("<th scope=\"col\">금</th>");
		dataList.append("<th scope=\"col\" class=\"sat\">토</th>");
		dataList.append("</tr>");
		dataList.append("</thead>");
		dataList.append("<tbody>");
		
		int fwcm = DateUtil.getFirstWeekday(year, month);	//월의 첫번째주일
		int ldcm = DateUtil.getLastDay(year, month);				//월의 마지막 날짜
		int cw = DateUtil.getWeekCount(fwcm,ldcm);				//월의 주 개수

		HashMap<String, List<ZValue>> map = getOnlineApplyMapByDate(zvl);
		
		String className = "";
		int k = 1;
		for(int i = 1; i <= cw * 7; i++)
		{	
			if(i % 7 == 1)
			{
				dataList.append("<tr>");
			}
			if(i < fwcm)
			{
				dataList.append("<td class=\"none\">&nbsp;</td>\n");
			}
			else
			{
				if(k <= ldcm)
				{		
					if(i % 7 == 0)
					{
						className = "class=\"day_sat\"";
					}
					else if(i % 7 == 1)
					{
						className = "class=\"day_sun\"";
					}
					else
					{
						className = "class=\"day\"";
					}			
					dataList.append("<td "+className+"><p class=\"day\">" + k + "</p>");
					List<ZValue> values = map.get(EgovStringUtil.lPad(String.valueOf(k), 2, '0'));
					if(values != null)
					{
						for(ZValue val : values)
						{
							String title = val.getString("title");
							String applyCode = val.getString("applyCode");
							String _categoryId = null;
							if("APP000029".equals(applyCode))
							{
								_categoryId = "2435";
							}
							else if("APP000030".equals(applyCode))
							{
								_categoryId = "2436";
							}
							else if("APP000031".equals(applyCode))
							{
								_categoryId = "2437";
							}
							else if("APP000032".equals(applyCode))
							{
								_categoryId = "2438";
							}
							else if("APP000033".equals(applyCode))
							{
								_categoryId = "2439";
							}
							else if("APP000034".equals(applyCode))
							{
								_categoryId = "2440";
							}
							else if("EDU0001".equals(applyCode))
							{
								_categoryId = "2441";
							}
							else if("APP000035".equals(applyCode))
							{
								_categoryId = "2442";
							}
							else if("APP000036".equals(applyCode))
							{
								_categoryId = "2443";
							}
							String link = 
								"/health/onlineApply/selectOnlineApply.do" +
								"?applyCode="+val.getString("applyCode")+
								"&amp;onlineId="+val.getString("onlineId")+
								"&amp;categoryId="+_categoryId;
							dataList.append("<p><a href=\""+link+"\" title=\""+title+"\">" + DateUtil.strlen(title,12,"...") + "</a></p>");
						}
					}
					dataList.append("</td>\n");
				}
				else
				{
					dataList.append("<td class=\"none\">&nbsp;</td>\n");
				}
				k++;
			}

			if(i % 7 == 0)
			{
				dataList.append("</tr>\n");
			}
		}

		dataList.append("</tbody>");
		dataList.append("</table>");
		
		return dataList.toString();
	}   

	public String getEventCalendar(ZValue zvl)  throws Exception
	{
		String date = zvl.getString("date");
		String categoryId = zvl.getString("categoryId");
		String bbsId = zvl.getString("bbsId");
		
		int day = 0;
		if("".equals(date))
		{
	    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			date = sdf.format(new Date());
			zvl.put("date", date);
			day = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
		}
		int year =Integer.parseInt(date.substring(0,4));
		int month =Integer.parseInt(date.substring(4));

		int nYear = 0;
		int nMonth = 0;
		int pYear = 0;
		int pMonth = 0;

	      if (month == 1) {
	    	  pMonth = 12 ;
	          pYear = year - 1 ;
	          nMonth = month + 1 ;
	          nYear =  year;
	      }
	      else if (month == 12) {
	    	  nMonth = 1;
	          nYear = year + 1;
	          pMonth = month - 1;
	          pYear = year;
	      }
	      else{
	    	  nMonth = month + 1 ;
	          nYear =  year;
	          pMonth = month - 1;
	          pYear = year;
	      }
	      String pYearDate = (year-1) + EgovStringUtil.lPad(String.valueOf(month), 2, '0');
	      String nYearDate = (year+1) + EgovStringUtil.lPad(String.valueOf(month), 2, '0');
	      String pDate = pYear + EgovStringUtil.lPad(String.valueOf(pMonth), 2, '0');
	      String nDate = nYear + EgovStringUtil.lPad(String.valueOf(nMonth), 2, '0');
	      String calLink = 
				"/health/onlineApply/selectEventCalendar.do" +
				"?categoryId="+categoryId;
	      String pYLink = calLink + "&amp;date="+ pYearDate + "&amp;bbsId=" + bbsId;
	      String nYLink = calLink + "&amp;date="+ nYearDate + "&amp;bbsId=" + bbsId;
	      String pMLink = calLink + "&amp;date="+ pDate + "&amp;bbsId=" + bbsId;
	      String nMLink = calLink + "&amp;date="+ nDate + "&amp;bbsId=" + bbsId;
	      
		StringBuffer dataList = new StringBuffer();
		dataList.append("<div class=\"calender_index_box\">");
		dataList.append("<ul class=\"calender_index\">");
		dataList.append("<li class=\"cal_pre\">");
		dataList.append("<a href=\""+pYLink+"\"><img src=\"/health/open_content/images/common/cal_pre.gif\" alt=\"이전 년도\" /></a>");
		dataList.append("</li>");
		dataList.append("<li>" + year+"년</li>");
		dataList.append("<li class=\"cal_next\"><a href=\""+nYLink+"\"><img src=\"/health/open_content/images/common/cal_next.gif\" alt=\"다음 년도\" /></a>");
		dataList.append("</li>");
//2010-09-17		dataList.append("<li class=\"cal_next\">");
		dataList.append("<li class=\"cal_pre2\"><a href=\""+pMLink+"\"><img src=\"/health/open_content/images/common/cal_pre.gif\" alt=\"이전 달\" /></a>");
		dataList.append("</li>");
		dataList.append("<li>"+month+"월</li>");
		dataList.append("<li class=\"cal_next2\">");
		dataList.append("<a href=\""+nMLink+"\"><img src=\"/health/open_content/images/common/cal_next.gif\" alt=\"다음 달\" /></a>");
		dataList.append("</li>");
		dataList.append("</ul>");
		dataList.append("</div>");
		dataList.append("<table class=\"calender_view\" summary=\"월간 주요일정을 한 눈에 보실수 있습니다.\">");
		dataList.append("<caption>");
		dataList.append("교육 캘린더");
		dataList.append("</caption>");
		dataList.append("<colgroup span=\"7\" width=\"14.28%\" />");
		dataList.append("<thead>");
		dataList.append("<tr>");
		dataList.append("<th scope=\"col\" class=\"sun\">일</th>");
		dataList.append("<th scope=\"col\">월</th>");
		dataList.append("<th scope=\"col\">화</th>");
		dataList.append("<th scope=\"col\">수</th>");
		dataList.append("<th scope=\"col\">목</th>");
		dataList.append("<th scope=\"col\">금</th>");
		dataList.append("<th scope=\"col\" class=\"sat\">토</th>");
		dataList.append("</tr>");
		dataList.append("</thead>");
		dataList.append("<tbody>");
		
		int fwcm = DateUtil.getFirstWeekday(year, month);	//월의 첫번째주일
		int ldcm = DateUtil.getLastDay(year, month);				//월의 마지막 날짜
		int cw = DateUtil.getWeekCount(fwcm,ldcm);				//월의 주 개수

		HashMap<String, List<ZValue>> map = getEventMapByDate(zvl);
		
		String className = "";
		int k = 1;
		for(int i = 1; i <= cw * 7; i++)
		{	
			if(i % 7 == 1)
			{
				dataList.append("<tr>");
			}
			if(i < fwcm)
			{
				dataList.append("<td class=\"none\">&nbsp;</td>\n");
			}
			else
			{
				if(k <= ldcm)
				{		
					if(i % 7 == 0)
					{
						className = "class=\"day_sat\"";
					}
					else if(i % 7 == 1)
					{
						className = "class=\"day_sun\"";
					}
					else
					{
						className = "class=\"day\"";
					}			
					dataList.append("<td "+className+"><p class=\"day\">" + k + "</p>");
					List<ZValue> values = map.get(EgovStringUtil.lPad(String.valueOf(k), 2, '0'));
					if(values != null)
					{
						for(ZValue val : values)
						{
							String title = val.getString("nttSj");
							String link = 
								"/health/bbs/selectBoardArticle.do" +
								"?bbsId="+val.getString("bbsId")+
								"&amp;nttId="+val.getString("nttId")+
								"&amp;categoryId=" + categoryId;
							dataList.append("<p><a href=\""+link+"\" title=\""+title+"\">" + DateUtil.strlen(title,12,"...") + "</a></p>");
						}
					}
					dataList.append("</td>\n");
				}
				else
				{
					dataList.append("<td class=\"none\">&nbsp;</td>\n");
				}
				k++;
			}

			if(i % 7 == 0)
			{
				dataList.append("</tr>\n");
			}
		}

		dataList.append("</tbody>");
		dataList.append("</table>");
		
		return dataList.toString();
	}   
	
	public String getDeliveryCalendar(ZValue zvl)  throws Exception
	{
		String date = zvl.getString("date");
		String delDay = zvl.getString("delDay");
		//String selDate = zvl.getString("selDate");
		int selYear = 0;
		int selMonth = 0;
		int selDay = 0;

		if(!"".equals(delDay)){
			selYear = Integer.parseInt(delDay.substring(0,4));
			selMonth = Integer.parseInt(delDay.substring(4,6));
			selDay = Integer.parseInt(delDay.substring(6,8));
		}
		String categoryId = zvl.getString("categoryId");
		
		int day = 0;
		if("".equals(date))
		{
	    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			date = sdf.format(new Date());
			zvl.put("date", date);
			day = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
		}
		int year =Integer.parseInt(date.substring(0,4));
		int month =Integer.parseInt(date.substring(4));

		int nYear = 0;
		int nMonth = 0;
		int pYear = 0;
		int pMonth = 0;

	      if (month == 1) {
	    	  pMonth = 12 ;
	          pYear = year - 1 ;
	          nMonth = month + 1 ;
	          nYear =  year;
	      }
	      else if (month == 12) {
	    	  nMonth = 1;
	          nYear = year + 1;
	          pMonth = month - 1;
	          pYear = year;
	      }
	      else{
	    	  nMonth = month + 1 ;
	          nYear =  year;
	          pMonth = month - 1;
	          pYear = year;
	      }
	      String pYearDate = (year-1) + EgovStringUtil.lPad(String.valueOf(month), 2, '0');
	      String nYearDate = (year+1) + EgovStringUtil.lPad(String.valueOf(month), 2, '0');
	      String pDate = pYear + EgovStringUtil.lPad(String.valueOf(pMonth), 2, '0');
	      String nDate = nYear + EgovStringUtil.lPad(String.valueOf(nMonth), 2, '0');
	      
	      String calLink = 
				"/health/delibery/selectDelivery30Calendar.do" +
				"?categoryId="+categoryId;
	      String pYLink = calLink + "&amp;date="+ pYearDate + "&amp;delDay=" + delDay;
	      String nYLink = calLink + "&amp;date="+ nYearDate + "&amp;delDay=" + delDay;
	      String pMLink = calLink + "&amp;date="+ pDate + "&amp;delDay=" + delDay;
	      String nMLink = calLink + "&amp;date="+ nDate + "&amp;delDay=" + delDay;
	      String clickLink = 
				"/health/delibery/selectDelivery30Calendar.do" +
				"?categoryId="+categoryId+"&amp;delDay="+ delDay;
	      
		StringBuffer dataList = new StringBuffer();
		dataList.append("<div class=\"calender_index_box\">");
		dataList.append("<ul class=\"calender_index\">");
		dataList.append("<li class=\"cal_pre\">");
		dataList.append("<a href=\""+pYLink+"\"><img src=\"/health/open_content/images/common/cal_pre.gif\" alt=\"이전 년도\" /></a>");
		dataList.append("</li>");
		dataList.append("<li>" + year+"년</li>");
		dataList.append("<li class=\"cal_next\"><a href=\""+nYLink+"\"><img src=\"/health/open_content/images/common/cal_next.gif\" alt=\"다음 년도\" /></a>");
		dataList.append("</li>");
//2010-09-17		dataList.append("<li class=\"cal_next\">");
		dataList.append("<li class=\"cal_pre2\"><a href=\""+pMLink+"\"><img src=\"/health/open_content/images/common/cal_pre.gif\" alt=\"이전 달\" /></a>");
		dataList.append("</li>");
		dataList.append("<li>"+month+"월</li>");
		dataList.append("<li class=\"cal_next2\">");
		dataList.append("<a href=\""+nMLink+"\"><img src=\"/health/open_content/images/common/cal_next.gif\" alt=\"다음 달\" /></a>");
		dataList.append("</li>");
		dataList.append("</ul>");
		dataList.append("</div>");
		dataList.append("<form name=\"frm\" action=\"/health/delibery/resultDelivery30Calendar.do?categoryId=2689\" method=\"post\" >");
		dataList.append("<div align=\"center\" style=\"padding-bottom:10px\" >");
		dataList.append("※출산예정일을 선택하세요&nbsp;&nbsp;");
		dataList.append("<label for=\"selYear\"><input type=\"text\" id=\"selYear\" name=\"selYear\" style=\"width:40px\" /> 년</label>&nbsp;");
		dataList.append("<label for=\"selMonth\"><input type=\"text\" id=\"selMonth\" name=\"selMonth\" style=\"width:20px\" /> 월</label>&nbsp;");
		dataList.append("<label for=\"selDay\"><input type=\"text\" id=\"selDay\" name=\"selDay\" style=\"width:20px\" /> 일</label>&nbsp;&nbsp;");
		dataList.append("<input type=\"image\" src=\"/health/open_content/images/borad/btn_search.gif\" alt=\"검색\" />");
		dataList.append("</div>");
		dataList.append("<table class=\"calender_view\" summary=\"월간 주요일정을 한 눈에 보실수 있습니다.\">");
		dataList.append("<caption>");
		dataList.append("캘린더");
		dataList.append("</caption>");
		dataList.append("<colgroup span=\"7\" width=\"14.28%\" />");
		dataList.append("<thead>");
		dataList.append("<tr>");
		dataList.append("<th scope=\"col\" class=\"sun\">일</th>");
		dataList.append("<th scope=\"col\">월</th>");
		dataList.append("<th scope=\"col\">화</th>");
		dataList.append("<th scope=\"col\">수</th>");
		dataList.append("<th scope=\"col\">목</th>");
		dataList.append("<th scope=\"col\">금</th>");
		dataList.append("<th scope=\"col\" class=\"sat\">토</th>");
		dataList.append("</tr>");
		dataList.append("</thead>");
		dataList.append("<tbody>");
		
		int fwcm = DateUtil.getFirstWeekday(year, month);	//월의 첫번째주일
		int ldcm = DateUtil.getLastDay(year, month);				//월의 마지막 날짜
		int cw = DateUtil.getWeekCount(fwcm,ldcm);				//월의 주 개수
		
		String className = "";
		int k = 1;
		for(int i = 1; i <= cw * 7; i++)
		{	
			if(i % 7 == 1)
			{
				dataList.append("<tr>");
			}
			if(i < fwcm)
			{
				dataList.append("<td class=\"none\">&nbsp;</td>\n");
			}
			else
			{
				if(k <= ldcm)
				{		
					if(i % 7 == 0)
					{
						className = "class=\"day_sat\"";
					}
					else if(i % 7 == 1)
					{
						className = "class=\"day_sun\"";
					}
					else
					{
						className = "class=\"day\"";
					}			
					dataList.append("<td "+className+"><p class=\"day\">" + k +"</p>");
					
					if(selYear == year && selMonth == month && selDay == k){
						dataList.append("<p>출산예정일</p>");
					}
					
					for(int j=1; j<31 ;j++){
						if(!"".equals(delDay)){
							String reDate = year+"";
							if(month < 10){
								reDate += "0"+month;
							}else{
								reDate += month;
							}
							if(k < 10){
								reDate += "0"+k;
							}else{
								reDate += k;
							}
							
							if(reDate.equals(EgovDateUtil.addYearMonthDay(delDay,0,0,-j))){
								int dayAfter = EgovDateUtil.getDaysDiff(reDate,delDay);
								dataList.append("<p><a href=\""+clickLink+"&amp;dayAfter="+dayAfter+"&amp;date="+reDate.substring(0,6)+"\">D-"+j+"</a></p>");
							}
						}
					}
					dataList.append("</td>\n");
				}
				else
				{
					dataList.append("<td class=\"none\">&nbsp;</td>\n");
				}
				k++;
			}

			if(i % 7 == 0)
			{
				dataList.append("</tr>\n");
			}
		}

		dataList.append("</tbody>");
		dataList.append("</table>");
		dataList.append("</form>");
		
		return dataList.toString();
	}
	
	public String getCategoryIdByApplyCode(String applyCode)
	{
		String categoryId = null;
		if("APP000028".equals(applyCode))
			categoryId ="2434";
		else if("APP000029".equals(applyCode))
			categoryId ="2435";
		else if("APP000030".equals(applyCode))
			categoryId ="2436";
		else if("APP000031".equals(applyCode))
			categoryId ="2437";
		else if("APP000032".equals(applyCode))
			categoryId ="2438";
		else if("APP000033".equals(applyCode))
			categoryId ="2439";
		else if("APP000034".equals(applyCode))
			categoryId ="2440";
		else if("EDU0001".equals(applyCode))
			categoryId ="2441";
		else if("APP000035".equals(applyCode))
			categoryId ="2442";
		else if("APP000036".equals(applyCode))
			categoryId ="2443";
		return categoryId;
	}
}

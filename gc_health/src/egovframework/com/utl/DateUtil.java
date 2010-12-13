package egovframework.com.utl;

import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.text.DecimalFormat;

public class DateUtil {
	
   /***
    * 문자열 자르기 
    * @param str : 문자 <br>
    * @param i : 바이트 <br>
    * @param trail : 생략 문자열. 예) "..."
    * @return
    */
	public static String strlen(String str, int i, String trail) {
    	if (str==null) return "";
    	String tmp = str;
    	int slen = 0, blen = 0;
    	char c;
    	try {
        	if(tmp.getBytes("MS949").length>i) {
        		while (blen+1 < i) {
        			c = tmp.charAt(slen);
        			blen++;
        			slen++;
        			if ( c  > 127 ) blen++;  //2-byte character..
        		}
        		tmp=tmp.substring(0,slen)+trail;
        	}
        } catch(java.io.UnsupportedEncodingException e) {}
    	return tmp;
    }
	
	 /***
    * 제로필 숫자 처리 ex)zeroFill("0000","5") ==> 0005
    * @param format
    * @param input
    * @return
    */
	public static String zeroFill(String format, String input){	
		DecimalFormat DF = new DecimalFormat(format);
		String outPut = DF.format(Integer.parseInt(input)); 
		return outPut;
	}
	
	/***
	 * null && 공백 체크 <p>
	 * @param str
	 * @return
	 */
	public static String chkNull(String str){
		if(str == null){
			return "";
		}
		return str.trim();
	}
	
	/***
	 * 숫자체크 <p>
	 * @param num
	 * @return
	 */
	public static boolean chkNum(String num){	
		
		boolean chk = true;
		
		if(num == null) num = "";
		
		Pattern patt = Pattern.compile("^[0-9]*[0-9]$");		
		Matcher match = patt.matcher(num);
					
		if(num == null || !match.find()){
			chk = false;
		}else{
			chk = true;
		}

		return chk;
	}
		
	/***
	 * 현재 년도 <p>
	 * @return int
	 */
	public static int getYear()	 {
		Calendar cal = Calendar.getInstance();
		return cal.get(Calendar.YEAR);
	 }

	/***
	 * 현재 월 <p>
	 * @return int
	 */
	public static int getMonth() {
		Calendar cal = Calendar.getInstance();
		return cal.get(Calendar.MONTH)+1;
	}

	/***
	 * 현재 일 <p>
	 * @return int
	 */
	public static int getDay() {
		Calendar cal = Calendar.getInstance();
		return cal.get(Calendar.DATE);
	}
	
	/***
	 * 현재 요일 <p>
	 * @return String
	 */
	public static String getWeek() {
		Calendar cal = Calendar.getInstance();
		String [] week = {"","일","월","화","수","목","금","토"};
		return week[cal.get(Calendar.DAY_OF_WEEK)]; 
	}	
	
	/***
	 * 날짜 가져오기 ex) 오늘부 터 7일후 getDate(0,0,7) <p>
	 * @param Y <br>
	 * @param M <br>
	 * @param D
	 * @return int
	 */
	public static String getDate(int Y, int M, int D) {
		Calendar cal = Calendar.getInstance();
		
		if(Y != 0) cal.add(Calendar.YEAR,Y); 
		if(M != 0) cal.add(Calendar.MONTH,M); 
		if(D != 0) cal.add(Calendar.DATE,D); 
		
		String year = Integer.toString(cal.get(Calendar.YEAR));
		String month = zeroFill("00",Integer.toString(cal.get(Calendar.MONTH)+1));		
		String day = zeroFill("00", Integer.toString(cal.get(Calendar.DATE)));
		
		return year + "." + month + "." + day;
	}
	
	/***
	 * 현재달 주 (1주, 2주 ...)
	 * @return int
	 */
	public static int getCurrentWeek(){
		Calendar cal = Calendar.getInstance();
		int result = cal.get(Calendar.WEEK_OF_MONTH) ;
		return result;
	} 
	
	/***
	 * 해당년월의 마지막 날짜
	 * @param nYear : 년도
	 * @param nMonth : 월
	 * @return int
	 */
	public static int getLastDay(int nYear, int nMonth){
		GregorianCalendar cld = new GregorianCalendar (nYear, nMonth - 1, 1);
		int result = cld.getActualMaximum(Calendar.DAY_OF_MONTH);
		return result;
	}
	
	/***
	 * 해당년월의 첫번째 날짜의 요일(1:SUNDAY, 2:MONDAY...)
	 * @param nYear
	 * @param nMonth
	 * @return
	 */
	public static int getFirstWeekday(int nYear, int nMonth){
		GregorianCalendar cld = new GregorianCalendar (nYear, nMonth - 1, 1);
		int result = cld.get(Calendar.DAY_OF_WEEK);
		return result;
	}
	
	/***
	 * 해당년월의 주의 개수
	 * @param nFristWeekday : 그 달의 첫째날의 요일
	 * @param nToDay : 그 달의 날짜 수
	 * @return
	 */
	public static int getWeekCount(int nFristWeekday, int nToDay){
		int nCountDay = nFristWeekday + nToDay - 1;
		int result = (nCountDay / 7);
		if ((nCountDay % 7) > 0) {
			result++;
		}
		return result;
	}

	
	/**
	 * 셀렉트 년도 날짜 생성 ex) getYear(2007)
	 * @param sY : 년도
	 * @return 
	 */
	public static String getSelYear(int sY){

		StringBuffer dataList = new StringBuffer();
		
		for(int i = sY - 4; i <= sY + 4; i++){
			if(i == sY){
				dataList.append("<option value='" + i + "' selected>" + i + "</option>");
			}else{
				dataList.append("<option value='" + i + "'>" + i + "</option>");
			}
		}

		return dataList.toString();
	}
	
	/**
	 * 기간(일자)별 월 구하기
	 * @param from : 2008.01.21
	 * @param to : 2008.05.10
	 * @return int 
	 * @throws java.text.ParseException
	 */
	public static int monthsBetween(String from, String to) throws java.text.ParseException {
        return monthsBetween(from, to, "yyyy.MM.dd");
    }

    public static int monthsBetween(String from, String to, String format) throws java.text.ParseException {
        java.util.Date fromDate = check(from, format);
        java.util.Date toDate = check(to, format);

        // if two date are same, return 0.
        if (fromDate.compareTo(toDate) == 0) return 0;

 		java.text.SimpleDateFormat yearFormat =
		    new java.text.SimpleDateFormat("yyyy", java.util.Locale.KOREA);
 		java.text.SimpleDateFormat monthFormat =
		    new java.text.SimpleDateFormat("MM", java.util.Locale.KOREA);
 		java.text.SimpleDateFormat dayFormat =
		    new java.text.SimpleDateFormat("dd", java.util.Locale.KOREA);

        int fromYear = Integer.parseInt(yearFormat.format(fromDate));
        int toYear = Integer.parseInt(yearFormat.format(toDate));
        int fromMonth = Integer.parseInt(monthFormat.format(fromDate));
        int toMonth = Integer.parseInt(monthFormat.format(toDate));
        int fromDay = Integer.parseInt(dayFormat.format(fromDate));
        int toDay = Integer.parseInt(dayFormat.format(toDate));

        int result = 0;
        result += ((toYear - fromYear) * 12);
        result += (toMonth - fromMonth);

        if (((toDay - fromDay) > 0) ) result += toDate.compareTo(fromDate);

        return result;
    }
    
    public static java.util.Date check(String s, String format) throws java.text.ParseException {
		if ( s == null )
			throw new java.text.ParseException("date string to check is null", 0);
		if ( format == null )
			throw new java.text.ParseException("format string to check date is null", 0);

		java.text.SimpleDateFormat formatter =
            new java.text.SimpleDateFormat (format, java.util.Locale.KOREA);
		java.util.Date date = null;
		try {
			date = formatter.parse(s);
		}
		catch(java.text.ParseException e) {
            throw new java.text.ParseException(" wrong date:\"" + s +
            "\" with format \"" + format + "\"", 0);
		}

		if ( ! formatter.format(date).equals(s) )
			throw new java.text.ParseException(
				"Out of bound date:\"" + s + "\" with format \"" + format + "\"",
				0
			);
        return date;
	}


	/**
	 *  셀렉트 월  날짜 생성 ex) getMonth(3);
	 * @param m : 현재 월
	 * @return
	 */
	public static String getSelMonth(int sM){

		StringBuffer dataList = new StringBuffer();
	
		String mon = "";
		for(int i = 1; i < 13; i++){
	
			mon = zeroFill("00", Integer.toString(i));
			
			if(i == sM){
				dataList.append("<option value='" + mon + "' selected>" + mon + "</option>");
			}else{
				dataList.append("<option value='" + mon + "'>" + mon + "</option>");
			}
		}

		return dataList.toString();
	}

	/***
	 * 셀렉트 일 날짜 생성 ex(getDay(25))
	 * @param d : 현재 일
	 * @return
	 */
	public static String getSelDay(int sY, int sM, int sD){
		StringBuffer dataList = new StringBuffer();
		
		String day = "";
		for(int i = 1; i <= DateUtil.getLastDay(sY,sM); i++){
			
			day = zeroFill("00", Integer.toString(i));
			
			if(i == sD){
				dataList.append("<option value='" + day + "' selected>" + day + "</option>");
			}else{
				dataList.append("<option value='" + day + "'>" + day + "</option>");
			}
		}

		return dataList.toString();
	}

	/**
	 * 날짜빼기
	 * @param date
	 * @param num
	 * @return
	 */
    public static String getOrgDate(String date, int num){
        Calendar cal = Calendar.getInstance();
        String today[] = date.split("\\.");
       
        int  year   = Integer.parseInt(today[0]);
        int  month  = Integer.parseInt(today[1]);
        int  day   = Integer.parseInt(today[2]);
        int  hour   = 0;
        int  minute  = 0;
        int  second  = 0;
     
        cal.set(year, month-1, day-num, hour, minute, second);
     
        return (new SimpleDateFormat("yyyyMMdd")).format(cal.getTime());

   }
    
	public static String getPrevYear(int nYear, int nMonth, String page){
		nYear = nYear - 1; 
		return page + "&year=" + nYear + "&month=" + nMonth;
	}
	public static String getNextYear(int nYear, int nMonth, String page){
			nYear = nYear + 1;
		return page + "&year=" + nYear + "&month=" + nMonth;
	}
	
	public static String getPrevMonth(int nYear, int nMonth, String page){
		if(nMonth == 1){
			nYear = nYear - 1; 
			nMonth = 12;
		}else{
			nMonth = nMonth -1;
		}
		return page + "&year=" + nYear + "&month=" + nMonth;
	}
	public static String getNextMonth(int nYear, int nMonth, String page){
		if(nMonth == 12){
			nYear = nYear + 1;
			nMonth = 1;
		}else{
			nMonth = nMonth + 1;
		}
		return page + "&year=" + nYear + "&month=" + nMonth;
	}
}

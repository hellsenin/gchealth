package egovframework.kr.go.geumcheon.health.util;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;

import org.springframework.stereotype.Service;

import com.ibm.icu.util.Calendar;

public class DateUtil {
	
	public static SimpleDateFormat dateFormat = new SimpleDateFormat();
	
	static {
		dateFormat.applyPattern("yyyy-MM-dd");
	}
	
	private DateUtil() {}
	
	public static String getCurrentDateString() {
		return dateFormat.format(Calendar.getInstance().getTime());
	}
	
	public static String getCurrentDateDisplay() {
		dateFormat.applyPattern("yyyy년MM월dd일");
		
		String currentDate = dateFormat.format(Calendar.getInstance().getTime());
		
		dateFormat.applyPattern("yyyy-MM-dd");
		return currentDate;
	}
	
	public static void main(String[] args) {
		System.out.println(DateUtil.getCurrentDateString());
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
}

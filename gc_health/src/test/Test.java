package test;

import java.io.File;
import java.util.Calendar;

import org.apache.http.HttpRequest;
import org.apache.http.HttpVersion;
import org.apache.http.message.BasicHttpRequest;


public class Test {

	public static long count;
	/**
	 * @param args
	 */
	public static void main(String[] args){
		String date = "201010";	
    	System.out.println("date.substring(0,4) :" + date.substring(4,6));
		Calendar _date = Calendar.getInstance();
		_date.set(Calendar.YEAR, Integer.parseInt(date.substring(4,6))-1);	
		_date.set(Calendar.MONTH, Integer.parseInt(date.substring(4,6))-1);			
	    	System.out.println("_date :" + _date.get(Calendar.DATE));
	    	System.out.println("_date :" + _date.getActualMaximum(Calendar.DATE));
	    	
	}

}

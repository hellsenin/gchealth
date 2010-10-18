package egovframework.com.utl;

import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Set;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.lang.reflect.*;
import java.net.URLEncoder;
import java.awt.Toolkit;
import java.awt.datatransfer.*;


public class HttpUtil extends HttpServlet {
	
	/**
	 * 창을 메세지 출력후 창 닫음
	 * MethodName : winClose
	 * @return void
	 * @exception 
	 * @param response
	 * @param msg
	 * @desc
	 */
	public static void winClose(HttpServletResponse response, String msg){
		try {
			response.reset();
			response.setContentType("text/html;charset=UTF-8");
			response.setHeader("Cache-Control","no-cache");
			
			PrintWriter out = response.getWriter();
			out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
			out.println("<html>");
			out.println("<head>");		
			out.println("<meta HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=UTF-8\">");
			out.println("<script language='JavaScript'>");
			if (msg!=null && !msg.equals("")){
				out.println("alert('" + msg+ "');");
			} 
			out.println("window.close();");
			out.println("</script>");
			out.println("<noscript>");
			out.println(getNoScriptHtml(msg, "현재의 창을 닫는 스크립트입니다. <br>자바스크립트를 지원하지 않아 일부기능이 동작을 하지 않을 수 있습니다.<br>창을 닫은 후 사용하여 주십시오.", 
					null, -1) );
			out.println("</noscript>");
			out.println("</head>");
			out.println("</html>");
			out.close();
		} catch (java.io.IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 창을 메세지 출력후 창 닫고 부모창 새로고침
	 * MethodName : winCloseReload
	 * @return void
	 * @exception 
	 * @param response
	 * @param msg
	 * @desc
	 */
	public static void winCloseReload(HttpServletResponse response, String msg){
		try {
			response.reset();
			response.setContentType("text/html;charset=UTF-8");
			response.setHeader("Cache-Control","no-cache");
			
			PrintWriter out = response.getWriter();
			out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
			out.println("<html>");
			out.println("<head>");		
			out.println("<meta HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=UTF-8\">");
			out.println("<script language='JavaScript'>");
			out.println("opener.location.reload();");
			if (msg!=null){
			out.println("alert('" + msg+ "');");
			}
			out.println("window.close();");
			out.println("</script>");
			out.println("<noscript>");
			out.println(getNoScriptHtml(msg, "현재의 창을 닫는 스크립트입니다. <br>자바스크립트를 지원하지 않아 일부기능이 동작을 하지 않을 수 있습니다. <br>창을 닫은 후 새로고침 후 사용하여 주십시오.", 
					null, -1) );
			out.println("</noscript>");
			out.println("</head>");
			out.println("</html>");
			out.close();
		} catch (java.io.IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 창을 닫은 후 보무창을 goUrl로 보냄
	 * MethodName : winCloseLocation
	 * @return void
	 * @exception 
	 * @param response
	 * @param goUrl
	 * @param msg
	 * @desc
	 */
	public static void winCloseLocation(HttpServletResponse response, String goUrl, String msg){
		try {
			response.reset();
			response.setContentType("text/html;charset=UTF-8");
			response.setHeader("Cache-Control","no-cache");
			
			PrintWriter out = response.getWriter();
			out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
			out.println("<html>");
			out.println("<head>");		
			out.println("<meta HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=UTF-8\">");
            out.println("<meta http-equiv=\"refresh\" content=\"1;url=" + goUrl + " \">");
			out.println("<script language='JavaScript'>");
			if (msg!=null && !msg.equals("")){
			out.println("alert('" + msg+ "');");
			}
			out.println("opener.location.href='" + goUrl + "';");
			out.println("window.close();");
			out.println("</script>");
			out.println("<noscript>");
			StringBuffer sb = new StringBuffer();
			sb.append("현재의 창을 닫고 부모창을 특정페이지로 이동하는 스크립트입니다.");
			sb.append("<br/>자바스크립트를 지원하지 않아 일부기능이 동작을 하지 않을 수 있습니다.");
			sb.append("<br/>10초후 자동으로 이동합니다.");
			sb.append("<br/>지금 바로 이동을 원하시면 아래의 [바로 이동하기]버튼을 클릭하여 주십시오.");
			out.println(getNoScriptHtml(msg, sb.toString(),	goUrl, 0) );
			out.println("</noscript>");
			out.println("</head>");
			out.println("</html>");
			out.close();
		} catch (java.io.IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 해당 페이지(goUrl)로 보냄
	 * MethodName : goUrl
	 * @return void
	 * @exception 
	 * @param response
	 * @param goUrl
	 * @param msg
	 * @desc
	 */
	public static void goUrl(HttpServletResponse response, String goUrl, String msg){
		try {
						
			response.reset();
			response.setContentType("text/html;charset=UTF-8");
			response.setHeader("Cache-Control","no-cache");
			
			PrintWriter out = response.getWriter();
			out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
			out.println("<html>");
			out.println("<head>");		
			out.println("<meta HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=UTF-8\">");
            out.println("<meta http-equiv=\"refresh\" content=\"1;url=" + goUrl + " \">");
			out.println("<script language='JavaScript'>");
			if (msg!=null){
			out.println("alert('" + msg + "');");
			}
			out.println("location.href='" + goUrl + "';");
			out.println("</script>");
			out.println("<noscript>");
			StringBuffer sb = new StringBuffer();
			sb.append("새로운 페이지로 이동하는 스크립트입니다.");
			sb.append("<br/>자바스크립트를 지원하지 않아 일부기능이 동작을 하지 않을 수 있습니다.");
			sb.append("<br/>10초 후 자동으로 이동합니다.");
			sb.append("<br/>지금 바로 이동을 원하시면 아래의 [바로 이동하기]버튼을 클릭하여 주십시오.");
			out.println(getNoScriptHtml(msg, sb.toString(),	goUrl, 0) );
			out.println("</noscript>");
			out.println("</head>");
			out.close();
		} catch (java.io.IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 이전 페이지로 history back
	 * MethodName : back
	 * @return void
	 * @exception 
	 * @param response
	 * @param msg
	 * @desc
	 */
	public static void back(HttpServletResponse response, String msg){
		try {
			String goUrl = "";
			response.reset();
			response.setContentType("text/html;charset=UTF-8");
			response.setHeader("Cache-Control","no-cache");
			
			PrintWriter out = response.getWriter();
			out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
			out.println("<html>");
			out.println("<head>");		
			out.println("<meta HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=UTF-8\">");
			out.println("<meta http-equiv=\"refresh\" content=\"1;url=/\">");
			out.println("<script language='JavaScript'>");
			out.println("alert('" + msg + "');");
			out.println("history.back();");
			out.println("</script>");
			out.println("<noscript>");
			StringBuffer sb = new StringBuffer();
			sb.append("이전 페이지로 이동하는 스크립트입니다. 자바스크립트를 지원하지 않아 일부기능이 동작을 하지 않을 수 있습니다.");
			sb.append("<br/>10초 후 메인페이지로 자동으로 이동합니다.");
			sb.append("<br/>지금 바로 이동을 원하시면 아래의 [바로 이동하기]버튼을 클릭하여 주십시오.");
			out.println(getNoScriptHtml(msg, sb.toString(),	"/", 0) );
			out.println("</noscript>");
			out.println("</head>");
			out.println("</html>");
            out.flush();
			out.close();
		} catch (java.io.IOException e) {
			e.printStackTrace();
		}
	}
	
	
	/**
	 * 창을 닫음
	 * MethodName : realName_winClose
	 * @return void
	 * @exception 
	 * @param response
	 * @param action
	 * @param msg
	 * @desc
	 */
	public static void realName_winClose(HttpServletResponse response, String action, String msg){
		try {
			response.reset();
			response.setContentType("text/html;charset=UTF-8");
			response.setHeader("Cache-Control","no-cache");
			
			PrintWriter out = response.getWriter();
			out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
			out.println("<html>");
			out.println("<head>");		
			out.println("<meta HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=UTF-8\">");
			out.println("<script language='JavaScript'>");
			out.println("alert('" + msg+ "');");
			out.println("self.close();");
			out.println("</script>");
			out.println("</head>");
			out.println("</html>");
			out.close();
		} catch (java.io.IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 해당 URL로 POST로 보냄
	 * MethodName : goUrl
	 * @return void
	 * @exception 
	 * @param response
	 * @param url
	 * @param map
	 * @param msg
	 * @desc
	 */
	public static void goUrl(HttpServletResponse response, String url, HashMap map, String msg) {
		try {
			
			response.reset();
			response.setContentType("text/html;charset=UTF-8");
			response.setHeader("Cache-Control","no-cache");
			PrintWriter out = response.getWriter();
			out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
			out.println("<html>");
			out.println("<head>");		
			out.println("<meta HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=EUC-KR\">");
			out.println("</head>");
			
			out.println("<form name=\"gofrm\" action='" + url + "' method='GET'>");
			for (int i=0; i<map.size();i++){
				Set set = map.keySet();
				Object[] keys = set.toArray();
				if (map.get(keys[i].toString())==null || map.get(keys[i].toString()).equals("") || map.get(keys[i].toString()).equals("null")){
				} else {
					out.println("<input type='hidden' name='" + keys[i].toString().toLowerCase() + "' value='" + map.get(keys[i].toString()) + "' />");
				}
			}
			out.println("<script language='JavaScript'>");
			out.println("<!--");
			if (msg!=null && msg.length()>0){
			out.println("alert('" + msg + "');");
			}
			out.println("document.gofrm.submit();");
			out.println("-->");
			out.println("</script>");
			
			out.println("<noscript>");
			StringBuffer sb = new StringBuffer();
			sb.append("특정 페이지로 이동하는 스크립트입니다. 자바스크립트를 지원하지 않아 일부기능이 동작을 하지 않을 수 있습니다.");
			sb.append("<br/>이동을 원하시면 아래의 [바로 이동하기]버튼을 클릭하여 주십시오.");
			out.println(getNoScriptHtml(msg, sb.toString(),	"/", 2) );
			out.println("</noscript>");
			
			out.println("</form>");
			

			out.close();
		} catch (java.io.IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @param resultMsg : 메인 메제지 alert창에 뛰우는 메세지
	 * @param infoMsg : noscript에 대한 설명 메세지
	 * @param rurl : 바로이동하기 위한 URL
	 * @param target : -1: 창닫기-닫고 사용을 권장, 0=링크, 1:새창, 2 : submit
	 * @param paramMap : Post로 넘길 파라미터가 있을 경우
	 * @return
	 */
	public static String getNoScriptHtml(String resultMsg, String infoMsg, String rurl, int target){
		StringBuffer sb = new StringBuffer();
		sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"/korea/css/common.css\" />");
		sb.append("<div id=\"no_script\">");
		sb.append("<ul class=\"bg\">");
		if (resultMsg==null || resultMsg.equals("")){
			sb.append("<li class=\"tt\"></li>");
		} else {
			sb.append("<li class=\"tt\">"+resultMsg+"</li>");			
		}
		sb.append("<li class=\"txt\">"+infoMsg+"</li>");

		rurl = (rurl==null || rurl.equals("")|| rurl.equals("/")) ? "/" : rurl;
		if (target==-1){ //창닫기-닫고 사용을 권장
			sb.append("<li class=\"btn\"></li>");
		} else if (target==0){ //링크
			sb.append("<li class=\"btn\"><a href=\""+rurl+"\" title=\"페이지 이동하기\"><img src=\"/korea/images/etc/btn_move.gif\" alt=\"바로 이동하기 버튼\" /></a></li>");			
		} else if (target==1){ //새창
			sb.append("<li class=\"btn\"><a href=\""+rurl+"\" title=\"페이지 이동하기\" target+\"_blank\"><img src=\"/korea/images/etc/btn_move.gif\" alt=\"바로 이동하기 버튼\" /></a></li>");
		} else if (target==2){ //submit
			sb.append("<li class=\"btn\"><input type=\"image\" src=src=\"/korea/images/etc/btn_move.gif\" alt=\"바로 이동하기 버튼\"/></li>");
		}
		sb.append("</ul>");
		sb.append("</div>");
		return sb.toString();
	}
}

package egovframework.kr.go.geumcheon.health.service;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.util.Enumeration;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.kr.go.geumcheon.health.vo.Company;
import egovframework.kr.go.geumcheon.health.vo.UsersVO;
import egovframework.rte.fdl.string.EgovStringUtil;

@Service
public class WebFactory {

	protected Log log = LogFactory.getLog(WebFactory.class);
	
	public ZValue getAttributes(HttpServletRequest request) {
		ZValue zvl = new ZValue();
		String name = "";
		Enumeration<String> e = request.getParameterNames();
		while (e.hasMoreElements()) {
			name = e.nextElement();
			if(name.indexOf("_U") > -1)
			{
				String[] values = request.getParameterValues(name);
				String value = "";
				for(int i=0; i<values.length; i++)
				{
					if(i == values.length - 1)
						value += values[i];
					else
						value += values[i] + "-";
				}
				zvl.put(name.replaceAll("_U", ""), value);
			}
			else if(name.indexOf("_D") > -1)
			{
				String[] values = request.getParameterValues(name);
				String value = "";
				if(values.length == 3)
				{
					value = values[0] + "-" + EgovStringUtil.lPad(values[1], 2, '0') +  "-" + EgovStringUtil.lPad(values[2], 2, '0');
					zvl.put(name.replaceAll("_D", ""), value);
				}
			}
			else if(name.indexOf("_E") > -1)
			{
				String[] values = request.getParameterValues(name);
				String value = "";
				for(int i=0; i<values.length; i++)
				{
					if(i == values.length - 1)
						value += values[i];
					else
						value += values[i] + "@";
				}
				zvl.put(name.replaceAll("_E", ""), value);
			}
			else if(name.indexOf("_A") > -1)
			{
				zvl.put(name.replaceAll("_A", ""), request.getParameterValues(name));
			}
			else
			{
				zvl.put(name, request.getParameter(name));
			}
		}

		return zvl; 
	}
	
	public void download(String path, String fileName, String orgFileName, HttpServletRequest request, HttpServletResponse response)
		throws Exception
	{
        String encFileName  = URLDecoder.decode(orgFileName, "UTF-8");
        String extension    = fileName.substring(fileName.lastIndexOf(".")+1).toLowerCase();
        String userAgent    = request.getHeader("User-Agent");  //클라이언트의 브라우저 유형 정보
		String mimetype = null;

    	log.debug("encFileName ::: " + encFileName);
        encFileName  = EgovStringUtil.toEng(encFileName);
    	log.debug("encFileName ::: " + encFileName);
    	log.debug("extension ::: " + extension);
    	log.debug("userAgent ::: " + userAgent);
    	
	    File uFile = new File(path, fileName);
	    int fSize = (int)uFile.length();

	    if (fSize > 0) 
	    {	

            //브라우저에 전송될 파일 형식 지정(Internet Media Type)
            if ( extension.equals("xls") )
            	mimetype="Content-type: APPLICATION/VND.MS-EXCEL;";
            else if ( extension.equals("doc") )
            	mimetype="Content-type: APPLICATION/MSWORD;";
            else if ( extension.equals("ppt") )
            	mimetype="Content-type: APPLICATION/VND.MS-POWERPOINT;";
            else if ( extension.equals("hwp") )
            	mimetype="Content-type: APPLICATION/UNKNOWN;";
            else
            	mimetype="Content-type: APPLICATION/STREAM;";

            mimetype += "charset=utf-8";

            response.setContentType(mimetype);
			response.setBufferSize(fSize);
			
            if( userAgent != null && userAgent.indexOf("MSIE 5.5") != -1 ) {
                //response.setHeader("Content-Disposition","filename=" + encFileName + ";");
                response.setHeader("Content-Disposition","filename=" + encFileName + ";");
            }
            else {
                //response.setHeader("Content-Disposition","attachment;filename=" + encFileName + ";");
                response.setHeader("Content-Disposition","attachment;filename=" + encFileName + ";");
            }

            response.setHeader("Accept-Ranges",             "bytes");
            response.setHeader("Content-Transfer-Encoding", "binary;");
            response.setHeader("Content-Length",            String.valueOf(fSize) ); //Message-Body의 길이
	        
			BufferedInputStream in = new BufferedInputStream(new FileInputStream(uFile));
			FileCopyUtils.copy(in, response.getOutputStream());
			in.close();
			response.getOutputStream().flush();
			response.getOutputStream().close();
	    } 
	    else 
	    {
			response.setContentType("application/x-msdownload");
			PrintWriter printwriter = response.getWriter();
			printwriter.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
			printwriter.println("<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"ko\" xml:lang=\"ko\">");
			printwriter.println("<head>");		
			printwriter.println("<title>금천구 보건소</title>");
			printwriter.println("<meta HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=UTF-8\">");
			printwriter.println("</head>");
			printwriter.println("<body>");
			printwriter.println("<br><br><br><h2>다음파일을 찾을 수 없습니다.:<br>" + orgFileName + "</h2>");
			printwriter.println("<br><br><br><center><h3><a href='/health/main/main.do'>[메인으로 이동하기]</a></h3></center>");
			printwriter.println("</body>");
			printwriter.println("</html>");
			printwriter.flush();
			printwriter.close();
	    }
	}
	
	public void contentsDownload(String path, HttpServletRequest request, HttpServletResponse response)
		throws Exception
	{
    	ZValue zvl = getAttributes(request);

		String fileName = zvl.getString("filename");		
		download(path, fileName, fileName, request, response);
	}

	public void printHtml(HttpServletResponse response, String msg,
			String forwardUrl) throws Exception {
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"ko\" xml:lang=\"ko\">");
		out.println("<head>");		
		out.println("<title>금천구 보건소</title>");
		out.println("<meta HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=UTF-8\">");
        out.println("<meta http-equiv=\"refresh\" content=\"1;url=" + forwardUrl + " \">");
		out.println("<script type=\"text/javascript\">");
		if (msg!=null && !msg.equals("")){
		out.println("alert('" + msg + "');");
		}
		out.println("location.href='" + forwardUrl + "';");
		out.println("</script><noscript>");
		out.println("이전 페이지로 이동하는 스크립트입니다.");
		out.println("<br/>자바스크립트를 지원하지 않아 일부기능이 동작을 하지 않을 수 있습니다.");
		out.println("<br/><a href='/health/main/main.do'>[메인으로 이동하기]</a>");
		out.println("</noscript>");
		out.println("</head>");
		out.flush();
	}
	
	public void printHtmlBack(HttpServletResponse response, String msg) throws Exception {
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"ko\" xml:lang=\"ko\">");
		out.println("<head>");		
		out.println("<title>금천구 보건소</title>");
		out.println("<meta HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=UTF-8\">");
		out.println("<script type=\"text/javascript\">");
		if (msg!=null && !msg.equals("")){
		out.println("alert('" + msg + "');");
		}
		out.println("history.back();");
		out.println("</script><noscript>");
		out.println("이전 페이지로 이동하는 스크립트입니다.");
		out.println("<br/>자바스크립트를 지원하지 않아 일부기능이 동작을 하지 않을 수 있습니다.");
		out.println("<br/><a href='/health/main/main.do'>[메인으로 이동하기]</a>");
		out.println("</noscript>");
		out.println("</head>");
		out.flush();
	}
	
	public UsersVO getUserInfo(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		UsersVO user = (UsersVO)session.getAttribute("user");  
		return user;
	}

	public Company getCompanyInfo(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		Company company = (Company)session.getAttribute("company");  
		return company;
	}

	public void setForwardPage(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String forwardPage = request.getRequestURI() + "?" + request.getQueryString();
		System.out.println("setForwardPage : forwardPage : " + forwardPage);
		HttpSession session = request.getSession();
		session.setAttribute("forwardPage", forwardPage);
		// printHtml(response, "로그인또는 실명인증이 필요한 페이지입니다.\n로그인 하시겠습니까?", )

		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();

		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"ko\" xml:lang=\"ko\">");
		out.println("<head>");	
		out.println("<title>금천구 보건소</title>");	
		out.println("<meta HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=UTF-8\">");
		out.println("<script type=\"text/javascript\">");
		out.print("if(confirm('로그인 또는 실명인증이 필요한 페이지입니다. 로그인 페이지로 이동하시겠습니까?'))\n");
		out.print("location.href='http://www.geumcheon.go.kr/member.do?method=loginPage&amp;fromLogin=health&amp;pageKey=08010101'\n");
		out.print("else history.back();\n");
		out.println("</script><noscript>");
		out.println("이전 페이지로 이동하는 스크립트입니다.");
		out.println("<br/>자바스크립트를 지원하지 않아 일부기능이 동작을 하지 않을 수 있습니다.");
		out.println("<br/><a href='/health/main/main.do'>[메인으로 이동하기]</a>");
		out.println("</noscript>");
		out.println("</head>");
		out.flush();
		return;
	}

	public void setForwardPage2(HttpServletRequest request,
			HttpServletResponse response, String msg) throws Exception {
		String forwardPage = request.getRequestURI() + "?" + request.getQueryString();
		System.out.println("setForwardPage : forwardPage : " + forwardPage);
		HttpSession session = request.getSession();
		session.setAttribute("forwardPage", forwardPage);
		// printHtml(response, "로그인또는 실명인증이 필요한 페이지입니다.\n로그인 하시겠습니까?", )

		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();

		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"ko\" xml:lang=\"ko\">");
		out.println("<head>");	
		out.println("<title>금천구 보건소</title>");	
		out.println("<meta HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=UTF-8\">");
		out.println("<script type=\"text/javascript\">");
		out.print("if(confirm('"+msg+"'))\n");
		out.print("location.href='http://www.geumcheon.go.kr/member.do?method=loginPage&amp;fromLogin=health&amp;pageKey=08010101'\n");
		out.print("else history.back();\n");
		out.println("</script><noscript>");
		out.println("이전 페이지로 이동하는 스크립트입니다.");
		out.println("<br/>자바스크립트를 지원하지 않아 일부기능이 동작을 하지 않을 수 있습니다.");
		out.println("<br/><a href='/health/main/main.do'>[메인으로 이동하기]</a>");
		out.println("</noscript>");
		out.println("</head>");
		out.flush();
		return;
	}

	public void setUserLoinForwardPage(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String forwardPage = request.getRequestURI() + "?" + request.getQueryString();
		System.out.println("//////////////////////////////////////////forwardPage : " + forwardPage);
		HttpSession session = request.getSession();
		session.setAttribute("forwardPage", forwardPage);
		// printHtml(response, "로그인또는 실명인증이 필요한 페이지입니다.\n로그인 하시겠습니까?", )

		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();

		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<html>");
		out.println("<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"ko\" xml:lang=\"ko\">");	
		out.println("<title>금천구 보건소</title>");	
		out.println("<meta HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=UTF-8\">");
		out.println("<script type=\"text/javascript\">");
		out.print("if(confirm('로그인이 필요한 페이지입니다. 로그인 페이지로 이동하시겠습니까?'))\n");
		out.print("location.href='http://www.geumcheon.go.kr/member.do?method=loginPage&amp;fromLogin=health&amp;pageKey=08010101'\n");
		out.print("else history.back();\n");
		out.println("</script><noscript>");
		out.println("이전 페이지로 이동하는 스크립트입니다.");
		out.println("<br/>자바스크립트를 지원하지 않아 일부기능이 동작을 하지 않을 수 있습니다.");
		out.println("<br/><a href='/health/main/main.do'>[메인으로 이동하기]</a>");
		out.println("</noscript>");
		out.println("</head>");
		out.flush();
		return;
	}
	
	/**
     * 해당 게시물의 비번과 로그인한 사용자의 비번이 다른 경우
     * 
     * @param		HttpServletRequest
     * @param		HttpServletResponse
     * @return		void
     * @throws	Exception
     */
	public void setUserPasswordForwardPage(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String forwardPage = request.getRequestURI() + "?" + request.getQueryString();
		System.out.println("//////////////////////////////////////////forwardPage : " + forwardPage);
		HttpSession session = request.getSession();
		session.setAttribute("forwardPage", forwardPage);

		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();

		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<html>");
		out.println("<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"ko\" xml:lang=\"ko\">");	
		out.println("<title>금천구 보건소</title>");	
		out.println("<meta HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=UTF-8\">");
		out.println("<script type=\"text/javascript\">");
		out.print("alert('작성자가 본인이 아닌 경우 수정이나 삭제할 수 없습니다.');");
		out.print("history.back();");
		out.print("</script>");
		out.println("</script><noscript>");
		out.println("이전 페이지로 이동하는 스크립트입니다.");
		out.println("<br/>자바스크립트를 지원하지 않아 일부기능이 동작을 하지 않을 수 있습니다.");
		out.println("<br/><a href='/health/main/main.do'>[메인으로 이동하기]</a>");
		out.println("</noscript>");
		out.println("</head>");
		out.flush();
		return;
	}
	
	/**
     * 첨부파일 용량 초과에 따른 메시지
     * 
     * @param		HttpServletRequest
     * @param		HttpServletResponse
     * @return		void
     * @throws	Exception
     */
	public void setExcessFileSizeForwardPage(final MultipartHttpServletRequest multiRequest, HttpServletResponse response, String msg) throws Exception {
		String forwardPage = multiRequest.getRequestURI() + "?" + multiRequest.getQueryString();
		HttpSession session = multiRequest.getSession();
		session.setAttribute("forwardPage", forwardPage);

		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();

		out.print("<script>\n");
		out.print("alert('" +msg+ "');");
		out.print("history.back();");
		out.print("</script>");
		return;
	}
	
	public String getForwardPage(HttpServletRequest request) {
		HttpSession session = request.getSession();
		return (String) session.getAttribute("forwardPage");
	}

	public void removeForwardPage(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute("forwardPage");
	}

	public String readPetitionWebContents(String urlString) 
	{	
		String htmlContents = "";
		URLConnection connection = null;
		try 
		{
			URL url = new URL(urlString);
			connection = url.openConnection();
		} 
		catch (MalformedURLException e) 
		{
			e.printStackTrace();
		} 
		catch (IOException e) 
		{
			e.printStackTrace();
		}
		
		BufferedReader in = null;
		try 
		{
			in = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"));

			String inputLine;
			while ((inputLine = in.readLine()) != null) 
			{
				htmlContents += inputLine;
			}
		} 
		catch (IOException e) 
		{
			e.printStackTrace();
		}
		finally
		{
			try
			{
				if(in != null) in.close();
			}
			catch(Exception ignore)
			{
				
			}
		}
		return htmlContents;
	}

    public ZValue getValueFromCookie(HttpServletRequest req)
    {
        ZValue zv = new ZValue("cookie");

        Cookie cookies[] = req.getCookies();
        if(cookies == null)
            return zv;
        for(int i = 0; cookies != null && i < cookies.length; i++)
        {
            String key = cookies[i].getName();
            String value = cookies[i].getValue();
            log.debug("key :" + key + ", value : " + value);
            if(value == null)
                value = "";
            zv.put(key, value);
        }
        return zv;
    }
    
	public static void main(String[] args) throws Exception
	{
		//System.out.println(WebFactory.readPetitionWebContents("http://localhost:8080/admin/portal/apply/petition/selectPetitionView.do?applyCode=RELY&petiGubun=1&applyId=6"));
	}
	
}

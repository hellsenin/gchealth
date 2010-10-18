package egovframework.kr.go.geumcheon.health.web;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

public class FreecheckConnectionServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	public void init() throws ServletException {
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			Class.forName("org.apache.commons.dbcp.PoolingDriver");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}

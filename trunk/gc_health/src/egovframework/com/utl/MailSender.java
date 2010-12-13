package egovframework.com.utl;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;


public class MailSender {

	private static String MAIL_SERVER = "210.99.170.235";
	private static String MAIL_SEND_USER = "webmaster@jongno.go.kr";
	/**
	 * @Method Name : SimpleSendEmail
	 * @작성일 : 2008. 09. 22
	 * @작성자 : LEE.KH(수정) - sendmail 실패로 (javax.mail -> org.apache.commons.mail.SimpleEmail) 변경
	 * @변경이력 :
	 * @Method 설명 :
	 * @param host
	 *            -메일서버
	 * @param senderemail
	 *            -보내는 사람
	 * @param email
	 *            -받는사람 이메일
	 * @param name
	 *            -받는사람 이름
	 * @param subject
	 *            -제목
	 * @param mailtext
	 *            -내용
	 * @param attached
	 *            -첨부파일
	 * @throws javax.mail.internet.AddressException
	 * @throws javax.mail.MessagingException
	 * @throws java.io.UnsupportedEncodingException
	 * @throws org.apache.commons.mail.EmailException
	 */
	public static void sendEmail(String host, String senderemail, String email,
			String subject, String mailtext, String[] attached)
			throws javax.mail.internet.AddressException,
			javax.mail.MessagingException, java.io.UnsupportedEncodingException {

		try {
			SimpleEmail simpleEmail = new SimpleEmail();
			simpleEmail.setCharset("euc-kr"); 
			simpleEmail.setHostName(host);   
			simpleEmail.addTo(email, "회원");
			simpleEmail.setFrom(senderemail, "관리자");
			simpleEmail.setSubject(subject);
			simpleEmail.setContent(mailtext,"text/html; charset=euc-kr");
			simpleEmail.send();
		} catch (EmailException e){
			System.out.println(e);
		}
	}

	/**
	 * @Method Name : sendEmail
	 * @작성일 : 2008. 07. 01
	 * @작성자 : Kim.HW(수정)
	 * @변경이력 :
	 * @Method 설명 :
	 * @param senderemail
	 *            -보내는 사람
	 * @param email
	 *            -받는사람 ","로 구분된 메일 주소
	 * @param subject
	 *            -제목
	 * @param mailtext
	 *            -내용
	 * @param attached
	 *            -첨부파일
	 * @throws javax.mail.internet.AddressException
	 * @throws javax.mail.MessagingException
	 * @throws java.io.UnsupportedEncodingException
	 */
	public static void sendEmail(String senderemail, String email,
			String subject, String mailtext, String[] attached)
			throws javax.mail.internet.AddressException,
			javax.mail.MessagingException, java.io.UnsupportedEncodingException {
		sendEmail(MAIL_SERVER, senderemail, email, subject, mailtext, attached);
	}

	/**
	 * @Method Name  : sendEmail
	 * @작성일        : 2008. 07. 01 
	 * @작성자        : Kim.HW
	 * @변경이력      :
	 * @Method 설명   :
	 * @param email		-받을사람 이메일
	 * @param subject	-제목
	 * @param mailtext	-내용
	 * @throws javax.mail.internet.AddressException
	 * @throws javax.mail.MessagingException
	 * @throws java.io.UnsupportedEncodingException
	 */
	public static void sendEmail(String email, String subject, String mailtext
			) throws javax.mail.internet.AddressException,
			javax.mail.MessagingException, java.io.UnsupportedEncodingException, EmailException {
		sendEmail(MAIL_SERVER, MAIL_SEND_USER, email, subject,
				mailtext, null);
	}

	public static String iso8859(String strStr)
			throws java.io.UnsupportedEncodingException {
		if (strStr == null) {
			return null;
		} else {
			return new String(strStr.getBytes("KSC5601"), "8859_1");
		}
	}
	
	/**
	 * @Method Name : SimpleSendEmail
	 * @작성일 : 2008. 09. 16
	 * @작성자 : LEE.KH(수정)
	 * @변경이력 :
	 * @Method 설명 :
	 * @param host
	 *            -메일서버
	 * @param senderemail
	 *            -보내는 사람
	 * @param email
	 *            -받는사람 이메일
	 * @param name
	 *            -받는사람 이름
	 * @param subject
	 *            -제목
	 * @param mailtext
	 *            -내용
	 * @param attached
	 *            -첨부파일
	 * @throws javax.mail.internet.AddressException
	 * @throws javax.mail.MessagingException
	 * @throws java.io.UnsupportedEncodingException
	 * @throws org.apache.commons.mail.EmailException
	 */
	public static void SimpleSendEmail(String host, String senderemail, String email, String name,
			String subject, String mailtext)
			throws javax.mail.internet.AddressException,
			javax.mail.MessagingException, java.io.UnsupportedEncodingException, EmailException {

		SimpleEmail simpleEmail = new SimpleEmail();
		simpleEmail.setCharset("utf-8"); 
		simpleEmail.setHostName(host);   
		simpleEmail.addTo(email, name);
		simpleEmail.setFrom(senderemail, "관리자");
		simpleEmail.setSubject(subject);
		simpleEmail.setContent(mailtext,"text/html; charset=utf-8");
		simpleEmail.send();
	}
	
	public static void sendEmail(String fromName, String fromEmail, String toName, String toEmail, String subject, String mailtext, String charSet)
			throws javax.mail.internet.AddressException,
			javax.mail.MessagingException, java.io.UnsupportedEncodingException, EmailException {

		SimpleEmail simpleEmail = new SimpleEmail();
		simpleEmail.setCharset(charSet); 
		simpleEmail.setHostName(MAIL_SERVER);   
		simpleEmail.addTo(toEmail, "");
		simpleEmail.setFrom(fromEmail, "");
		simpleEmail.setSubject(subject);
		simpleEmail.setContent(mailtext,"text/html; charset="+charSet);
		simpleEmail.send();
	}
}

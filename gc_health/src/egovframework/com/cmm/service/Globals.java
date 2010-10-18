package egovframework.com.cmm.service;

/**
 *  Class Name : Globals.java
 *  Description : 시스템 구동 시 프로퍼티를 통해 사용될 전역변수를 정의한다.
 *  Modification Information
 * 
 *     수정일         수정자                   수정내용
 *   -------    --------    ---------------------------
 *   2009.01.19    박지욱          최초 생성
 *
 *  @author 공통 서비스 개발팀 박지욱
 *  @since 2009. 01. 19
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2009 by MOPAS  All right reserved.
 */

public class Globals {
	//OS 유형
    public static final String OsType = EgovProperties.getProperty("Globals.OsType");
    //DB 유형
    public static final String DbType = EgovProperties.getProperty("Globals.DbType");
    //메인 페이지
    public static final String MainPage = EgovProperties.getProperty("Globals.MainPage");
    //ShellFile 경로
    public static final String ShellFilePath = EgovProperties.getProperty("Globals.ShellFilePath");
    //퍼로퍼티 파일 위치
    public static final String ConfPath = EgovProperties.getProperty("Globals.ConfPath");
    //Server정보 프로퍼티 위치
    public static final String ServerConfPath = EgovProperties.getProperty("Globals.ServerConfPath");
    //Client정보 프로퍼티 위치
    public static final String ClientConfPath = EgovProperties.getProperty("Globals.ClientConfPath");
    //파일포맷 정보 프로퍼티 위치
    public static final String FileFormatPath = EgovProperties.getProperty("Globals.FileFormatPath");
    
    //파일 업로드 원 파일명
	public static final String ORIGIN_FILE_NM = "originalFileName";
	//파일 확장자
	public static final String FILE_EXT = "fileExtension";
	//파일크기
	public static final String FILE_SIZE = "fileSize";
	//업로드된 파일명
	public static final String UPLOAD_FILE_NM = "uploadFileName";
	//파일경로
	public static final String FILE_PATH = "filePath";
	
	//메일발송요청 XML파일경로
	public static final String MAIL_REQUEST_PATH = EgovProperties.getProperty("Globals.MailRequestPath");
	//메일발송응답 XML파일경로
	public static final String MAIL_RESPONSE_PATH = EgovProperties.getProperty("Globals.MailRResponsePath");
	
	// G4C 연결용 IP (localhost)
	public static final String LocalIp = EgovProperties.getProperty("Globals.LocalIp");

	public static final String HEALTH_SITE_ID = "5";

	//관리자
	public static final String ADMIN_MAIN_PAGE = "admin/adminMain";
	//포탈
	public static final String PORTAL_MAIN_PAGE = "portal/open_content/main/portalIndex";
	//보건소
	public static final String HEALTH_MAIN_PAGE = "health/open_content/main/healthIndex";
	//어린이
	public static final String CHILD_MAIN_PAGE = "children/open_content/main/childIndex";
	//구의회
	public static final String COUNCIL_MAIN_PAGE = "council/open_content/main/councilIndex";
	
	public static final String DEPT_MAIN_PAGE = "dept/open_content/main/deptIndex";
	
	public static final String DONG_MAIN_PAGE = "dong/open_content/main/dongIndex";
	
	public static final String TOUR_MAIN_PAGE = "tour/open_content/main/tourIndex";

	public static final String ENGLISH_MAIN_PAGE = "english/open_content/main/englishIndex";

	public static final String CHINA_MAIN_PAGE = "china/open_content/main/chinaIndex";

	public static final String JAPANESE_MAIN_PAGE = "japanese/open_content/main/japaneseIndex";
	
	public static final String IN_MAIN_PAGE = "town/open_content/main/inTownIndex";
	
	public static final String UNI_MAIN_PAGE = "town/open_content/main/uiTownIndex";
	
	public static final String BUK_MAIN_PAGE = "town/open_content/main/bkTownIndex";
	
	public static final String CHUNG_MAIN_PAGE = "town/open_content/main/chTownIndex";
	
	// 이미지, 첨부파일 허용 최대 사이즈(Byte)
	public static final long FILE_MAX_SIZE = 5242880;
	
	// 이미지, 첨부파일 등록불가한 확장자
	public static final String FILE_LIMIT_EXTSN = "exe,com,bat,scr,dll,inf,sh";
    
	// 종로구청 메인 도메인 주소
	public static final String MAIN_URL = EgovProperties.getProperty("Globals.Main.Url");
	
	// UCC IP
	public static final String UCC_IP = "210.99.170.223";
	
	// 커뮤니티에서 목록 페이지에서 보여줄 동영상 목록 갯수
	public static final int COMMUNITY_MOVIE_PAGE_UNIT = 8;
}

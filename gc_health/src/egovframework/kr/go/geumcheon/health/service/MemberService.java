package egovframework.kr.go.geumcheon.health.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.ibm.icu.util.Calendar;

import egovframework.kr.go.geumcheon.health.dao.MemberDAO;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.kr.go.geumcheon.health.vo.UsersVO;

@Service("memberService")
public class MemberService {

	protected Log log = LogFactory.getLog(this.getClass());
	
	@Resource(name="memberDAO")
	private MemberDAO memberDAO;

    public int getAgeByBirthDate(String birthDate)
    {
    	int year = Integer.parseInt(birthDate.substring(0,4));
    	
        Calendar cal = Calendar.getInstance();
        int nowyear=cal.get(Calendar.YEAR);

        int age=nowyear-year+1;
    	
    	return age;    	
    }    

    public int getAgeByJumin(String jumin)
    {
    	int year=Integer.parseInt(jumin.substring(0,2));
        int gender=jumin.charAt(6);

        if(gender=='1'||gender=='2') year+=1900;
        else year+=2000;

        Calendar cal = Calendar.getInstance();
        int nowyear=cal.get(Calendar.YEAR);

        int age=nowyear-year+1;
    	
    	return age;    	
    }    

    public String getBirthdayByJumin(String jumin)
    {
    	int year=Integer.parseInt(jumin.substring(0,2));
        int gender=jumin.charAt(6);

        if(gender=='1'||gender=='2') year+=1900;
        else year+=2000;
        
        String strYear = String.valueOf(year);
        String strMonth = jumin.substring(2,4);
        String strDay = jumin.substring(4,6);
        
        return strYear + "-" + strMonth + "-" + strDay;  	
    }

    public String getSexByJumin(String jumin)
    {
    	String sex = null;
        char gender=jumin.charAt(6);
        
        if(gender=='1'||gender=='3') sex = "1";
        else sex = "2";
                
        return sex;  	
    }
    
	public UsersVO selectMember(ZValue zvl) throws Exception {
		return memberDAO.selectMember(zvl);
	}

	public HashMap<String, Object> selectMemberList(ZValue zvl) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<ZValue> resultList = memberDAO.selectMemberList(zvl);
		int resultListCnt = memberDAO.selectMemberListCnt(zvl);
		map.put("resultList", resultList);
		map.put("resultListCnt", resultListCnt);
		return map;
	}

	public HashMap<String, Object> selectStaffList(ZValue zvl) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<ZValue> resultList = memberDAO.selectStaffList(zvl);
		int resultListCnt = memberDAO.selectStaffListCnt(zvl);
		map.put("resultList", resultList);
		map.put("resultListCnt", resultListCnt);
		return map;
	}
                                                    
	public int checkDupId(ZValue zvl) throws Exception {
		return memberDAO.checkDupId(zvl);
	}
    
	public int checkDupPinno(String pinno) throws Exception {
		return memberDAO.checkDupPinno(pinno);
	}

	public String findId(ZValue zvl) throws Exception
	{
		return memberDAO.findId(zvl);
	}

	public ZValue findPassword(ZValue zvl) throws Exception
	{
		return memberDAO.findPassword(zvl);
	}

	public UsersVO getLoginVoFromZvl(ZValue loginZvl)
	{
    	UsersVO user = new UsersVO();
    	user.setWebMemId(loginZvl.getString("webMemId"));
    	user.setMemNm(loginZvl.getString("memNm"));
    	user.setBirthday(loginZvl.getString("birthday"));
    	user.setSex(loginZvl.getString("sex"));
    	user.setOtherEmail(loginZvl.getString("email"));
    	user.setUseGcmail(loginZvl.getString("useGcmail"));
    	user.setAllowMailing(loginZvl.getString("allowMailing"));
    	user.setZipcode(loginZvl.getString("zipcode"));
    	user.setAddress1(loginZvl.getString("address1"));
    	user.setAddress2(loginZvl.getString("address2"));
    	user.setAddress3(loginZvl.getString("address3"));
    	user.setPhone(loginZvl.getString("phone"));
    	user.setHandphone(loginZvl.getString("handphone"));
    	user.setPin(loginZvl.getString("pin"));
    	
    	return user;
	}

	public int selectAuthCodeCntByWebMemId(String webMemId) throws Exception
	{
		return memberDAO.selectAuthCodeCntByWebMemId(webMemId);
	}

	public String selectAuthCodeByWebMemId(String webMemId) throws Exception
	{
		return memberDAO.selectAuthCodeByWebMemId(webMemId);
	}

	public void addUsersAuth(ZValue zvl) throws Exception
	{
		memberDAO.addUsersAuth(zvl);
	}

	public void updateUsersAuth(ZValue zvl) throws Exception
	{
		memberDAO.updateUsersAuth(zvl);
	}

	public void applyUsersAuth(ZValue zvl) throws Exception
	{
		String authCode = zvl.getString("authCode");
		String authName = zvl.getString("authName");
		ArrayList<String> webMemIdList = zvl.getArrayList("webMemId");
		for(String webMemId : webMemIdList)
		{
			ZValue param = new ZValue();
			param.put("webMemId", webMemId);
			param.put("authCode", authCode);
			param.put("authName", authName);
			if(memberDAO.selectAuthCodeCntByWebMemId(webMemId) > 0)
			{
				memberDAO.updateUsersAuth(param);
			}
			else
			{
				memberDAO.addUsersAuth(param);
			}
		}
	}
}


package egovframework.kr.go.geumcheon.health.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.kr.go.geumcheon.health.vo.UsersVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("memberDAO")
public class MemberDAO  extends EgovAbstractDAO{

	public UsersVO selectMember(ZValue zvl) throws Exception
	{
		return (UsersVO)selectByPk("memberDAO.selectMember", zvl);
	}

	public List<ZValue> selectMemberList(ZValue zvl) throws Exception
	{
		return list("memberDAO.selectMemberList", zvl);
	}

	public int selectMemberListCnt(ZValue zvl) throws Exception
	{
		return (Integer)selectByPk("memberDAO.selectMemberListCnt", zvl);
	}

	public List<ZValue> selectStaffList(ZValue zvl) throws Exception
	{
		return list("memberDAO.selectStaffList2", zvl);
	}

	public int selectStaffListCnt(ZValue zvl) throws Exception
	{
		return (Integer)selectByPk("memberDAO.selectStaffListCnt2", zvl);
	}

	public int checkDupId(ZValue zvl) throws Exception
	{
		return (Integer)selectByPk("memberDAO.checkDupId", zvl);
	}

	public int checkDupPinno(String pinno) throws Exception
	{
		return (Integer)selectByPk("memberDAO.checkDupPinno", pinno);
	}

	public String findId(ZValue zvl) throws Exception
	{
		return (String)selectByPk("memberDAO.findId", zvl);
	}

	public ZValue findPassword(ZValue zvl) throws Exception
	{
		return (ZValue)selectByPk("memberDAO.findPassword", zvl);
	}

	public int selectAuthCodeCntByWebMemId(String webMemId) throws Exception
	{
		return (Integer)selectByPk("memberDAO.selectAuthCodeCntByWebMemId", webMemId);
	}

	public String selectAuthCodeByWebMemId(String webMemId) throws Exception
	{
		return (String)selectByPk("memberDAO.selectAuthCodeByWebMemId", webMemId);
	}

	public void addUsersAuth(ZValue zvl) throws Exception
	{
		insert("memberDAO.addUsersAuth", zvl);
	}

	public void updateUsersAuth(ZValue zvl) throws Exception
	{
		update("memberDAO.updateUsersAuth", zvl);
	}

}

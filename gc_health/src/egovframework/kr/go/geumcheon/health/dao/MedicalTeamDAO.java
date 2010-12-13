package egovframework.kr.go.geumcheon.health.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("MedicalTeamDAO")
public class MedicalTeamDAO extends EgovAbstractDAO{

	public List<ZValue> selectMedicalTeamList(ZValue zvl) throws Exception
	{
		return list("MedicalTeamDAO.selectMedicalTeamList", zvl);
	}

	public ZValue selectMedicalTeam(int no) throws Exception
	{
		return (ZValue)selectByPk("MedicalTeamDAO.selectMedicalTeam", no);
	}

	public int selectMedicalTeamPetiGubun() throws Exception
	{
		return (Integer)selectByPk("MedicalTeamDAO.selectMedicalTeamPetiGubun", null);
	}
	
	public void addMedicalTeam(ZValue zvl) throws Exception
	{	
		insert("MedicalTeamDAO.addMedicalTeam", zvl);
	}
	
	public void updateMedicalTeam(ZValue zvl) throws Exception
	{
		update("MedicalTeamDAO.updateMedicalTeam", zvl);
	}

	public void deleteMedicalTeam(int no) throws Exception
	{
		update("MedicalTeamDAO.deleteMedicalTeam", no);
	}


}

package egovframework.kr.go.geumcheon.health.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("searchDAO")
public class SearchDAO  extends EgovAbstractDAO{
	
	public List<ZValue> selectCategoryListByName(String name) throws Exception
	{
		return list("searchDAO.selectCategoryListByName", name);
	}

	public List<ZValue> selectCategoryListByNameA(ZValue zvl) throws Exception
	{
		return list("searchDAO.selectCategoryListByNameA", zvl);
	}

	public int selectCategoryListByNameCnt(String name) throws Exception
	{
		return (Integer)selectByPk("searchDAO.selectCategoryListByNameCnt", name);
	}

	public List<ZValue> selectStaffList(String searchTxt) throws Exception
	{
		return list("searchDAO.selectStaffList", searchTxt);
	}

	public List<ZValue> selectStaffListA(ZValue zvl) throws Exception
	{
		return list("searchDAO.selectStaffListA", zvl);
	}
	
	public int selectStaffListCnt(String name) throws Exception
	{
		return (Integer)selectByPk("searchDAO.selectStaffListCnt", name);
	}
	
	public int selectBBSListCnt(String name) throws Exception
	{
		return (Integer)selectByPk("searchDAO.selectBBSListCnt", name);
	}
	
	public List<ZValue> selectBBSListByContent(ZValue zvl) throws Exception
	{
		return list("searchDAO.selectBBSListByContent", zvl);
	}
	
	public List<ZValue> selectBBSListByContentA(ZValue zvl) throws Exception
	{
		return list("searchDAO.selectBBSListByContentA", zvl);
	}

}

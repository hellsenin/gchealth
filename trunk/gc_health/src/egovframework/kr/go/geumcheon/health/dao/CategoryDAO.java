package egovframework.kr.go.geumcheon.health.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("categoryDAO")
public class CategoryDAO  extends EgovAbstractDAO{
	
	public List<ZValue> selectCategoryListBySiteId(String siteId) throws Exception
	{
		return list("categoryDAO.selectCategoryListBySiteId", siteId);
	}	

	public void delCategoryAdditionBySiteId(String siteId) throws Exception
	{
		delete("categoryDAO.delCategoryAdditionBySiteId", siteId);
	}	

	public void addCategoryAddition(ZValue zvl) throws Exception
	{
		insert("categoryDAO.addCategoryAddition", zvl);
	}	

	public void addFolderMap(ZValue zvl) throws Exception
	{
		insert("categoryDAO.addFolderMap", zvl);
	}	

	public List selectProgramList(String siteId) throws Exception
	{
		return list("categoryDAO.selectProgramList", siteId);
	}

	public void insertProgramList(ZValue zvl) throws Exception
	{	
		insert("categoryDAO.insertProgramList", zvl);
	}

	public void updateProgramList(ZValue zvl) throws Exception
	{	
		insert("categoryDAO.updateProgramList", zvl);
	}

	public int existCategoryIdInProgramList(String categoryId) throws Exception
	{
		return (Integer)selectByPk("categoryDAO.existCategoryIdInProgramList", categoryId);
	}

	public String selectContentsPath(String categoryId) throws Exception
	{
		return (String)selectByPk("categoryDAO.selectContentsPath", categoryId);
	}

	public List<ZValue> selectCategoryByName(String name) throws Exception
	{
		return list("categoryDAO.selectCategoryByName", name);
	}

}

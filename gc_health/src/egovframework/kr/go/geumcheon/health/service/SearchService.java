package egovframework.kr.go.geumcheon.health.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.kr.go.geumcheon.health.dao.SearchDAO;
import egovframework.kr.go.geumcheon.health.util.ZValue;

@Service("searchService")
public class SearchService {

	@Resource(name="searchDAO")
	private SearchDAO searchDAO; 
	
	public List<ZValue> selectCategoryListByName(String name) throws Exception {
		return searchDAO.selectCategoryListByName(name);
	}

	public List<ZValue> selectCategoryListByNameA(ZValue zvl) throws Exception {
		return searchDAO.selectCategoryListByNameA(zvl);
	}

	public List<ZValue> selectStaffList(String name) throws Exception {
		return searchDAO.selectStaffList(name);
	}

	public List<ZValue> selectStaffListA(ZValue zvl) throws Exception {
		return searchDAO.selectStaffListA(zvl);
	}

	public int selectCategoryListByNameCnt(String name) throws Exception
	{
		return searchDAO.selectCategoryListByNameCnt(name);
	}

	public int selectStaffListCnt(String name) throws Exception
	{
		return searchDAO.selectStaffListCnt(name);
	}
	
	public int selectBBSListCnt(String name) throws Exception
	{
		return searchDAO.selectBBSListCnt(name);
	}
	
	public List<ZValue> selectBBSListByContent(ZValue zvl) throws Exception {
		return searchDAO.selectBBSListByContent(zvl);
	}
	
	public List<ZValue> selectBBSListByContentA(ZValue zvl) throws Exception {
		return searchDAO.selectBBSListByContentA(zvl);
	}

}

package egovframework.kr.go.geumcheon.health.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.kr.go.geumcheon.health.dao.InfoCustomMadeDAO;
import egovframework.kr.go.geumcheon.health.util.ZValue;

@Service("infoCustomMadeService")
public class InfoCustomMadeService {

	protected Log log = LogFactory.getLog(this.getClass());

	@Resource(name="infoCustomMadeDAO")
	private InfoCustomMadeDAO infoCustomMadeDAO;
	
	public int addFavorite(ZValue zvl) throws Exception
	{	
		int result = 0;
		if(infoCustomMadeDAO.selectFavoriteCnt(zvl) == 0)
		{
			infoCustomMadeDAO.addFavorite(zvl);
			result = 1;
		}
		
		return result;
	}

	public Map<String, Object> selectFavoriteByUserId(ZValue zvl) throws Exception{
		
		List result = infoCustomMadeDAO.selectFavoriteByUserId(zvl);
		int cnt = infoCustomMadeDAO.selectFavoriteByUserIdCnt(zvl.getString("userId"));

		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", result);
		map.put("resultCnt", Integer.toString(cnt));
		return map;
	}

	public void delFavorite(ZValue zvl) throws Exception
	{	
		infoCustomMadeDAO.delFavorite(zvl);
	}

	public void addCustomMainMenuCategory(ZValue zvl) throws Exception
	{	
		infoCustomMadeDAO.addCustomMainMenuCategory(zvl);
	}

	public Map<String, List<ZValue>> selectCustomMainMenuCategoryList() throws Exception
	{
		String prefix = "cstmId_";
		Map<String, List<ZValue>> resultMap = new HashMap<String, List<ZValue>>();
		List<ZValue> resultList = infoCustomMadeDAO.selectCustomMainMenuCategoryList();
		List<ZValue> mapValue = null;
		String key = null;
		for(ZValue result : resultList)
		{ 
			key = prefix + result.getString("cstmId");
			mapValue = resultMap.get(key);
			if(mapValue == null)
			{
				mapValue = new ArrayList<ZValue>();
				mapValue.add(result);
				resultMap.put(key, mapValue);
			}
			else
			{
				mapValue.add(result);	
			}
		}
		return resultMap;
	}

	public Map<String, List<ZValue>> selectCustomMainMenuCategoryList(List<ZValue> resultList) throws Exception
	{
		String prefix = "categoryId_";
		Map<String, List<ZValue>> resultMap = new HashMap<String, List<ZValue>>();
		List<ZValue> mapValue = null;
		String key = null;
		for(ZValue result : resultList)
		{ 
			key = prefix + result.getString("categoryId");
			mapValue = resultMap.get(key);
			if(mapValue == null)
			{
				mapValue = new ArrayList<ZValue>();
				mapValue.add(result);
				resultMap.put(key, mapValue);
			}
			else
			{
				mapValue.add(result);	
			}
		}
		return resultMap;
	}

	public Map<String, List<ZValue>> selectedBasicCustomMainMenuMap() throws Exception
	{
		String prefix = "cstmId_";
		Map<String, List<ZValue>> resultMap = new HashMap<String, List<ZValue>>();
		List<ZValue> resultList = infoCustomMadeDAO.selectedBasicCustomMainMenuList();
		List<ZValue> mapValue = null;
		String key = null;
		for(ZValue result : resultList)
		{ 
			key = prefix + result.getString("cstmId");
			mapValue = resultMap.get(key);
			if(mapValue == null)
			{
				mapValue = new ArrayList<ZValue>();
				mapValue.add(result);
				resultMap.put(key, mapValue);
			}
			else
			{
				mapValue.add(result);	
			}
		}
		return resultMap;
	}

	public List<ZValue> selectedBasicCustomMainMenuList() throws Exception
	{
		return infoCustomMadeDAO.selectedBasicCustomMainMenuList();
	}

	public List<ZValue> selectedUserCustomMainMenuList(String cstmMenuNoes) throws Exception
	{
		return infoCustomMadeDAO.selectedUserCustomMainMenuList(cstmMenuNoes);
	}

	public List<ZValue> selectUserCustomMainMenuList(ZValue zvl) throws Exception
	{
		return infoCustomMadeDAO.selectUserCustomMainMenuList(zvl);
	}

	public List<ZValue> selectBasicCustomMainMenuList() throws Exception
	{
		return infoCustomMadeDAO.selectBasicCustomMainMenuList();
	}

	public List<ZValue> selectCustomMainMenuCategorySortOrdrList() throws Exception
	{
		return infoCustomMadeDAO.selectCustomMainMenuCategorySortOrdrList();
	}

	public ZValue selectCustomMainMenuCategory(String categoryId) throws Exception
	{
		return infoCustomMadeDAO.selectCustomMainMenuCategory(categoryId);
	}

	public void delCustomMainMenu(ZValue zvl) throws Exception
	{	
		infoCustomMadeDAO.delCustomMainMenu(zvl);
	}

	public void delCustomMainMenuCategory(String categoryId) throws Exception
	{	
		infoCustomMadeDAO.delCustomMainMenuCategory(categoryId);
		infoCustomMadeDAO.delCustomMainMenuByCategoryId(categoryId);
	}

	public void updateCustomMainMenuCategory(ZValue zvl) throws Exception
	{	
		infoCustomMadeDAO.updateCustomMainMenuCategory(zvl);
	}

	public void updateCustomMainMenu(ZValue zvl) throws Exception
	{	
		infoCustomMadeDAO.updateCustomMainMenu(zvl);
	}

	public List<ZValue> selectCustomMainMenuA(ZValue zvl) throws Exception
	{	
		return infoCustomMadeDAO.selectCustomMainMenuA(zvl);
	}

	public List<ZValue> selectedCustomMainMenuA(String categoryId) throws Exception
	{	
		return infoCustomMadeDAO.selectedCustomMainMenuA(categoryId);
	}
	
	public void addCustomMainMenu(ZValue zvl) throws Exception
	{	
		String cstmId = zvl.getString("cstmId");
    	
		ArrayList<String> checkFieldes = zvl.getArrayList("checkFieldes");
		ZValue param = null;
		for(int i=0; i<checkFieldes.size(); i++)
		{
			param = new ZValue();
			param.put("cstmId", cstmId);
			param.put("categoryId", checkFieldes.get(i));
			infoCustomMadeDAO.addCustomMainMenu(param);
		}
    	    	
	}

}

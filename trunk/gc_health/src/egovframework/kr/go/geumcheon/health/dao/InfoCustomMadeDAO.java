package egovframework.kr.go.geumcheon.health.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("infoCustomMadeDAO")
public class InfoCustomMadeDAO extends EgovAbstractDAO{

	public void addFavorite(ZValue zvl) throws Exception
	{	
		insert("infoCustomMadeDAO.addFavorite", zvl);
	}

	public List<ZValue> selectFavoriteByUserId(ZValue zvl) throws Exception
	{
		return list("infoCustomMadeDAO.selectFavoriteByUserId", zvl);
	}
	
	public int selectFavoriteByUserIdCnt(String userId) throws Exception
	{
		return (Integer)selectByPk("infoCustomMadeDAO.selectFavoriteByUserIdCnt", userId);
	}

	public int selectFavoriteCnt(ZValue zvl) throws Exception
	{
		return (Integer)selectByPk("infoCustomMadeDAO.selectFavoriteCnt", zvl);
	}

	public void delFavorite(ZValue zvl) throws Exception
	{	
		delete("infoCustomMadeDAO.delFavorite", zvl);
	}

	public void addCustomMainMenuCategory(ZValue zvl) throws Exception
	{	
		insert("infoCustomMadeDAO.addCustomMainMenuCategory", zvl);
	}

	public List<ZValue> selectCustomMainMenuCategorySortOrdrList() throws Exception
	{
		return list("infoCustomMadeDAO.selectCustomMainMenuCategorySortOrdrList", null);
	}

	public List<ZValue> selectCustomMainMenuCategoryList() throws Exception
	{
		return list("infoCustomMadeDAO.selectCustomMainMenuCategoryList", null);
	}

	public List<ZValue> selectUserCustomMainMenuList(ZValue zvl) throws Exception
	{
		return list("infoCustomMadeDAO.selectUserCustomMainMenuList", zvl);
	}

	public List<ZValue> selectedBasicCustomMainMenuList() throws Exception
	{
		return list("infoCustomMadeDAO.selectedBasicCustomMainMenuList", null);
	}

	public List<ZValue> selectedUserCustomMainMenuList(String cstmMenuNoes) throws Exception
	{
		return list("infoCustomMadeDAO.selectedUserCustomMainMenuList", cstmMenuNoes);
	}

	public List<String> getSelectCustomMainMenuNo(String categoryId) throws Exception
	{
		return list("infoCustomMadeDAO.getSelectCustomMainMenuNo", categoryId);
	}

	public List<ZValue> selectBasicCustomMainMenuList() throws Exception
	{
		return list("infoCustomMadeDAO.selectBasicCustomMainMenuList", null);
	}

	public ZValue selectCustomMainMenuCategory(String categoryId) throws Exception
	{
		return (ZValue)selectByPk("infoCustomMadeDAO.selectCustomMainMenuCategory", categoryId);
	}

	public void delCustomMainMenuCategory(String categoryId) throws Exception
	{	
		delete("infoCustomMadeDAO.delCustomMainMenuCategory", categoryId);
	}

	public void updateCustomMainMenuCategory(ZValue zvl) throws Exception
	{	
		update("infoCustomMadeDAO.updateCustomMainMenuCategory", zvl);
	}

	public List<ZValue> selectCustomMainMenuA(ZValue zvl) throws Exception
	{
		return list("infoCustomMadeDAO.selectCustomMainMenuA", zvl);
	}

	public List<ZValue> selectedCustomMainMenuA(String categoryId) throws Exception
	{
		return list("infoCustomMadeDAO.selectedCustomMainMenuA", categoryId);
	}

	public void addCustomMainMenu(ZValue zvl) throws Exception
	{	
		insert("infoCustomMadeDAO.addCustomMainMenu", zvl);
	}

	public void updateCustomMainMenu(ZValue zvl) throws Exception
	{	
		update("infoCustomMadeDAO.updateCustomMainMenu", zvl);
	}

	public void delCustomMainMenu(ZValue zvl) throws Exception
	{	
		delete("infoCustomMadeDAO.delCustomMainMenu", zvl);
	}

	public void delCustomMainMenuByCategoryId(String categoryId) throws Exception
	{	
		delete("infoCustomMadeDAO.delCustomMainMenuByCategoryId", categoryId);
	}

}

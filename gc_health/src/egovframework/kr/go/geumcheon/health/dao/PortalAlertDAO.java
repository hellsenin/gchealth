package egovframework.kr.go.geumcheon.health.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.springframework.ui.ModelMap;

import egovframework.kr.go.geumcheon.health.vo.PortalAlert;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("PortalAlertDAO")
public class PortalAlertDAO extends EgovAbstractDAO {

	public int selectPortalAlertPK() {
		return (Integer) getSqlMapClientTemplate().queryForObject("PortalAlertDAO.selectPortalAlertPK");
	}
	
	public int selectListTotCnt(PortalAlert bean) {
		return (Integer)getSqlMapClientTemplate().queryForObject("PortalAlertDAO.selectPortalAlertListTotCnt", bean);
	}

    @SuppressWarnings("unchecked")
	public List<PortalAlert> selectList(PortalAlert bean) {
    	List<PortalAlert> resultMany = null;
    	try {
    		resultMany = (List<PortalAlert>) list("PortalAlertDAO.selectPortalAlertList", bean);
    	} catch (Exception e) {
    		e.printStackTrace();
		}
    	return resultMany;
	}
    
    public PortalAlert select(PortalAlert bean, ModelMap model) {
    	PortalAlert resultOne = null;
    	try {
    		resultOne = (PortalAlert) selectByPk("PortalAlertDAO.selectPortalAlertDetail", bean);
    	} catch (Exception e) {
			e.printStackTrace();
		}
    	return resultOne; 
	}

    @SuppressWarnings("unchecked")
	public List<PortalAlert> selectPublishList(PortalAlert bean) {
    	List<PortalAlert> resultMany = null;
    	try {
    		resultMany = (List<PortalAlert>) list("PortalAlertDAO.selectPublishList", bean);
    	} catch (Exception e) {
    		e.printStackTrace();
		}
    	return resultMany;
	}
    
	public void insert(PortalAlert bean) {
		try {
			insert("PortalAlertDAO.insertPortalAlert", bean);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void update(PortalAlert bean) {
		try {
			update("PortalAlertDAO.updatePortalAlert", bean);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void delete(PortalAlert bean) {
		delete("PortalAlertDAO.deletePortalAlert", bean);
	}
}
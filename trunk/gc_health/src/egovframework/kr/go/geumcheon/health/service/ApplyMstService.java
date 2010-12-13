package egovframework.kr.go.geumcheon.health.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import egovframework.kr.go.geumcheon.health.dao.ApplyMstDAO;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Service("applyMstService")
public class ApplyMstService {

    Logger log = Logger.getLogger(this.getClass());

    public static final String BASIC_APPLY = "1";
    public static final String EDUCATION_APPLY = "2";
    
	@Resource(name="applyMstDAO")
	private ApplyMstDAO applyMstDAO; 

    @Resource(name = "egovApplyMstrIdGnrService")
    private EgovIdGnrService idgenService;		
		
	public void addApplyMst(ZValue zvl) throws Exception
	{
		String applyCode = idgenService.getNextStringId();
		zvl.put("applyCode", applyCode);
		applyMstDAO.addApplyMst(zvl);
	}

	public void modifyApplyMst(ZValue zvl) throws Exception
	{
		applyMstDAO.modifyApplyMst(zvl);
	}

	public ZValue selectApplyMst(String applyCode) throws Exception
	{
		return applyMstDAO.selectApplyMst(applyCode);
	}

	public int selectApplyMstListCnt(ZValue zvl) throws Exception
	{
		return applyMstDAO.selectApplyMstListCnt(zvl);
	}

	public List<ZValue> selectApplyMstList(ZValue zvl) throws Exception
	{
		return applyMstDAO.selectApplyMstList(zvl);
	}

}

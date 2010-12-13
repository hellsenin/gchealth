package egovframework.kr.go.geumcheon.health.dao;

import java.util.Iterator;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.FileVO;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.kr.go.geumcheon.health.vo.MinwonFileVO;
import egovframework.rte.fdl.string.EgovStringUtil;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("applyDAO")
public class ApplyDAO  extends EgovAbstractDAO{

	public int selectApplyId(String applyKey) throws Exception
	{
		return (Integer)selectByPk("applyDAO.selectApplyId", applyKey);
	}
	
	public void apply(ZValue zvl) throws Exception{
		insert("applyDAO.apply", zvl);
	}
	
	public void addFile(List fileList, ZValue zvl) throws Exception
	{
		Iterator iter = fileList.iterator();
		while (iter.hasNext()) {
			FileVO vo = (FileVO)iter.next();

			MinwonFileVO fvo = new MinwonFileVO();
			fvo.setApplyId(zvl.getInt("applyId"));
			fvo.setAnswerId(zvl.getInt("answerId"));
			fvo.setFileExt(vo.getFileExtsn());
			fvo.setFileName(vo.getStreFileNm());
			fvo.setFilePath(vo.getFileStreCours());
			fvo.setFileSize(EgovStringUtil.string2integer(vo.getFileMg()));
			fvo.setOrgFileName(vo.getOrignlFileNm());
			fvo.setApplyCode(zvl.getString("applyCode"));
			
			fvo.setFileFieldName(vo.getFileFiledNm());
			
		    insert("applyDAO.addFile", fvo);
		}		
	}

	public void addApplyFile(ZValue zvl) throws Exception
	{
		insert("applyDAO.addApplyFile", zvl);
	}

	public List selectApplyListById(ZValue zvl) throws Exception
	{
        return list("applyDAO.selectApplyListById", zvl);
	}

	public void delFile(String fileId) throws Exception
	{
		delete("applyDAO.delFile", fileId);
	}

	public void delApplyFile(ZValue zvl) throws Exception
	{
		delete("applyDAO.delApplyFile", zvl);
	}
	
	public int selectApplyListCntById(ZValue zvl) throws Exception
	{
		return (Integer)getSqlMapClientTemplate().queryForObject("applyDAO.selectApplyListCntById", zvl);
	}

	public List selectApplyList(ZValue zvl) throws Exception
	{
        return list("applyDAO.selectApplyList", zvl);
	}

	public int selectApplyListCnt(ZValue zvl) throws Exception
	{
		return (Integer)getSqlMapClientTemplate().queryForObject("applyDAO.selectApplyListCnt", zvl);
	}

	public List selectApplyListA(ZValue zvl) throws Exception
	{
        return list("applyDAO.selectApplyListA", zvl);
	}

	public List excelSelectApplyListA(ZValue zvl) throws Exception
	{
        return list("applyDAO.excelSelectApplyListA", zvl);
	}
	
	public int selectApplyListCntA(ZValue zvl) throws Exception
	{
		return (Integer)getSqlMapClientTemplate().queryForObject("applyDAO.selectApplyListCntA", zvl);
	}

	public List selectFileListById(ZValue zvl) throws Exception
	{
        return list("applyDAO.selectFileListById", zvl);
	}
	
	public ZValue selectFileByFileId(String id) throws Exception
	{
		return (ZValue)selectByPk("applyDAO.selectFileByFileId", id);
	}

	public ZValue selectApplyView(ZValue zvl) throws Exception
	{
		return (ZValue)selectByPk("applyDAO.selectApplyView", zvl);
	}

	public ZValue selectPetitionView(ZValue zvl) throws Exception
	{
		return (ZValue)selectByPk("applyDAO.selectPetitionView", zvl);
	}

	public ZValue selectApplyViewByApplyId(ZValue zvl) throws Exception
	{
		return (ZValue)selectByPk("applyDAO.selectApplyViewByApplyId", zvl);
	}

	public void updateApplyByApplyId(ZValue zvl) throws Exception
	{
		update("applyDAO.updateApplyByApplyId", zvl);
	}

	public void deleteApplyByApplyId(ZValue zvl) throws Exception
	{
		delete("applyDAO.deleteApplyByApplyId", zvl);
	}

	public List selectAnswerList(ZValue zvl) throws Exception
	{
        return list("applyDAO.selectAnswerList", zvl);
	}

	public List selectAssignedDeptList(ZValue zvl) throws Exception
	{
        return list("applyDAO.selectAssignedDeptList", zvl);
	}

	public void addAnswer(ZValue zvl) throws Exception
	{
		insert("applyDAO.addAnswer", zvl);
	}

	public void updateAnswer(ZValue zvl) throws Exception
	{
		insert("applyDAO.updateAnswer", zvl);
	}

	public void updateAssignedDeptAnswer(ZValue zvl) throws Exception
	{
		insert("applyDAO.updateAssignedDeptAnswer", zvl);
	}

	public void assignDept(ZValue zvl) throws Exception
	{
		insert("applyDAO.assignDept", zvl);
	}

	public void assignPersonInCharge(ZValue zvl) throws Exception
	{
		update("applyDAO.assignPersonInCharge", zvl);
	}

	public void updateDeadline(ZValue zvl) throws Exception
	{
		update("applyDAO.updateDeadline", zvl);
	}

	public void deleteAssignedDept(ZValue zvl) throws Exception
	{
		delete("applyDAO.deleteAssignedDept", zvl);
	}

	public ZValue selectApplyStatus(ZValue zvl) throws Exception
	{
        return (ZValue)getSqlMapClientTemplate().queryForObject("applyDAO.selectApplyStatus", zvl);
	}

	public void updateStatus(ZValue zvl) throws Exception
	{
		update("applyDAO.updateStatus", zvl);
	}

	public void updateAnswerStatus(ZValue zvl) throws Exception
	{
		update("applyDAO.updateAnswerStatus", zvl);
	}

	public void changeStatus(ZValue zvl) throws Exception
	{
		update("applyDAO.changeStatus", zvl);
	}

	public void changeAnswerStatus(ZValue zvl) throws Exception
	{
		update("applyDAO.changeAnswerStatus", zvl);
	}

	public void exceptApplicant(ZValue zvl) throws Exception
	{
		update("applyDAO.exceptApplicant", zvl);
	}

	public void cancelApply(ZValue zvl) throws Exception
	{
		update("applyDAO.cancelApply", zvl);
	}

	public void addHit(ZValue zvl) throws Exception
	{
		update("applyDAO.addHit", zvl);
	}

	public void transferApply(ZValue zvl) throws Exception
	{
		update("applyDAO.transferApply", zvl);
	}

	public int selectMaxNttId() throws Exception
	{
		return (Integer)selectByPk("applyDAO.selectMaxNttId", null);
	}

	public void transferApplyToFAQ(ZValue zvl) throws Exception
	{
		insert("applyDAO.transferApplyToFAQ", zvl);
	}

	public ZValue selectUserAnswer(ZValue zvl) throws Exception
	{
        return (ZValue)selectByPk("applyDAO.selectUserAnswer", zvl);
	}

	public ZValue selectAnswer(String answerId) throws Exception
	{
        return (ZValue)selectByPk("applyDAO.selectAnswer", answerId);
	}

	public int selectAnswerStatusByUserIdAndApplyId(ZValue zvl) throws Exception
	{
        return (Integer)selectByPk("applyDAO.selectAnswerStatusByUserIdAndApplyId", zvl);
	}

	public int selectOnlineApplyCnt(ZValue zvl) throws Exception
	{
        return (Integer)selectByPk("applyDAO.selectOnlineApplyCnt", zvl);
	}

}

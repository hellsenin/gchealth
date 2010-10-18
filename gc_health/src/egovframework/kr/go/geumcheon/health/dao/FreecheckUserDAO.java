package egovframework.kr.go.geumcheon.health.dao;


import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.kr.go.geumcheon.health.vo.Answer;
import egovframework.kr.go.geumcheon.health.vo.Company;
import egovframework.kr.go.geumcheon.health.vo.Handleitem;
import egovframework.kr.go.geumcheon.health.vo.Master;
import egovframework.kr.go.geumcheon.health.vo.Question2;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("FreecheckUserDAO")
public class FreecheckUserDAO extends EgovAbstractDAO {
	

	/**
	 * 자율점검 사용자 로그인
	 * @param bean
	 * @return
	 */
	public Company loginFreecheck(Company bean) {
		return (Company) selectByPk("FreecheckUserDAO.loginFreecheck", bean);
	}

	public List selectMasterCdDataByCompany(String id) {
		return list("FreecheckUserDAO.selectMasterCdDataByCompany", id);
	}
	
	public String selectCompanyTypeInfo(Company bean) {
		return (String) selectByPk("FreecheckUserDAO.selectCompanyTypeInfo", bean);
	}

	public int selectCheckStateListTotCnt(Company bean) {
		return (Integer) selectByPk("FreecheckUserDAO.selectCheckStateListTotCnt", bean);
	}

	public List<HashMap> selectCheckStateList(Company bean) {
//		return (List<HashMap>) list("FreecheckUserDAO.selectCheckStateList", bean);
		return (List<HashMap>) list("FreecheckUserDAO.checkListState", bean);
		
	}

	/**
	 * 점검 대상(HETB_CK_MASTER)에 대한 업체 기본 정보(HETB_CK_ANSWER) (질문 불러오기 1/4) : 점검 대상(HETB_CK_ANSWER) 불러오기
	 * @param bean
	 * @return
	 */
	public HashMap selectCompanyInfo(Company bean) {
		return (HashMap) selectByPk("FreecheckUserDAO.selectCompanyInfo", bean);
	}

	/**
	 * 점검 대상(HETB_CK_MASTER)에 대한 업체 기본 정보(HETB_CK_ANSWER) (질문 불러오기 1/4) : 점검 대상(HETB_CK_ANSWER) 불러오기
	 * @param bean
	 * @return
	 */
	public HashMap selectCompanyInfoAnswer(Company bean) {
		return (HashMap) selectByPk("FreecheckUserDAO.selectCompanyInfoAnswer", bean);
	}
	
	
	/**
	 * 점검 대상(HETB_CK_MASTER)에 대한 점검 항목 불러오기 (질문 불러오기 2/4) : 점검 대상(HETB_CK_MASTER) 불러오기
	 * @param bean
	 * @return
	 */
	public Master selectMaster(Company bean) {
		return (Master) selectByPk("FreecheckUserDAO.selectMaster", bean);
	}

	/**
	 * 점검 대상(HETB_CK_MASTER)에 대한 점검 항목 불러오기 (질문 불러오기 3/4) : 점검 항목(HETB_CK_QUESTION) 불러오기
	 * @param bean
	 * @return
	 */
	public List<HashMap> selectQuestion(Company bean) {
		return (List<HashMap>) list("FreecheckUserDAO.selectQuestion", bean);
	}
	
	/**
	 * 점검 대상(HETB_CK_MASTER)에 대한 점검 항목 불러오기 (질문 불러오기 4/4) : 점검 항목의 선택할 수 있는 질문의 선택형 답변(?) 항목 (HETB_CK_QUESTION2) 불러오기
	 * @param bean
	 * @return
	 */
	public List<HashMap> selectAnswer(Question2 bean) {
		return (List<HashMap>) list("FreecheckUserDAO.selectAnswer", bean);
	}
	

	/**
	 * 점검 대상(HETB_CK_MASTER)에 대한 점검 항목 불러오기 (질문 불러오기 4/4) : 점검 항목의 선택할 수 있는 질문의 선택형 답변(?) 항목 (HETB_CK_QUESTION2) 불러오기
	 * @param bean
	 * @return
	 */
	public List<Handleitem> selectHandleItemList(Answer bean) {
		return (List<Handleitem>) list("FreecheckUserDAO.selectHandleItemList", bean);
	}
	public void deleteHandleItem(Handleitem bean) {
		insert("FreecheckUserDAO.deleteHandleItem", bean);
	}
	public void updateHandleItem(Handleitem bean) {
		update("FreecheckUserDAO.updateHandleItem", bean);
	}
	public void insertHandleItem(Handleitem bean) {
		delete("FreecheckUserDAO.insertHandleItem", bean);
	}

	
	

	public List<HashMap> selectNextFreecheck(Company bean) {
		return (List<HashMap>) list("FreecheckUserDAO.selectNextFreecheck", bean);
		
	}

	/**
	 * 점검 대상(HETB_CK_MASTER)에 대한 점검 항목 불러오기 (질문 불러오기 4/4-2) : 점검 항목의 선택할 수 있는 질문의 선택형 답변(?) 항목 (HETB_CK_QUESTION2) 불러오기
	 * @param bean
	 * @return
	 */
	public void checkQuestion(Answer bean) {
		insert ("FreecheckUserDAO.checkQuestion", bean);
	}

	public void checkQuestion2(Answer bean) {
		insert ("FreecheckUserDAO.checkQuestion2", bean);
	}

	public void checkUpdateQuestion(Answer bean) {
		update("FreecheckUserDAO.checkUpdateQuestion", bean);
		update("FreecheckUserDAO.updateCompanyInfoForQuestion", bean);
	}

	public void deleteCheckedQuestion2(Answer bean) {
		insert ("FreecheckUserDAO.deleteCheckedQuestion2", bean);
	}
	

	public ZValue actionLogin(ZValue zvl) throws Exception
	{
		return (ZValue)selectByPk("memberDAO.actionLogin", zvl);
	}

	public List<ZValue> selectItemListForCheck(int masterCd) throws Exception
	{
		return list("FreecheckUserDAO.selectItemListForCheck", masterCd);
	}

	public void addHandleitem(ZValue zvl) {
		insert ("FreecheckUserDAO.addHandleitem", zvl);
	}

	public void delHandleitem(Company company) {
		insert ("FreecheckUserDAO.delHandleitem", company);
	}

	public List<ZValue> selectHandleitemListU(Company company) throws Exception
	{
		return list("FreecheckUserDAO.selectHandleitemListU", company);
	}

}

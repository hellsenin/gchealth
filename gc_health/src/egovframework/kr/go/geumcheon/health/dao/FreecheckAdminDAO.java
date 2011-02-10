package egovframework.kr.go.geumcheon.health.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.utl.DateUtil;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.kr.go.geumcheon.health.vo.Company;
import egovframework.kr.go.geumcheon.health.vo.Handleitem;
import egovframework.kr.go.geumcheon.health.vo.Industry;
import egovframework.kr.go.geumcheon.health.vo.Master;
import egovframework.kr.go.geumcheon.health.vo.Question;
import egovframework.kr.go.geumcheon.health.vo.Question2;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("FreecheckAdminDAO")
public class FreecheckAdminDAO extends EgovAbstractDAO {

	public int selectIndustryListTotCnt(Industry bean) {
		return (Integer) selectByPk("FreecheckAdminDAO.selectIndustryListTotCnt", bean);
	}
	public int selectIndustryListTotCnt2(Industry bean) {
		return (Integer) selectByPk("FreecheckAdminDAO.selectIndustryListTotCnt2", bean);
	}
	
	public List<Industry> selectIndustryList(Industry bean) {
		return (List<Industry>) list("FreecheckAdminDAO.selectIndustryList", bean); 
	}

	public Industry selectIndustry(Industry bean) {
		System.out.println(bean.toString());
		return (Industry) selectByPk("FreecheckAdminDAO.selectIndustry", bean); 
	}

	public void insertIndustry(Industry bean) {
		insert("FreecheckAdminDAO.insertIndustry", bean); 
	}

	public void updateIndustry(Industry bean) {
		update("FreecheckAdminDAO.updateIndustry", bean); 
	}
	
	public void deleteIndustry(Industry bean) {
		update("FreecheckAdminDAO.deleteIndustry", bean); 
	}	
	
	public int selectCompanyListTotCnt(Company bean) {
		return (Integer) selectByPk("FreecheckAdminDAO.selectCompanyListTotCnt", bean);
	}

	public List<Company> selectCompanyList(Company bean) {
		return (List<Company>) list("FreecheckAdminDAO.selectCompanyList", bean); 
	}

	public List<String> selectCheckListByCompany(int companyCd) {
		return (List<String>) list("FreecheckAdminDAO.selectCheckListByCompany", companyCd); 
	}
	
	public List<Industry> selectIndustryListForSelection(Industry industry) {
		return (List<Industry>) list("FreecheckAdminDAO.selectIndustryListForSelection", industry); 
	}
	
	public Company selectCompany(Company bean) {
		return (Company) selectByPk("FreecheckAdminDAO.selectCompany", bean); 
	}
	
	public int checkCompanyId(Company bean) {
		return (Integer) selectByPk("FreecheckAdminDAO.checkCompanyId", bean);
	}
	
	public String generateCompanyId(Company bean) {
		int industry_cd = bean.getIndustry_cd();
		String key1 = String.valueOf(DateUtil.getYear());
		String key2 = String.format("%02d", industry_cd);
		String key3 = (String) selectByPk("FreecheckAdminDAO.selectCompanyNextKey", industry_cd);
		if(key3 == null) key3 = "0000";
		String id = key1+key2+key3;
		return id;
	}
	
	public void insertCompany(Company bean) {
		String key1 = (String) selectByPk("FreecheckAdminDAO.selectDivideCd", bean.getIndustry_cd());;
		String key3 = (String) selectByPk("FreecheckAdminDAO.selectCompanyNextKey", null);
		if(key3 == null) key3 = "0000";
		String id = key1+key3;
		String passwd = 
    		EgovStringUtil.getRandomStr('0', '9') + EgovStringUtil.getRandomStr('0', '9') + 
    		EgovStringUtil.getRandomStr('0', '9') + EgovStringUtil.getRandomStr('0', '9');
		bean.setId(id);
		bean.setPasswd(passwd);
		int existCnt = (Integer) selectByPk("FreecheckAdminDAO.isExistCompanyId", bean.getId());
		if(existCnt == 0) {
			insert("FreecheckAdminDAO.insertCompany", bean); 
			//insert("FreecheckAdminDAO.insertMember", bean);
		} 
	}

	public void updateCompany(Company bean) {
		update("FreecheckAdminDAO.updateCompany", bean); 
	}

	public void deleteCompany(Company bean) {
		delete("FreecheckAdminDAO.deleteCompany", bean); 
	}

	public void deleteCompanyForExcel(ZValue zvl) {
		delete("FreecheckAdminDAO.deleteCompanyForExcel", zvl); 
	}

	public void deleteAnswerForCompanyId(Company bean) {
		delete("FreecheckAdminDAO.deleteAnswerForCompanyId", bean); 
	}

	public void deleteAnswer2ForCompanyId(Company bean) {
		update("FreecheckAdminDAO.deleteAnswer2ForCompanyId", bean); 
	}

	public void deleteHandleItem(Company bean) {
		delete("FreecheckAdminDAO.deleteHandleItem", bean); 
	}
	
	
	public List<HashMap> selectCheckformList(String year_cd) {
		return (List<HashMap>) list("FreecheckAdminDAO.selectCheckformList", year_cd); 
	}
	
	public Master selectCheckform(int master_cd) {
		return (Master) selectByPk("FreecheckAdminDAO.selectCheckform", master_cd); 
	}

	public void insertCheckform(Master bean) {
		insert("FreecheckAdminDAO.insertCheckform", bean); 
	}

	public void deleteCheckformAttachFile(Master bean) {
		update("FreecheckAdminDAO.deleteCheckformAttachFile", bean); 
	}
	
	public void updateCheckform(Master bean) {
		update("FreecheckAdminDAO.updateCheckform", bean); 
	}
	
	public void deleteCheckform(Master bean) {
		update("FreecheckAdminDAO.deleteCheckform", bean); 
	}	
	
	public int selectCheckedCompanyListTotCnt(Master bean) {
		return (Integer) selectByPk("FreecheckAdminDAO.selectCheckedCompanyListTotCnt", bean);
	}

	public List<HashMap> selectCheckedCompanyList(Master bean) {
		return (List<HashMap>) list("FreecheckAdminDAO.selectCheckedCompanyList", bean); 
	}
	
	public List<Handleitem> selectCheckedHandleitemList(Company bean) {
		return (List<Handleitem>) list("FreecheckAdminDAO.selectCheckedHandleitemList", bean); 
	}

	public int selectCheckedHandleitemListTotCnt(Company bean) {
		return (Integer) selectByPk("FreecheckAdminDAO.selectCheckedHandleitemListTotCnt", bean);
	}
	
	public int selectNotCheckedCompanyListTotCnt(Master bean) {
		return (Integer) selectByPk("FreecheckAdminDAO.selectNotCheckedCompanyListTotCnt", bean);
	}
	
	public List<HashMap> selectNotCheckedCompanyList(Master bean) {
		return (List<HashMap>) list("FreecheckAdminDAO.selectNotCheckedCompanyList", bean); 
	}

	public List<HashMap> selectQuestionList(Master bean) {
		return (List<HashMap>) list("FreecheckAdminDAO.selectQuestionList", bean); 
	}

	public List<HashMap> selectAnswerStatisticsList(Master bean) {
		return (List<HashMap>) list("FreecheckAdminDAO.selectAnswerStatisticsList", bean); 
	}

	public List<HashMap> downloadExcelAnswerList(Master bean) {
		return (List<HashMap>) list("FreecheckAdminDAO.downloadExcelAnswerList", bean); 
	}
	

	/* 의약업소 자율점검 (점검표관리) (질문 HETB_CK_QUESTION) : 조회 (단일 레코드)  */
	public HashMap selectQuestion(Question bean) {
		return (HashMap) selectByPk("FreecheckAdminDAO.selectQuestion", bean); 
	}

	/* 의약업소 자율점검 (점검표관리) (질문 HETB_CK_QUESTION) : 입력  */
	public void insertQuestion(Question bean) {
		insert("FreecheckAdminDAO.insertQuestion", bean); 
	}

	/* 의약업소 자율점검 (점검표관리) (질문 HETB_CK_QUESTION) : 수정  */
	public void updateQuestion(Question bean) {
		update("FreecheckAdminDAO.updateQuestion", bean); 
	}

	/* 의약업소 자율점검 (점검표관리) (질문 HETB_CK_QUESTION) : 삭제 */
	public void updateQuestionForDelete(Question bean) {
		update("FreecheckAdminDAO.updateQuestionForDelete", bean); 
	}

	/* 의약업소 자율점검 (점검표관리) (질문HETB_CK_QUESTION1에 대한 답변 항목 HETB_CK_QUESTION2 조회) */
	public List<Question2> selectQuestion2ForUpdate(Question2 bean) {
		return (List<Question2>) list("FreecheckAdminDAO.selectQuestion2ForUpdate", bean); 
	}

	/* 의약업소 자율점검 (점검표관리) (질문HETB_CK_QUESTION1에 대한 답변 항목 HETB_CK_QUESTION2 등록) */
	public void insertQuestion2(Question2 bean) {
		insert("FreecheckAdminDAO.insertQuestion2", bean); 
	}

	/* 의약업소 자율점검 (점검표관리) (질문HETB_CK_QUESTION1에 대한 답변 항목 HETB_CK_QUESTION2 수정) */
	public void updateQuestion2(Question2 bean) {
		update("FreecheckAdminDAO.updateQuestion2", bean); 
	}

	/* 의약업소 자율점검 (점검표관리) (질문HETB_CK_QUESTION1에 대한 답변 항목 HETB_CK_QUESTION2 삭제) */
	public void updateQuestion2ForDelete(Question2 bean) {
		update("FreecheckAdminDAO.updateQuestion2ForDelete", bean); 
	}
	

	/**
	 * 점검표별 업소리스트 
	 * @param bean
	 * @return
	 */
	public List selectCompanyInfoList(Company bean) {
		return (List) list("FreecheckUserDAO.selectCompanyInfoAnswerList", bean);
	}

	public List selectCheckedQuestionCntList(Company bean) {
		return list("FreecheckAdminDAO.selectCheckedQuestionCntList", bean);
	}

	public List selectWrongQuestionList(Company bean) {
		return list("FreecheckAdminDAO.selectWrongQuestionList", bean);
	}

	public List selectLinkedMasterList() {
		return list("FreecheckAdminDAO.selectLinkedMasterList", null);
	}

	public List<ZValue> selectIndustryAttrList() {
		return list("FreecheckAdminDAO.selectIndustryAttrList", null);
	}

	public List selectLinkedMasterByIndustry(String industryCd) {
		return list("FreecheckAdminDAO.selectLinkedMasterByIndustry", industryCd);
	}

	public List selectMasterListByIndustry(String industryCd) {
		return list("FreecheckAdminDAO.selectMasterListByIndustry", industryCd);
	}

	public void addLinkedMaster(ZValue zvl) {
		insert("FreecheckAdminDAO.addLinkedMaster", zvl);
	}

	public void delLinkedMaster(ZValue zvl) {
		insert("FreecheckAdminDAO.delLinkedMaster", zvl);
	}

	public List<ZValue> selectMasterCompanyPointList(ZValue zvl) {
		return list("FreecheckAdminDAO.selectMasterCompanyPointList", zvl);
	}

	public List<ZValue> selectMasterListForItem(String yearCd) {
		return list("FreecheckAdminDAO.selectMasterListForItem", yearCd);
	}

	public List<ZValue> selectItemList(String yearCd) {
		return list("FreecheckAdminDAO.selectItemList", yearCd);
	}

	public void addItem(ZValue zvl) {
		insert("FreecheckAdminDAO.addItem", zvl);
	}

	public void delItem(int itemId) {
		delete("FreecheckAdminDAO.delItem", itemId);
	}

	public void deleteMasterForMigration(ZValue zvl) {
		delete("FreecheckAdminDAO.deleteMasterForMigration", zvl);
	}

	public void deleteQuestionForMigration(ZValue zvl) {
		delete("FreecheckAdminDAO.deleteQuestionForMigration", zvl);
	}

	public void deleteQuestion2ForMigration(ZValue zvl) {
		delete("FreecheckAdminDAO.deleteQuestion2ForMigration", zvl);
	}

	public void addCompanyForMigration(ZValue zvl) {
		insert("FreecheckAdminDAO.addCompanyForMigration", zvl);
	}

	public void deleteCompanyForMigration(ZValue zvl) {
		insert("FreecheckAdminDAO.deleteCompanyForMigration", zvl);
	}

	public List<Integer> selectAFMasterCdForMigration(ZValue zvl) {
		return (List<Integer>) list("FreecheckAdminDAO.selectAFMasterCdForMigration", zvl);
	}
	
	public List<Integer> selectMasterCdForMigration(ZValue zvl) {
		return (List<Integer>) list("FreecheckAdminDAO.selectMasterCdForMigration", zvl);
	}

	public List<Integer> selectQuestionCdForMigration(ZValue zvl) {
		return (List<Integer>) list("FreecheckAdminDAO.selectQuestionCdForMigration", zvl);
	}
	
	public int selectMasterCdPKForMigration() {
		return (Integer) selectByPk("FreecheckAdminDAO.selectMasterCdPKForMigration", null);
	}

	public int selectQuestionCdPKForMigration() {
		return (Integer) selectByPk("FreecheckAdminDAO.selectQuestionCdPKForMigration", null);
	}
	
	public void addMasterForMigration(ZValue zvl) {
		insert("FreecheckAdminDAO.addMasterForMigration", zvl);
	}

	public void addQuestionForMigration(ZValue zvl) {
		insert("FreecheckAdminDAO.addQuestionForMigration", zvl);
	}

	public void addQuestion2ForMigration(ZValue zvl) {
		insert("FreecheckAdminDAO.addQuestion2ForMigration", zvl);
	}

}

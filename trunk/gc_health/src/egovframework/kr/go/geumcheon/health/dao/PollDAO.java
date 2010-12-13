package egovframework.kr.go.geumcheon.health.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.kr.go.geumcheon.health.vo.Answer;
import egovframework.kr.go.geumcheon.health.vo.Company;
import egovframework.kr.go.geumcheon.health.vo.Master;
import egovframework.kr.go.geumcheon.health.vo.Question;
import egovframework.kr.go.geumcheon.health.vo.Question2;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("pollDAO")
public class PollDAO extends EgovAbstractDAO {

	public List<HashMap> selectCheckformList(String year_cd) {
		return (List<HashMap>) list("pollDAO.selectCheckformList", year_cd); 
	}

	public void insertCheckform(Master bean) {
		insert("pollDAO.insertCheckform", bean); 
	}

	public Master selectCheckform(int master_cd) {
		return (Master) selectByPk("pollDAO.selectCheckform", master_cd); 
	}

	public void updateCheckform(Master bean) {
		update("pollDAO.updateCheckform", bean); 
	}

	public List<HashMap> selectQuestionList(Master bean) {
		return (List<HashMap>) list("pollDAO.selectQuestionList", bean); 
	}

	public List<HashMap> selectTestQuestionList(Master bean) {
		return (List<HashMap>) list("pollDAO.selectTestQuestionList", bean); 
	}

	public List<HashMap> selectAnswerStatisticsList(Master bean) {
		return (List<HashMap>) list("pollDAO.selectAnswerStatisticsList", bean); 
	}

	public List<HashMap> selectTestAnswerStatisticsList(Master bean) {
		return (List<HashMap>) list("pollDAO.selectTestAnswerStatisticsList", bean); 
	}

	public void insertQuestion(Question bean) {
		insert("pollDAO.insertQuestion", bean); 
	}

	public HashMap selectQuestion(Question bean) {
		return (HashMap) selectByPk("pollDAO.selectQuestion", bean); 
	}

	public void updateQuestion(Question bean) {
		update("pollDAO.updateQuestion", bean); 
	}
	public List<Question2> selectQuestion2ForUpdate(Question2 bean) {
		return (List<Question2>) list("pollDAO.selectQuestion2ForUpdate", bean); 
	}

	public void insertQuestion2(Question2 bean) {
		insert("pollDAO.insertQuestion2", bean); 
	}

	public void updateQuestion2(Question2 bean) {
		update("pollDAO.updateQuestion2", bean); 
	}

	public Master selectMaster(Company bean) {
		return (Master) selectByPk("pollDAO.selectMaster", bean);
	}

	public List<Master> selectOngoingMasterList(String yearCd) {
		return list("pollDAO.selectOngoingMasterList", yearCd);
	}

	public int selectOngoingMasterListCnt(String yearCd) {
		return (Integer)selectByPk("pollDAO.selectOngoingMasterListCnt", yearCd);
	}

	public List<Master> selectFinishedMasterList(ZValue zvl) {
		return list("pollDAO.selectFinishedMasterList", zvl);
	}

	public int selectFinishedMasterListCnt(String yearCd) {
		return (Integer)selectByPk("pollDAO.selectFinishedMasterListCnt", yearCd);
	}

	public List<HashMap> selectQuestionU(Company bean) {
		return (List<HashMap>) list("pollDAO.selectQuestionU", bean);
	}

	public List<HashMap> selectAnswer(Question2 bean) {
		return (List<HashMap>) list("pollDAO.selectAnswer", bean);
	}

	public void checkQuestion(Answer bean) {
		insert ("pollDAO.checkQuestion", bean);
	}

	public void checkQuestion2(Answer bean) {
		insert ("pollDAO.checkQuestion2", bean);
	}
	
	public List<HashMap> selectAnswerAndResponse(Question2 bean) {
		return (List<HashMap>) list("pollDAO.selectAnswerAndResponse", bean);
	}

	public List<ZValue> selectOtherList(ZValue zvl) {
		return (List<ZValue>) list("pollDAO.selectOtherList", zvl);
	}

	public List<ZValue> selectEssayList(ZValue zvl) {
		return (List<ZValue>) list("pollDAO.selectEssayList", zvl);
	}

	public void updateQuestionForDelete(Question bean) {
		update("pollDAO.updateQuestionForDelete", bean); 
	}

	public int selectTempPollId() {
		return (Integer) selectByPk("pollDAO.selectTempPollId", null); 
	}

	public int selectCheckedListTotCnt(Master bean) {
		return (Integer) selectByPk("pollDAO.selectCheckedListTotCnt", bean);
	}

	public List<HashMap> selectCheckedList(Master bean) {
		return (List<HashMap>) list("pollDAO.selectCheckedList", bean); 
	}

	public void deleteAnswer2ForCompanyId(Company bean) {
		update("pollDAO.deleteAnswer2ForCompanyId", bean); 
	}

	public void delete(int masterCd) {
		delete("pollDAO.deleteAnswer2A", masterCd); 
		delete("pollDAO.deleteQuestion2A", masterCd); 
		delete("pollDAO.deleteQuestionA", masterCd); 
		delete("pollDAO.deleteMasterA", masterCd); 
	}

	public List<HashMap> selectQuestionA(Company bean) {
		return (List<HashMap>) list("pollDAO.selectQuestionA", bean);
	}

	public ZValue selectRescentPoll() {
		return (ZValue)selectByPk("pollDAO.selectRescentPoll", null);
	}
	
	public List<ZValue> selectPollExceptSatisfaction() {
		return list("pollDAO.selectPollExceptSatisfaction", null);
	}

}

package egovframework.kr.go.geumcheon.health.dao;

import java.util.Iterator;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import egovframework.kr.go.geumcheon.health.util.ZValue;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("CommentDAO")
public class CommentDAO  extends EgovAbstractDAO{
	
	public  Log log = LogFactory.getLog(getClass()); 
	
    /**
    * 조건에 맞는 게시물 목록을 조회 한다.
    * 
    * @param boardVO
    * @return
    * @throws Exception
    */
   @SuppressWarnings("unchecked")
   public List<ZValue> selectCommentList(ZValue zvl) throws Exception {
	return list("CommentDAO.selectCommentList", zvl);
   }

   /**
    * 조건에 맞는 게시물 목록에 대한 전체 건수를 조회 한다.
    * 
    * @param boardVO
    * @return
    * @throws Exception
    */
   public int selectCommentListCnt(ZValue zvl) throws Exception {
	return (Integer)getSqlMapClientTemplate().queryForObject("CommentDAO.selectCommentListCnt", zvl);
   }
   
   /**
    * 게시판에 게시물을 등록 한다.
    * 
    * @param board
    * @throws Exception
    */
   public boolean insertCommentArticle(ZValue zvl) {
   	
		try {
			return insert("CommentDAO.insertCommentArticle", zvl) != null;
		} catch (Exception ex) {
			if(log.isErrorEnabled()) {
				if(log.isErrorEnabled()) {	log.error("Insert Fail : ", ex);}
			}
		}
		return false;
		
   }
   
   /**
    * 게시물 한 건을 삭제 한다.
    * 
    * @param board
    * @throws Exception
    */
   public void deleteCommentArticle(ZValue zvl) throws Exception {
   	update("CommentDAO.deleteCommentArticle", zvl);
   }
   
   /**
    * 게시물 한 건을 삭제 한다.
    * 
    * @param board
    * @throws Exception
    */
   /*public int updateCommentState(CommentDto dto) throws Exception {
   	return update("CommentDAO.updateCommentState", dto);
   }*/
   
   /**
    * 게시물 한 건을 삭제 한다.(관리자 용)
    * 
    * @param board
    * @throws Exception
    */
   /*public void deleteCommentArticleForAdmin(CommentDto dto) throws Exception {
   	update("CommentDAO.deleteCommentArticleForAdmin", dto);
   }*/

}

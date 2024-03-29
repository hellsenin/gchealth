package egovframework.com.utl.pao.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.utl.pao.service.PrntngOutptVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 
 * 전자관인에서 사용해야 하는 서비스를 정의하기위한 데이터 접근 클래스
 * @author 공통서비스 개발팀 이중호
 * @since 2009.02.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.02.01  이중호          최초 생성
 *
 * Copyright (C) 2009 by MOPAS  All right reserved.
 * </pre>
 */
@Repository("PrntngOutptDAO")
public class PrntngOutptDAO extends EgovAbstractDAO {

    protected final Log logger = LogFactory.getLog(getClass());

    /**
	 * 주어진 조건에 따른 공통코드를 불러온다.
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public PrntngOutptVO selectErncsl(PrntngOutptVO vo) throws Exception{
		String queryId = "PrntngOutptDAO.selectErncsl";
		return (PrntngOutptVO) getSqlMapClientTemplate().queryForObject(queryId, vo);
	}
	
}

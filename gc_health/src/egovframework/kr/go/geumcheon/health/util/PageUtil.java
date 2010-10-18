package egovframework.kr.go.geumcheon.health.util;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Service("pageUtil")
public class PageUtil 
{
    Logger log = Logger.getLogger(this.getClass());
    
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
	public ZValue getJnPaginationInfo(ZValue zvl)
	{
    	int pageUnit = propertyService.getInt("pageUnit");
    	int pageSize = propertyService.getInt("pageSize");
    	int pageIndex = zvl.getInt("pageIndex", 1);
    	int totalRecordCount = zvl.getInt("totCnt", 1);
    	
    	log.debug(">>>>>>>>totalRecordCount " + totalRecordCount);

		PaginationInfo paginationInfo = new PaginationInfo();		
		paginationInfo.setCurrentPageNo(pageIndex);
		paginationInfo.setRecordCountPerPage(pageUnit);
		paginationInfo.setPageSize(pageSize);
		paginationInfo.setTotalRecordCount(totalRecordCount);

    	zvl.put("pageIndex", pageIndex);
    	zvl.put("pageUnit", pageUnit);
    	zvl.put("pageSize", pageSize);
    	zvl.put("firstIndex", paginationInfo.getFirstRecordIndex());
    	zvl.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
    	zvl.put("totalPageCount", paginationInfo.getTotalPageCount());
    	    	
    	return zvl;
	}
	
	public String getSgPageNavString(ZValue zvl)
	{
		return getSgPageNavString( zvl.getInt("pageSize"), zvl.getInt("totCnt"), zvl.getInt("pageIndex"), zvl.getString("link") );
	}
	
	public String getSgPageNavString( int pageSize, int total, int cpage, String link ) 
	{
		// 전체페이지
		int totalPage = (total - 1) / pageSize + 1;
		// 이전10개, 다음10개
		// 이전 마지막 페이지 0 이면 이전10개 없음
		int prev10 = (int) Math.floor((cpage - 1) / 10.0) * 10;
		// 다음 첫페이지 totalPage 보다 크면 다음10개 없음
		int next10 = prev10 + 11;
		StringBuffer sbuf = new StringBuffer();

		if (prev10 > 0) 
		{
			sbuf.append("<li class=\"nopd\"><a href=\"" + link + "&amp;pageIndex=1\"><img src=\"/health/open_content/images/borad/paging_fir.gif\" width=\"19\" height=\"15\" alt=\"처음페이지\" /></a></li>");
			sbuf.append("<li  class=\"nopd\"><a href=\"" + link + "&amp;pageIndex=" +prev10 + "\">");
			sbuf.append("<img src=\"/health/open_content/images/borad/paging_pre.gif\" width=\"19\" height=\"15\" alt=\"이전페이지\" /></a></li>");
		} // end if 이전10개
		else
		{
			sbuf.append("<li class=\"nopd\"><img src=\"/health/open_content/images/borad/paging_fir.gif\" width=\"19\" height=\"15\" alt=\"처음페이지\" /></li>");
			sbuf.append("<li class=\"nopd\"><img src=\"/health/open_content/images/borad/paging_pre.gif\" width=\"19\" height=\"15\" alt=\"이전페이지\" /></li>" );
		}

		for (int i = 1 + prev10; i < next10 && i <= totalPage; i++) 
		{
			if (i == cpage) 
			{
				sbuf.append("<li><span title=\"현재 페이지\">"+i+"</span></li>");
			} 
			else 
			{
				sbuf.append("<li><a href=\"" +link + "&amp;pageIndex="+i + "\">"+i+"</a></li>");
			} // end if 현재페이지 링크제거
		} // end for

		if (totalPage >= next10) 
		{
			sbuf.append("<li class=\"nopd\"><a href=\"" + link + "&amp;pageIndex=" +next10 + "\" class=\"next\"><img src=\"/health/open_content/images/borad/paging_next.gif\" width=\"19\" height=\"15\" alt=\"다음페이지\" /></a></li>");
			sbuf.append("<li class=\"nopd\"><a href=\"" + link + "&amp;pageIndex=" +totalPage + "\" class=\"last\"><img src=\"/health/open_content/images/borad/paging_end.gif\" width=\"19\" height=\"15\" alt=\"마지막페이지\" /></a></li>");
		} // end if 다음10개
		else
		{
			sbuf.append("<li class=\"nopd\"><img src=\"/health/open_content/images/borad/paging_next.gif\" width=\"19\" height=\"15\" alt=\"다음페이지\" /></li>");
			sbuf.append("<li class=\"nopd\"><img src=\"/health/open_content/images/borad/paging_end.gif\" width=\"19\" height=\"15\" alt=\"마지막페이지\" /></li>");
		}

		return sbuf.toString();
	}
	
	public String getJnPageNavString( int pageSize, int total, int cpage, String link ) 
	{
		// 전체페이지
		int totalPage = (total - 1) / pageSize + 1;
		// 이전10개, 다음10개
		// 이전 마지막 페이지 0 이면 이전10개 없음
		int prev10 = (int) Math.floor((cpage - 1) / 10.0) * 10;
		// 다음 첫페이지 totalPage 보다 크면 다음10개 없음
		int next10 = prev10 + 11;
		StringBuffer sbuf = new StringBuffer();

		if( link.indexOf("?") == -1) link += "?";
		
		if (prev10 > 0) 
		{
			sbuf.append("<a href='" + link + "&amp;pageIndex=1' class='first'><img src='/portal/open_content/images/common/btn/btn_first.gif' class='vam' alt='처음으로' /></a>");
			sbuf.append("<a href='" + link + "&amp;pageIndex=" +prev10 + "' class='prev'>");
			sbuf.append("<img src='/portal/open_content/images/common/btn/btn_prev.gif' class='vam' alt='이전 10페이지' /></a>");
		} // end if 이전10개
		else
		{
			sbuf.append("<img src='/portal/open_content/images/common/btn/btn_first.gif' class='vam' alt='처음으로' />");
			sbuf.append("<img src='/portal/open_content/images/common/btn/btn_prev.gif' class='vam' alt='이전 10페이지' />" );
		}
		
		sbuf.append("<ol>" );
		
		for (int i = 1 + prev10; i < next10 && i <= totalPage; i++) 
		{
			if (i == cpage) 
			{
				if(i==1)
					sbuf.append("<li class=\"nobg\">"+i+"</li>");
				else
					sbuf.append("<li class=\"current\">"+i+"</li>");
			} 
			else 
			{
				sbuf.append("<li><a href='" +link + "&amp;pageIndex="+i + "'>"+i+"</a></li>");
			} // end if 현재페이지 링크제거
		} // end for

		sbuf.append("</ol>" );

		if (totalPage >= next10) 
		{
			sbuf.append("<a href='" + link + "&amp;pageIndex=" +next10 + "' class='next'><img src='/portal/open_content/images/common/btn/btn_next.gif' class='vam' alt='다음 10페이지' /></a>");
			sbuf.append("<a href='" + link + "&amp;pageIndex=" +totalPage + "' class='last'><img src='/portal/open_content/images/common/btn/btn_end.gif' class='vam' alt='맨끝으로' /></a>");
		} // end if 다음10개
		else
		{
			sbuf.append("<img src='/portal/open_content/images/common/btn/btn_next.gif' class='vam' alt='다음 10페이지' />");
			sbuf.append("<img src='/portal/open_content/images/common/btn/btn_end.gif' class='vam' alt='맨끝으로' />");
		}

		return sbuf.toString();
	}

	public String getPageNavStringToFunc( int pageSize, int total, int cpage, String funcName ) 
	{
		// 전체페이지
		int totalPage = (total - 1) / pageSize + 1;
		// 이전10개, 다음10개
		// 이전 마지막 페이지 0 이면 이전10개 없음
		int prev10 = (int) Math.floor((cpage - 1) / 10.0) * 10;
		// 다음 첫페이지 totalPage 보다 크면 다음10개 없음
		int next10 = prev10 + 11;
		StringBuffer sbuf = new StringBuffer();

		if (prev10 > 0) 
		{
			sbuf.append("<a href='javascript:"+funcName+"("+prev10+");'><img src='/portal/open_content/images/common/btn/btn_prev.gif' alt='이전10페이지' /></a>" );
		} // end if 이전10개
		else
		{
			sbuf.append("<img src='/portal/open_content/images/common/btn/btn_prev.gif' alt='이전10페이지' />" );
		}

		for (int i = 1 + prev10; i < next10 && i <= totalPage; i++) 
		{
			sbuf.append(" <a href='javascript:"+funcName+"("+i+");'>").append(i).append("</a> ");
		} // end for

		if (totalPage >= next10) 
		{
			sbuf.append("<a href='javascript:"+funcName+"("+next10+");'><img src='/portal/open_content/images/common/btn/btn_next.gif' alt='다음10페이지' /></a>");
		} // end if 다음10개
		else
		{
			sbuf.append("<img src='/portal/open_content/images/common/btn/btn_next.gif' alt='다음10페이지' />");
		}

		return sbuf.toString();
	}
	
}

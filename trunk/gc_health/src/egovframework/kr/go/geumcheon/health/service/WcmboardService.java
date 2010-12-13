package egovframework.kr.go.geumcheon.health.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntity;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.entity.mime.content.StringBody;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import sun.misc.BASE64Encoder;
import egovframework.kr.go.geumcheon.health.dao.WcmboardDAO;
import egovframework.kr.go.geumcheon.health.util.ZValue;

@Service("wcmboardService") 
public class WcmboardService {

    Logger log = Logger.getLogger(this.getClass());

	@Resource(name="wcmboardDAO")
	private WcmboardDAO wcmboardDAO; 

	public ZValue selectWcmboard(ZValue zvl) throws Exception
	{
		return wcmboardDAO.selectWcmboard(zvl);
	}

	public List<ZValue> selectWcmboardFileListByBoardId(ZValue zvl) throws Exception
	{
		List<ZValue> fileList = new ArrayList<ZValue>();
		List<ZValue> _fileList = wcmboardDAO.selectWcmboardFileListByBoardId(zvl);

		for(ZValue val : _fileList)
		{
			String fileAppdId = val.getString("fileAppdId");
			if(!"".equals(fileAppdId))
			{
				fileAppdId = "!@#$"+fileAppdId +"--$$";
				fileAppdId = new BASE64Encoder().encode(fileAppdId.getBytes());
				val.set("fileAppdId", fileAppdId);
			}
			fileList.add(val);
		}
		
		return fileList;
	}

	public HashMap<String, List<ZValue>> selectWcmboardFileMap(ZValue zvl) throws Exception
	{
		List<ZValue> fileList = wcmboardDAO.selectWcmboardFileList(zvl);
		
		return getFileMap(fileList);
	}

	public List<ZValue> selectWcmboardList(ZValue zvl) throws Exception
	{
    	return wcmboardDAO.selectWcmboardList(zvl);
	}
	
	public int selectWcmboardListCnt(ZValue zvl) throws Exception
	{
    	return wcmboardDAO.selectWcmboardListCnt(zvl);
	}

	public boolean uploadTempExcel() throws Exception
	{
		boolean result = true;
			    
	    try
	    {
	    	File f = new File("c:/GIS2.xls");
	    	if(!f.exists())
	    	{
	    		log.debug("File not exist!!!!!! ");
	    		return false;
	    	}
	    		    	
			Workbook workbook = Workbook.getWorkbook(f); 
			Sheet sheet = workbook.getSheet(0); 
			Cell boardIdCell;
			Cell titleCell;
			Cell etc1Cell;
			Cell etc8Cell;
			Cell etc9Cell;
	
			ArrayList<ZValue> dataList = new ArrayList<ZValue>();
			int colLen = sheet.getColumn(0).length;
			
			for(int j = 1 ; j <= colLen - 1 ; j++)
			{
				boardIdCell = sheet.getCell(0,j); 
				titleCell = sheet.getCell(1,j);     
				etc1Cell = sheet.getCell(2,j);       
				etc8Cell = sheet.getCell(3,j);  
				etc9Cell = sheet.getCell(4,j);
				
				ZValue data = new ZValue();
				data.put("boardId", boardIdCell.getContents());
				data.put("etc8", etc8Cell.getContents());
				data.put("etc9", etc9Cell.getContents());
								
				dataList.add(data);
			}
		
			for(ZValue data : dataList)
			{
				wcmboardDAO.updateB0048(data);
			}
		
	    }
	    catch(Exception e)
	    {
	    	e.printStackTrace();
	    	result = false;
	    }
	    
	    return result;
	}
	
	public void addWcmboardToGc() throws Exception
	{
		HttpClient httpclient = new DefaultHttpClient();
		HttpPost httppost = new HttpPost("http://admin.geumcheon.go.kr:9081/cms/board/board1/InsertBoard.jsp?fileSize=&community_id=B0034");

		MultipartEntity reqEntity = new MultipartEntity(HttpMultipartMode.BROWSER_COMPATIBLE);

		reqEntity.addPart("communityKey", new StringBody("B0034"));
		reqEntity.addPart("tableName", new StringBody("WCM_BOARD_B0034"));
		reqEntity.addPart("secretYn", new StringBody("N"));
		reqEntity.addPart("dbsts", new StringBody("A"));
		reqEntity.addPart("mime_contents", new StringBody(""));
		reqEntity.addPart("fileSize", new StringBody("5242880"));
		reqEntity.addPart("fileAppdYn", new StringBody("Y"));
		reqEntity.addPart("rowCount", new StringBody("1"));
		reqEntity.addPart("act", new StringBody("WRITE_FORM"));
		reqEntity.addPart("branch_id", new StringBody(""));
		reqEntity.addPart("branch_child_id", new StringBody(""));
		reqEntity.addPart("mbo_mother_page", new StringBody("http://admin.geumcheon.go.kr:9081/cms/board/board/Board.jsp"));
		reqEntity.addPart("attach_file_count", new StringBody("5"));
		reqEntity.addPart("community_kind", new StringBody("ONEWAY"));
		reqEntity.addPart("community_type", new StringBody("BOARD"));
		reqEntity.addPart("community_id", new StringBody("B0034"));
		reqEntity.addPart("notify_cnt", new StringBody("0"));
		reqEntity.addPart("notifyYN", new StringBody("N"));
		reqEntity.addPart("title", new StringBody("test"));
		reqEntity.addPart("korName", new StringBody("관리자"));
		reqEntity.addPart("position", new StringBody("홍보전산과"));

		FileBody bin = new FileBody(
			new File("c:/GIS.xls"));
		reqEntity.addPart("filename1", bin );

		httppost.setEntity(reqEntity);

		System.out.println("executing request " + httppost.getRequestLine());
		HttpResponse response = httpclient.execute(httppost);
		HttpEntity resEntity = response.getEntity();

		if (resEntity != null) {
			String page = EntityUtils.toString(resEntity);
			System.out.println("PAGE :" + page);
		}


	}
	
	
	private HashMap<String, List<ZValue>> getFileMap(List<ZValue> list)
	{
		HashMap<String, List<ZValue>> resultMap = new HashMap<String, List<ZValue>>();
		List<ZValue> resultList = null;
		for(ZValue val : list)
		{
			String fileAppdId = val.getString("fileAppdId");
			if(!"".equals(fileAppdId))
			{
				fileAppdId = "!@#$"+fileAppdId +"--$$";
				fileAppdId = new BASE64Encoder().encode(fileAppdId.getBytes());
				val.set("fileAppdId", fileAppdId);
			}
			
			String boardId = "B"+val.getString("boardId");
			resultList = resultMap.get(boardId);
			if(resultList == null)
			{
				resultList = new ArrayList<ZValue>();
				resultList.add(val);
				resultMap.put(boardId, resultList);
			}
			else
			{
				resultList.add(val);
				resultMap.put(boardId, resultList);
			}
		}

		return resultMap;
	}
	
	public static void main(String[] args)throws Exception
	{
		new WcmboardService().addWcmboardToGc();
	}
}

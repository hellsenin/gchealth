package egovframework.kr.go.geumcheon.health.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.com.cmm.service.FileVO;
import egovframework.kr.go.geumcheon.health.dao.MetabolicSyndromeDAO;
import egovframework.kr.go.geumcheon.health.util.ZValue;

@Service("APP000046ApplicationService")
public class APP000046ApplicationService extends ApplicationService{

    Logger log = Logger.getLogger(this.getClass());

	@Resource(name="metabolicSyndromeDAO")
	protected MetabolicSyndromeDAO metabolicSyndromeDAO;

	public boolean uploadExcel(ZValue zvl, Map<String, MultipartFile> files) throws Exception
	{
		boolean result = true;
		String applyCode = zvl.getString("applyCode");
		
	    if (files.isEmpty()) {
	    	return false;
	    }
	    
	    List<FileVO> fList = fileUtil.parseFileInf(files, "M_", 0, "", "apply.fileStorePath");
	    
	    if(fList == null || fList.size() == 0)
	    {
	    	return false;
	    }
		
	    FileVO file = fList.get(0);
	    String fileName = file.getStreFileNm();
	    String path = propertyService.getString("apply.fileStorePath");
	    
	    try
	    {
	    	File f = new File(path+fileName);
	    	if(!f.exists())
	    	{
	    		log.debug("File not exist!!!!!! " + path+fileName);
	    		return false;
	    	}
			Workbook workbook = Workbook.getWorkbook(f); 
			Sheet sheet = workbook.getSheet(0); 
			Cell col01SunbunCell;    //순번 a
			Cell col01RegnoCell;     //등록번호 b
			Cell col01NameCell;      //이름 c
			Cell col01JuminCell;     //주민번호 d
			Cell col01TelCell;       //전화번호 e
			Cell col01Addr1Cell;     //주소 f
			
			Cell col02MngCenterCell; //등록정보 관리센터 g
			Cell col02RegDateCell;   //등록정보 등록일자 h
			Cell col02NaesoCell;     //등록정보 내소동기 i
			Cell col02MngCenter2Cell;     //등록정보 j
			
			Cell col03CheckCell;     //검진일자 k
			
			Cell col04WaistCell;     //복부비만 허리둘레 l
			
			Cell col05JungsungCell;  //고지혈증 중성지방 m
			Cell col05HdlCell;       //고지혈증 HDL n
			Cell col05MedicineCell;  //고지혈증 약복용 o
			
			Cell col06BloodPressureCell;  //고혈압 혈압 p
			Cell col06MedicineCell;  //고혈압 약복용 q
			
			Cell col07BloodPressurekCell; //당뇨 공복혈당 r
			Cell col07MedicineCell;  //당뇨 약복용 s
			
			Cell col08CheckDateCell; //t
			Cell col08DiagosisCell;  //u
			Cell col08StageCell;     //v
			Cell col08WaistCell;     //w  
			Cell col08BloodPressureCell; //x
			Cell col08BloodSugarCell; //y
			Cell col08HdlCell;        //z
			Cell col08tgCell;         //aa
			Cell col08EquipmentCell;  //ab
			Cell col08InstitutionCell; //ac
	
			ArrayList<ZValue> dataList = new ArrayList<ZValue>();
			int colLen = sheet.getColumn(0).length;
			
			for(int j = 2 ; j <= colLen - 1 ; j++)
			{
				col01SunbunCell = sheet.getCell(0,j);
				col01RegnoCell = sheet.getCell(1,j);    
				col01NameCell = sheet.getCell(2,j);      
				col01JuminCell = sheet.getCell(3,j);     
				col01TelCell = sheet.getCell(4,j);       
				col01Addr1Cell = sheet.getCell(5,j);     
				
				col02MngCenterCell = sheet.getCell(6,j);
				col02RegDateCell = sheet.getCell(7,j);   
				col02NaesoCell = sheet.getCell(8,j);     
				col02MngCenter2Cell = sheet.getCell(9,j);     
				
				col03CheckCell = sheet.getCell(10,j);     
				
				col04WaistCell = sheet.getCell(11,j);    
				
				col05JungsungCell = sheet.getCell(12,j);  
				col05HdlCell = sheet.getCell(13,j);      //
				col05MedicineCell = sheet.getCell(14,j);  
				
				col06BloodPressureCell = sheet.getCell(15,j);  
				col06MedicineCell = sheet.getCell(16,j);  
				
				col07BloodPressurekCell = sheet.getCell(17,j); 
				col07MedicineCell = sheet.getCell(18,j);  
				
				col08CheckDateCell = sheet.getCell(19,j);
				col08DiagosisCell = sheet.getCell(20,j);
				col08StageCell = sheet.getCell(21,j);
				col08WaistCell = sheet.getCell(22,j);
				col08BloodPressureCell = sheet.getCell(23,j);
				col08BloodSugarCell = sheet.getCell(24,j);
				col08HdlCell = sheet.getCell(25,j);
				col08tgCell = sheet.getCell(26,j);
				col08EquipmentCell = sheet.getCell(27,j);
				col08InstitutionCell = sheet.getCell(28,j);
				
				ZValue data = new ZValue();
				data.put("applyCode", applyCode);
				
				data.put("etc1", col01RegnoCell.getContents());
				data.put("name", col01NameCell.getContents());
				data.put("etc2", col01JuminCell.getContents());
				data.put("tel", col01TelCell.getContents());
				data.put("addr1", col01Addr1Cell.getContents());
				data.put("etc3", col02MngCenterCell.getContents());
				data.put("etc4", col02RegDateCell.getContents());
				data.put("etc5", col02NaesoCell.getContents());
				data.put("etc6", col02MngCenter2Cell.getContents());
				data.put("etc7", col03CheckCell.getContents());
				
				data.put("etc8", col04WaistCell.getContents());
				data.put("etc9", col05JungsungCell.getContents());
				data.put("etc10", col05HdlCell.getContents());
				data.put("etc11", col05MedicineCell.getContents());
				data.put("etc12", col06BloodPressureCell.getContents());
				data.put("etc13", col06MedicineCell.getContents());
				data.put("etc14", col07BloodPressurekCell.getContents());
				data.put("etc15", col07MedicineCell.getContents());
				data.put("etc16", col08CheckDateCell.getContents());
				data.put("etc17", col08DiagosisCell.getContents());
				
				data.put("etc18", col08StageCell.getContents());
				data.put("etc19", col08WaistCell.getContents());
				data.put("etc20", col08BloodPressureCell.getContents());
				data.put("etc21", col08BloodSugarCell.getContents());
				data.put("etc22", col08HdlCell.getContents());
				data.put("etc23", col08tgCell.getContents());
				data.put("etc24", col08EquipmentCell.getContents());
				data.put("etc25", col08InstitutionCell.getContents());
				data.put("etc26", col01SunbunCell.getContents());
				
				dataList.add(data);
			}
		
			for(ZValue data : dataList)
			{
				int applyId = applyDAO.selectApplyId(applyCode);
				data.put("applyId", applyId);
				applyDAO.apply(data);
			}
		
	    }
	    catch(Exception e)
	    {
	    	e.printStackTrace();
	    	result = false;
	    }
	    
	    return result;
	}

	public ZValue read(String regno) throws Exception
	{
		return metabolicSyndromeDAO.read(regno);
	}


}

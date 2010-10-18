package egovframework.kr.go.geumcheon.health.service;

import org.springframework.stereotype.Service;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;
import egovframework.kr.go.geumcheon.health.util.ZValue;

@Service("H001ApplicationService")
public class H001ApplicationService extends ApplicationService{

	public void apply(ZValue zvl) throws Exception 
	{
		String jumin = new BASE64Encoder().encode(zvl.getString("etc3").getBytes());
		zvl.put("etc3", jumin);
		
		super.apply(zvl);	
	}
		
	public ZValue selectApplyViewByApplyId(ZValue zvl) throws Exception
	{
		ZValue result = applyDAO.selectApplyViewByApplyId(zvl);
		String jumin = new String(new BASE64Decoder().decodeBuffer(result.getString("etc3")));
		result.put("etc3", jumin);
		
		return result;
	}

	public void modifyApply(ZValue zvl) throws Exception
	{
		String jumin = new BASE64Encoder().encode(zvl.getString("etc3").getBytes());
		zvl.put("etc3", jumin);
		
		super.modifyApply(zvl);
	}

}

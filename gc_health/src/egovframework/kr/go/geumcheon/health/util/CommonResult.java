package egovframework.kr.go.geumcheon.health.util;

import org.apache.commons.lang.builder.ToStringBuilder;

public class CommonResult {
	
	public boolean success = true;
	public String message = "";
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	
	
}

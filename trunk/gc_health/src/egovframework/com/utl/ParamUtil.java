package egovframework.com.utl; 

import java.lang.reflect.Array;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;  // Logging 처리를 위한 import
import org.apache.commons.logging.LogFactory;


/**
 * 
 * @author LGH(DEV)
 * @since 2010. 3. 2.
 * @see
 * @desc 
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *		수정일			수정자		수정내용
 *		-------			--------	---------------------------
 *		2010. 3. 2.	LGH(DEV)	최초 생성
 *
 * Copyright (C) 2010 by NEMOSOFT All right reserved.
 * </pre>
 */

public class ParamUtil extends HashMap<String, Object>{

	private static Log log = LogFactory.getLog(ParamUtil.class);
	private HashMap<String, Object> map = new HashMap<String, Object>();
	
	public ParamUtil(HttpServletRequest request){
		String name = "";
		Enumeration e = request.getParameterNames();
		while (e.hasMoreElements()) {
			name = (String) e.nextElement();
			map.put(name, request.getParameter(name));
		}
	}
	
    public Object get(Object s)
    {   
    	Object obj = super.get(s);
    	if(obj == null)
    		obj = "";
    	return obj;
    }

    public String getValue(String s)
    {
        return getString(s);
    }
    
    

    public boolean getBoolean(String s)
    {
        String s1 = getString(s);
        boolean flag = false;
        try
        {
            flag = (new Boolean(s1)).booleanValue();
        }
        catch(Exception exception) { }

        return flag;
    }

    public double getDouble(String s)
    {
        String s1 = removeComma(getString(s));
        if(s1.equals(""))
            return 0.0D;
        double d = 0.0D;
        try
        {
            d = Double.valueOf(s1).doubleValue();
        }
        catch(Exception exception)
        {
            d = 0.0D;
        }

        return d;
    }

    public float getFloat(String s)
    {
        return (float)getDouble(s);
    }

    public int getInt(String s)
    {
        double d = getDouble(s);
        return (int)d;
    }
    
    public int getInt(String s, int initVal)
    {
    	int ret = getInt(s);
    	if(ret == 0)
    		ret = initVal;
    	return ret;
    }

    public long getLong(String s)
    {
        String s1 = removeComma(getString(s));
        if(s1.equals(""))
            return 0L;
        long l = 0L;
        try
        {
            l = Long.valueOf(s1).longValue();
        }
        catch(Exception exception)
        {
            l = 0L;
        }

        return l;
    }
    
    public String getString(String s)
    {
        String s1 = null;
        try
        {
            Object obj = super.get(s);
            Class class1 = obj.getClass();

            if(obj == null)
                s1 = "";
            else if(class1.isArray())
            {
                int i = Array.getLength(obj);
                if(i == 0)
                {
                    s1 = "";
                }
                else
                {
                    Object obj1 = Array.get(obj, 0);
                    if(obj1 == null)
                        s1 = "";
                    else
                        s1 = obj1.toString();
                }
            }
            else
            {
                s1 = obj.toString();
            }
        }
        catch(Exception exception)
        {
            s1 = "";
        }

        return s1.trim();
    }
    
    public String getString(String s, String defaultValue)
    {
    	return getString(s)==null ? defaultValue : getString(s);
    }
    
    protected static String removeComma(String s)
    {
        if(s == null)
            return null;
        if(s.indexOf(",") != -1)
        {
            StringBuffer stringbuffer = new StringBuffer();
            for(int i = 0; i < s.length(); i++)
            {
                char c = s.charAt(i);
                if(c != ',')
                    stringbuffer.append(c);
            }

            return stringbuffer.toString();
        }
        else
        {
          return s;
        }
    }
}




package test;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.CookieStore;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.protocol.ClientContext;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;
import org.apache.http.protocol.BasicHttpContext;


public class Test2 {

	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception{
		InputStream is = null;
		String result = null;
		 BasicHttpContext localContext = new BasicHttpContext(); 
         // Create a local instance of cookie store 
         CookieStore cookieStore = new BasicCookieStore(); 
         localContext.setAttribute(ClientContext.COOKIE_STORE, 
cookieStore); 

		ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
		nameValuePairs.add(new BasicNameValuePair("applyCode", "RELY0001"));
		nameValuePairs.add(new BasicNameValuePair("petiGubun", "1"));
		nameValuePairs.add(new BasicNameValuePair("name", "httpClient테스트"));
		
		HttpClient httpclient = new DefaultHttpClient();
		HttpParams params = httpclient.getParams();
		HttpConnectionParams.setConnectionTimeout(params, 5000);
		HttpConnectionParams.setSoTimeout(params, 5000);
		
		HttpPost httppost = new HttpPost("http://localhost:9090/health/member/testLogin.do");
		httppost.setHeader("Connection","Keep-Alive");
		UrlEncodedFormEntity entityRequest = 
		new UrlEncodedFormEntity(nameValuePairs, "UTF-8");
		httppost.setEntity(entityRequest);
			
		HttpResponse response = httpclient.execute(httppost, localContext);
		HttpEntity entityResponse = response.getEntity();
		is = entityResponse.getContent();
		
		/** convert response to string */
		BufferedReader reader = new BufferedReader(new InputStreamReader(
				is, "iso-8859-1"), 8);
		StringBuilder sb = new StringBuilder();
		String line = null;
		while ((line = reader.readLine()) != null) {
			sb.append(line).append("\n");
		}
		is.close();
		result = sb.toString();
		System.out.println(">>>>>>>>" + result);
		/*
		File f = new File("s:/eula.1028.txt");
		FileEntity et = new FileEntity(f, "text/plain; charset=\"UTF-8\"");
		
        HttpPost httppost = new HttpPost("http://localhost:9090/health/application/apply.do");
        httppost.setEntity(et);
        
        MultipartEntity mpEntity = new MultipartEntity();
        ContentBody cbFile = new FileBody(f);
        mpEntity.addPart("userfile", cbFile);


        httppost.setEntity(mpEntity);
        System.out.println("executing request " + httppost.getRequestLine());
        HttpResponse response = httpclient.execute(httppost);
        HttpEntity resEntity = response.getEntity();

        System.out.println(response.getStatusLine());
        if (resEntity != null) {
          System.out.println(EntityUtils.toString(resEntity));
        }
        if (resEntity != null) {
          resEntity.consumeContent();
        }
		*/
        httpclient.getConnectionManager().shutdown();
       
	}

}

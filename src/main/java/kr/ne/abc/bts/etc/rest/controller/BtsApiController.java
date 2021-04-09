package kr.ne.abc.bts.etc.rest.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Locale;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class BtsApiController {
	
	
	@RequestMapping(value = "/btsApiRest", method = RequestMethod.GET)
	public String btsApiRest(
			Model model
			, Locale locale) {
		
		return "etc/other/rest/bts_api";
	}
	
	
	@RequestMapping(value = "/btsApiCall_json", produces="application/json; charset=utf8")
	@ResponseBody
	public String apicall(
			Locale locale
			, Model model
			, @RequestBody HashMap<String,Object> map) throws IOException 
	{
		String requestUrl = "";
		if(map!=null) {
			requestUrl = (String)map.get("requestUrl");
			map.remove("requestUrl");
		}
		
		String result = "";
		String json = new JSONObject(map).toString();    //convert map to JSON String(JSON으로 변환)
		
	    try {
	    	result = sendRESTJson(requestUrl, json);
	    	System.out.println(result);
	    } catch(Exception e) {
	    	e.printStackTrace();
	    }
	    return result;
	}
	
	public static String sendRESTJson(String sendUrl, String jsonValue) throws IllegalStateException {

		String inputLine = null;
		StringBuffer outResult = new StringBuffer();

		  try{
			URL url = new URL(sendUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setDoOutput(true);
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-Type", "application/json");
			conn.setRequestProperty("Accept-Charset", "UTF-8"); 
			conn.setConnectTimeout(1000000);
			conn.setReadTimeout(1000000);
		      
			OutputStream os = conn.getOutputStream();
			os.write(jsonValue.getBytes("UTF-8"));
			os.flush();
		    
			BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			while ((inputLine = in.readLine()) != null) {
				outResult.append(inputLine);
			}
			conn.disconnect();      
		  }catch(Exception e){
		      e.printStackTrace();
		  }	
		  
		  return outResult.toString();
		}
}

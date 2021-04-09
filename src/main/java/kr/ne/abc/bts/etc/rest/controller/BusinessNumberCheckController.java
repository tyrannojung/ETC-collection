package kr.ne.abc.bts.etc.rest.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

@Controller
public class BusinessNumberCheckController {

	
	@RequestMapping(value = "/businessNumberCheckRest", method = RequestMethod.GET)
	public String businessNumberCheckRest(
			Model model
			, Locale locale) {
		
		return "etc/other/rest/business_num_check";
	}
	
	
	@RequestMapping(value = "/businessNumberCheck_json", produces="application/json; charset=utf8")
	@ResponseBody
	public Map<String, Object> businessNumberCheck(
			Locale locale
			, Model model
			, @RequestBody HashMap<String,Object> map) throws IOException 
	{
		String requestUrl = "";
    	String content = "";
    	
		if(map!=null) {
			requestUrl = (String)map.get("requestUrl");
			content = (String)map.get("content");
			map.remove("requestUrl");
		}
		
		String result = "";
		
	    try {
	    	result = sendRESTXml(requestUrl, content);
	    } catch(Exception e) {
	    	e.printStackTrace();
	    }
	    
	    //xml문서를 document객체라고 인식한다.
    	//xml 문서를 읽기 위한 공장
  		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
  		Document doc = null;
  		DocumentBuilder builder = null;
		try
		 {
		     builder = factory.newDocumentBuilder();
		     //공장을 통해 문자열을 xml형식으로 변환
		     doc = builder.parse(new InputSource(new StringReader(result.toString())));
		 } 
		 catch (Exception e) 
		 {
		     e.printStackTrace();
		 }
		 
	     //문서의 root요소 획득
		 Element root = doc.getDocumentElement();
		 
		 //root 요소의 필요한 자식노드 추출하기
		 NodeList childeren = root.getChildNodes();
		 Node node = childeren.item(4);
		 Node node2 = childeren.item(5);
		 Element ele = (Element)node;
		 Element ele2 = (Element)node2;
		 String nodeName = ele.getFirstChild().getNodeValue();
		 String nodeName2 = ele2.getFirstChild().getNodeValue();
		
		 
		//json 형태로 보내기위해 map에 요소를 담아서 return하기
		Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("check", nodeName);
		map2.put("detail", nodeName2);
		 
		return map2;
	}
	
	public static String sendRESTXml(String requestUrl, String content) throws IllegalStateException {

		String inputLine = null;
		StringBuffer outResult = new StringBuffer();

		  try{
			URL url = new URL(requestUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setDoOutput(true);
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-Type", "application/text");
			conn.setRequestProperty("Accept-Charset", "UTF-8"); 
			conn.setConnectTimeout(1000000);
			conn.setReadTimeout(1000000);
		      
			OutputStream os = conn.getOutputStream();
			os.write(content.getBytes("UTF-8"));
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

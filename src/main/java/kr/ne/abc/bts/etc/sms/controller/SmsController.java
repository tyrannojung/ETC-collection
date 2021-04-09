package kr.ne.abc.bts.etc.sms.controller;

import java.io.IOException;
import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.ne.abc.bts.etc.sms.util.SMS;

@Controller
public class SmsController {
	
	@RequestMapping(value = "/smsWrite", method = RequestMethod.GET)
	public String smsWrite(
			Model model
			, Locale locale) {
		
		return "etc/other/sms/sms_write";
	}
	
	@ResponseBody
	@RequestMapping(value = "/sendSMS", method = RequestMethod.POST)
	public String sendSMS(
			Locale locale
			, Model model
			, @RequestParam(required = false)  String send_number
			, @RequestParam(required = false)  String receiver_number
			, @RequestParam(required = false)  String sms_content
			) 
	{
		SMS sms = new SMS();
		/* Begin SMS =================================== */
		String callNo = receiver_number;// 받는 전화번호
	    String callBack = send_number; // 보내는 전화번호(발신번호 제한으로 인한 고정)
	    String caller = "bts_207"; // 발신자 성명(option)
	    String msg = sms_content; // 보낼 메시지 최대 90byte		    
	    String smsresult = null;
	    
	    System.out.println("callNo : " + callNo);
	    System.out.println("callBack : " + callBack);
	    System.out.println("caller : " + caller);
	    System.out.println("msg : " + msg);
	    
	    try{
	    	sms.connect();
	    }catch(Exception e){
	    	smsresult = "FAIL";	    
	    }//catch

	    //전화번호와 회신번호는 숫자만 가능하며  보내는 사람은 최대 10바이트, 메세지는 최대 90바이트입니다.
		//전화번호와 회신번호와 메세지는 필수사항이며 보내는 사람은 옵션입니다.
		//옵션 사항이 필요 없으시면 스페이스 1바이트로 처리해주십시요.

	    try{
	    	String rslt = sms.SendMsg(callNo,callBack,sms.en(caller),sms.en(msg));
			if(! rslt.equals(""))
			smsresult = "OK";
			else
			smsresult = "FAIL";
	    }catch(IOException e){
	    	smsresult = "FAIL";
	    }

	    try {
			sms.disconnect();
		} catch (Exception e) {
			e.printStackTrace();
		}			 
	    System.out.println("smsresult : " + smsresult);
		/* End SMS =================================== */
		
		return smsresult;
	}

}

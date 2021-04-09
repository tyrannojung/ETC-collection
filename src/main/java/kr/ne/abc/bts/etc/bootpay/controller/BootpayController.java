package kr.ne.abc.bts.etc.bootpay.controller;

import java.util.Locale;

import org.apache.commons.io.IOUtils;
import org.apache.http.HttpResponse;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.ne.abc.bts.etc.bootpay.BootpayApi;

@Controller
public class BootpayController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(BootpayController.class);

	private BootpayApi api;
	
	public BootpayController() {
		this.api = new BootpayApi("60015f05d8c1bd001d2d1474","S2T5pOKzquAhE46CtzDgLPcmYHjGDdqX9BbRPE+wyaY=");
	}
	
	@RequestMapping(value = "/bootpay", method = RequestMethod.GET)
	public String bootpay(
			Model model
			, Locale locale) {
		
		return "etc/pay/bootpay/bootpay_payment";
	}
	
	
	/**
	 * NICE 와 부트페이 검증
	 * @param dto
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/bootpay_confirm", method = RequestMethod.POST)
	public String bootpay_confirm(
			@RequestParam(value = "pgid", required = false) String pgid
			, @RequestParam(value = "payment", required = false) int payment
			, Model model
			) 
	{	
		String bootpay_check = "";
		// 부트페이 인증 토큰 발급
    	try {
    		api.getAccessToken();
		} catch (Exception e) {
			e.printStackTrace();
		}
    	// 부트페이로부터 검증데이터 가져오기
    	try {
    		HttpResponse res = api.verify(pgid);
    	    
    	    //부트페이에서 가져온 검증 JSON
    	    bootpay_check = IOUtils.toString(res.getEntity().getContent(), "UTF-8");
    	    
    	    // NICE에서 넘겨주는 pgid
    	    String pay_pgid = pgid;
    	    // NICE에서 넘겨주는 pay_money
    	    String pay_money =  Integer.toString(payment);
    	    
    	    JSONParser jsonParse = new JSONParser();
			JSONObject jsonObj = (JSONObject)jsonParse.parse(bootpay_check);
			JSONObject jsonObj2 = (JSONObject)jsonParse.parse((jsonObj.get("data").toString()));
			
			// 결제 상태
			String boot_status = (jsonObj.get("status")).toString();
			// 부트페이에서 넘겨주는 pgid
			String boot_pgid = (jsonObj2.get("receipt_id")).toString();
			// 부트페이에서 넘겨주는 pay_money
			String boot_pay_money = (jsonObj2.get("price")).toString();
			// 부트페이에서 넘겨주는 거래상태 (1일 경우 결제 완료 상태)
			String boot_status2 = (jsonObj2.get("status")).toString();
			
			// 거래상태코드
			if(boot_status.equals("200")) 
			{	// 서버검증
				if(boot_pgid.equals(pay_pgid) 
						&&  boot_pay_money.equals(pay_money) 
						&&  boot_status2.equals("1")) 
				{
					//System.out.println("이니시스 부트페이 비교 검증 성공");
					//성공
					return "OK";
				}
			}
    	} catch (Exception e) {
    	    e.printStackTrace();
    	    return "NO";
    	}
    	//실패
		return "NO";
	}
}

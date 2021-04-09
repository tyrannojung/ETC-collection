package kr.ne.abc.bts.etc.iamport.controller;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

@Controller
public class IamportController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(IamportController.class);
	
	private IamportClient api;
	
	public IamportController() {
		this.api = new IamportClient("5066129639471292","B2T28jNIjuptHk91iAJrPGJP6q3uxr09uUbCdZlxtK0b4acmKWNACxqJXuduVeDq8O2mOnTh8Usc4FzP");
	}
	
	@RequestMapping(value = "/iamport", method = RequestMethod.GET)
	public String iamport(
			Model model
			, Locale locale) {
		
		return "etc/pay/iamport/iamport_payment";
	}
	
	//검증하기
	@ResponseBody
	@RequestMapping(value="/verifyIamport/{imp_uid}")
	public IamportResponse<Payment> paymentByImpUid(
			Model model
			, Locale locale
			, HttpSession session
			, @PathVariable(value= "imp_uid") String imp_uid) throws IamportResponseException, IOException
	{	
			return api.paymentByImpUid(imp_uid);
	}

}

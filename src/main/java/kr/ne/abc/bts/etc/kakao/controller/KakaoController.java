package kr.ne.abc.bts.etc.kakao.controller;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class KakaoController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(KakaoController.class);
	
	@RequestMapping(value = "/kakaoAdress", method = RequestMethod.GET)
	public String kakaoAdress(
			Model model
			, Locale locale) {
		
		return "etc/social/kakao/kakao_address";
	}
	
	@RequestMapping(value = "/kakaoLogin", method = RequestMethod.GET)
	public String kakaoLogin(
			Model model
			, Locale locale) {
		
		return "etc/social/kakao/kakao_login";
	}
}

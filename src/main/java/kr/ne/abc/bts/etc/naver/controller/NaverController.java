package kr.ne.abc.bts.etc.naver.controller;

import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class NaverController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(NaverController.class);
	
	@RequestMapping(value = "/naverLogin", method = RequestMethod.GET)
	public String kakaoLogin(
			Model model
			, Locale locale
			, HttpSession session) {
		
		return "etc/social/naver/naver_login";
	}
}

package kr.ne.abc.bts.etc.facebook.controller;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class FacebookController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(FacebookController.class);
	
	@RequestMapping(value = "/facebookLogin", method = RequestMethod.GET)
	public String facebookLogin(
			Model model
			, Locale locale) {
		
		return "etc/social/facebook/facebook_login";
	}

}

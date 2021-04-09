package kr.ne.abc.bts.etc.mail.controller;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.ne.abc.bts.etc.mail.dto.EmailDTO;
import kr.ne.abc.bts.etc.mail.service.MailService;
import kr.ne.abc.bts.etc.mail.service.impl.MailServiceImpl;

@Controller
public class MailController {
	
	@RequestMapping(value = "/mailWrite", method = RequestMethod.GET)
	public String mailWrite(
			Model model
			, Locale locale) {
		
		return "etc/other/mail/mail_write";
	}
	
	@ResponseBody
	@RequestMapping(value = "/sendMail", method = RequestMethod.POST)
	public String sendSMS(
			Locale locale
			, Model model
			, @RequestParam(required = false)  String send_mail
			, @RequestParam(required = false)  String receiver_mail
			, @RequestParam(required = false)  String mail_subject
			, @RequestParam(required = false)  String mail_content
			) 
	{
		MailService mailService = new MailServiceImpl();
		EmailDTO emailDTO = new EmailDTO();
		String mailresult = "FAIL";
		
		try {
			emailDTO.setFrom(send_mail);
			emailDTO.setTo(receiver_mail);
			emailDTO.setSubject(mail_subject);
			emailDTO.setContent(mail_content);
			
			if (mailService.sendTestMail(emailDTO)) {
				mailresult = "OK";	
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		} 
		return mailresult;
	}
}

package kr.ne.abc.bts.etc.mail.service;

import kr.ne.abc.bts.etc.mail.dto.EmailDTO;

public interface MailService {
	
	public void sendToHtml(String from, String to, String title, String content) throws Exception;
	
	public void sendToHtml(EmailDTO email) throws Exception;
	
	public boolean sendTestMail(EmailDTO email) throws Exception;
	
	public void sendToHtml(String from, String[] to, String title, String content) throws Exception;
	
	public void sendToHtml(EmailDTO email, String[] to) throws Exception;

}

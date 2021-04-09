package kr.ne.abc.bts.etc.summernote.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Locale;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;

@Controller
public class SummernoteController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(SummernoteController.class);
	
	@Autowired
	private ResourceLoader resourceLoader;

	@RequestMapping(value = "/summernote", method = RequestMethod.GET)
	public String summernote(
			Model model
			, Locale locale) {
		
		return "etc/other/summernote/summernote";
	}
	
	
	/**
	 * 파일업로드
	 * @param multipartFile
	 * @return
	 * @throws IOException
	 */
	@ResponseBody
	@RequestMapping(value = "/uploadProductImageFile", produces = "application/json; charset=utf8", method = RequestMethod.POST)
	public String uploadProductImageFile(
			@RequestParam("file") MultipartFile multipartFile) throws IOException {
		
		JsonObject jsonObject = new JsonObject();
		String contextRoot;

			contextRoot = resourceLoader.getResource("classpath:/static/fileupload/").getURI().getPath();
		
		String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
		String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
		File targetFile = new File(contextRoot + savedFileName);	
		
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장
			jsonObject.addProperty("url", "/fileupload/"+savedFileName);
			jsonObject.addProperty("responseCode", "success");
			System.out.println("성공");

		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);	//저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		String a = jsonObject.toString();
		System.out.println(a);
		return a;
	}
	
	
	
	
}

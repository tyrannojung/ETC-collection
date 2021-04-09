package kr.ne.abc.bts.etc.nice.controller;

import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class NiceIdenController {
	
	@RequestMapping(value = "/niceIdenVerification", method = RequestMethod.GET)
	public String niceIdenVerification(Locale locale,  HttpSession session,
			Model model) {

		//////////// NICE 본인인증 시작
		NiceID.Check.CPClient niceCheck = new NiceID.Check.CPClient();
		String sSiteCode = "BQ427"; // NICE로부터 부여받은 사이트 코드
		String sSitePassword = "K7qi4HldWrNM"; // NICE로부터 부여받은 사이트 패스워드
		String sRequestNumber = "REQ0000000001"; // 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
		sRequestNumber = niceCheck.getRequestNO(sSiteCode);
		session.setAttribute("REQ_SEQ", sRequestNumber); // 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.
		String sAuthType = "M"; // 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서
		String popgubun = "N"; // Y : 취소버튼 있음 / N : 취소버튼 없음
		String customize = ""; // 없으면 기본 웹페이지 / Mobile : 모바일페이지
		String sGender = ""; // 없으면 기본 선택 값, 0 : 여자, 1 : 남자
		// CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
		// 리턴url은 인증 전 인증페이지를 호출하기 전 url과 동일해야 합니다. ex) 인증 전 url : http://www.~ 리턴 url :
		// http://www.~
		String sReturnUrl = "http://localhost:8181/niceSuccess";      // 성공시 이동될 URL
		String sErrorUrl = "http://localhost:8181/kycfail";          // 실패시 이동될 URL -> 아직 안만듬.
		// 입력될 plain 데이타를 만든다.
		String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber + "8:SITECODE"
				+ sSiteCode.getBytes().length + ":" + sSiteCode + "9:AUTH_TYPE" + sAuthType.getBytes().length + ":"
				+ sAuthType + "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl + "7:ERR_URL"
				+ sErrorUrl.getBytes().length + ":" + sErrorUrl + "11:POPUP_GUBUN" + popgubun.getBytes().length + ":"
				+ popgubun + "9:CUSTOMIZE" + customize.getBytes().length + ":" + customize + "6:GENDER"
				+ sGender.getBytes().length + ":" + sGender;
		String sMessage = "";
		String sEncData = "";
		int iReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);
		if (iReturn == 0) {
			sEncData = niceCheck.getCipherData();
		} else if (iReturn == -1) {
			sMessage = "암호화 시스템 에러입니다.";
		} else if (iReturn == -2) {
			sMessage = "암호화 처리오류입니다.";
		} else if (iReturn == -3) {
			sMessage = "암호화 데이터 오류입니다.";
		} else if (iReturn == -9) {
			sMessage = "입력 데이터 오류입니다.";
		} else {
			sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
		}
		model.addAttribute("sEncData", sEncData);
		return "etc/other/nice/nice_identity_verification";
	}
	
	
	@RequestMapping(value="/niceSuccess")
	public String niceSuccess(
			HttpSession session
			, @RequestParam(required = false) String EncodeData
			, Model model) 
	{
		System.out.println(EncodeData);
		HashMap<String,String> result = encodeDataCheck(EncodeData, session);
		
		model.addAttribute("sEncData", result);
		return "etc/other/nice/nice_success";
	}
	
	public HashMap<String,String> encodeDataCheck(String EncodeData, HttpSession session) {

		NiceID.Check.CPClient niceCheck = new NiceID.Check.CPClient();
		HashMap<String,String> result = new HashMap<String,String>();

		String sEncodeData = requestReplace(EncodeData, "encodeData");
		String sSiteCode = "BQ427"; // NICE로부터 부여받은 사이트 코드
		String sSitePassword = "K7qi4HldWrNM"; // NICE로부터 부여받은 사이트 패스워드
		String sRequestNumber = ""; // 요청 번호
		String sName = ""; // 성명
		String sDupInfo = ""; // 중복가입 확인값 (DI_64 byte)
		String sBirthDate = ""; // 생년월일(YYYYMMDD)
		String sGender = ""; // 성별
		String sMobileNo = ""; // 휴대폰번호
		String sMessage = "";
		String sPlainData = "";
		int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);
		if (iReturn == 0) {
			sPlainData = niceCheck.getPlainData();
			// 데이타를 추출합니다.
			HashMap mapresult = niceCheck.fnParse(sPlainData);
			sRequestNumber = (String) mapresult.get("REQ_SEQ");
			sName = (String) mapresult.get("NAME");
			sBirthDate = (String) mapresult.get("BIRTHDATE");
			sGender = (String) mapresult.get("GENDER");
			sDupInfo = (String) mapresult.get("DI");
			sMobileNo = (String) mapresult.get("MOBILE_NO");

			// 여기를 수정해서 사용한다.
			result.put("sRequestNumber", sRequestNumber);
			result.put("sName", sName);
			result.put("sBirthDate", sBirthDate);
			result.put("sGender", sGender);
			result.put("sDupInfo", sDupInfo);
			result.put("sMobileNo", sMobileNo);
			
			
			String session_sRequestNumber = (String) session.getAttribute("REQ_SEQ");
			if (!sRequestNumber.equals(session_sRequestNumber)) {
				sMessage = "세션값 불일치 오류입니다.";
			}
		} else if (iReturn == -1) {
			sMessage = "복호화 시스템 오류입니다.";
		} else if (iReturn == -4) {
			sMessage = "복호화 처리 오류입니다.";
		} else if (iReturn == -5) {
			sMessage = "복호화 해쉬 오류입니다.";
		} else if (iReturn == -6) {
			sMessage = "복호화 데이터 오류입니다.";
		} else if (iReturn == -9) {
			sMessage = "입력 데이터 오류입니다.";
		} else if (iReturn == -12) {
			sMessage = "사이트 패스워드 오류입니다.";
		} else {
			sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
		}
		result.put("sMessage", sMessage);
		return result;
	}
	
	public String requestReplace(String paramValue, String gubun) {

		String result = "";

		if (paramValue != null) {

			paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

			paramValue = paramValue.replaceAll("\\*", "");
			paramValue = paramValue.replaceAll("\\?", "");
			paramValue = paramValue.replaceAll("\\[", "");
			paramValue = paramValue.replaceAll("\\{", "");
			paramValue = paramValue.replaceAll("\\(", "");
			paramValue = paramValue.replaceAll("\\)", "");
			paramValue = paramValue.replaceAll("\\^", "");
			paramValue = paramValue.replaceAll("\\$", "");
			paramValue = paramValue.replaceAll("'", "");
			paramValue = paramValue.replaceAll("@", "");
			paramValue = paramValue.replaceAll("%", "");
			paramValue = paramValue.replaceAll(";", "");
			paramValue = paramValue.replaceAll(":", "");
			paramValue = paramValue.replaceAll("-", "");
			paramValue = paramValue.replaceAll("#", "");
			paramValue = paramValue.replaceAll("--", "");
			paramValue = paramValue.replaceAll("-", "");
			paramValue = paramValue.replaceAll(",", "");

			if (gubun != "encodeData") {
				paramValue = paramValue.replaceAll("\\+", "");
				paramValue = paramValue.replaceAll("/", "");
				paramValue = paramValue.replaceAll("=", "");
			}

			result = paramValue;

		}
		return result;
	}
}

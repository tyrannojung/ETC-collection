<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../include/header.jsp" %>
<html>
<head>
<style>
.social-link {
    color: #fff;
    background: #ff3f3f;
    display: block;
    transition: all 0.3s;
}

.social-link:hover, .social-link:focus {
    color: white;
    text-decoration: none;
}

.social-link .icon {
    width: 4rem;
    text-align: center;
    margin-right: 1.5rem;
    border-right: 1px solid rgba(255, 255, 255, 0.4);
}
.social-naver{
    background: #04C259;
}

.social-naver:hover, .social-naver:focus {
    background: #53AA47;
}

.social-link-gradient.social-naver {
    background: linear-gradient(to right, #04C259, #53AA47);
}

</style>
</head>
<body>
<%@include file="../../include/nav.jsp" %>
<div class="container">
	<div class="row justify-content-center">
		<div class="col-lg-8 col-md-10" style="margin-top: 60px;">
			<div class="card-header text-uppercase font-weight-bold" style="line-height: 40px">NAVER LOGIN</div>
			<div class="card-body">
		        <div class="d-flex justify-content-end mt-2">
	            </div>
			</div>
			<div class="card-footer">
	            <ul class="list-unstyled">
                   <li class="mb-2">
				        <!-- naver-->
				        <a id="naverIdLogin_loginButton" href="javascript:void(0)"  class="social-link social-naver d-flex align-items-center py-2 rounded-pill shadow-sm">
					        <span class="icon py-1">
					        	<i class="fas fa-search fa-fw" style="color:#F7F7F7"></i>
					        </span><span class="font-weight-bold" style="color:#F7F7F7">네이버 로그인</span>
				        </a>
				    </li>
				    <li class="mb-2" onclick="naverLogout(); return false;">
				        <!-- naver-->
				        <a href="javascript:void(0)" class="social-link social-naver d-flex align-items-center py-2 rounded-pill shadow-sm">
					        <span class="icon py-1">
					        	<i class="fas fa-search fa-fw" style="color:#F7F7F7"></i>
					        </span><span class="font-weight-bold" style="color:#F7F7F7">네이버 로그아웃</span>
				        </a>
				    </li>
                </ul>


			</div>
		</div>
	</div>
</div>
<!-- 네이버아디디로로그인 초기화 Script -->
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<script>

/* (3) 네아로 로그인 정보를 초기화하기 위하여 init을 호출 */

var naverLogin = new naver.LoginWithNaverId(
		{
			clientId: "80mdf88flkWWJT1f93Tz",
			callbackUrl: "http://localhost:8181/naverLogin",
			isPopup: false,
			callbackHandle: true
		}
	);	

naverLogin.init();

window.addEventListener('load', function () {
	naverLogin.getLoginStatus(function (status) {
		if (status) {
			var email = naverLogin.user.getEmail();
    		
			console.log(naverLogin.user); 
    		
            if( email == undefined || email == null) {
				alert("이메일은 필수정보입니다. 정보제공을 동의해주세요.");
				naverLogin.reprompt();
				return;
			}
		} else {
			console.log("callback 처리에 실패하였습니다.");
		}
	});
});


var testPopUp;
function openPopUp() {
    testPopUp= window.open("https://nid.naver.com/nidlogin.logout", "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,width=1,height=1");
}
function closePopUp(){
    testPopUp.close();
}

function naverLogout() {
	openPopUp();
	setTimeout(function() {
		closePopUp();
		}, 1000);
	
	
}
</script>
</body>
</html>
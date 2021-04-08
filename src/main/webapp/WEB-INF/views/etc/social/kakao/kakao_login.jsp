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
.social-kakao{
    background: #F7E600;
}

.social-kakao:hover, .social-kakao:focus {
    background: #ECC301;
}

.social-link-gradient.social-kakao {
    background: linear-gradient(to right, #F7E600, #FAF4A5);
}

</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
	<div class="d-flex justify-content-center">
	  <h1>Kakao 로그인 & 로그아웃</h1>
	</div>
	<ul class="list-unstyled">
	    <li class="mb-2" onclick="kakaoLogin(); return false;">
	        <!-- kakao-->
	        <a href="javascript:void(0)" class="social-link social-kakao d-flex align-items-center py-2 rounded-pill shadow-sm">
		        <span class="icon py-1">
		        	<i class="fab fa-kickstarter fa-fw text-white"></i>
		        </span><span class="font-weight-bold text-white">카카오 로그인</span>
	        </a>
	    </li>
	    <li class="mb-2" onclick="kakaoLogout(); return false;">
	        <!-- kakao-->
	        <a href="javascript:void(0)" class="social-link social-kakao d-flex align-items-center py-2 rounded-pill shadow-sm">
		        <span class="icon py-1">
		        	<i class="fab fa-kickstarter fa-fw text-white"></i>
		        </span><span class="font-weight-bold text-white">카카오 로그아웃</span>
	        </a>
	    </li>
	</ul>
</div>
<!-- 카카오 스크립트 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
Kakao.init('8890a67c089173194979845f9389950d'); //발급받은 키 중 javascript키를 사용해준다.
console.log(Kakao.isInitialized()); // sdk초기화여부판단
//카카오로그인
function kakaoLogin() {
    Kakao.Auth.login({
      success: function (response) {
        Kakao.API.request({
          url: '/v2/user/me',
          success: function (response) {
        	  console.log(response)
          },
          fail: function (error) {
            console.log(error)
          },
        })
      },
      fail: function (error) {
        console.log(error)
      },
    })
  }
//카카오로그아웃  
function kakaoLogout() {
    if (Kakao.Auth.getAccessToken()) {
      Kakao.API.request({
        url: '/v1/user/unlink',
        success: function (response) {
        	console.log(response)
        },
        fail: function (error) {
          console.log(error)
        },
      })
      Kakao.Auth.setAccessToken(undefined)
    }
  }  
</script>
</body>
</html>
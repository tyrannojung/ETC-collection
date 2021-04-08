<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
<%@include file="etc/include/header.jsp" %>
<body>
<div class="jumbotron text-center">
  <h1>BTS ETC PAGE</h1>
  <p>VER 1.0 <button type="button" class="btn btn-info btn-sm" onclick="location.href='/';">DEMO</button></p> 
</div>
<div class="container">
  <div class="row">
    <div class="col-sm-4">
      <h3>Social</h3>
      <p class="mt-3"><b>1. KAKAO</b></p>
      <div onclick="location.href='/kakaoLogin';"> - kakao-login</div>
      <div onclick="location.href='/kakaoAdress';"> - kakao-address</div>
      <p class="mt-2"><b>2. FACEBOOK</b></p>
      <div onclick="location.href='/facebookLogin';"> - facebook-login</div>
      <p class="mt-2"><b>3. GOOGLE</b></p>
      <div onclick="location.href='/googleLogin';"> - google-login</div>
    </div>
    <div class="col-sm-4">
      <h3>PAY</h3>
      <p class="mt-3"><b>1. Bootpay</b></p>
      <p class="mt-2"><b>2. Iamport</b></p>
    </div>
    <div class="col-sm-4">
      <h3>OTHER</h3>
      <p class="mt-3"><b>1. Summernote</b></p>
      <p class="mt-2"><b>2. RestAPI</b></p>
      <div> - bts - api</div>
      <div> - Business Number api</div>
      <p class="mt-2"><b>3. SMS</b></p>
      <p class="mt-2"><b>4. MAIL</b></p>
    </div>
  </div>
</div>
<script>
function fnFbCustomLogin(){
	FB.login(function(response) {
		if (response.status === 'connected') {
			fnFBlogin();
		} else if (response.status === 'not_authorized') {
			// 사람은 Facebook에 로그인했지만 앱에는 로그인하지 않았습니다.
			alert('앱에 로그인해야 이용가능한 기능입니다.');
		} else {
			// 그 사람은 Facebook에 로그인하지 않았으므로이 앱에 로그인했는지 여부는 확실하지 않습니다.
			alert('페이스북에 로그인해야 이용가능한 기능입니다.');
		}
	}, {scope: 'public_profile,email'});
}

// 로그인 상태를 가져오기 위해 Facebook에 대한 호출
function statusChangeCallback(res){
	statusChangeCallback(response);
}

window.fbAsyncInit = function() {
	FB.init({
		appId      : '1588150011384568',
		cookie     : true,
		xfbml      : true,
		version    : 'v10.0'
	});
	FB.AppEvents.logPageView();   
};

(function(d, s, id){
	var js, fjs = d.getElementsByTagName(s)[0];
	if (d.getElementById(id)) {return;}
	js = d.createElement(s); js.id = id;
	js.src = "https://connect.facebook.net/en_US/sdk.js";
	fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

</script>

<script async defer crossorigin="anonymous" src="https://connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v10.0&appId=1588150011384568" nonce="SiOBIhLG"></script>
</body>
</html>

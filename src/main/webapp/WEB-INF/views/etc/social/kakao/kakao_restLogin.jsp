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
</head>
<body>
<%@include file="../../include/nav.jsp" %>
<div class="container">
	<div class="row justify-content-center">
		<div class="col-lg-8 col-md-10" style="margin-top: 60px;">
			<div class="card-header text-uppercase font-weight-bold" style="line-height: 40px">KAKAO LOGIN</div>
			<div class="card-body">
		        <div class="d-flex justify-content-end mt-2">
	            </div>
			</div>
			<div class="card-footer">
	            <ul class="list-unstyled">
                   <li class="mb-2" onclick="kakaoLogin(); return false;">
				        <!-- kakao-->
				        <a href="javascript:void(0)" class="social-link social-kakao d-flex align-items-center py-2 rounded-pill shadow-sm">
					        <span class="icon py-1">
					        	<i class="fab fa-kickstarter fa-fw" style="color:#372223"></i>
					        </span><span class="font-weight-bold" style="color:#372223">카카오 REST 로그인</span>
				        </a>
				    </li>
                </ul>
			</div>
		</div>
	</div>
</div>
<!-- 카카오 스크립트 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
//카카오로그인
function kakaoLogin() {
  $.ajax({
      url: '/login/getKakaoAuthUrl',
      type: 'get',
      async: false,
      dataType: 'text',
      success: function (res) {
          location.href = res;
      }
  });
 	
}
$(document).ready(function() {
	
	var kakaoInfo = '${kakaoInfo}';
	
	if(kakaoInfo != ""){
		var data = JSON.parse(kakaoInfo);
		
		alert("카카오로그인 성공 \n accessToken : " + data['accessToken']);
		alert(
		"user : \n" + "email : "
		+ data['email']  
		+ "\n nickname : " 
		+ data['nickname']);
	}
});  
</script>
</body>
</html>
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
      <p class="mt-3" onclick="location.href='/bootpay';"><b>1. Bootpay</b></p>
      <p class="mt-2" onclick="location.href='/iamport';"><b>2. Iamport</b></p>
    </div>
    <div class="col-sm-4">
      <h3>OTHER</h3>
      <p class="mt-3" onclick="location.href='/summernote';"><b>1. Summernote</b></p>
      <p class="mt-2"><b>2. RestAPI</b></p>
      <div onclick="location.href='/btsApiRest';"> - bts - api</div>
      <div onclick="location.href='/businessNumberCheckRest';"> - Business Number api</div>
      <p class="mt-2" onclick="location.href='/niceIdenVerification';"><b>3. Identity verification(Nice)</b></p>
      <p class="mt-2" onclick="location.href='/smsWrite';"><b>4. SMS</b></p>
      <p class="mt-2" onclick="location.href='/mailWrite';"><b>5. MAIL</b></p>
    </div>
  </div>
</div>
</body>
</html>

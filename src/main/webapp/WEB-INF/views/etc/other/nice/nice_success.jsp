<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../include/header.jsp" %>
<html>
<body>
<%@include file="../../include/nav.jsp" %>
<div class="container">
	<div class="row justify-content-center">
		<div class="col-lg-8 col-md-10" style="margin-top: 60px;">
			<div class="card-header text-uppercase font-weight-bold" style="line-height: 40px">NICE 본인인증 성공</div>
			<div class="card-body">
		        <div class="d-flex justify-content-end mt-2">
		        	<table class="table">
					    <tbody>
					      <tr>
					        <td>중복확인코드 : </td>
					        <td>${sEncData.sDupInfo}</td>
					      </tr>
					      <tr>
					        <td>이름 : </td>
					        <td>${sEncData.sName}</td>
					      </tr>
					      <tr>
					        <td>성별 : </td>
					        <td>${sEncData.sGender}</td>
					      </tr>
					      <tr>
					        <td>생년월일 : </td>
					        <td>${sEncData.sBirthDate}</td>
					      </tr>
					      <tr>
					        <td>전화번호 : </td>
					        <td>${sEncData.sMobileNo}</td>
					      </tr>
					    </tbody>
					  </table>
	            </div>
		        <hr />    
			</div>
		</div>
	</div>
</div>
</body>
</html>
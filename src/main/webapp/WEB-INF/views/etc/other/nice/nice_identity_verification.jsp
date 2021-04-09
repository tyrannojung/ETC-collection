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
			<div class="card-header text-uppercase font-weight-bold" style="line-height: 40px">NICE 본인인증</div>
			<div class="card-body">
		        <div class="d-flex justify-content-end mt-2">
		        	<a href="javascript:void(0)" class="btn btn-outline-primary" onclick="fnPopup();">본인인증</a>
	            </div>
	            <form name="form_chk" method="post" style="display:none;">
					<input type="hidden" name="m" value="checkplusSerivce">
					<input type="hidden" name="EncodeData" value="${sEncData}">
				</form>
		        <hr />    
			</div>
		</div>
	</div>
</div>
<script>
function fnPopup(){
	document.form_chk.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
	document.form_chk.submit();
}
</script>
</body>
</html>
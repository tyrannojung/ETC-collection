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
			<div class="card-header text-uppercase font-weight-bold" style="line-height: 40px">MAIL 발송</div>
			<form id="frmCheck" name="frmCheck" method="post" onsubmit="return false;">
				<div class="card-body">
					<div class="form-group">
				      <label for="send_mail">Sender : </label>
				      <input type="text" class="form-control" id="send_mail" name="send_mail" value="tyrannojung@abc.ne.kr" readonly>
				    </div>
				    <div class="form-group">
				      <label for="receiver_mail">Receiver : </label>
				      <input type="text" class="form-control" id="receiver_mail" name="receiver_mail">
				    </div>
				    <div class="form-group">
				      <label for="mail_subject">Subject : </label>
				      <input type="text" class="form-control" id="mail_subject" name="mail_subject">
				    </div>
				    <div class="form-group">
				      <label for="mail_content">Content : </label>
				      <textarea class="form-control" rows="5" id="mail_content" name="mail_content"></textarea>
				    </div>
			        <div class="d-flex justify-content-end mt-2">
			        	<button type="button" class="btn btn-outline-primary" onclick="mailSend()">전송</button>
		            </div>
			        <hr />    
				</div>
			</form>
		</div>
	</div>
</div>
<script>

function mailSend() {
	var params = $('#frmCheck').serialize();
	
	$.ajax({
		type : "POST",
		url : "/sendMail",
		data : params
	}).done(function(data) {
		if(data == "OK"){
			alert("전송성공");
		} else {
			alert("전송실패");
		}
	});
}

</script>
</body>
</html>
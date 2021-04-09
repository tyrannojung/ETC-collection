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
			<div class="card-header text-uppercase font-weight-bold" style="line-height: 40px">SMS 발송</div>
			<form id="frmCheck" name="frmCheck" method="post" onsubmit="return false;">
				<div class="card-body">
					<div class="form-group">
				      <label for="send_number">Sender : </label>
				      <input type="text" class="form-control" id="send_number" name="send_number" value="028537605" readonly>
				    </div>
				    <div class="form-group">
				      <label for="receiver_number">Receiver : </label>
				      <input type="text" class="form-control" id="receiver_number" name="receiver_number">
				    </div>
				    <div class="form-group">
				      <label for="sms_content">Content : </label>
				      <textarea class="form-control" rows="5" id="sms_content" name="sms_content"></textarea>
				    </div>
			        <div class="d-flex justify-content-end mt-2">
			        	<button type="button" class="btn btn-outline-primary" onclick="smsSend()">전송</button>
		            </div>
			        <hr />    
				</div>
			</form>
		</div>
	</div>
</div>
<script>

function smsSend() {
	var params = $('#frmCheck').serialize();
	
	$.ajax({
		type : "POST",
		url : "/sendSMS",
		data : params
	}).done(function(data) {
		if(JSON.parse(data)['result'] == "OK"){
			alert("전송성공");
		} else {
			alert("전송실패");
		}
	});
}

</script>
</body>
</html>
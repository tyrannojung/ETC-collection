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
			<div class="card-header text-uppercase font-weight-bold" style="line-height: 40px">REST - API</div>
			<div class="card-body">
				<h6>BTS wid 조회</h6>
				<hr />
				<div class="form-group">
			      <label for="usr">ID:</label>
			      <input type="text" class="form-control" id="usr" name="username">
			    </div>
		        <div class="d-flex justify-content-end mt-2">
		        	<button type="button" class="btn btn-outline-primary" onclick="api_json()">전송</button>
	            </div>
		        <hr />    
			</div>
		</div>
	</div>
</div>
<script>
function api_json(){
	var sQuery = 
	{
		"requestUrl" : "http://61.43.57.207:8887/btsql"
		, "id": $('#usr').val()
		, "cmd":"getAccountAddress"	
	};
	var a = JSON.stringify(sQuery);
	$.ajax({
	    url: "/btsApiCall_json", 
	    type: 'POST',
	    data: JSON.stringify(sQuery),
	    dataType: 'json',
	    async:false,
		contentType:"application/json;charset=UTF-8",
	    success: function(data) {
	    	console.log(data);
	    	alert("wid : " + data.value.addr);
	    },
	    error:function() { 
	        alert("ajax실패")
	    }
	});
}
</script>
</body>
</html>
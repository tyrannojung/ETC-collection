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
				<h6>사업자번호 조회</h6>
				<hr />
				<div class="form-group">
			        <label for="usr">사업자번호:</label>
			        <input type="text" class="form-control" id="businessNumber">
				</div>
		        <div class="d-flex justify-content-end mt-2">
		        	<button type="button" class="btn btn-outline-success" onclick="api_xml()">전송</button>
	            </div>
	            <hr />
			</div>
		</div>
	</div>
</div>
<script>
function api_xml(){

	var businessNumber = $('#businessNumber').val().replace(/[^0-9]/g,'');
	
	var sQuery = 
	{
			"requestUrl" : "https://teht.hometax.go.kr/wqAction.do?actionId=ATTABZAA001R08&screenId=UTEABAAA13&popupYn=false&realScreenId="
		  , "content":"<map id='ATTABZAA001R08'><inqrTrgtClCd>1</inqrTrgtClCd><txprDscmNo>"+ businessNumber +"</txprDscmNo></map>"
	};
	$.ajax({
	    url: "/businessNumberCheck_json", 
	    type: 'POST',
	    data: JSON.stringify(sQuery),
		contentType:"application/json;charset=UTF-8",
	    success: function(data) { 
	    	if(data.check == '등록되어 있는 사업자등록번호 입니다. '){
	    		alert("정상적인 사업자등록번호 입니다.");
	    	} else {
	    		alert("등록되어있지 않은 사업자 번호입니다.")
	    	}
	    },
	    error:function() { 
	        alert("조회실패");
	    }
	});
}
</script>
</body>
</html>
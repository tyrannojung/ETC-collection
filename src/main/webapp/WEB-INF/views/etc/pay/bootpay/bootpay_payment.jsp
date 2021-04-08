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
.social-bootpay{
    background: #5D51E6;
}

.social-bootpay:hover, .social-bootpay:focus {
    background: #5042E5;
}

.social-link-gradient.social-bootpay {
    background: linear-gradient(to right, #5D51E6, #5D51E6);
}
</style>
</head>
<body>
<%@include file="../../include/nav.jsp" %>
<div class="container">
	<div class="row justify-content-center">
		<div class="col-lg-8 col-md-10" style="margin-top: 60px;">
			<div class="card-header text-uppercase font-weight-bold" style="line-height: 40px">Bootpay Payment</div>
			<div class="card-body">
		        <div class="d-flex justify-content-end mt-2">
	            </div>
			</div>
			<div class="card-footer">
	            <ul class="list-unstyled">
                   <li class="mb-2" onclick="bootpay(); return false;">
                       <!-- Bootpay--><a href="javascript:void(0)" class="social-link social-bootpay d-flex align-items-center py-2 rounded-pill shadow-sm"><span class="icon py-1"><i class="fas fa-bold fa-fw text-white"></i></span><span class="font-weight-bold text-white">결제하기</span></a>
                   </li>
                </ul>
			</div>
		</div>
	</div>
</div>
<!-- 부트페이 스크립트 -->
<script>
var todayDate = new Date();
var oderid =String(todayDate.valueOf());
oderid = "bts_etc" + oderid ;
var point_point = 100

function bootpay(){
	BootPay.request({
		price: point_point,
		application_id: "60015f05d8c1bd001d2d1471",
		name: 'bts-etc',
		pg: 'nicepay',
		method: 'card',
		show_agree_window: 0,
		items: [
			{
				item_name: 'bts-etc',
				qty: 1,
				unique: oderid,
				price: point_point
			}
		],
		order_id: oderid
	}).error(function (data) {
		alert('오류가 발생했습니다.');
	}).cancel(function (data) {
		alert('결제를 취소하셨습니다.');
	}).close(function (data) {
	    console.log(data);
	    // pg 결제 완료
	}).done(function (data) {
		point_pg = JSON.stringify(data);
		point_pgid = data.receipt_id;
		point_pg_kind = data.method_name;
		$.ajax({
			type : "POST",
			url : "/bootpay_confirm",
			data : 
			{
				pgid : point_pgid,
				payment : point_point
			}
		}).done(function (data) {
			if(data == "OK"){
				alert("검증성공");
			}
		});	
	});
}
</script>
<script src="https://cdn.bootpay.co.kr/js/bootpay-3.3.1.min.js" type="application/javascript"></script>     
</body>
</html>
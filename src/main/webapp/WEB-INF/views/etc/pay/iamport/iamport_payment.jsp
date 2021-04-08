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
.social-iamport{
    background: #5D51E6;
}

.social-iamport:hover, .social-iamport:focus {
    background: #5042E5;
}

.social-link-gradient.social-iamport {
    background: linear-gradient(to right, #5D51E6, #5D51E6);
}
</style>
</head>
<body>
<%@include file="../../include/nav.jsp" %>
<div class="container">
	<div class="row justify-content-center">
		<div class="col-lg-8 col-md-10" style="margin-top: 60px;">
			<div class="card-header text-uppercase font-weight-bold" style="line-height: 40px">Iamport Payment</div>
			<div class="card-body">
		        <div class="d-flex justify-content-end mt-2">
	            </div>
			</div>
			<div class="card-footer">
	            <ul class="list-unstyled">
                   <li class="mb-2" onclick="iamport(); return false;">
                       <!-- Iamport--><a href="javascript:void(0)" class="social-link social-iamport d-flex align-items-center py-2 rounded-pill shadow-sm"><span class="icon py-1"><i class="fas fa-bold fa-fw text-white"></i></span><span class="font-weight-bold text-white">결제하기</span></a>
                   </li>
                </ul>
			</div>
		</div>
	</div>
</div>
<!-- 아임포트 스크립트 -->
<script>
function iamport(){
	//가맹점 식별코드
	IMP.init('imp04623135');
	IMP.request_pay({
	    pg : 'kcp',
	    pay_method : 'card',
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : 'bts_etc' , //결제창에서 보여질 이름
	    amount : 100, //실제 결제되는 가격
	    buyer_email : 'iamport@siot.do',
	    buyer_name : '구매자이름',
	    buyer_tel : '010-1234-5678',
	    buyer_addr : '서울 강남구 도곡동',
	    buyer_postcode : '123-456',
	}, function(rsp) {
		console.log(rsp);
		// 결제검증
		$.ajax({
        	type : "POST",
        	url : "/verifyIamport/" + rsp.imp_uid 
        }).done(function(data) {
        	console.log(data);
        	// 위의 rsp.paid_amount 와 data.response.amount를 비교한후 로직 실행 (import 서버검증)
        	if(rsp.paid_amount == data.response.amount){
	        	alert("결제 및 결제검증완료");
        	} else {
        		alert("결제 실패");
        	}
        });
	});
}
</script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../include/header.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/etc/css/join.css" />
</head>
<body>
    <%@include file="../../include/nav.jsp" %>
    <div class="wrap">
        <div class="join_box">
            <!--  -->
            <div class="box_top">
                <p>카카오(다음) 주소찾기</p>
            </div>
            <!--  -->
            <div class="box_bot">
                <div class="join_txt">Company Address</div>
                <input id="member_post" class="w_50pec" type="text" placeholder="Zip Code" readonly onclick="findAddr()">
                <input id="member_addr" type="text" placeholder="Address" readonly> <br>
                <input class="w_300" type="text" placeholder="Detailed Address">
            </div>
        </div>
    </div>
</body>
<script>
function findAddr(){
	new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var jibunAddr = data.jibunAddress; // 지번 주소 변수
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('member_post').value = data.zonecode;
            if(roadAddr !== ''){
                document.getElementById("member_addr").value = roadAddr;
            } 
            else if(jibunAddr !== ''){
                document.getElementById("member_addr").value = jibunAddr;
            }
        }
    }).open();
}
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</html>
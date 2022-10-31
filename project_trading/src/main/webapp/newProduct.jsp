<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품신규등록</title>
	<script>
		function sub(){
			var name = document.getElementsByName("name")[0].value;
			var unit = document.getElementsByName("unit")[0].value;
			var price = document.getElementsByName("price")[0].value;
			
			if(name=="" || unit=="" || price==""){
				alert("공백은 허용되지 않습니다.");
				return;
			}
			var frm=document.frm;
			frm.submit();
		}
	</script>
</head>
<body>
	<%@ include file="header.jsp" %>
	
	<br><br>
<%
	if(auth==0 || auth==1 || (int)session.getAttribute("product")==0){			//비회원,거래처일경우
%>
		<script>
			alert("잘못된 접근입니다.");
			location.href='index.jsp';		
		</script>
<%
	}
%>		
	상품관리
	<br><br>
	<form name="frmCode" method="post" action="newProduct">
		상품명: <input type="text" name="name"> <br>
		단위: <input type="text" name="unit"> <br>
		단가: <input type="number" name="price"> <br>
		<input type="button" onclick="sub();" value="등록하기">
		<input type = "reset" value ="다시작성">
	</form>	
		
	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String code=request.getParameter("code");				
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품신규등록</title>
</head>
<body>
	<%@ include file="header.jsp" %>
	
	<br><br>
<%
	if(auth==0 || auth==1){			//비회원,거래처일경우
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
		공급가액: <input type="text" name="price"> <br>
		<input type="submit" value="등록하기">
		<input type = "reset" value ="다시작성">
	</form>	
		
	
</body>
</html>
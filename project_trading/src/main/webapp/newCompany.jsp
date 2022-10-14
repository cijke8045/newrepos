<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거래처신규등록</title>
</head>
<body>
	<%@ include file="header.jsp" %>
	
	<br><br>
<%
	if(auth==0 || auth==1 || (int)session.getAttribute("company")==0){			//비회원,거래처,권한없는경우
%>
		<script>
			alert("잘못된 접근입니다.");
			location.href='index.jsp';		
		</script>
<%
	}
%>		
	거래처관리
	<br><br>
	<form name="frmCode" method="post" action="newCompany">
		상호 : <input type="text" name="name"> <br>
		사업자번호 : <input type="text" name="code"> <br>
		연락처: <input type="text" name="contact"> <br>
		주소: <input type="text" name="address"> <br>
		<input type="submit" value="등록하기">
		<input type = "reset" value ="다시작성">
	</form>	
		
	
</body>
</html>
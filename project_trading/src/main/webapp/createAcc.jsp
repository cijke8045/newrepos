<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String code=request.getParameter("code");				
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입창</title>
</head>
<body>
	<%@ include file="header.jsp" %>
	회원가입은 승인제입니다.<br>
	고유번호가 없으신분은 관리자에게 코드를 부여받으세요.<br>
	Contact. 010-1234-5678<br><br>
	
	
	<form name="frmCode" method="post" action="checkCode">
		고유번호: <input type="text" name="code">
		<input type="submit" value="가입하기">
	</form>		
	
</body>
</html>
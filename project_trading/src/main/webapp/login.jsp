<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String id = request.getParameter("id");
String pw = request.getParameter("pw");
Boolean loginClick=Boolean.parseBoolean(request.getParameter("loginClick"));
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
	<script>
		function login(){
			var frmLogin = document.frmLogin;
			var id= frmLogin.id.value;
			var pw= frmLogin.pw.value;			
			if(id==null || id.length==0){				<!--유저아이디 미입력시-->
				alert("아이디를 입력하세요.");
			} else if(pw==null || pw.length==0) { 	<!--유저비밀번호 미 입력시-->
				alert("비밀번호를 입력하세요.");
			} else {
				frmLogin.action = "login";
				frmLogin.method = "post";
				frmLogin.submit();
			}
		}
	</script>
</head>
<body>
	<%@ include file="header.jsp" %>
	<br>
	
	<form name ="frmLogin" encType="utf-8">
		아이디 : <input type="text" name="id"><br>
		비밀번호:<input type ="password" name="pw"><br>
		<input type="button" onclick="login()" value="로그인">
		<input type="reset" value="다시입력">
	</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String user_id = request.getParameter("user_id");
String user_pw = request.getParameter("user_pw");
Boolean loginClick=Boolean.parseBoolean(request.getParameter("loginClick"));
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

</head>
<body>
	<%@ include file="header.jsp" %>
	<br><br>
	
	<form name ="frmLogin" method="post" action="login.jsp" encType="utf-8">
	아이디 : <input type="text" name="user_id"><br>
	비밀번호:<input type ="password" name="user_pw"><br>
	<input type="hidden" name="loginClick" value="true">
	<input type="submit" value="로그인">
	<input type="reset" value="다시입력">
	</form>
	
	<%
	if(loginClick==true) {								//유저아이디 미입력시
		if(user_id==null || user_id.length()==0){
	%>
		<script>
			alert("아이디를 입력하세요.")
		</script>
	<%
		} else if(user_pw==null || user_pw.length()==0) { //유저비밀번호 미 입력시
	%>			
			<script>
			alert("비밀번호를 입력하세요.")
			</script>
	<%
		}else {							// 로그인성공시 작동 DB연동 로그인기능 구현 후 처리
	%>
			<%= user_id %>					
	<%		
		}
	}
	%>
	
	
</body>
</html>
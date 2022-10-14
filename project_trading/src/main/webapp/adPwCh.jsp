<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.ArrayList"
	import=" dto.EmployeeDTO"
	import=" dao.EmployeeDAO"
    pageEncoding="UTF-8"%>
   
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 비밀번호 변경</title>
	<link rel = "stylesheet" href = "css/style.css">
	<script>
		function conf() {
			var ans = confirm("변경하시겠습니까?");
			
			if(ans){
				var tbl = document.tbl;
				tbl.method="post";
				tbl.action="adPwCh";
				tbl.submit();
			}
		}
	</script>
</head>
<body>
	<%@ include file="header.jsp" %>
	<br><br>
<%
	if(auth!=3){			//관리자 외 접속시
%>
		<script>
			alert("잘못된 접근입니다.");
			location.href='index.jsp';		
		</script>
<%
	}else{			//관리자 로그인시
%>	
		
		비밀번호변경 
		<br><br>
		<form method="post" name="tbl" action="employee.jsp" style="text-align: center;">
			<a>현재 비밀번호:<input type="text" name = "nowpw" value=""/></a><br><br>
			<a>변경 할 비밀번호:<input type="text" name = "changepw"  value=""/></a><br><br>
			<a>변경 할 비밀번호 확인:<input type="text" name = "checkchangepw" value=""/></a>
		</form>
		
		<br><br>

		<div style="text-align: center ">
			<button class="btn" type="button" value="신규등록" onclick="conf();">변경</button>  &nbsp;&nbsp;
		</div>
<%
	}
%>	
</body>
</html>
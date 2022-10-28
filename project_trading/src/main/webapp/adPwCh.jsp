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
			var nowpw=document.getElementsByName("nowpw")[0].value;
			var chpw=document.getElementsByName("changepw")[0].value;
			var chpwch=document.getElementsByName("checkchangepw")[0].value;
			
			if(chpw=="" || chpwch=="" || nowpw==""){
				alert("비밀번호는 공백일 수 없습니다.");
				return;
			}else if (chpw!=chpwch){
				alert("설정한 비밀번호와 확인이 다릅니다.");
				return;
			}
			
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
			<a>현재 비밀번호:<input type="password" name = "nowpw" /></a><br><br>
			<a>변경 할 비밀번호:<input type="password" name = "changepw"/></a><br><br>
			<a>변경 할 비밀번호 확인:<input type="password" name = "checkchangepw" /></a>
		</form>
		
		<br><br>

		<div style="text-align: center ">
			<button class="btn" type="button" onclick="conf();">변경</button>  &nbsp;&nbsp;
		</div>
<%
	}
%>	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원신규등록</title>
	<script>
		function sub(){
			var name = document.getElementsByName("name")[0].value;
			var department = document.getElementsByName("department")[0].value;
			var job = document.getElementsByName("job")[0].value;
			var contact = document.getElementsByName("contact")[0].value;
			
			if(name=="" || department=="" ||job=="" || contact==""){
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
	if(auth!=3){			//관리자만
%>
		<script>
			alert("잘못된 접근입니다.");
			location.href='index.jsp';		
		</script>
<%
	}
%>		
	직원관리
	<br><br>
	<form name="frm" method="post" action="newEmployee">
		이름 : <input type="text" name="name"> <br>
		부서 : <input type="text" name="department"> <br>
		직급: <input type="text" name="job"> <br>
		연락처: <input type="text" name="contact"> <br>
		<input type="button" onclick="sub();" value="등록하기">
		<input type ="reset" value ="다시작성">
	</form>	
		
</body>
</html>
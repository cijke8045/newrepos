<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String code=request.getParameter("code"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입창</title>
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript">
		function overlapch() {
			var _id =$("#t_id").val();
			if(_id==''){
				alert("ID를 입력하세요.");
				return;
			}
			$.ajax({
				type:"post", async:true, url:"http://192.168.1.57:8090/project_trading/overlap",
				dataType:"text",data:{id:_id},
				success:function(data, textStatus){
					if(data=='possible'){
				       	   $('#message').text("사용할 수 있는 ID입니다.");	
				       	   $('#btn_duplicate').prop("disabled", true);
				    }else{
				       	   $('#message').text("!!!!사용불가!!!!");
			        }						
				},
				error:function(data,textStatus){
			          alert("에러가 발생했습니다.");
			    },
			    complete:function(data,textStatus){
			          //alert("작업을완료 했습니다");
			    }
			})
		}
	</script>
	<script>
	function fn_sendMember() {
		var frmMember = document.frmMember;
		var id = frmMember.id.value;
		var pwd = frmMember.pw.value;
		var chpwd = frmMember.chpwd.value;
		
		if(pwd.length == 0 || pwd=="") {
			alert("비밀번호는 필수입니다.");
		} else if(chpwd!=pwd){
			alert("비밀번호를 확인하세요.")
		}else{
			frmMember.method = "post";
			frmMember.action = "newmember";
			frmMember.submit();
		}
	}
	</script>
</head>
<body>
	<% 
	if(code==null) { 
	%>	
	<script>
			alert("잘못된 접근입니다.");
	</script>
	<a href ="index.jsp">메인으로</a>
		
	<%
	} else{
	%>		
	<form name="frmMember">
		<table>
			<th>회원가입창</th>
			<tr>
				<td>아이디</td>
				<td><input type="text" id="t_id" name="id"></td>
				<td><input type="button" id="btn_duplicate" value="ID중복체크" onClick="overlapch()">
				<div id="message"> </div>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="pw"></td>				
			</tr>
			<tr>
				<td>비밀번호확인</td>
				<td><input type="password" name="chpwd"></td>				
			</tr>
		</table>

		<input type= "hidden" name="code" value="<%= code %>">
		<input type = "button" value="가입하기" onclick="fn_sendMember()">
		<input type = "reset" value ="다시작성">		
	</form>
	<%
	}
	%>
</body>
</html>
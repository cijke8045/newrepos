<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.ArrayList"
	import="dto.MemberDTO"
	import="dao.MemberDAO"
    pageEncoding="UTF-8"%>
   
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 관리</title>
	<link rel = "stylesheet" href = "css/style.css">
	<script>
		function auth() {
			var tbl = document.tbl;
			tbl.method="post";
			tbl.action="mngAuth.jsp";
			tbl.submit();
		}
	
		function conf() {
			var ans = confirm("회원을 삭제하시겠습니까?");
			
			if(ans){
				var tbl = document.tbl;
				tbl.method="post";
				tbl.action="delMember";
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
		
		직원관리 
		<br><br>
		<form class = "searchCom" method="post" action="member.jsp">
			<select name="sel">
				<option value="employee">직원</option>
				<option value="company">거래처</option>
			</select>
			<input type="text" width="500px" name = "comtxt" placeholder="상호 또는 직원명을 입력해주세요" value=""/>
			<input type="submit" value="검색"/>
		</form>
		
		<br><br>
		
<%
		ArrayList<MemberDTO> dtos = new ArrayList<MemberDTO>();
		MemberDAO dao = new MemberDAO(); 
		MemberDTO dto = new MemberDTO();
		if(request.getParameter("comtxt")==null) {		
			
		}else if(request.getParameter("comtxt").equals("")){		//미 입력시 전부검색
			if(request.getParameter("sel").equals("employee")) {	//직원검색
				dtos=dao.searchMemberE("all");
			}else{													//거래처검색		
				dtos=dao.searchMemberC("all");
			}
		} else{														//검색어 입력시
			if(request.getParameter("sel").equals("employee")) {	//직원검색
				dtos=dao.searchMemberE(request.getParameter("comtxt"));
			}else{
				dtos=dao.searchMemberC(request.getParameter("comtxt"));
			}
		}
		
		if(request.getParameter("comtxt")!=null) {
			if(request.getParameter("sel").equals("employee")){			//직원조회
%>
				<form class="tblWrapper" name="tbl">
				<table class="infoList">
					<tr><th>선택</th><th>직원코드</th><th>아이디</th><th>이름</th><th>부서</th><th>직급</th></tr>
<%						
				for(int i =0; i<dtos.size(); i++){
					dto=dtos.get(i);
%>				
				<tr><td><input type="radio" name="code" value=<%=dto.getCode() %> /></td><td><%= dto.getCode() %></td><td><%=dto.getId() %></td><td><%=dto.getName() %></td><td><%=dto.getDepartment() %></td><td><%=dto.getJob() %></td></tr>
<%	
				}
			} else {
%>
			<form class="tblWrapper" name="tbl">
				<table class="infoList">
					<tr><th>선택</th><th>사업자번호</th><th>아이디</th><th>상호</th></tr>
<%						
				for(int i =0; i<dtos.size(); i++){
					dto=dtos.get(i);
%>				
				<tr><td><input type="radio" name="code" value=<%=dto.getCode() %> /></td><td><%= dto.getCode() %></td><td><%=dto.getId() %></td><td><%=dto.getName() %></td></tr>
<%				
				}
			}
		}
%>				
			</table>
		</form>
		
		<br><br>
		<div style="text-align: center ">
<%
		if(dtos.size()!=0){
			if(request.getParameter("sel").equals("employee")){
%>		
			<button class="btn" type="button" onclick="auth();">관리권한설정</button>  &nbsp;&nbsp;
<%
			}
%>			
			<button class="btn" type="button" onclick="conf();">계정삭제</button>
		</div>
<%
		}
	}
%>	
</body>
</html>
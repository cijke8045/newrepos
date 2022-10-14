<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.ArrayList"
	import=" dto.EmployeeDTO"
	import=" dao.EmployeeDAO"
    pageEncoding="UTF-8"%>
   
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>직원 관리</title>
	<link rel = "stylesheet" href = "css/style.css">
	<script>
		function conf() {
			var ans = confirm("직원을 삭제하시겠습니까?");
			
			if(ans){
				var tbl = document.tbl;
				tbl.method="post";
				tbl.action="delEmployee";
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
		<form class = "searchCom" method="post" action="employee.jsp">
			<input type="text" name = "comtxt" placeholder="직원명을 입력해주세요" value=""/>
			<input type="submit" value="검색"/>
		</form>
		
		<br><br>
		
<%
		ArrayList<EmployeeDTO> dtos = new ArrayList<EmployeeDTO>();
		EmployeeDAO dao = new EmployeeDAO(); 
		EmployeeDTO dto = new EmployeeDTO();
		if(request.getParameter("comtxt")==null) {		
			
		}else if(request.getParameter("comtxt").equals("")){
			dtos=dao.searchEmployee("all");		//미 입력시 전부검색
		} else{					//검색어 입력시
			dtos=dao.searchEmployee(request.getParameter("comtxt"));
		}
		
		if(request.getParameter("comtxt")!=null) {		
%>
			<form class="tblWrapper" name="tbl">
			<table class="infoList">
				<tr><th>선택</th><th>직원코드</th><th>이름</th><th>부서</th><th>직급</th><th>연락처</th></tr>
<%						
			for(int i =0; i<dtos.size(); i++){
				dto=dtos.get(i);
%>				
		
		<tr><td><input type="radio" name="code" value=<%=dto.getCode() %> /></td><td><%= dto.getCode() %></td><td><%=dto.getName() %></td><td><%=dto.getDepartment() %></td><td><%=dto.getJob() %></td><td><%=dto.getContact() %></td></tr>
<%
			}
		}
%>				
			</table>
		</form>
		
		<br><br>
		<div style="text-align: center ">
			<button class="btn" type="button" value="신규등록" onclick="location.href='newEmployee.jsp';">신규등록</button>  &nbsp;&nbsp;
			<button class="btn" type="button" value="삭제" onclick="conf();">삭제</button>
		</div>
<%
	}
%>	
</body>
</html>
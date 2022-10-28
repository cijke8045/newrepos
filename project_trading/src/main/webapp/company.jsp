<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.ArrayList"
	import=" dto.CompanyDTO"
	import=" dao.CompanyDAO"
    pageEncoding="UTF-8"%>
   
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>거래처 관리</title>
	<link rel = "stylesheet" href = "css/style.css">
	<script>
		function conf() {
			var code=document.getElementsByName("code");
			var flag = false;
			
			for(var i=0; i<code.length;i++){
				if(code[i].checked){
					flag=true;
					break;
				}
			}
			if(flag){
				var ans = confirm("거래처를 삭제하시겠습니까? 3번 생각하고 삭제하세요");
				if(ans){
					var tbl = document.tbl;
					tbl.method="post";
					tbl.action="delCompany";
					tbl.submit();
				}	
			}else{
				alert("삭제할 거래처를 선택해주세요.");
				return;
			}
			
		}
	</script>
</head>
<body>
	<%@ include file="header.jsp" %>
	<br><br>
<%
	if(auth==0 || auth==1 ||(int)session.getAttribute("company")==0){			//비회원,거래처,권한없는경우
%>
		<script>
			alert("잘못된 접근입니다.");
			location.href='index.jsp';		
		</script>
<%
	}else{			//권한 있을 시
%>	
		
		거래처관리 
		<br><br>
		<form class = "searchCom" method="post" action="company.jsp">
			<input type="text" name = "comtxt" placeholder="상호명을 입력해주세요" value=""/>
			<input type="submit" value="검색"/>
		</form>
		
		<br><br>
		
<%
		ArrayList<CompanyDTO> dtos = new ArrayList<CompanyDTO>();
		CompanyDAO dao = new CompanyDAO(); 
		CompanyDTO dto = new CompanyDTO();
		if(request.getParameter("comtxt")==null) {		
			
		}else if(request.getParameter("comtxt").equals("")){
			dtos=dao.searchCompany("all");		//미 입력시 전부검색
		} else{					//검색어 입력시
			dtos=dao.searchCompany(request.getParameter("comtxt"));
		}
		
		if(request.getParameter("comtxt")!=null) {		
%>
			<form class="tblWrapper" name="tbl">
			<table class="infoList">
				<tr><th>선택</th><th>사업자번호</th><th>상호</th><th>전화번호</th><th>주소</th></tr>
<%						
			for(int i =0; i<dtos.size(); i++){
				dto=dtos.get(i); 
%>				
		
		<tr><td><input type="radio" name="code" value=<%=dto.getCode() %> /></td><td><%=dto.getCode() %></td><td><%=dto.getName() %></td><td><%=dto.getContact() %></td><td><%=dto.getAddress() %></td></tr>
<%
			}
		}
%>				
			</table>
		</form>
		
		<br><br>
		<div style="text-align: center ">
			<button class="btn" type="button" value="신규등록" onclick="location.href='newCompany.jsp';">신규등록</button>  &nbsp;&nbsp;
<%
		if(request.getParameter("comtxt")!=null) {
%>			
			<button class="btn" type="button" value="삭제" onclick="conf();">삭제</button>
<%
		}
%>			
		</div>
<%
	}
%>	
</body>
</html>
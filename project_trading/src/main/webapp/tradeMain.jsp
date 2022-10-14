<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.ArrayList"
	import=" dto.CompanyDTO"
	import=" dao.CompanyDAO"
	pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>거래 관리</title>
	<link rel = "stylesheet" href = "css/style.css">
	<script>
		function search() {
			var tbl = document.tbl;
			tbl.method = "post";
			tbl.action = "tradeDetail.jsp";
			tbl.submit();
		}
	</script>
</head>
<body>
	<%@ include file="header.jsp" %>
	<br><br>
<%
	if(auth==0 || auth==1 || (int)session.getAttribute("trade")==0){			//비회원,거래처일경우
%>
		<script>
			alert("잘못된 접근입니다.");
			location.href='index.jsp';		
		</script>
<%
	}else{			//권한 있을 시
%>	
		거래관리
		<br><br>
		<button class="btn" type="button" onclick="location.href='tradeFormOut.jsp';">신규 매출 거래명세서</button> &nbsp;&nbsp;
		<button class="btn" type="button" onclick="location.href='tradeFormIn.jsp';">신규 매입 거래명세서</button> &nbsp;&nbsp;
		<form class = "searchCom" method="post" action="tradeMain.jsp">
			<input type="text" name = "comtxt" placeholder="상호를 입력해주세요" value=""/>
			<input type="submit" value="검색"/>
		</form>
		<p style="text-align: center;">※ 전체거래처를 검색하시려면 공란으로 검색을 해주세요.</p>
<%
		if(request.getParameter("comtxt")!=null) {
%>
		<br><br>
<%
		}
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
		<form name="tbl" style="width: 1200px; height: 500px; margin: auto;">
			<table class="infoList">
				<tr><th>선택</th><th>사업자번호</th><th>상호</th><th>전화번호</th><th>주소</th></tr>
<%						
			for(int i =0; i<dtos.size(); i++){
				dto=dtos.get(i);
%>			
		
		<tr><td><input type="radio" name="code" value=<%=dto.getCode() %> /></td><td><%=dto.getCode() %></td><td><%=dto.getName() %></td><td><%=dto.getContact() %></td><td><%=dto.getAddress() %></td></tr>
<%
			}
%>				
			</table>
		<br><br>
		<div style="text-align: center ">
			<p style="text-align: center;">※ 거래처 미 선택시 전체거래처로 조회됩니다.</p>
			<p style="text-align: center;">※ 전체기간을 검색하시려면 조회기간을 공란으로 두고 조회 해주세요.</p>
			조회기간:<input type="date" name="start" value="all"/>~<input type="date" name="end" value="all"/>
			<button class="btn" type="button" onclick="search();">조회</button>  &nbsp;&nbsp;
		</div>
		</form>
<%
		}
	}
%>	
</body>
</html>
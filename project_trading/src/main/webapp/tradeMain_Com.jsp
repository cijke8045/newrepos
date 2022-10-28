<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.ArrayList"
	import=" dto.CompanyDTO"
	import=" dao.CompanyDAO"
	pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>거래명세서 조회</title>
	<link rel = "stylesheet" href = "css/style.css">
	<script>
		function search() {
			var tbl = document.tbl;
			tbl.method = "post";
			tbl.action = "tradeList_Com.jsp";
			tbl.submit();
		}
	</script>
</head>
<body>
	<%@ include file="header.jsp" %>
	<br><br>
<%
	if(auth!=1){			//거래처가 아닐경우
%>
		<script>
			alert("잘못된 접근입니다.");
			location.href='index.jsp';		
		</script>
<%
	}else{			//권한 있을 시
%>	
		거래명세서 조회
		<br><br>
		<form name="tbl" style="width: 1200px; height: 500px; margin: auto;">
		<div style="text-align: center ">
			<p style="text-align: center;">※ 전체기간을 검색하시려면 조회기간을 공란으로 두고 조회 해주세요.</p>
			조회기간:<input type="date" name="start"/>~<input type="date" name="end" />
			<select name="inout">
				<option value="3">매출매입</option>
				<option value="0">매출만</option>
				<option value="1">매입만</option>
			</select>
			<input type="hidden" name="code" value=<%=session.getAttribute("code") %> />
			<button class="btn" type="button" onclick="search();">조회</button>  &nbsp;&nbsp;
		</div>
		</form>
<%
	}
%>	
</body>
</html>
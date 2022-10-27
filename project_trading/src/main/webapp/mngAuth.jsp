<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.ArrayList"
	import="dto.MemberDTO"
	import="dao.MemberDAO"
    pageEncoding="UTF-8"%>
   
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 권한 설정</title>
	<link rel = "stylesheet" href = "css/style.css">
	<script>
		function conf() {
			var ans = confirm("권한을 이대로 저장하시겠습니까?");
			
			if(ans){
				var tbl = document.tbl;
				tbl.method="post";
				tbl.action="mngAuth";
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
		권한 설정 
		<br><br>
		
<%
		MemberDAO dao = new MemberDAO(); 
		MemberDTO dto = new MemberDTO();
		dto=dao.infoMemberE(Integer.parseInt(request.getParameter("code")));
%>
		<%=dto.getName() %> (직원코드:<%=dto.getCode() %>) 님의 관리권한입니다.
		<form name="tbl" style="width: 1200px; height: 100px; margin: auto;">
			<table class="infoList">
				<tr><th>거래처관리</th><th>상품관리</th><th>재고관리</th><th>거래관리</th><th>외상관리</th></tr>
				<tr>

					<td><input type="checkbox" name="company" value="1" ></td>
					<td><input type="checkbox" name="product" value="1" ></td>
					<td><input type="checkbox" name="stock" value="1" ></td>
					<td><input type="checkbox" name="trade" value="1" ></td>
					<td><input type="checkbox" name="collect" value="1"></td>
					
					<script>
						if(<%=dto.getCompany()%>==1){							
							tbl.company.checked = true;
						}
						if(<%=dto.getProduct()%>==1){							
							tbl.product.checked = true;
						}
						if(<%=dto.getStock()%>==1){							
							tbl.stock.checked = true;
						}
						if(<%=dto.getTrade()%>==1){							
							tbl.trade.checked = true;
						}
						if(<%=dto.getCollect()%>==1){							
							tbl.collect.checked = true;
						}
					</script>
				</tr>
			</table>
			<input type="hidden" name="code" value="<%=dto.getCode() %>">
		</form>
<%				
	}
%>			
		<br><br>
		<div style="text-align: center ">
			<button class="btn" type="button" onclick="conf();">저장</button>  &nbsp;&nbsp;
			<button class="btn" type="button" onclick="location.href='member.jsp';">돌아가기</button>
		</div>
</body>
</html>
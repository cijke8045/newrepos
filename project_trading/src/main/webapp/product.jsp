<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.List"
	import=" dto.ProductDTO"
	import=" dao.ProductDAO"
    pageEncoding="UTF-8"%>
<%!
	String p_code;
	String p_name;
	String p_unit;
	String p_price;
	
%>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>거래처 관리</title>
	<link rel = "stylesheet" href = "css/style.css">
</head>
<body>
	<%@ include file="header.jsp" %>
	<br><br>
<%
	if(auth==0 || auth==1){			//비회원,거래처일경우
%>
		<script>
			alert("잘못된 접근입니다.");
			location.href='index.jsp';		
		</script>
<%
	}else{			//권한 있을 시
%>	

		<form class = "searchCom" method="post" action="product.jsp">
			<input type="text" name = "comtxt" placeholder="상품명을 입력해주세요"/>
			<input type="submit" value="검색"/>
			<input type="hidden" name="command" value="search"/>
		</form>
		
		<br><br>
		
<%
		List<ProductDTO> dtos=null;
		ProductDAO dao = new ProductDAO(); 
		ProductDTO dto = new ProductDTO();
				
		if(request.getParameter("comtxt")==null && request.getParameter("command")==null){
			dtos=dao.searchProduct("all");		//미 입력시 전부검색
		} else if(request.getParameter("command").equals("search")){					//검색어 입력시
			dtos=dao.searchProduct(request.getParameter("comtxt"));
		}
%>		
		<form class="tblWrapper">
			<table class="infoList">
				<tr><th>상품코드</th><th>상품명</th><th>단위</th><th>공급가액</th></tr>
<%
		for(int i =0; i<dtos.size(); i++){
			dto=dtos.get(i);
%>				
		<tr><td><%= dto.getP_code() %></td><td><%=dto.getP_name() %></td><td><%=dto.getP_unit() %></td><td><%= dto.getP_price() %></td></tr>
<%
		}
%>				
			</table>
		</form>
		
		<br><br>
		<div style="text-align: center ">
			<button class="btn" type="button" value="상세조회">상세조회</button> &nbsp;&nbsp;
			<button class="btn" type="button" value="신규등록">신규등록</button>  &nbsp;&nbsp;
			<button class="btn" type="button" value="삭제">삭제</button>
		</div>
<%
	}
%>	
</body>
</html>
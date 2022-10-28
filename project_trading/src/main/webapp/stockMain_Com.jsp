<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.ArrayList"
	import=" dto.StockDTO"
	import=" dto.ProductDTO"
	import=" dao.StockDAO"
	import=" dao.ProductDAO"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>재고 조회</title>
	<link rel = "stylesheet" href = "css/style.css">
</head>
<body>
	<%@ include file="header.jsp" %>
	<br><br>
<%
	if(auth!=1){
%>
		<script>
			alert("잘못된 접근입니다.");
			location.href='index.jsp';		
		</script>
<%
	}else{			//권한 있을 시
%>	
		재고조회
		<br><br>
		
		<form class = "searchCom" method="post" action="stockMain_Com.jsp">
			<input type="text" name = "comtxt" placeholder="상품명을 입력해주세요" value=""/>
			<input type="submit" value="검색"/>
		</form>
		
		<br><br>
		
<%
		ArrayList<ProductDTO> p_dtos = new ArrayList<ProductDTO>();
		ProductDAO p_dao = new ProductDAO(); 
		ProductDTO p_dto = new ProductDTO();
		StockDTO s_dto = new StockDTO();
		StockDAO s_dao = new StockDAO();
		
		if(request.getParameter("comtxt")==null) {		
			
		}else if(request.getParameter("comtxt").equals("")){
			p_dtos=p_dao.searchProduct("all");		//미 입력시 전부검색
		} else{					//검색어 입력시
			p_dtos=p_dao.searchProduct(request.getParameter("comtxt"));
		}
		
		if(request.getParameter("comtxt")!=null) {		
%>

			<p style="text-align:center;">본 재고수량은 참고용입니다. 실수량은 문의하세요.</p>
			<br>
			<form class="tblWrapper" name="tbl">
			<table class="infoList">
				<tr><th>상품코드</th><th>상품명</th><th>현재수량</th></tr>
<%						
			for(int i =0; i<p_dtos.size(); i++){
				p_dto=p_dtos.get(i);
				s_dto=s_dao.stockWithcode(p_dto.getP_code());
				
%>				
		
		<tr><td><%= p_dto.getP_code() %></td><td><%=p_dto.getP_name() %></td><td><%=s_dto.getTotalcnt() %></td></tr>
<%
			}
%>				
			</table>
		</form>
<%
		}
	}
%>	
</body>
</html>
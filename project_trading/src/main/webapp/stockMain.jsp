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
	<title>재고 관리</title>
	<link rel = "stylesheet" href = "css/style.css">
	<script>
		function detail() {
			var tbl = document.tbl;
			tbl.method = "post";
			tbl.action = "stockDetail.jsp";
			tbl.submit();
		}
	</script>
</head>
<body>
	<%@ include file="header.jsp" %>
	<br><br>
<%
	if(auth==0 || auth==1 || (int)session.getAttribute("stock")==0){			//비회원,거래처일경우
%>
		<script>
			alert("잘못된 접근입니다.");
			location.href='index.jsp';		
		</script>
<%
	}else{			//권한 있을 시
%>	
		재고관리
		<br><br>
		
		<form class = "searchCom" method="post" action="stockMain.jsp">
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
			<form class="tblWrapper" name="tbl">
			<table class="infoList">
				<tr><th>선택</th><th>상품코드</th><th>상품명</th><th>현재수량</th></tr>
<%						
		
			for(int i =0; i<p_dtos.size(); i++){
				p_dto=p_dtos.get(i);
				s_dto=s_dao.stockWithcode(p_dto.getP_code());
				
%>				
		
		<tr><td><input type="radio" name="code" value=<%=p_dto.getP_code() %> /></td><td><%= p_dto.getP_code() %></td><td><%=p_dto.getP_name() %></td><td><%=s_dto.getTotalcnt() %></td></tr>
<%
			}
		
%>				
			</table>
		</form>
		
		<br><br>
		<div style="text-align: center ">
			<button class="btn" type="button" onclick="detail();">입출내역상세조회</button>  &nbsp;&nbsp;
		</div>
<%
		}
	}
%>	
</body>
</html>
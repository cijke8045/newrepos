<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.ArrayList"
	import=" dto.ProductDTO"
	import=" dao.ProductDAO"
    pageEncoding="UTF-8"%>
   
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품 관리</title>
	<link rel = "stylesheet" href = "css/style.css">
	<script>
		function conf() {
			var ans = confirm("상품삭제시 재고 또한 삭제됩니다. 3번 생각하고 삭제하세요");
			
			if(ans){
				var tbl = document.tbl;
				tbl.method="post";
				tbl.action="delProduct";
				tbl.submit();
			}
		}
	</script>
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
		
		상품관리 
		<br><br>
		<form class = "searchCom" method="post" action="product.jsp">
			<input type="text" name = "comtxt" placeholder="상품명을 입력해주세요" value=""/>
			<input type="submit" value="검색"/>
		</form>
		
		<br><br>
		
<%
		ArrayList<ProductDTO> dtos = new ArrayList<ProductDTO>();
		ProductDAO dao = new ProductDAO(); 
		ProductDTO dto = new ProductDTO();
		if(request.getParameter("comtxt")==null) {		
			
		}else if(request.getParameter("comtxt").equals("")){
			dtos=dao.searchProduct("all");		//미 입력시 전부검색
		} else{					//검색어 입력시
			dtos=dao.searchProduct(request.getParameter("comtxt"));
		}
		
		if(request.getParameter("comtxt")!=null) {		
%>
			<form class="tblWrapper" name="tbl">
			<table class="infoList">
				<tr><th>선택</th><th>상품코드</th><th>상품명</th><th>단위</th><th>공급가액</th></tr>
<%						
			for(int i =0; i<dtos.size(); i++){
				dto=dtos.get(i);
%>				
		
		<tr><td><input type="radio" name="code" value=<%=dto.getP_code() %> /></td><td><%= dto.getP_code() %></td><td><%=dto.getP_name() %></td><td><%=dto.getP_unit() %></td><td><%= dto.getP_price() %></td></tr>
<%
			}
		}
%>				
			</table>
		</form>
		
		<br><br>
		<div style="text-align: center ">
			<button class="btn" type="button" value="신규등록" onclick="location.href='newProduct.jsp';">신규등록</button>  &nbsp;&nbsp;
			<button class="btn" type="button" value="삭제" onclick="conf();">삭제</button>
		</div>
<%
	}
%>	
</body>
</html>
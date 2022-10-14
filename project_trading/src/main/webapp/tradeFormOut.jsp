<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.ArrayList"
	import="dao.CompanyDAO"
	import="dto.CompanyDTO"
	import="dao.ProductDAO"
	import="dto.ProductDTO"
	
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>신규 매출 등록</title>
	<link rel = "stylesheet" href = "css/style.css">
	<script>
		function comsel(){
			var cominfo = document.
		}	
		function newcol(){
			
		}
	</script>
</head>
<body>
	<%@ include file="header.jsp" %>
	<br><br>
<%
	if(auth==0 || auth==1 || (int)session.getAttribute("trade")==0){			//비회원,거래처,권한없을경우
%>
		<script>
			alert("잘못된 접근입니다.");
			location.href='index.jsp';		
		</script>
<%
	}
	CompanyDAO c_dao = new CompanyDAO();
	CompanyDTO c_dto = new CompanyDTO();
	ArrayList<CompanyDTO> c_dtos = new ArrayList<CompanyDTO>();
	ProductDAO p_dao = new ProductDAO();
	ProductDTO p_dto = new ProductDTO();
	ArrayList<ProductDTO> p_dtos = new ArrayList<ProductDTO>();
	
	c_dtos=c_dao.searchCompany("all");
	p_dtos=p_dao.searchProduct("all");
	
%>
	
	<table class="trade">
		<tr>
			<th style="background-color:gray; width:100px;">수요자</th>
			<th style="background-color:white; width:450px;">
					<div style="text-align:left;" class = "searchTrade">
						<label for="search">상호:</label>
						<input type="text" list="com_list" name="company">
							<datalist id="com_list">
<% 
	for(int i=0; i<c_dtos.size(); i++){
		c_dto=c_dtos.get(i);
%>								
						    	<option value=<%=c_dto.getName()  %>></option>
<% 
	}
%>							    	
						    </datalist>
						<button class="btn" type="button" onclick="comsel();">선택</button>
					</div>	
				
				<p style="text-align: left;">사업자 : </p>
				<p style="text-align: left;" >연락처 : </p>
				<p style="text-align: left;">주소 : </p>
			</th>
			
			<th style="background-color:gray; width:230px;">
				<p>거래 명세서</p>
				<p>거래 일자</p>
				<p><input type="date"> </p>
			</th>
			
			<th style="background-color:gray; width:100px;">공급자</th>
			<th style="background-color:white; width:450px; text-align:left">
				<p> 상호 : 고이상사</p>
				<p> 사업자 : 12345678910</p>
				<p> 연락처 : 010-1234-5678</p>
				<p> 주소 : 대한민국</p>
				</pre>
			</th>
	</table>
	<button class="btn" type="button" onclick="newcol();">행추가</button>
	<button class="btn" type="button" onclick="delcol();">행삭제</button>
	<form class="tblWrapper_trade">
	<table class="tradeList">
		<tr>
			<th>선택</th>
			<th>연번</th>
			<th>상품명</th>
			<th>단위</th>
			<th>수량</th>
			<th>공급가액</th>
			<th>세액</th>
			<th>합계</th>
		</tr>
		<tr>
			<td><input type="radio" name="code" value="3"></td>
			<td >1</td>
			<td>
			<label for="search"></label>
				<input type="text" list="pro_list" name="product">
				<datalist id="pro_list">
				   	<option value="1"></option>
				 </datalist>
				 <button class="btn" type="button" onclick="prosel();" style="width: 50px; height: 30px; font-size: 12px;">선택</button>
			</td>
			<td><input type="text" class="inshort" placeholder="단위 입력"></td>
			<td><input type="text" class="inshort" placeholder="수량 입력"></td>
			<td><input type="text" class="inlong" placeholder="공급가액 입력"></td>
			<td><input type="text" class="inlong" placeholder="세액 입력"></td>
			<td><input type="text" class="inlong" placeholder="합계 입력"></td>
			
		</tr>
		
		<tr class="tradeTotal">
				<td>합계</td>
				<td colspan="3"></td>				
				<td>수량 합계</td>
				<td>공급가액 합계</td>
				<td>세액 합계</td>
				<td>총 합계</td>
		</tr>
			
	</table>
	</form>	
	
	<br><br>
	<div style="text-align: center ">
		<button class="btn" type="button" onclick="detail();">btn1</button>  &nbsp;&nbsp;
		<button class="btn" type="button" onclick="detail();">btn2</button>  &nbsp;&nbsp;
	</div>
</body>
</html>
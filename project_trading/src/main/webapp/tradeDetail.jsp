<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.ArrayList"
	import="dao.TradeDAO"
	import="dto.TradeDTO"
	pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>거래 관리</title>
	<link rel = "stylesheet" href = "css/style.css">
	<script>
		function del(){
			
			var ans = confirm("거래내역이 삭제됩니다.정말삭제하시겠습니까?");
			if(ans){
				var tbl = document.tbl;
				tbl.method="post";
				tbl.action="delTrade";
				tbl.submit();
			}
		}
	</script>
</head>
<body>
	<%@include file="header.jsp"%>
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
	TradeDAO dao = new TradeDAO();
	TradeDTO dto = new TradeDTO();
	ArrayList<TradeDTO> dtos = new ArrayList<TradeDTO>();
	int t_code=Integer.parseInt(request.getParameter("t_code"));
	dtos = dao.tradeDetail(t_code);
	dto=dtos.get(0);
	if(dto.getInout()==0){
%>
	<h1>매출 거래명세서</h1>
	<form name="tbl">
		<table class="trade">
			<tr>
				<th style="background-color:gray; width:100px;">수요자</th>
				<th style="background-color:white; width:450px;" id="company_detail">
					<p> 상호 : <%=dto.getC_name() %></p>
					<p> 사업자 : <%=dto.getC_code() %></p>
					<p> 연락처 : <%=dto.getContact() %></p>
					<p> 주소 : <%=dto.getC_address() %></p>
				</th>
				<th style="background-color:gray; width:230px;">
					<p>거래 명세서</p>
					<p>거래 일자</p>
					<p><%=dto.getT_date() %></p>
				</th>
				<th style="background-color:gray; width:100px;">공급자</th>
				<th style="background-color:white; width:450px; text-align:left">
					<p> 상호 : 고이상사</p>
					<p> 사업자 : 12345678910</p>
					<p> 연락처 : 010-1234-5678</p>
					<p> 주소 : 대한민국</p>
				</th>
		</table>
<%
	}else{
%>
	<h1> 매입 거래명세서</h1>	
	<form name="tbl">
		<table class="trade">
			<tr>
				<th style="background-color:gray; width:100px;">수요자</th>
				<th style="background-color:white; width:450px;" id="company_detail">
					<p> 상호 : 고이상사</p>
					<p> 사업자 : 12345678910</p>
					<p> 연락처 : 010-1234-5678</p>
					<p> 주소 : 대한민국</p>
				</th>
				<th style="background-color:gray; width:230px;">
					<p>거래 명세서</p>
					<p>거래 일자</p>
					<p><%=dto.getT_date() %></p>
				</th>
				<th style="background-color:gray; width:100px;">공급자</th>
				<th style="background-color:white; width:450px; text-align:left">
					<p> 상호 : <%=dto.getC_name() %></p>
					<p> 사업자 : <%=dto.getC_code() %></p>
					<p> 연락처 : <%=dto.getContact() %></p>
					<p> 주소 : <%=dto.getC_address() %></p>
				</th>
		</table>
<%
	}
%>				
		<br><br><br>
		
		<div class="tblWrapper_trade">
		<table class="tradeList" id="table">
			<tr>
				<th>연번</th>
				<th>상품명</th>
				<th>단위</th>
				<th>수량</th>
				<th>단가</th>
				<th>공급가액</th>
				<th>세액</th>
			</tr>
<%
	int sup=0;
	int tax=0;
	int total=0;
	for(int i=0; i<dtos.size(); i++){
		dto = dtos.get(i);
		if(dto.getInout()==1){
			dto.setSup_price(dto.getSup_price()*(-1));
			dto.setTax(dto.getTax()*(-1));
		}
%>
			<tr>
				<td ><input type="text"readonly style="width:40px" value=<%=dto.getNo() %>></td>
				<td><input type="text" class="inlong" readonly value=<%=dto.getP_name() %>></td>
				<td><input type="text" class="inshort" readonly value=<%=dto.getUnit() %>></td>
				<td><input type="text" class="inshort" readonly value=<%=dto.getCnt() %>></td>
				<td><input type="text" class="inlong" readonly value=<%=dto.getPrice() %>></td>
				<td><input type="text" name="p_supprice" class="inlong" readonly value=<%=dto.getSup_price() %>></td>
				<td><input type="text" name="p_tax" class="inlong" readonly value=<%=dto.getTax() %>></td>
			</tr>
<%
	sup=sup+dto.getSup_price();
	tax=tax+dto.getTax();
	}
	
	total=sup+tax;
%>			
			<tr class="tradeTotal">
					<td colspan="2">총 합계금액</td>
					<td colspan="3"><input type="text" name="total_price" readonly value=<%=total %>></td>				
					<td><input type="text" name="total_supprice" readonly value=<%=sup %>></td>
					<td><input type="text" name="total_tax" readonly value=<%=tax %>></td>
			</tr>
				
		</table>
		</div>
		<br><br>
	<div style="text-align: center ">
		<button class="btn" type="button" onclick="history.back();">돌아가기</button>  &nbsp;&nbsp;
		<button class="btn" type="button" onclick="del();">삭제</button>  &nbsp;&nbsp;
		<input type="hidden" name="t_code" value=<%=t_code%>>
	</div>
	
	</form>
</body>
</html>
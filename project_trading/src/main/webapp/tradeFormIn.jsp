<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel = "stylesheet" href = "css/style.css">
	<script>
		function newcol(){
			
		}
	</script>
</head>
<body>
	<%@ include file="header.jsp" %>
	<br><br>
	
	<table class="trade">
		<tr>
			<th style="background-color:gray; width:100px;">수요자</th>
			<th style="background-color:white; width:450px;">
				<p>
						<form style="text-align:left;" class = "searchTrade" method="post" action="tradeFormIn.jsp">
							<label for="search">상호:</label>
							<input type="text" list="com_list" name="company">
								<datalist id="com_list">
							    	<option value="1"></option>
							    </datalist>
							<input type="submit" value="선택">
						</form>	
				</p>
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
			<th>연번</th>
			<th>상품명</th>
			<th>단위</th>
			<th>수량</th>
			<th>공급가액</th>
			<th>세액</th>
			<th>합계</th>
		</tr>
		<tr>
			<td >1</td>
			<td>
			<label for="search"></label>
				<input type="text" list="pro_list" name="product">
				<datalist id="pro_list">
				   	<option value="1"></option>
				 </datalist>
			</td>
			<td><input type="text" class="inshort" placeholder="단위 입력"></td>
			<td><input type="text" class="inshort" placeholder="수량 입력"></td>
			<td><input type="text" class="inlong" placeholder="공급가액 입력"></td>
			<td><input type="text" class="inlong" placeholder="세액 입력"></td>
			<td><input type="text" class="inlong" placeholder="합계 입력"></td>
			
		</tr>
		
		<tr class="tradeTotal">
				<td>합계</td>
				<td colspan="2"></td>				
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
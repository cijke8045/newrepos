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
	<title>거래 관리</title>
	<link rel = "stylesheet" href = "css/style.css">
	<script>
			function cal_2(){
				var total_price= document.getElementsByName("total_price")[0];
				var total_supprice= document.getElementsByName("total_supprice")[0];
				var total_tax= document.getElementsByName("total_tax")[0];
				
				var supprice= document.getElementsByName("p_supprice");
				var tax= document.getElementsByName("p_tax");
				
				var tempsup=0;
				var temptax=0;
				
				for(var i=0; i<tax.length;i++){
					tempsup = tempsup+parseInt(supprice[i].value);
					temptax = temptax+parseInt(tax[i].value);
				}
				total_supprice.value=tempsup;
				total_tax.value=temptax;
				total_price.value=tempsup+temptax;
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
%>
	<form name="tbl">
		<table class="trade">
			<tr>
				<th style="background-color:gray; width:100px;">수요자</th>
				<th style="background-color:white; width:450px;" id="company_detail">
					<input style="width:250px" type="text" name="txt_comsel" id="id_comsel">
				</th>
				<th style="background-color:gray; width:230px;">
					<p>거래 명세서</p>
					<p>거래 일자</p>
					<p><input type="date" name="date"> </p>
				</th>
				<th style="background-color:gray; width:100px;">공급자</th>
				<th style="background-color:white; width:450px; text-align:left">
					<p> 상호 : 고이상사</p>
					<p> 사업자 : 12345678910</p>
					<p> 연락처 : 010-1234-5678</p>
					<p> 주소 : 대한민국</p>
				</th>
		</table>
		<button class="btn" type="button" onclick="newrow();">행추가</button>
		<button class="btn" type="button" onclick="delrow();">행삭제</button>
		<button class="btn" type="button" onclick="cal_1();">자동계산</button>
		
		<div class="tblWrapper_trade">
		<table class="tradeList" id="table">
			<tr>
				<th>선택</th>
				<th>연번</th>
				<th>상품명</th>
				<th>단위</th>
				<th>수량</th>
				<th>단가</th>
				<th>공급가액</th>
				<th>세액</th>
			</tr>
			<tr >
				<td><input type="checkbox" name="p_noC" value="1"></td>
				<td ><input type="text" value="1" name="p_no" readonly style="width:40px"></td>
				<td>
					<div id="div_prosel">
					<input type="text" id="id_prosel" list="pro_list" name="p_name"class="inlong" style="width:150px">
					 <input class="btn" name="btn" type="button" value="선택" onclick="prosel(1);" style="width: 50px; height: 30px; font-size: 12px;"></input>
					 </div>
				</td>
				<td><input type="text" name="p_unit" class="inshort" ><input type="hidden" name="p_code" ></td>
				<td><input type="text" name="p_cnt" class="inshort" ></td>
				<td><input type="text" name="p_price" class="inlong" ></td>
				<td><input type="text" name="p_supprice" class="inlong" onblur="cal_2();"></td>
				<td><input type="text" name="p_tax" class="inlong" onblur="cal_2();"></td>
				
				
			</tr>
			
			<tr class="tradeTotal">
					<td colspan="2">총 합계금액</td>
					<td colspan="4"><input type="text" name="total_price" readonly></td>				
					<td><input type="text" name="total_supprice" disabled></td>
					<td><input type="text" name="total_tax" disabled></td>
			</tr>
				
		</table>
		</div>
		<input type="hidden" name="inout" value="out">	
		<br><br>
	<div style="text-align: center ">
		<button class="btn" type="button" onclick="saveform();">저장</button>  &nbsp;&nbsp;
		<button class="btn" type="button" onclick="refresh();">새로작성</button>  &nbsp;&nbsp;
	</div>
	
	</form>
</body>
</html>
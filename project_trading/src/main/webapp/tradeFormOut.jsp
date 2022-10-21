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
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
	
		function prosel(no){
			no=no-1;
			
			var name = document.getElementsByName("p_name")[no].value;
			var code= name.substr(name.indexOf('[')+1,name.indexOf(']')-name.indexOf('[')-1);
			var btn = document.getElementsByName("btn")[no];
			var unit = document.getElementsByName("p_unit")[no].value;
			var supprice = document.getElementsByName("p_supprice")[no].value;
			var idx =p_codeArr.indexOf(code);
			
			
			btn.parentNode.removeChild(btn);
			val.setAttribute("disabled");
			unit=p_unitArr[idx];
			supprice=p_suppriceArr[idx];
		}
	
		function comsel(){
			var value = $("#id_comsel").val();
			var name= value.substring(0,value.indexOf('['));
			var code= value.substr(value.indexOf('[')+1,10);
			$("#div_comsel").remove();
			document.getElementById("company_detail").innerHTML ='<div style="text-align:left;">상호: <input type="text" id="c_name"  disabled></input><br>	사업자번호: <input type="text" id="c_code" disabled></input><br> 연락처: <input type="text" id="c_contact" disabled></input><br>	주소: <input type="text" id="c_address" disabled></input><div>';
			
			$("#c_name").val(name);
			$("#c_code").val(code);
			var idx = c_codeArr.indexOf(parseInt(code));
			var contact = c_contactArr[idx];
			var address = c_addressArr[idx];
			$("#c_contact").val(contact);
			$("#c_address").val(address);
			
		}	
	
		function newrow(){
			var tbl = document.getElementById("table");
			var rowcnt = tbl.rows.length;
			
			var newrow = tbl.insertRow(rowcnt-1);
			
			var cell0 =newrow.insertCell(0);
			var cell1 =newrow.insertCell(1);
			var cell2 =newrow.insertCell(2);
			var cell3 =newrow.insertCell(3);
			var cell4 =newrow.insertCell(4);
			var cell5 =newrow.insertCell(5);
			var cell6 =newrow.insertCell(6);
			var cell7 =newrow.insertCell(7);
			cell0.innerHTML = '<input type="checkbox" name="p_noC" value='+(rowcnt-1)+'>';
			cell1.innerHTML = '<input type="text" name="p_no" value='+(rowcnt-1)+' disabled style="width:40px">';
			cell2.innerHTML ='<input type="text" name="p_name" list="pro_list" class="inlong" style="width:150px"> <datalist id="pro_list"> </datalist> <button class="btn" type="button" name="btn" onclick="prosel('+(rowcnt-1)+');" style="width: 50px; height: 30px; font-size: 12px;">선택</button>';
			cell3.innerHTML ='<input type="text" name="p_unit" class="inshort" >';		
			cell4.innerHTML ='<input type="text" name="p_cnt" class="inshort" >';
			cell5.innerHTML ='<input type="text" name="p_supprice" class="inlong" >';
			cell6.innerHTML ='<input type="text" name="p_tax" class="inlong" >';
			cell7.innerHTML ='<input type="text" name="p_totalprice" class="inlong" >';
			
			}
			
			function delrow() {
				var tbl = document.getElementById("table");
				var p_noC = document.getElementsByName("p_noC");
				
				for(i=0; i<p_noC.length;i++){
					if(p_noC[i].checked){
						tbl.deleteRow(i+1);
						i=i-1;
					}
				}
				align();
			}
			
			function align(){
				var p_no=document.getElementsByName("p_no");
				var p_noC = document.getElementsByName("p_noC");
				var btn = document.getElementsByName("btn");
				
				for(i=0; i<p_no.length; i++){
					p_no[i].value=i+1;
					p_noC[i].value=i+1;
					btn[i].setAttribute("onclick","prosel('"+(i+1)+"');");
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
	CompanyDAO c_dao = new CompanyDAO();
	CompanyDTO c_dto = new CompanyDTO();
	ArrayList<CompanyDTO> c_dtos = new ArrayList<CompanyDTO>();
	ProductDAO p_dao = new ProductDAO();
	ProductDTO p_dto = new ProductDTO();
	ArrayList<ProductDTO> p_dtos = new ArrayList<ProductDTO>();
	
	c_dtos=c_dao.searchCompany("all");
	p_dtos=p_dao.searchProduct("all");
%>
	<script>
		let c_codeArr=[];
		let c_contactArr=[];
		let c_addressArr=[];
		
		let p_codeArr=[];
		let p_unitArr=[];
		let p_suppriceArr=[];
	</script>
<%
	for(int i=0; i<c_dtos.size(); i++){
		c_dto=c_dtos.get(i);
%>
			<script>
				c_codeArr.push(<%=c_dto.getCode()%>);
				c_contactArr.push("<%=c_dto.getContact()%>");
				c_addressArr.push("<%=c_dto.getAddress()%>");
			</script>
			
<% 
	}
	for(int i=0; i<p_dtos.size(); i++){
		c_dto=c_dtos.get(i);
%>
			<script>
				p_codeArr.push(<%=p_dto.getP_code()%>);
				p_unitArr.push(<%=p_dto.getP_unit()%>);
				p_suppriceArr.push(<%=p_dto.getP_price()%>);
			</script>
			
<% 
	}
%>


	<table class="trade">
		<tr>
			<th style="background-color:gray; width:100px;">수요자</th>
			<th style="background-color:white; width:450px;" id="company_detail">
					
						<div id="div_comsel">
						<input style="width:250px" type="text" list="com_list" name="txt_comsel" id="id_comsel" placeholder="상호나 사업자번호를 입력하세요">
							<datalist id="com_list">
<% 
	for(int i=0; i<c_dtos.size(); i++){
		c_dto=c_dtos.get(i);
%>
								<option value=<%=c_dto.getName() %>[<%=c_dto.getCode() %>]></option>
<% 
	}
%>							    	
							</datalist>
						<button class="btn" type="button" onclick="comsel();">선택</button>
						</div>
				
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
	<form class="tblWrapper_trade">
	<table class="tradeList" id="table">
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
		<tr >
			<td><input type="checkbox" name="p_noC" value="1"></td>
			<td ><input type="text" value="1" name="p_no" disabled style="width:40px"></td>
			<td>
				<div id="div_prosel">
				<input type="text" id="id_prosel" list="pro_list" name="p_name"class="inlong" style="width:150px">
					<datalist id="pro_list">
<%
	for(int i=0; i<p_dtos.size(); i++) {
		p_dto=p_dtos.get(i);
%>					
					   	<option value=<%=p_dto.getP_name() %>[<%=p_dto.getP_code() %>]></option>
<%
	}
%>	
					 </datalist>
				 <button class="btn" name="btn" type="button" onclick="prosel(1);" style="width: 50px; height: 30px; font-size: 12px;">선택</button>
				 </div>
			</td>
			<td><input type="text" name="p_unit" class="inshort" ></td>
			<td><input type="text" name="p_cnt" class="inshort" ></td>
			<td><input type="text" name="p_supprice" class="inlong" ></td>
			<td><input type="text" name="p_tax" class="inlong"></td>
			<td><input type="text" name="p_totalprice" class="inlong"></td>
			
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
		<button class="btn" type="button" onclick="detail();">저장</button>  &nbsp;&nbsp;
		<button class="btn" type="button" onclick="detail();">새로작성</button>  &nbsp;&nbsp;
	</div>
</body>
</html>
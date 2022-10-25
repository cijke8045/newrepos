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
	<title>신규 매입 등록</title>
	<link rel = "stylesheet" href = "css/style.css">
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		
		function prosel(no){
			no=no-1;
			var name = document.getElementsByName("p_name")[no].value;
			if(name==""){
				alert("상품명을 입력해주세요");
				return;
			}
			var code= name.substr(name.indexOf('[')+1,name.indexOf(']')-name.indexOf('[')-1);
			var btn = document.getElementsByName("btn")[no];
			var unit = document.getElementsByName("p_unit")[no];
			var price = document.getElementsByName("p_price")[no];
			var idx =p_codeArr.indexOf(parseInt(code));
			if(idx==-1){
				alert("존재하지 않는상품입니다. \n이대로 넣으시려면 선택버튼을 누르지마세요. \n재고는 영향을 받지않습니다.");
				return;
			}
			document.getElementsByName("p_code")[no].value=code;
			btn.setAttribute("type","hidden");
			document.getElementsByName("p_name")[no].setAttribute("readonly", true);
			unit.value=p_unitArr[idx];
			price.value=p_priceArr[idx];
		}
	
		function comsel(){
			
			var value = $("#id_comsel").val();
			var name= value.substring(0,value.indexOf('['));
			var code= value.substr(value.indexOf('[')+1,10);
			
			if(code.length!=10){
				alert("올바른 거래처가 아닙니다.");
				return;
			}
			$("#div_comsel").remove();
			document.getElementById("company_detail").innerHTML ='<div style="text-align:left;">상호: <input type="text" id="c_name" readonly><br>	사업자번호: <input type="text" id="c_code" name="c_code" readonly ><br> 연락처: <input type="text" id="c_contact" readonly></input><br>	주소: <input type="text" id="c_address" readonly></input><div>';
			
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
			cell1.innerHTML = '<input type="text" name="p_no" value='+(rowcnt-1)+' readonly style="width:40px">';
			cell2.innerHTML ='<input type="text" name="p_name" list="pro_list" class="inlong" style="width:150px"> <datalist id="pro_list"> </datalist> <input class="btn" type="button" value="선택" name="btn" onclick="prosel('+(rowcnt-1)+');" style="width: 50px; height: 30px; font-size: 12px;"> <input type="hidden" name="p_code" >';
			cell3.innerHTML ='<input type="text" name="p_unit" class="inshort" >';		
			cell4.innerHTML ='<input type="text" name="p_cnt" class="inshort" >';
			cell5.innerHTML ='<input type="text" name="p_price" class="inlong" >';
			cell6.innerHTML ='<input type="text" name="p_supprice" class="inlong" onblur="cal_2();">';
			cell7.innerHTML ='<input type="text" name="p_tax" class="inlong" onblur="cal_2();">';
			
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
				cal_2();
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
			
			function cal_1() {
				var cnt = document.getElementsByName("p_cnt");
				var price = document.getElementsByName("p_price");
				var supprice = document.getElementsByName("p_supprice");
				var tax = document.getElementsByName("p_tax");
				
				for(var i=0; i<cnt.length; i++){
					if(cnt[i]==null){
						cnt[i].value=0;
					}
					if(price[i]==null){
						price[i].value=0
					}
					supprice[i].value= cnt[i].value*price[i].value;
					tax[i].value =supprice[i].value*0.1; 
				}
				cal_2();
			}
			
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
			
			function refresh() {
				var ans=confirm("작성한 내용은 사라집니다. 새로작성하시겠습니까?");
				if(ans){
					history.go();
				}
			}
			
			function saveform() {
				var tbl = document.tbl;
				tbl.method="post";
				tbl.action="newTrade";
				tbl.submit();
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
		let p_priceArr=[];
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
		p_dto=p_dtos.get(i);
		
%>
			<script>
				p_codeArr.push(<%=p_dto.getP_code()%>);
				p_unitArr.push('<%=p_dto.getP_unit()%>');
				p_priceArr.push('<%=p_dto.getP_price()%>');
			</script>
			
<% 
	}
%>

	<form name="tbl">
		<table class="trade">
			<tr>
				<th style="background-color:gray; width:100px;">수요자</th>
				<th style="background-color:white; width:450px; text-align:left">
					<p> 상호 : 고이상사</p>
					<p> 사업자 : 12345678910</p>
					<p> 연락처 : 010-1234-5678</p>
					<p> 주소 : 대한민국</p>
				</th>
				<th style="background-color:gray; width:230px;">
					<p>거래 명세서</p>
					<p>거래 일자</p>
					<p><input type="date" name="date"> </p>
				</th>
				
				<th style="background-color:gray; width:100px;">공급자</th>
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
		<input type="hidden" name="inout" value="in">	
		<br><br>
	<div style="text-align: center ">
		<button class="btn" type="button" onclick="saveform();">저장</button>  &nbsp;&nbsp;
		<button class="btn" type="button" onclick="refresh();">새로작성</button>  &nbsp;&nbsp;
	</div>
	
	</form>
</body>
</html>
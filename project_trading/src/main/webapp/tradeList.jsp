<%@ page language="java" contentType="text/html; charset=UTF-8"
	import= "java.sql.Date"
	import= "java.util.ArrayList"
	import= "dao.TradeDAO"
	import= "dto.TradeDTO"
	pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>거래 관리</title>
	<link rel = "stylesheet" href = "css/style.css">
	<script>
		
	</script>
</head>
<body>
	<%@ include file="header.jsp" %>
	<br><br>
<%
	if(auth==0 || auth==1 || (int)session.getAttribute("trade")==0){			//비회원,거래처일경우
%>
		<script>
			alert("잘못된 접근입니다.");
			location.href='index.jsp';		
		</script>
<%
	}else{			//권한 있을 시
		TradeDAO dao = new TradeDAO();
		TradeDTO dto = new TradeDTO();
		ArrayList<TradeDTO> dtos = new ArrayList<TradeDTO>(); 
		
		int inout =Integer.parseInt(request.getParameter("inout"));
		int c_code=-1;
		Date start=null;
		Date end=null;
		
		if(request.getParameter("code")!=null) {
			c_code=Integer.parseInt(request.getParameter("code"));
		}
		try {
			start = Date.valueOf(request.getParameter("start"));
		}catch (Exception e) {
		}
		try {
			end = Date.valueOf(request.getParameter("end"));
		}catch (Exception e) {
		}
		
		dtos = dao.tradeList(c_code, start, end);
%>	
		거래관리
		<br><br>
		<button class="btn" type="button" onclick="location.href='tradeFormOut.jsp';">신규 매출 거래명세서</button> &nbsp;&nbsp;
		<button class="btn" type="button" onclick="location.href='tradeFormIn.jsp';">신규 매입 거래명세서</button> &nbsp;&nbsp;
		
<%
	if(start==null){
%>	
	* 
<%	
	}else{
%> 
<%=start %>
<%
	}
%>
~ 
<%
	if(end==null){
%>	
	* 
<%	
	}else{
%> 
<%=end %>
<%
	}
%>
 까지 [
<%
	if(c_code==-1){
%>	
	전체거래처 
<%	
	}else{
		dto=dtos.get(0);
%> 
<%=dto.getC_name() %>
<%
	}
%> 
 ] 의 [
 <%
	if(inout==0){
%>	
	매출 
<%	
	}else if (inout==1){
%> 
	매입
<%
	}else{
%>
 매입매출
<%
	}
%>
		] 거래명세서 조회입니다.
		<br><br><br>
		<div class="tblWrapper_trade">
		<form name="tbl" style="width: 1200px; height: 500px; margin: auto;">
			<table class="tradeList" id="table">
			<tr>
				<th>선택</th>
				<th>구분</th>
				<th>날짜</th>
				<th>상호</th>
				<th>품목</th>
				<th>공급가액</th>
				<th>세액</th>
				<th>합계</th>
				
			</tr>
<%
	boolean flag = false;
	int t_code=-1;
	int sum_sup=0;
	int sum_tax=0;
	int sum=0;
	int total_sup=0;
	int total_tax=0;
	int total_sum=0;
	int cnt=-1;
	String str_inout="";
	
	for(int i=0; i<dtos.size(); i++){
		dto=dtos.get(i);
		System.out.println(dto.getSup_price());
		if(inout!=dto.getInout() && inout!=3){
			continue;
		}
		
		t_code=dto.getT_code();
		
		if(i<dtos.size()-1){
			if(dtos.get(i+1).getT_code()!=t_code){
				flag=true;
			}
		}else {
			flag=true;
		}
		
		sum_sup = sum_sup + dto.getSup_price();
		sum_tax = sum_tax + dto.getTax();
		cnt++;
		
		if(flag) {
			sum= sum_sup + sum_tax;
			total_sup= total_sup + sum_sup;
			total_tax= total_tax + sum_tax;
			if(dto.getInout()==0){
				str_inout="매출";
			}else {
				str_inout="매입";
			}
%>
			<tr>
				<td><input type="radio" name="t_code" value=<%=dto.getT_code() %>></td>
				<td ><input type="text" value=<%=str_inout %> name="inout" style="width:30px" ></td>
				<td ><input type="text" value=<%=dto.getT_date() %> name="t_date" style="width:120px"></td>
				<td><input type="text" value=<%=dto.getC_name() %> name="c_name"class="inshort"></td>
				<td><input type="text" value=<%=dto.getP_name() %>외<%=cnt %>건 class="inlong" ><input type="hidden" name="p_code" ></td>
				<td><input type="text" value=<%=sum_sup %>  class="inshort" ></td>
				<td><input type="text" value=<%=sum_tax %>  class="inshort" ></td>
				<td><input type="text" value=<%=sum %> class="inshort" ></td>
			</tr>
<%
			flag=false;
			sum_sup=0;
			sum_tax=0;
			sum=0;
			cnt=-1;
		}
	}
	total_sum= total_sup+total_tax;
%>
			<tr class="tradeTotal">
					<td colspan="5">합계</td>
					<td><input type="text" value=<%=total_sup%> name="sum_supprice" disabled></td>
					<td><input type="text" value=<%=total_tax%> name="sum_tax" disabled></td>
					<td><input type="text" value=<%=total_sum%> name="sum_total" disabled></td>
			</tr>
		</table>
		
		<br><br>
			<button class="btn" type="button" onclick="search();">상세조회</button>  &nbsp;&nbsp;
			<button class="btn" type="button" onclick="search();">수정</button>  &nbsp;&nbsp;
			<button class="btn" type="button" onclick="search();">삭제</button>  &nbsp;&nbsp;
		</form>
		</div>
<%	
	}
%>	
</body>
</html>
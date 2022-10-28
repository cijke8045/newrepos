<%@ page language="java" contentType="text/html; charset=UTF-8"
	import= "java.sql.Date"
	import= "java.util.ArrayList"
	import= "dao.TradeDAO"
	import= "dao.CollectDAO"
	import= "dto.TradeDTO"
	import="dto.CollectDTO"
	pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>외상 관리</title>
	<link rel = "stylesheet" href = "css/style.css">
	<script>
		function del(){
			var ans = confirm("내역이 삭제됩니다.정말삭제하시겠습니까?");
			if(ans){
				var tbl = document.tbl;
				tbl.method="post";
				tbl.action="delCollect";
				tbl.submit();
			}
		}
	</script>
</head>
<body>
	<%@ include file="header.jsp" %>
	<br><br>
<%
	if(auth==0 || auth==1 || (int)session.getAttribute("collect")==0){			//비회원,거래처일경우
%>
		<script>
			alert("잘못된 접근입니다.");
			location.href='index.jsp';		
		</script>
<%
	}else{			//권한 있을 시
		TradeDAO t_dao = new TradeDAO();
		TradeDTO t_dto = new TradeDTO();
		ArrayList<TradeDTO> t_dtos = new ArrayList<TradeDTO>();
		CollectDAO col_dao = new CollectDAO();
		CollectDTO col_dto = new CollectDTO();
		ArrayList<CollectDTO> col_dtos = new ArrayList<CollectDTO>();
		
		String c_code="all";
		Date start=null;
		Date end=null;
		
		if(request.getParameter("code")!=null) {
			c_code=request.getParameter("code");
		}
		try {
			start = Date.valueOf(request.getParameter("start"));
		}catch (Exception e) {
		}
		try {
			end = Date.valueOf(request.getParameter("end"));
		}catch (Exception e) {
		}
		
		t_dtos = t_dao.tradeList(c_code, start, end);
		col_dtos = col_dao.collectList(c_code, start, end);
		if(t_dtos.size()==0 && col_dtos.size()==0){
%>
		<script type='text/javascript'>
			alert("조회결과가 없습니다.");
			location.href='tradeMain.jsp';
		</script>
<%
		}
%>			
		외상관리
		<br><br>
		<button class="btn" type="button" onclick="location.href='collectForm.jsp';">신규 외상처리</button> &nbsp;&nbsp;

		<br><br><br>
		<div class="tblWrapper_trade">
		<form name="tbl" style="width: 1200px; height: 500px; margin: auto;">
			<table class="tradeList" id="table">
			<tr>
				<th>선택</th>
				<th>구분</th>
				<th>날짜</th>
				<th>상호</th>
				<th>내용</th>
				<th>수정자</th>
				<th>금액</th>
			</tr>
<%
	int total=0;
	int check=0;
	String str_inout="";
	for(int i=0; i<col_dtos.size(); i++){
		col_dto=col_dtos.get(i);
		if(col_dto.getCol_memo()==null){
			col_dto.setCol_memo("X");
		}
		
		total=total+col_dto.getCol_amount();
		if(col_dto.getCol_inout()==1){
			str_inout="입금";
		} else{
			str_inout="출금";
		}
%>			
		<tr>
				<td><input type="radio" value=<%=col_dto.getCol_no() %> name="col_code"
				<%
					if(check==0){
				%>
				checked="checked"
				<%
					}
				%>
				></td>
				<td ><input type="text" value=<%=str_inout %> name="inout" style="width:30px" readonly></td>
				<td ><input type="text" value=<%=col_dto.getCol_date() %> name="t_date" style="width:120px" readonly></td>
				<td><input type="text" value=<%=col_dto.getC_name() %> name="c_name"class="inlong" readonly></td>
				<td><input type="text" value=<%=col_dto.getCol_memo() %> class="inlong" readonly></td>
				<td><input type="text" value=<%=col_dto.getCol_editor() %>  class="inshort" readonly></td>
				<td><input type="text" value=<%=col_dto.getCol_amount() %> class="inshort" readonly></td>
			</tr>		
			
<%
		check++;
	}
	boolean flag = false;
	int t_code=-1;
	int sum_sup=0;
	int sum_tax=0;
	int sum=0;
	int cnt=-1;
	
	for(int i=0; i<t_dtos.size(); i++){
		t_dto=t_dtos.get(i);
		t_code=t_dto.getT_code();
		
		if(i<t_dtos.size()-1){
			if(t_dtos.get(i+1).getT_code()!=t_code){
				flag=true;
			}
		}else {
			flag=true;
		}
		
		sum_sup = sum_sup + t_dto.getSup_price();
		sum_tax = sum_tax + t_dto.getTax();
		cnt++;
		
		if(flag) {
			sum= sum_sup + sum_tax;
			total=total+sum;
			if(t_dto.getInout()==0){
				str_inout="매출";
			}else {
				str_inout="매입";
			}
%>

			<tr>
				<td></td>
				<td><input type="text" value=<%=str_inout %> style="width:30px" readonly></td>
				<td><input type="text" value=<%=t_dto.getT_date() %> style="width:120px" readonly></td>
				<td><input type="text" value=<%=t_dto.getC_name() %> class="inlong" readonly></td>
				<td><input type="text" value=<%=t_dto.getP_name() %>외<%=cnt %>건 class="inlong" readonly></td>
				<td><input type="text" value=<%=t_dto.getT_editor() %> class="inshort" readonly></td>
				<td><input type="text" value=<%=sum %> class="inlong" readonly></td>
			</tr>
<% 
		flag=false;
		sum_sup=0;
		sum_tax=0;
		sum=0;
		cnt=-1;
		}
	}
%>
			<tr class="tradeTotal">
					<td colspan="4">
					
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
	if(c_code.equals("all")){
%>	
	전체거래처 
<%	
	}else{
		if(t_dtos.size()!=0){
			t_dto=t_dtos.get(0);
		}
%> 
	<%=t_dto.getC_name() %>
<%
	}
%> 
 ] 의 미수금
					</td>
					<td colspan="3"><input type="text" value=<%=total %> name="sum_supprice" readonly></td>
			</tr>
		</table>
		
		<br><br>
			<button class="btn" type="button" onclick="del();">삭제</button>  &nbsp;&nbsp;
		</form>
		</div>
<%	
	}
%>	
</body>
</html>

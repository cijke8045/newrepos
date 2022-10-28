<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.ArrayList"
	import=" dto.StockDTO"
	import=" dto.ProductDTO"
	import=" dao.StockDAO"
	import=" dao.ProductDAO"
    pageEncoding="UTF-8"%>

<% int code = Integer.parseInt(request.getParameter("code")); %>    

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>재고 관리</title>
	<link rel = "stylesheet" href = "css/style.css">
	<script>		
		function openmemo() {
			var no=document.getElementsByName("no");
			var flag = false;
			
			for(var i=0; i<no.length;i++){
				if(no[i].checked){
					flag=true;
					break;
				}
			}
			if(flag){
				var tbl = document.tbl;
				tbl.method = "post";
				tbl.action = "stockDetail.jsp";
				tbl.submit();	
			}else{
				alert("메모를 열람할 건을 선택해주세요.");
				return;
			}
		}
		function new_() {
			var tbl = document.tbl;
			
			tbl.method="post";
			tbl.action="stockForm.jsp";
			tbl.submit();
		}
		function del() {
			var no=document.getElementsByName("no");
			var flag = false;
			
			for(var i=0; i<no.length;i++){
				if(no[i].checked){
					flag=true;
					break;
				}
			}
			if(flag){
				var tbl = document.tbl;
				tbl.method="post";
				tbl.action="delStock";
				tbl.submit();	
			}else{
				alert("삭제할 건을 선택해주세요.");
				return;
			}
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
		<br>
<%	
		ProductDAO p_dao = new ProductDAO(); 
		ProductDTO p_dto = new ProductDTO();
		StockDTO s_dto = new StockDTO();
		StockDAO s_dao = new StockDAO();
		
		p_dto= p_dao.infowithcode(code);
		ArrayList<StockDTO> s_dtos = s_dao.stockdetail(code);
%>
		재고관리
		
		<br><br>
		
			<form class="tblWrapper" name="tbl">
			"<%=p_dto.getP_name()%>"[<%=code%>] 에 관한 재고 변동내용입니다.
			<br>
			<table class="infoList">
				<tr><th>선택</th><th>변동날짜</th><th>변동원인</th><th>변동수량</th><th>총수량</th><th>수정자</th><th>수정날짜</th></tr>
<%						
			for(int i =0; i<s_dtos.size(); i++){
				s_dto = s_dtos.get(i);
%>				
		
		<tr>
			<td>
<%
				if(!(s_dto.getCause().equals("매입") || s_dto.getCause().equals("매출"))) {		//거래명세서로 작성된 재고는 삭제불가
%>			
				<input type="radio" name="no" value=<%=s_dto.getNo() %> />
<%
				}
%>				
			</td>
			<td><%= s_dto.getCausedate() %></td><td><%=s_dto.getCause() %></td><td><%=s_dto.getChangecnt() %></td><td><%= s_dto.getTotalcnt() %></td><td><%=s_dto.getEditor() %></td><td><%=s_dto.getEditdate() %></td>
			
		</tr>
<%

				if(request.getParameter("command")!=null && request.getParameter("command").equals("open") && s_dto.getNo() == Integer.parseInt(request.getParameter("no"))){
%>
		<tr height="120px">
			<td colspan="7">
				<%=s_dto.getMemo() %>
			</td>
		</tr>
<%
				}
			}
%>			
			</table>

			<input type="hidden" name="name" value="<%=p_dto.getP_name()%>">
			<input type="hidden" name="code" value="<%=code%>">
			<input type="hidden" name="command" value="open">
		</form>
		
		<br><br>
		<div style="text-align: center ">
			<button class="btn" type="button" onclick="openmemo();">메모내용보기</button>  &nbsp;&nbsp;
			<button class="btn" type="button" onclick="new_();">재고변동등록</button>
			<button class="btn" type="button" onclick="del();">삭제</button>
		</div>
<%
		
	}
%>	
</body>
</html>
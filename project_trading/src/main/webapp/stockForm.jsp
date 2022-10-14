<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
 <% String code=request.getParameter("code"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>재고변동등록</title>
	<link rel = "stylesheet" href = "css/style.css">
	<script>
		function new_(){
			var tbl = document.tbl;
			tbl.method="post";
			tbl.action="newStock";
			tbl.submit();
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
		"<%= request.getParameter("name") %>"[<%=code%>] 재고 변동내용 등록입니다.<br>
		<br><br>
		
		<form name="tbl">
			발생원인: 
			<select name="cause">
    			<option value="분실">분실(-재고가 줄어듭니다.-)</option>
    			<option value="폐기">폐기(-재고가 줄어듭니다.-)</option>
    			<option value="기타출고">기타(-재고가 줄어듭니다.-)</option>
    			<option value="기타입고">기타(+재고가 늘어납니다.+)</option>
    		</select>
    		발생날짜: <input type="date" name="causedate">
    		변동수량:	<input type="text" name="changecnt">
    		<br>
    		비고: <textarea name="memo"></textarea>
    		<input type ="hidden" name="code" value="<%=code%>">
			
			<br><br>
			
			<div style="text-align: center ">
			
				<button class="btn" type="button" onclick="new_();">등록</button>
				<button class="btn" type="button" onclick="location.href='javascript:history.back()';">돌아가기</button>
			
			</div>
			
		</form>
		
<%
		
	}
%>	
</body>
</html>
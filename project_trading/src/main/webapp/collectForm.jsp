<%@ page language="java" contentType="text/html; charset=UTF-8"
	import = "dao.CompanyDAO"
	import = "dto.CompanyDTO"
	import="java.util.ArrayList"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>신규외상처리</title>
	<link rel = "stylesheet" href = "css/style.css">
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		function new_(){
			var tbl = document.tbl;
			tbl.method="post";
			tbl.action="newCollect";
			tbl.submit();
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
			document.getElementById("tbl").insertAdjacentHTML('afterbegin', '<div style="text-align:left;">상호: <input type="text" id="c_name" readonly><input type="hidden" id="c_code" name="c_code" readonly ><div>');
			
			$("#c_name").val(name);
			$("#c_code").val(code);
				
		}
		
		function new_(){
			if(document.getElementById("div_comsel")!=null){
				alert("거래처를 선택 해 주세요.\n임의의 값은 지정되지 않습니다.");
				return;
			}
			var tbl = document.tbl;
			tbl.method="post";
			tbl.action="newCollect";
			tbl.submit();
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
		CompanyDAO c_dao = new CompanyDAO();
		CompanyDTO c_dto = new CompanyDTO();
		ArrayList<CompanyDTO> c_dtos = new ArrayList<CompanyDTO>();
		c_dtos=c_dao.searchCompany("all");
%>	
		<br><br>
		
		<form name="tbl" id="tbl">
			<div id="div_comsel">
			상호:	<input style="width:250px" type="text" list="com_list" name="txt_comsel" id="id_comsel" placeholder="상호나 사업자번호를 입력하세요">
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
			<br><br>
			외상처리: 
			<select name="cause">
    			<option value="입금">미수금처리(우리한테 들어온돈)</option>
    			<option value="출금">미지급금처리(거래처한테 나간돈)</option>
    		</select>
    		<br><br>
    		
    		처리날짜: <input type="date" name="c_date">
    		<br><br>
    		
    		금액:	<input type="text" name="c_amount">
    		<br><br>
    		메모: <textarea name="c_memo"></textarea>
    		
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
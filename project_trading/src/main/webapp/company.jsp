<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>거래처 관리</title>
	<link rel = "stylesheet" href = "css/style.css">
</head>
<body>
	<%@ include file="header.jsp" %>
	
	<br><br>
	<form class = "searchCom" method="post" action="searchCompany">
		<input type="text" name = "comtxt" placeholder="상호명을 입력해주세요"/>
		<input type="submit" value="검색"/>
	</form>
	
	<br><br>
	<form class="tblWrapper">
		<table class="infoList">
			<tr><th>No.</th><th>사업자 번호</th><th>상호</th><th>담당자</th><th>전화번호</th><th>주소</th></tr>
			<tr><td>1</td><td>2000102620001026</td><td>고이상사</td><td>이가현</td><td>010-1234-5678</td><td>가나다라마바사</td></tr>
			<tr><td>1</td><td>2000102620001026</td><td>고이상사</td><td>이가현</td><td>010-1234-5678</td><td>가나다라마바사</td></tr>
			<tr><td>1</td><td>2000102620001026</td><td>고이상사</td><td>이가현</td><td>010-1234-5678</td><td>가나다라마바사</td></tr>
			<tr><td>1</td><td>2000102620001026</td><td>고이상사</td><td>이가현</td><td>010-1234-5678</td><td>가나다라마바사</td></tr>
			<tr><td>1</td><td>2000102620001026</td><td>고이상사</td><td>이가현</td><td>010-1234-5678</td><td>가나다라마바사</td></tr>
			<tr><td>1</td><td>2000102620001026</td><td>고이상사</td><td>이가현</td><td>010-1234-5678</td><td>가나다라마바사</td></tr>
			<tr><td>1</td><td>2000102620001026</td><td>고이상사</td><td>이가현</td><td>010-1234-5678</td><td>가나다라마바사</td></tr>
			<tr><td>1</td><td>2000102620001026</td><td>고이상사</td><td>이가현</td><td>010-1234-5678</td><td>가나다라마바사</td></tr>
			<tr><td>1</td><td>2000102620001026</td><td>고이상사</td><td>이가현</td><td>010-1234-5678</td><td>가나다라마바사</td></tr>
			<tr><td>1</td><td>2000102620001026</td><td>고이상사</td><td>이가현</td><td>010-1234-5678</td><td>가나다라마바사</td></tr>
			<tr><td>1</td><td>2000102620001026</td><td>고이상사</td><td>이가현</td><td>010-1234-5678</td><td>가나다라마바사</td></tr><tr><td>1</td><td>2000102620001026</td><td>고이상사</td><td>이가현</td><td>010-1234-5678</td><td>가나다라마바사</td></tr>
			<tr><td>1</td><td>2000102620001026</td><td>고이상사</td><td>이가현</td><td>010-1234-5678</td><td>가나다라마바사</td></tr>
			<tr><td>1</td><td>2000102620001026</td><td>고이상사</td><td>이가현</td><td>010-1234-5678</td><td>가나다라마바사</td></tr>
			<tr><td>1</td><td>2000102620001026</td><td>고이상사</td><td>이가현</td><td>010-1234-5678</td><td>가나다라마바사</td></tr>
		
		</table>
	</form>
	
	<br><br>
	<div style="text-align: center ">
		<button class="btn" type="button" value="상세조회">상세조회</button> &nbsp;&nbsp;
		<button class="btn" type="button" value="신규등록">신규등록</button>  &nbsp;&nbsp;
		<button class="btn" type="button" value="삭제">삭제</button>
	</div>	
</body>
</html>
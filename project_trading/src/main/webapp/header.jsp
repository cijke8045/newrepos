<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
    <%
    	request.getSession();
    	int auth=0;
    	if(session.isNew()){
    		session.setAttribute("authority", 0);		//비로그인    		
    	} else if((int)session.getAttribute("authority")==1){		//거래처
    		auth=1;
    	} else if((int)session.getAttribute("authority")==2){		//직원
    		auth=2;
    	} else if((int)session.getAttribute("authority")==3){		//관리자
    		auth=3;
    	}
   %>
    	환영합니다. 
   <%
   		if(auth==1){
   %>
   		<%=session.getAttribute("co_name") %> 님
   <%   			
   		} else if(auth==2){
   %>
   		[<%=session.getAttribute("department") %>] <%=session.getAttribute("name") %> <%=session.getAttribute("job") %> 님
   <% 			
   		} else if(auth==3){
    %>
  		<%=session.getAttribute("name") %> 님 관리자로 로그인하셨습니다.
   <% 			
      	}
    %> 	  	
    	
        <div style="text-align: center;">
        	<a href=index.jsp >
            	<img src="img/pepe.png" height="200px">
            </a>
            <%
            	if(auth==0){
            %>
            		<a href="createAcc.jsp" class="loginsel">회원가입</a>
            		<a href="login.jsp">로그인</a>
            <%
            	} else if(auth==1 ||auth==2 || auth==3) {
            %>	
            <a href="logout">로그아웃</a>
            <%
            	}
            	
           		if(auth==3){
            %>
            <a href="#" style="color:grey">관리자메뉴</a>
            <%
           		}
            %>
            <br><br>
            <hr width = 70%>
            <%
            	if(auth==2 || auth==3){
            %>
		            <nav>
		                <a href="companyMng.jsp">거래처 관리</a> | 
		                <a href="product.jsp">상품 관리</a> | 
		                <a href="stockMain.jsp">재고 관리</a> |
		                <a href="#">거래 관리</a> | 
		                <a href="#">수금 관리</a>
		            </nav>
            <%
            	}
            %>
            <hr width = 70%>
        </div>
    </header>

</body>
</html>
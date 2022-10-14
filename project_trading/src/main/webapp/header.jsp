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
  		관리자로 로그인하셨습니다.
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
            %>
            <br><br>
            <hr width = 70%>
                    <nav>
            <%
            	if(auth==3 || session.getAttribute("company")!=null && (int)session.getAttribute("company")==1){
            %>
		                <a href="company.jsp">거래처 관리</a> 
			<%
            	}
            	if(auth==3 || session.getAttribute("product")!=null && (int)session.getAttribute("product")==1){
            %>		                 
		                <a href="product.jsp">상품 관리</a>
		    <%
            	}
            	if(auth==3 || session.getAttribute("stock")!=null && (int)session.getAttribute("stock")==1){
            %>              
		                <a href="stockMain.jsp">재고 관리</a> 
		    <%
            	}
            	if(auth==3 || session.getAttribute("trade")!=null && (int)session.getAttribute("trade")==1){
            %>            
		                <a href="tradeMain.jsp">거래 관리</a>
		    <%
            	}
            	if(auth==3 || session.getAttribute("collect")!=null && (int)session.getAttribute("collect")==1){
            %>            
		                <a href="#">수금 관리</a>
		    <%
            	}
            %>
		            </nav>
            
            <hr width = 70%>
        </div>
    </header>
<% 
	if(auth==3){	
%>
    <aside class="side">
    	<h1>관리자메뉴</h1>
    	
    	<ul class="side-list">
    		<li>
    			<a href="employee.jsp">직원관리</a>
    		</li>
    		<li>
    			<a href="member.jsp">회원관리</a>
    		</li>
    		<li>
    			<a href="adPwCh.jsp">관리자 비밀번호 변경</a>
    		</li>
    	</ul>
    </aside>
<%
	}
%>
</body>
</html>
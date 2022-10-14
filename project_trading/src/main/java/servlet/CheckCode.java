package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import dao.AccountDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/checkCode")

public class CheckCode extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public CheckCode() {      
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	private void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html; charset=utf-8");
		AccountDAO dao = new AccountDAO();
		PrintWriter out = response.getWriter();
		boolean codeExist=false;
		boolean idExist=false;
		codeExist=dao.codeExist(Integer.parseInt(request.getParameter("code")));
		idExist=dao.idExist(Integer.parseInt(request.getParameter("code")));
		
		if(codeExist==true && idExist==false) {			//코드존재,코드로 기가입 아이디없음.
			RequestDispatcher dispatch = request.getRequestDispatcher("memberForm.jsp?code="+request.getParameter("code"));
			dispatch.forward(request, response);//memberForm.jsp 회원가입양식페이지로 이동.
		} else {
			out.print("<body>"
					+ "<script>"
					+ " alert(\"잘못된입력\");"
					+ "location.href='createAcc.jsp';"
					+ "</script>"		
					+ "</body>");
		}
	}
}

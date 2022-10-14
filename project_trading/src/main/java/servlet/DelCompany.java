package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import dao.CompanyDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/delCompany")
public class DelCompany extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	private void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		CompanyDAO dao = new CompanyDAO();
		PrintWriter out = response.getWriter();
		
		dao.delCompany(request.getParameter("code"));
		
		
		out.print("<html>"
				+ "<body>"
				+ "<script>"
				+ "alert(\"삭제되었습니다.\");"
			    + "location.href='company.jsp';"
				+ "</script>"
				+ "<body>"
				+ "</html>");
	}

}

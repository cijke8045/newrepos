package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import dao.EmployeeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/delEmployee")
public class DelEmployee extends HttpServlet {
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
		
		EmployeeDAO dao = new EmployeeDAO();
		PrintWriter out = response.getWriter();
		dao.delEmployee(Integer.parseInt(request.getParameter("code")));
		
		out.print("<html>"
				+ "<body>"
				+ "<script>"
				+ "alert(\"삭제 되었습니다.\");"
			    + "location.href='employee.jsp';"
				+ "</script>"
				+ "<body>"
				+ "</html>");
	}

}

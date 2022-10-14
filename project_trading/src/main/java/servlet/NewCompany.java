package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import dao.CompanyDAO;
import dto.CompanyDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/newCompany")
public class NewCompany extends HttpServlet {
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
		CompanyDTO dto = new CompanyDTO();
		PrintWriter out = response.getWriter();
		String name=request.getParameter("name");
		
		dto.setCode(request.getParameter("code"));
		dto.setAddress(request.getParameter("address"));
		dto.setName(name);
		dto.setContact(request.getParameter("contact"));
		
		dao.newCompany(dto);
		
		out.print("<html>"
				+ "<body>"
				+ "<script>"
				+ "alert(\"["+name+"] 등록되었습니다.\");"
			    + "location.href='company.jsp';"
				+ "</script>"
				+ "<body>"
				+ "</html>");
	}

}

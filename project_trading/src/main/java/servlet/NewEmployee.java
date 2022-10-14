package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import dao.EmployeeDAO;
import dto.EmployeeDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/newEmployee")
public class NewEmployee extends HttpServlet {
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
		EmployeeDTO dto = new EmployeeDTO();
		PrintWriter out = response.getWriter();
		
		
		int code=dao.autoCode("employee");		//4자리 직원코드자동생성
		
		dto.setCode(code);
		dto.setJob(request.getParameter("job"));
		dto.setName(request.getParameter("name"));
		dto.setContact(request.getParameter("contact"));
		dto.setDepartment(request.getParameter("department"));
		
		dao.newEmployee(dto);
		
		out.print("<html>"
				+ "<body>"
				+ "<script>"
				+ "alert(\"["+code+"] 등록되었습니다.\");"
			    + "location.href='employee.jsp';"
				+ "</script>"
				+ "<body>"
				+ "</html>");
	}
	
}

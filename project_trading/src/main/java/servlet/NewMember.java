package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import dao.AccountDAO;
import dto.MemberDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/newmember")
public class NewMember extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	private void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html; charset=utf-8");
		AccountDAO dao = new AccountDAO();
		MemberDTO dto = new MemberDTO();
		PrintWriter out = response.getWriter();
		
		dto.setCode(Integer.parseInt(request.getParameter("code")));
		dto.setId(request.getParameter("id"));
		dto.setPw(request.getParameter("pw"));
		
		dao.insertmember(dto);
		
		out.print("<script type ='text/javascript'>"
				+ "alert(\"회원가입 되셨습니다.\");"
				+ "location.href='index.jsp';"
				+ "</script>");
	}
}

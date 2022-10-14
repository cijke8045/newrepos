package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import dao.MemberDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@WebServlet("/adPwCh")
public class AdPwCh extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	private void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		MemberDAO dao = new MemberDAO();
		dao.changePw((int)session.getAttribute("code"), request.getParameter("checkchangepw"));
		session.invalidate();
		response.setContentType("text/html; charset=utf-8");
		
		out.print("<script type ='text/javascript'>"
				+ "alert(\"변경 되었습니다. 다시 로그인 하세요.\");"
				+ "location.href='index.jsp';"
				+ "</script>");
		}
}

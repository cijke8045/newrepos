package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import dao.CollectDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/delCollect")
public class DelCollect extends HttpServlet {
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
		
		CollectDAO dao = new CollectDAO();
		dao.delCollect(Integer.parseInt(request.getParameter("col_code")));
		PrintWriter out = response.getWriter();
		
		out.print("<html>"
				+ "<body>"
				+ "<script>"
				+ "alert(\"삭제되었습니다.\");"
				+ "location.href='collectMain.jsp';"
				+ "</script>"
				+ "<body>"
				+ "</html>");
	}

}

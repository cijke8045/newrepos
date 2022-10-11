package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import dao.StockDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/delStock")
public class DelStock extends HttpServlet {
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
		PrintWriter out = response.getWriter();
		
		StockDAO dao = new StockDAO();
		int changecnt=dao.delStock(Integer.parseInt(request.getParameter("no")));
		dao.updateStock(changecnt);
		
		out.print("<html>"
				+ "<body>"
				+ "<form name=\"frm\" method=\"post\" action=\"stockDetail.jsp\">"
				+ "<input type=\"hidden\" name=\"code\" value="+request.getParameter("code")+">"
				+ "</form>"
				+ "<script>"
				+ "alert(\"삭제되었습니다.\");"
				+ "var frm = document.frm;"
				+ "frm.submit();"
				+ "</script>"
				+ "<body>"
				+ "</html>");
	}

}

package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import dao.ProductDAO;
import dto.ProductDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/delProduct")
public class DelProduct extends HttpServlet {
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
		
		ProductDAO dao = new ProductDAO();
		PrintWriter out = response.getWriter();
		dao.delProduct(request.getParameter("code"));
		
		out.print("<html>"
				+ "<body>"
				+ "<script>"
				+ "alert(\"상품번호["+request.getParameter("code")+"] 삭제 되었습니다.\");"
			    + "location.href='product.jsp';"
				+ "</script>"
				+ "<body>"
				+ "</html>");
	}

}

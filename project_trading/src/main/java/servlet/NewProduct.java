package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import dao.ProductDAO;
import dto.ProductDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class NewProduct extends HttpServlet {
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
		ProductDTO dto = new ProductDTO();
		PrintWriter out = response.getWriter();
		dto.setP_name(request.getParameter("name"));
		dto.setP_unit(request.getParameter("unit"));
		dto.setP_price(request.getParameter("price"));
		
		String code=dao.newProduct(dto);
		
		out.print("<html>"
				+ "<body>"
				+ "<script>"
				+ "alert(\"상품번호["+code+"] 등록되었습니다.\");"
			    + "location.href='product.jsp';"
				+ "</script>"
				+ "<body>"
				+ "</html>");
	}

}

package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import dao.MemberDAO;
import dto.MemberDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/mngAuth")
public class MngAuth extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	private void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html; charset=utf-8");
		MemberDAO dao = new MemberDAO();
		MemberDTO dto = new MemberDTO();
		PrintWriter out = response.getWriter();
		
		if(request.getParameter("code")==null) {
			dto.setCode(0);
		} else {
			dto.setCode(Integer.parseInt(request.getParameter("code")));
		}
		if(request.getParameter("product")==null) {
			dto.setProduct(0);
		} else {
			dto.setProduct(Integer.parseInt(request.getParameter("product")));
		}
		if(request.getParameter("stock")==null) {
			dto.setStock(0);
		} else {
			dto.setStock(Integer.parseInt(request.getParameter("stock")));
		}
		if(request.getParameter("company")==null) {
			dto.setCompany(0);
		} else {
			dto.setCompany(Integer.parseInt(request.getParameter("company")));
		}
		if(request.getParameter("trade")==null) {
			dto.setTrade(0);
		} else {
			dto.setTrade(Integer.parseInt(request.getParameter("trade")));
		}
		if(request.getParameter("collect")==null) {
			dto.setCollect(0);
		} else {
			dto.setCollect(Integer.parseInt(request.getParameter("collect")));
		}
		dao.setAuth(dto);
		
		out.print("<script type ='text/javascript'>"
				+ "alert(\"설정되었습니다.\");"
				+ "location.href='member.jsp';"
				+ "</script>");
	}
}

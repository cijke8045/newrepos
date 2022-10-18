package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;

import dao.StockDAO;
import dto.StockDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/getCompanyInfo")
public class GetCompanyInfo extends HttpServlet {
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
		HttpSession session = request.getSession();
		
		StockDAO dao = new StockDAO();
		StockDTO dto = new StockDTO();
		PrintWriter out = response.getWriter();
		
		dto.setCode(Integer.parseInt(request.getParameter("code")));
		dto.setCause(request.getParameter("cause"));
		dto.setCausedate(Date.valueOf(request.getParameter("causedate")));
		if(dto.getCause().equals("기타입고")) {
			dto.setChangecnt(Integer.parseInt(request.getParameter("changecnt")));
		} else {
			dto.setChangecnt(-Integer.parseInt(request.getParameter("changecnt")));
		}
		dto.setMemo(request.getParameter("memo"));
		dto.setEditor((String)session.getAttribute("name"));
		dao.newStock(dto);
		dao.updateStock(dto);
		
		out.print("<html>"
				+ "<body>"
				+ "<form name=\"frm\" method=\"post\" action=\"stockDetail.jsp\">"
				+ "<input type=\"hidden\" name=\"code\" value="+request.getParameter("code")+">"
				+ "</form>"
				+ "<script>"
				+ "alert(\"등록되었습니다.\");"
				+ "var frm = document.frm;"
				+ "frm.submit();"
				+ "</script>"
				+ "<body>"
				+ "</html>");
	}

}

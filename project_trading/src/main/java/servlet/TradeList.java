package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import dao.TradeDAO;
import dto.TradeDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/tradeList")
public class TradeList extends HttpServlet {
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
		
		TradeDAO dao = new TradeDAO();
		TradeDTO dto = new TradeDTO();
		ArrayList<TradeDTO> dtos = new ArrayList<TradeDTO>(); 
		
		PrintWriter out = response.getWriter();
		int inout =Integer.parseInt(request.getParameter("inout"));
		int c_code=-1;
		Date start=null;
		Date end=null;
		
		if(request.getParameter("code")!=null) {
			c_code=Integer.parseInt(request.getParameter("code"));
		}
		try {
			start = Date.valueOf(request.getParameter("start"));
		}catch (Exception e) {
		}
		try {
			end = Date.valueOf(request.getParameter("end"));
		}catch (Exception e) {
		}
		
		dtos = dao.tradeList(c_code, start, end);
		
		
	
		
		
/*
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
*/				
	}
}

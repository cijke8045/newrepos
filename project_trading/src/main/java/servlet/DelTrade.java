package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import dao.StockDAO;
import dao.TradeDAO;
import dto.StockDTO;
import dto.TradeDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/delTrade")
public class DelTrade extends HttpServlet {
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
		
		TradeDAO dao = new TradeDAO();
		StockDAO s_dao = new StockDAO();
		StockDTO s_dto = new StockDTO();
		ArrayList<StockDTO> s_dtos = new ArrayList<StockDTO>();
		
		int t_code=Integer.parseInt(request.getParameter("t_code")); 
			
		s_dtos=dao.delTrade(t_code);
		
		for(int i=0; i<s_dtos.size(); i++) {
			s_dto=s_dtos.get(i);
			s_dao.delStock(s_dto.getNo());
			s_dto.setChangecnt((-1)*s_dto.getChangecnt());		//삭제시 업데이트위한 음수화
			s_dao.updateStock(s_dto);
		}
		
		out.print("<html>"
				+ "<body>"
				+ "<script>"
				+ "alert(\"삭제되었습니다.\");"
				+ "location.href='tradeMain.jsp';"
				+ "</script>"
				+ "<body>"
				+ "</html>");
				
	}
}

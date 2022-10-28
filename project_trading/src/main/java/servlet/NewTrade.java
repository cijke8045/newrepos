package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;

import dao.ProductDAO;
import dao.TradeDAO;
import dto.TradeDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@WebServlet("/newTrade")
public class NewTrade extends HttpServlet {
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
		ProductDAO p_dao = new ProductDAO();
		
		PrintWriter out = response.getWriter();		
		ArrayList<TradeDTO> dtos= new ArrayList<TradeDTO>();
		
		String c_code= request.getParameter("c_code");
		int inout=0;
		if(request.getParameter("inout").equals("out")) {
			inout = 0;
		} else {
			inout= 1;
		}
		int t_code= p_dao.autoCode("trade");
		Date t_date =Date.valueOf(request.getParameter("date"));
		
		String[] no= request.getParameterValues("p_no");
		String[] p_name = request.getParameterValues("p_name");
		String[] p_code = request.getParameterValues("p_code");
		String[] p_unit = request.getParameterValues("p_unit");
		String[] p_cnt = request.getParameterValues("p_cnt");
		String[] p_price = request.getParameterValues("p_price");
		String[] p_supprice = request.getParameterValues("p_supprice");
		String[] p_tax = request.getParameterValues("p_tax");
		
		HttpSession session = request.getSession();
		String editor = (String)session.getAttribute("name");
		
		for(int i=0; i<no.length; i++) {
			TradeDTO dto = new TradeDTO();
			dto.setC_code(c_code);
			dto.setInout(inout);
			dto.setT_code(t_code);
			dto.setT_date(t_date);
			dto.setNo(Integer.parseInt(no[i]));
			dto.setP_name(p_name[i]);
			dto.setP_code(Integer.parseInt(p_code[i]));
			dto.setUnit(p_unit[i]);
			dto.setCnt(Integer.parseInt(p_cnt[i]));
			if(inout==1) {
				dto.setSup_price(Integer.parseInt(p_supprice[i])*(-1));
				dto.setTax(Integer.parseInt(p_tax[i])*(-1));
			}else {
				dto.setSup_price(Integer.parseInt(p_supprice[i]));
				dto.setTax(Integer.parseInt(p_tax[i]));
			}
			dto.setPrice(Integer.parseInt(p_price[i]));
			dtos.add(dto);
		}
		
		dao.newTrade(dtos, editor);
		
		
		out.print("<html>"
				+ "<body>"
				+ "<script>"
				+ "alert(\"저장되었습니다.\");"
			    + "location.href='tradeMain.jsp';"
				+ "</script>"
				+ "<body>"
				+ "</html>");
	}

}

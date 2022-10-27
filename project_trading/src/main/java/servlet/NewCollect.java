package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;

import dao.CollectDAO;
import dao.ProductDAO;
import dto.CollectDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/newCollect")
public class NewCollect extends HttpServlet {
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
		CollectDTO dto = new CollectDTO();
		ProductDAO p_dao = new ProductDAO();
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		String editor = (String)session.getAttribute("name");
		
		dto.setCol_date(Date.valueOf(request.getParameter("c_date")));
		dto.setCol_editor(editor);
		String inout=(String)request.getParameter("cause");
		if(inout.equals("입금")) {			//미수금처리
			dto.setCol_inout(1);
			dto.setCol_amount((-1)*Integer.parseInt(request.getParameter("c_amount")));
		}else {								//미지급금처리
			dto.setCol_inout(0);
			dto.setCol_amount(Integer.parseInt(request.getParameter("c_amount")));
		}
		dto.setCol_memo((String)request.getParameter("c_memo"));
		int no=p_dao.autoCode("collect");
		dto.setCol_no(no);
		dto.setC_code(Integer.parseInt(request.getParameter("c_code")));
		
		dao.newCollect(dto);
		
		out.print("<html>"
				+ "<body>"
				+ "<script>"
				+ "alert(\"등록되었습니다.\");"
				+ "location.href='collectMain.jsp';"
				+ "</script>"
				+ "<body>"
				+ "</html>");
	}

}

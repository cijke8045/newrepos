package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import dao.AccountDAO;
import dto.MemberDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class Login extends HttpServlet {
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
		AccountDAO dao = new AccountDAO();
		PrintWriter out = response.getWriter();
		
		String code = dao.checkIdPw(request.getParameter("id"),request.getParameter("pw"));	//아이디체크 후 고유번호 호출
		
		if(code!=null) {			//DB조회후 아이디 비밀번호 맞을때
			MemberDTO dto = new MemberDTO();
			dto=dao.getinformation(code);		//코드로 기타정보 조회
			
			HttpSession session = request.getSession();
			session.setAttribute("name", dto.getName());
			session.setAttribute("code", dto.getCode());
			session.setAttribute("department", dto.getDepartment());
			session.setAttribute("job", dto.getJob());
			session.setAttribute("co_name", dto.getCo_name());
			if(code.length()==10) {		//거래처일때
				session.setAttribute("authority", 1);
			} else if(code.length()==4) {  //직원일때
				session.setAttribute("authority", 2);
			} else if(code.equals("admin")) {
				session.setAttribute("authority", 3);
			}
			System.out.println("아이디조회성공");
			
			out.print("<script type ='text/javascript'>"					
					+ "location.href='index.jsp';"
					+ "</script>");
		}else {
			out.print("<script type ='text/javascript'>"
					+ "alert(\"아이디나 비밀번호가 틀렸습니다.\");"
					+ "location.href='login.jsp';"
					+ "</script>");
		}
	}

}

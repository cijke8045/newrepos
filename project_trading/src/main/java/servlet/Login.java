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
		
		int code = dao.checkIdPw(request.getParameter("id"),request.getParameter("pw"));	//아이디체크 후 고유번호 호출 아닐시 -10리턴
		
		if(code!=-10) {			//DB조회후 아이디 비밀번호 맞을때
			MemberDTO i_dto = new MemberDTO();
			MemberDTO a_dto = new MemberDTO();
			
			i_dto=dao.getinformation(code);		//코드로 기타정보 조회
			a_dto=dao.getAuth(code);			//코드로 권한조회
			String strcode=code+"";
			HttpSession session = request.getSession();
			session.setAttribute("name", i_dto.getName());
			session.setAttribute("code", i_dto.getCode());
			if(strcode.length()==10) {		//거래처일때
				session.setAttribute("authority", 1);
			} else if(strcode.length()==4) {  //직원일때
				session.setAttribute("authority", 2);
				session.setAttribute("department", i_dto.getDepartment());
				session.setAttribute("job", i_dto.getJob());
				session.setAttribute("company", a_dto.getCompany());
				session.setAttribute("stock", a_dto.getStock());
				session.setAttribute("product", a_dto.getProduct());
				session.setAttribute("trade", a_dto.getTrade());
				session.setAttribute("collect", a_dto.getCollect());
			} else if(strcode.length()==1) {	//관리자
				session.setAttribute("authority", 3);
				session.setAttribute("company",1);
				session.setAttribute("stock", 1);
				session.setAttribute("product", 1);
				session.setAttribute("trade", 1);
				session.setAttribute("collect", 1);
			}
			
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

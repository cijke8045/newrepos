package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.MemberDTO;

public class AccountDAO {
	
	private PreparedStatement pstmt=null;
	private Connection con;
	private DataSource dataFactory;
	private ResultSet rs=null;
	
	public AccountDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("jdbc/oracle"); 
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}
	
	public boolean codeExist(String code) {
		String query;
		boolean result=false;
		
		try {
			con = dataFactory.getConnection();
			if(code.length()==10) {			//사업자 번호이면 컴패니테이블 조회
				query="select code from company where code=?";
				pstmt = con.prepareStatement(query);
				pstmt.setString(1, code);
			} else if(code.length()==4) {			//직원번호이면 임플로이테이블 조회
				int intcode=Integer.parseInt(code);
				query="select code from employee where code=?";
				pstmt = con.prepareStatement(query);
				pstmt.setInt(1, intcode);
			} else {
				return false;
			}
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result=true;
			} 
			
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				con.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	public boolean idExist(String code) {
		
		boolean result=false;
		try {
			con = dataFactory.getConnection();
			String query="select id from member where code=?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, code);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result=true;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				con.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	public boolean idoverlap(String id) {
		
		boolean result=false;
		try {
			con = dataFactory.getConnection();
			String query="select id from member where id=?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			 rs = pstmt.executeQuery();
			if(rs.next()) {
				result=true;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				con.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	public void insertmember(MemberDTO dto) {
		try {
			con=dataFactory.getConnection();
			String id = dto.getId();
			String pw = dto.getPw();
			String code = dto.getCode();
			String query= "insert into member values(?,?,?,?,?,?,?,?)";
			
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, code);
			pstmt.setString(2, id);
			pstmt.setString(3, pw);
			pstmt.setInt(4, 0);
			pstmt.setInt(5, 0);
			pstmt.setInt(6, 0);
			pstmt.setInt(7, 0);
			pstmt.setInt(8, 0);
			pstmt.executeUpdate();
			pstmt.close();
			System.out.println("회원가입");
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				con.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public String checkIdPw(String id, String pw) {
		
		String result="fail";
		try {
			con = dataFactory.getConnection();
			String query="select code from member where id=? and pw=?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			 rs = pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getString(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				con.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	public MemberDTO getAuth(String code) {
		MemberDTO dto = new MemberDTO();
		try {
			con = dataFactory.getConnection();
			String query="select * from member where code=?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, code);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setCompany(rs.getInt("company"));
				dto.setProduct(rs.getInt("product"));
				dto.setStock(rs.getInt("stock"));
				dto.setTrade(rs.getInt("trade"));
				dto.setCollect(rs.getInt("collect"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				con.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return dto;
	}
	
	public MemberDTO getinformation(String code) {
		String query="";
		MemberDTO dto =new MemberDTO();
		try {
			con = dataFactory.getConnection();
			if(code.length()==4 ||code.length()==1) {				//직원
				query="select * from employee where code=?";
				pstmt = con.prepareStatement(query);
				pstmt.setInt(1,Integer.parseInt(code));
				rs = pstmt.executeQuery();
				if(rs.next()) {
					dto.setCode(rs.getInt("code")+"");
					dto.setDepartment(rs.getString("department"));
					dto.setName(rs.getString("name"));
					dto.setJob(rs.getString("job"));
				}
				
			} else if(code.length()==10) { 		//거래처
				query="select * from company where code=?";
				pstmt = con.prepareStatement(query);
				pstmt.setString(1, code);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					dto.setCode(rs.getString("code"));
					dto.setName(rs.getString("name"));
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				con.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return dto;
	}
}

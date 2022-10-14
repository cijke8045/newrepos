package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.MemberDTO;

public class MemberDAO {
	private PreparedStatement pstmt=null;
	private Connection con;
	private DataSource dataFactory;
	private ResultSet rs=null;
	public MemberDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("jdbc/oracle"); 
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public MemberDTO infoMemberE(int code) {
		String query;
		MemberDTO dto =new MemberDTO();
		
		try {
			con = dataFactory.getConnection();
			query="select * from member,employee where member.code=employee.code and employee.code=?";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, code);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setCode(rs.getInt(1));
				dto.setId(rs.getString(2));
				dto.setCompany(rs.getInt(4));
				dto.setProduct(rs.getInt(5));
				dto.setStock(rs.getInt(6));
				dto.setTrade(rs.getInt(7));
				dto.setCollect(rs.getInt(8));
				dto.setName(rs.getString(10));
				dto.setDepartment(rs.getString(11));
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
	
	public void setAuth(MemberDTO dto) {
		String query;
		try {
			con = dataFactory.getConnection();
			query="update member set company=?, product=?, stock=?, trade=?, collect=? where code=?";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, dto.getCompany());
			pstmt.setInt(2, dto.getProduct());
			pstmt.setInt(3, dto.getStock());
			pstmt.setInt(4, dto.getTrade());
			pstmt.setInt(5, dto.getCollect());
			pstmt.setInt(6, dto.getCode());
			pstmt.executeUpdate();
			
			
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
	}
	
	public ArrayList<MemberDTO> searchMemberE(String name) {
		String query;
		ArrayList<MemberDTO> dtos =new ArrayList<MemberDTO>();
		
		try {
			con = dataFactory.getConnection();
			if(name.equals("all")) {			//조회목록이 전부일경우
				query="select * from member,employee where member.code=employee.code";
				pstmt = con.prepareStatement(query);
			} else {			//특정직원 조회시
				query="select * from member,employee where member.code=employee.code and employee.name like ?";
				pstmt = con.prepareStatement(query);
				pstmt.setString(1, "%"+name+"%");
			}			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MemberDTO dto = new MemberDTO();
				dto.setCode(rs.getInt(1));
				dto.setId(rs.getString(2));
				dto.setCompany(rs.getInt(4));
				dto.setProduct(rs.getInt(5));
				dto.setStock(rs.getInt(6));
				dto.setTrade(rs.getInt(7));
				dto.setCollect(rs.getInt(8));
				dto.setName(rs.getString(10));
				dto.setDepartment(rs.getString(11));
				dto.setJob(rs.getString(12));
				dtos.add(dto);
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
		return dtos;
	}
	
	public ArrayList<MemberDTO> searchMemberC(String name) {
		String query;
		ArrayList<MemberDTO> dtos =new ArrayList<MemberDTO>();
		
		try {
			con = dataFactory.getConnection();
			if(name.equals("all")) {			//조회목록이 전부일경우
				query="select * from member,company where member.code=company.code";
				pstmt = con.prepareStatement(query);
			} else {			//특정직원 조회시
				query="select * from member,company where member.code=company.code and company.name like ?";
				pstmt = con.prepareStatement(query);
				pstmt.setString(1, "%"+name+"%");
			}			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MemberDTO dto = new MemberDTO();
				dto.setCode(rs.getInt(1));
				dto.setId(rs.getString(2));
				dto.setName(rs.getString(11));
				
				dtos.add(dto);
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
		return dtos;
	}
	
	public void delMember(int code) {		
		
		try {
			con = dataFactory.getConnection();
			String query="delete from member where code=?";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, code);
			pstmt.executeUpdate();
			
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
	}
	
	public void changePw(int code,String pw) {
		String query;
		try {
			con = dataFactory.getConnection();
			query="update member set pw=? where code=?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, pw);
			pstmt.setInt(2, code);
			pstmt.executeUpdate();
			
			
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
	}
}

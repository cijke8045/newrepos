package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.CompanyDTO;
import dto.ProductDTO;

public class CompanyDAO {
	private PreparedStatement pstmt=null;
	private Connection con;
	private DataSource dataFactory;
	private ResultSet rs=null;
	public CompanyDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("jdbc/oracle"); 
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public ArrayList<CompanyDTO> searchCompany(String name) {
		String query;
		ArrayList<CompanyDTO> dtos =new ArrayList<CompanyDTO>();
		
		try {
			con = dataFactory.getConnection();
			if(name.equals("all")) {			//조회목록이 전부일경우
				query="select * from company";
				pstmt = con.prepareStatement(query);
			} else {			//특정상품 조회시
				query="select * from product where name like ?";
				pstmt = con.prepareStatement(query);
				pstmt.setString(1, "%"+name+"%");
			}			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CompanyDTO dto = new CompanyDTO();
				dto.setCode(rs.getInt("code"));
				dto.setContact(rs.getString("contact"));
				dto.setName(rs.getString("price"));
				dto.setAddress(rs.getString("address"));
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
	
	public void newCompany(CompanyDTO dto) {
		
		try {
			con = dataFactory.getConnection();
			String query="insert into company values(?,?,?,?)";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, dto.getCode());
			pstmt.setString(2, dto.getContact());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getAddress());
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
	
	public void delCompany(int code) {		
		
		try {
			con = dataFactory.getConnection();
			String query="delete from company where code=?";
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
}

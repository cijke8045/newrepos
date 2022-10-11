package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

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
	
	public ArrayList<ProductDTO> searchCompany(String c_name) {
		String query;
		ArrayList<ProductDTO> dtos =new ArrayList<ProductDTO>();
		
		try {
			con = dataFactory.getConnection();
			if(p_name.equals("all")) {			//조회목록이 전부일경우
				query="select * from product";
				pstmt = con.prepareStatement(query);
			} else {			//특정상품 조회시
				query="select * from product where name like ?";
				pstmt = con.prepareStatement(query);
				pstmt.setString(1, "%"+p_name+"%");
			}			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductDTO dto = new ProductDTO();
				dto.setP_code(rs.getInt("code"));
				dto.setP_name(rs.getString("name"));
				dto.setP_price(rs.getString("price"));
				dto.setP_unit(rs.getString("unit"));
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
	
}

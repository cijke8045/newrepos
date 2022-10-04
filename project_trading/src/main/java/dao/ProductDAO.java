package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.ProductDTO;

public class ProductDAO {
	private PreparedStatement pstmt;
	private Connection con;
	private DataSource dataFactory;
	public ProductDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("jdbc/oracle"); 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public List<ProductDTO> searchProduct(String p_name) {
		String query;
		List<ProductDTO> dtos =null;
		
		try {
			con = dataFactory.getConnection();
			if(p_name.equals("all")) {			//조회목록이 전부일경우
				query="select * from product";
			} else {			//특정상품 조회시
				query="select * from product where code=?";
				pstmt.setString(1, p_name);
			}
			pstmt = con.prepareStatement(query);			
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				ProductDTO dto = new ProductDTO();
				dto.setP_code("code");
				dto.setP_name(p_name);
				dto.setP_price("price");
				dto.setP_unit("unit");
				dtos.add(dto);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return dtos;
	}
}

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

public class ProductDAO {
	private PreparedStatement pstmt=null;
	private Connection con;
	private DataSource dataFactory;
	private ResultSet rs=null;
	public ProductDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("jdbc/oracle"); 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public ProductDTO infowithcode(int code) {
		String query;
		ProductDTO dto =new ProductDTO();
		
		try {
			con = dataFactory.getConnection();
			query="select * from product where code=?";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, code);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setP_name(rs.getString("name"));
				dto.setP_price(rs.getString("price"));
				dto.setP_unit(rs.getString("unit"));
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
	
	public ArrayList<ProductDTO> searchProduct(String p_name) {
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
				System.out.println(rs.getInt("code"));
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
	
	public int autoCode(String table) {				//테이블이름으로 코드를 조회 후, 중간에 비어있거나 가장 큰 수를 리턴
		int code=0;
		int temp=0;
		
		try {
			con = dataFactory.getConnection();
			String query="select code from "+table+" order by code";
			pstmt = con.prepareStatement(query);			
			rs = pstmt.executeQuery();			
			while(rs.next()) {
				if(temp<rs.getInt("code")) {			//중간에 빈 번호가 있을때
					code=temp;
					break;
				}else {
					temp=rs.getInt("code")+1;					
				}
			}
			if(!rs.next()) {			//끝 번호
				code=temp;
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
		return code;
	}
	
	public int newProduct(ProductDTO dto) {		//자동으로 생성된 상품코드를 리턴함
		int code = autoCode("product");		//코드 자동생성
		try {
			con = dataFactory.getConnection();
			String query="insert into product values(?,?,?,?)";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, code);
			pstmt.setString(2, dto.getP_name());
			pstmt.setString(3, dto.getP_unit());
			pstmt.setString(4, dto.getP_price());
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
		return code;
	}
	
	public void delProduct(int code) {		
		
		try {
			con = dataFactory.getConnection();
			String query="delete from product where code=?";
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
	
	public void delStockAll(int code) {		
		
		try {
			con = dataFactory.getConnection();
			String query="delete from stock where code=?";
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

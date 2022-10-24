package dao;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.StockDTO;
import dto.TradeDTO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class TradeDAO {
	private PreparedStatement pstmt=null;
	private Connection con;
	private DataSource dataFactory;
	private ResultSet rs=null;
	public TradeDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("jdbc/oracle"); 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<StockDTO> stockdetail(int code) {
		String query;
		
		ArrayList<StockDTO> dtos = new ArrayList<StockDTO>();
		try {
			con = dataFactory.getConnection();
			query="select * from stock where code=? order by causedate desc, no desc";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, code);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				StockDTO dto =new StockDTO();
				dto.setTotalcnt(rs.getInt("totalcnt"));
				dto.setEditor(rs.getString("editor"));
				dto.setCause(rs.getString("cause"));
				dto.setCausedate(rs.getDate("causedate"));
				dto.setChangecnt(rs.getInt("changecnt"));
				dto.setEditdate(rs.getDate("editdate"));
				dto.setMemo(rs.getString("memo"));
				dto.setNo(rs.getInt("no"));
				
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
	
	public StockDTO findChange(int no) {
		StockDTO dto = new StockDTO();
		
		try {
			con = dataFactory.getConnection();
			String query="select changecnt,causedate from stock where no=?";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, no);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				dto.setChangecnt(rs.getInt(1));
				dto.setCausedate(rs.getDate(2));
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
	
	public void delStock(int no) {
		
		try {
			con = dataFactory.getConnection();
			String query="delete from stock where no=?";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, no);
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
	
	public void newTrade(ArrayList<TradeDTO> dtos , String editor) {
		TradeDTO dto = new TradeDTO();
		StockDTO s_dto = new StockDTO();
		StockDAO s_dao = new StockDAO();
		dto=dtos.get(0);
		
		try {
			
			con = dataFactory.getConnection();
			String query="insert into trade values(?,?,?,?)";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, dto.getT_code());
			pstmt.setInt(2, dto.getInout());
			pstmt.setInt(3, dto.getC_code());
			pstmt.setDate(4, dto.getT_date());
			pstmt.executeUpdate();
			
			for(int i=0; i<dtos.size(); i++) {
				dto=dtos.get(i);
				
				query="insert into tradecontent values(?,?,?,?,?,?,?,?,?)";
				pstmt = con.prepareStatement(query);
				pstmt.setInt(1, dto.getT_code());
				pstmt.setString(2, dto.getP_name());
				pstmt.setInt(3, dto.getP_code());
				pstmt.setString(4, dto.getUnit());
				pstmt.setInt(5, dto.getCnt());
				pstmt.setInt(6, dto.getSup_price());
				pstmt.setInt(7, dto.getTax());
				pstmt.setInt(8, dto.getPrice());
				pstmt.setInt(9, dto.getNo());
				pstmt.executeUpdate();
				
				if(dto.getP_code()!=-1) {
					s_dto.setCause("매출");
					s_dto.setCausedate(dto.getT_date());
					s_dto.setChangecnt(dto.getCnt()*(-1));
					s_dto.setMemo("");
					s_dto.setCode(dto.getP_code());
					s_dto.setEditor(editor);
					
					s_dao.newStock(s_dto);
					s_dao.updateStock(s_dto);
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
	}
}

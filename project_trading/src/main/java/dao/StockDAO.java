package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.ProductDTO;
import dto.StockDTO;

public class StockDAO {
	private PreparedStatement pstmt=null;
	private Connection con;
	private DataSource dataFactory;
	private ResultSet rs=null;
	public StockDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("jdbc/oracle"); 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public StockDTO stockWithcode(int code) {
		String query;
		StockDTO dto =new StockDTO();
		
		try {
			con = dataFactory.getConnection();
			query="select totalcnt from stock where code=? order by causedate desc, no desc";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, code);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setTotalcnt(rs.getInt("totalcnt"));
			} else {
				dto.setTotalcnt(0);
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
	
	public int findMaxNum(String table) {
		String query;
		int num=0;
		try {
			con = dataFactory.getConnection();
			query="select max(no) from "+table;
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				num=rs.getInt(1);
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
		
		return num;
	}
	
	public int findLastTotal(int code, Date causedate) {
		String query;
		int cnt=0;
		try {
			con = dataFactory.getConnection();
			query="select totalcnt from stock where causedate<=? and code=? order by causedate desc, no desc";
			pstmt = con.prepareStatement(query);
			pstmt.setDate(1, causedate);
			pstmt.setInt(2, code);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				cnt=rs.getInt("totalcnt");
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
		return cnt;
	}
	
	public void updateStock(StockDTO dto) {
		try {
			con = dataFactory.getConnection();
			String query="update stock set totalcnt =totalcnt+? where causedate>? and code=?";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, dto.getChangecnt());
			pstmt.setDate(2, dto.getCausedate());
			pstmt.setInt(3, dto.getCode());
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
	
	public void newStock(StockDTO dto) {
		int totalcnt=0;
		totalcnt =findLastTotal(dto.getCode(),dto.getCausedate())+dto.getChangecnt();
		//가장최근의 총수량에 변동된 수량 계산
		int maxnum = findMaxNum("stock")+1;
		//연번 자동으로입력
		
		try {
			con = dataFactory.getConnection();
			String query="insert into stock values(?,?,?,?,?,?,?,sysdate,?)";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, dto.getCode());
			pstmt.setString(2, dto.getCause());
			pstmt.setInt(3, dto.getChangecnt());
			pstmt.setInt(4, totalcnt);
			pstmt.setString(5, dto.getEditor());
			pstmt.setInt(6, maxnum);
			pstmt.setString(7, dto.getMemo());
			pstmt.setDate(8, dto.getCausedate());
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

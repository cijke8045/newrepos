package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.CollectDTO;
import dto.StockDTO;
import dto.TradeDTO;

public class CollectDAO {
	private PreparedStatement pstmt=null;
	private Connection con;
	private DataSource dataFactory;
	private ResultSet rs=null;
	public CollectDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("jdbc/oracle"); 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<CollectDTO> collectList(int c_code, Date start, Date end) {
		ArrayList<CollectDTO> dtos = new ArrayList<CollectDTO>();
		String query;
		try {
			con = dataFactory.getConnection();
			if(c_code==-1) {						//거래처 전부
				if(start==null && end==null) {			//기간없음
					query="select col.*, c.name from collect col,company c where c.code=col.c_code order by col_date desc, name";
					pstmt = con.prepareStatement(query);
				}else if(start==null && end!=null) {	//시작날짜 없을시 	
					query="select col.*, c.name from collect col,company c where c.code=col.c_code and col_date<=? order by col_date desc, name";
					pstmt = con.prepareStatement(query);
					pstmt.setDate(1, end);
				}else if(start!=null && end==null) {	//끝날짜 없읋시	
					query="select col.*, c.name from collect col,company c where c.code=col.c_code and ?<=col_date order by col_date desc, name";
					pstmt = con.prepareStatement(query);
					pstmt.setDate(1, start);
				}else {									//특정기간
					query="select col.*, c.name from collect col,company c where c.code=col.c_code and ?<=col_date and cal_date<=? order by col_date desc, name";
					pstmt = con.prepareStatement(query);
					pstmt.setDate(1, start);
					pstmt.setDate(2, end);
				}
			}else {									//특정거래처
				if(start==null && end==null) {			//기간없음
					query="select col.*, c.name from collect col,company c where c.code=col.c_code and c_code=? order by col_date desc, name";
					pstmt = con.prepareStatement(query);
					pstmt.setInt(1, c_code);
				}else if(start==null && end!=null) {	//시작날짜 없을시 	
					query="select col.*, c.name from collect col,company c where c.code=col.c_code and col_date<=? and c_code=? order by col_date desc, name";
					pstmt = con.prepareStatement(query);
					pstmt.setDate(1, end);
					pstmt.setInt(2, c_code);
				}else if(start!=null && end==null) {	//끝날짜 없읋시	
					query="select col.*, c.name from collect col,company c where c.code=col.c_code and ?<=col_date and c_code=? order by col_date desc, name";
					pstmt = con.prepareStatement(query);
					pstmt.setDate(1, start);
					pstmt.setInt(2, c_code);
				}else {									//특정기간
					query="select col.*, c.name from collect col,company c where c.code=col.c_code and ?<=col_date and cal_date<=? and c_code=? order by col_date desc, name";
					pstmt = con.prepareStatement(query);
					pstmt.setDate(1, start);
					pstmt.setDate(2, end);
					pstmt.setInt(3, c_code);
				}
			}
			rs=pstmt.executeQuery();
			while(rs.next()) {
				CollectDTO dto = new CollectDTO();
				dto.setCol_no(rs.getInt(1));
				dto.setCol_inout(rs.getInt(2));
				dto.setCol_memo(rs.getString(3));
				dto.setCol_amount(rs.getInt(4));
				dto.setCol_date(rs.getDate(5));
				dto.setC_code(rs.getInt(6));
				dto.setCol_editor(rs.getString(7));
				dto.setC_name(rs.getString(8));
				
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
	
	public void delCollect(int col_code) {
		String query;
		try {
			con = dataFactory.getConnection();
			query="delete from collect where code=?";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, col_code);
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
	
	public void newCollect(CollectDTO dto) {
		try {
			con = dataFactory.getConnection();
			String query="insert into collect values(?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, dto.getCol_no());
			pstmt.setInt(2, dto.getCol_inout());
			pstmt.setString(3, dto.getCol_memo());
			pstmt.setInt(4, dto.getCol_amount());
			pstmt.setDate(5, dto.getCol_date());
			pstmt.setInt(6, dto.getC_code());
			pstmt.setString(7, dto.getCol_editor());
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

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
	
	public ArrayList<TradeDTO> tradeList(int c_code, Date start, Date end) {
		String query;
		
		ArrayList<TradeDTO> dtos = new ArrayList<TradeDTO>();
		try {
			con = dataFactory.getConnection();
			
			if(c_code==-1) {						//전체거래처 조회시
				if(start==null && end==null) {			//기간없음
					query="select t.code, t.t_date, c.name, tc.p_name, tc.sup_price,tc.tax from company c,trade t, tradecontent tc where t.code=tc.code and t.c_code=c.code order by t_date desc ,name";
					pstmt = con.prepareStatement(query);
				}else if(start==null && end!=null) {	//시작날짜없음
					query="select t.code, t.t_date, c.name, tc.p_name, tc.sup_price,tc.tax from company c,trade t, tradecontent tc where t.code=tc.code and t.c_code=c.code and t.t_date<? order by t_date desc ,name";
					pstmt = con.prepareStatement(query);
					pstmt.setDate(1, end);
				}else if(start!=null && end==null) {	//끝날짜없음
					query="select t.code, t.t_date, c.name, tc.p_name, tc.sup_price,tc.tax from company c,trade t, tradecontent tc where t.code=tc.code and t.c_code=c.code and ?<t.t_date order by t_date desc ,name";
					pstmt = con.prepareStatement(query);
					pstmt.setDate(1, start);
				}else {									//특정기간있음	
					query="select t.code, t.t_date, c.name, tc.p_name, tc.sup_price,tc.tax from company c,trade t, tradecontent tc where t.code=tc.code and t.c_code=c.code and ?<t.t_date<? order by t_date desc ,name";
					pstmt = con.prepareStatement(query);
					pstmt.setDate(1, start);
					pstmt.setDate(2, end);
				}
			} else {								//특정거래처 조회시
				if(start==null && end==null) {			//기간없음
					query="select t.code, t.t_date, c.name, tc.p_name, tc.sup_price,tc.tax from company c,trade t, tradecontent tc where t.code=tc.code and t.c_code=c.code and t.c_code=? order by t_date desc ,name";
					pstmt = con.prepareStatement(query);
					pstmt.setInt(1, c_code);
				}else if(start==null && end!=null) {	//시작날짜없음
					query="select t.code, t.t_date, c.name, tc.p_name, tc.sup_price,tc.tax from company c,trade t, tradecontent tc where t.code=tc.code and t.c_code=c.code and t.t_date<? and t.c_code=? order by t_date desc ,name";
					pstmt = con.prepareStatement(query);
					pstmt.setDate(1, end);
					pstmt.setInt(2, c_code);
				}else if(start!=null && end==null) {	//끝날짜없음
					query="select t.code, t.t_date, c.name, tc.p_name, tc.sup_price,tc.tax from company c,trade t, tradecontent tc where t.code=tc.code and t.c_code=c.code and ?<t.t_date and t.c_code=? order by t_date desc ,name";
					pstmt = con.prepareStatement(query);
					pstmt.setDate(1, start);
					pstmt.setInt(2, c_code);
				}else {									//특정기간있음	
					query="select t.code, t.t_date, c.name, tc.p_name, tc.sup_price,tc.tax from company c,trade t, tradecontent tc where t.code=tc.code and t.c_code=c.code and ?<t.t_date<? and t.c_code=? order by t_date desc ,name";
					pstmt = con.prepareStatement(query);
					pstmt.setDate(1, start);
					pstmt.setDate(2, end);
					pstmt.setInt(3, c_code);
				}
			}
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				TradeDTO dto =new TradeDTO();
				dto.setT_code(rs.getInt("code"));
				dto.setT_date(rs.getDate("t_date"));
				dto.setC_name(rs.getString("name"));
				dto.setP_name(rs.getString("p_name"));
				dto.setSup_price(rs.getInt("sup_price"));
				dto.setTax(rs.getInt("tax"));
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
				
				if(dto.getInout()==0) {
					s_dto.setCause("매출");
					s_dto.setChangecnt(dto.getCnt()*(-1));
					s_dto.setEditor(editor);
					
				}else {
					s_dto.setCause("매입");
					s_dto.setChangecnt(dto.getCnt());
					s_dto.setEditor(editor);
				}
				s_dto.setMemo("");
				s_dto.setCode(dto.getP_code());
				s_dto.setCausedate(dto.getT_date());
				s_dao.newStock(s_dto);
				s_dao.updateStock(s_dto);
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

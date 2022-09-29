package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class AccountDAO {
	
	private PreparedStatement pstmt;
	private Connection con;
	private DataSource dataFactory;
	
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
		
		boolean result=false;
		try {
			con = dataFactory.getConnection();
			String query="select * from table where code=?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, code);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				result=true;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
public boolean idExist(String code) {
		
		boolean result=false;
		try {
			con = dataFactory.getConnection();
			String query="select * from table where code=?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, code);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				result=true;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}

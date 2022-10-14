package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.EmployeeDTO;

public class EmployeeDAO {
	private PreparedStatement pstmt=null;
	private Connection con;
	private DataSource dataFactory;
	private ResultSet rs=null;
	public EmployeeDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("jdbc/oracle"); 
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public int autoCode(String table) {				//테이블이름으로 코드를 조회 후,4자리 중간에 비어있거나 가장 큰 수를 리턴
		int code=1000;
		int temp=1000;
		
		try {
			con = dataFactory.getConnection();
			String query="select code from "+table+" where length(code)=4 order by code";
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
	
	public ArrayList<EmployeeDTO> searchEmployee(String name) {
		String query;
		ArrayList<EmployeeDTO> dtos =new ArrayList<EmployeeDTO>();
		
		try {
			con = dataFactory.getConnection();
			if(name.equals("all")) {			//조회목록이 전부일경우
				query="select * from employee";
				pstmt = con.prepareStatement(query);
			} else {			//특정직원 조회시
				query="select * from employee where name like ?";
				pstmt = con.prepareStatement(query);
				pstmt.setString(1, "%"+name+"%");
			}			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				EmployeeDTO dto = new EmployeeDTO();
				dto.setCode(rs.getInt("code"));
				dto.setContact(rs.getString("contact"));
				dto.setName(rs.getString("name"));
				dto.setDepartment(rs.getString("department"));
				dto.setJob(rs.getString("job"));
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
	
	public void newEmployee(EmployeeDTO dto) {
		
		try {
			con = dataFactory.getConnection();
			String query="insert into employee values(?,?,?,?,?)";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, dto.getCode());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getDepartment());
			pstmt.setString(4, dto.getJob());
			pstmt.setString(5, dto.getContact()); 
			
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
	
	
	
	public void delEmployee(int code) {		
		
		try {
			con = dataFactory.getConnection();
			String query="delete from employee where code=?";
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

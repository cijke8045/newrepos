package dto;

import java.sql.Date;

public class CollectDTO {
	private int col_no;
	private int col_inout;
	private String col_memo;
	private int col_amount;
	private Date col_date;
	private String col_editor;
	private String c_code;
	private String c_name;
	
	public String getC_name() {
		return c_name;
	}
	public void setC_name(String c_name) {
		this.c_name = c_name;
	}
	public String getC_code() {
		return c_code;
	}
	public void setC_code(String c_code) {
		this.c_code = c_code;
	}
	public String getCol_editor() {
		return col_editor;
	}
	public void setCol_editor(String col_editor) {
		this.col_editor = col_editor;
	}
	public int getCol_no() {
		return col_no;
	}
	public void setCol_no(int col_no) {
		this.col_no = col_no;
	}
	public int getCol_inout() {
		return col_inout;
	}
	public void setCol_inout(int col_inout) {
		this.col_inout = col_inout;
	}
	public String getCol_memo() {
		return col_memo;
	}
	public void setCol_memo(String col_memo) {
		this.col_memo = col_memo;
	}
	public int getCol_amount() {
		return col_amount;
	}
	public void setCol_amount(int col_amount) {
		this.col_amount = col_amount;
	}
	public Date getCol_date() {
		return col_date;
	}
	public void setCol_date(Date col_date) {
		this.col_date = col_date;
	}
	
}

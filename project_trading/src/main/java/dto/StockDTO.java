package dto;

import java.sql.Date;

public class StockDTO {
	private int code;
	private String cause;
	private int changecnt;
	private int totalcnt;
	private String editor;
	private int no;
	private String memo;
	private Date editdate;
	private Date causedate;
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getCause() {
		return cause;
	}
	public void setCause(String cause) {
		this.cause = cause;
	}
	public int getChangecnt() {
		return changecnt;
	}
	public void setChangecnt(int changecnt) {
		this.changecnt = changecnt;
	}
	public int getTotalcnt() {
		return totalcnt;
	}
	public void setTotalcnt(int totalcnt) {
		this.totalcnt = totalcnt;
	}
	public String getEditor() {
		return editor;
	}
	public void setEditor(String editor) {
		this.editor = editor;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public Date getEditdate() {
		return editdate;
	}
	public void setEditdate(Date editdate) {
		this.editdate = editdate;
	}
	public Date getCausedate() {
		return causedate;
	}
	public void setCausedate(Date causedate) {
		this.causedate = causedate;
	}
		
}

package xyz.itwill.dto;

public class ReviewDTO {
	
	/*
	 이름       널?       유형             
-------- -------- -------------- 
RNO      NOT NULL NUMBER(20)     
RNAME             VARCHAR2(20)   
RCONTENT          VARCHAR2(20)   
RDATE             DATE           
SNO               NUMBER(20)     
REPLY             VARCHAR2(1000) 
RRATING           NUMBER(10)     
	 */
	private int rno;
	private String rname;
	private String rcontent;
	private String rdate;
	private int sno;
	private String reply;
	private int rrating;
	
	
	public String getReply() {
		return reply;
	}
	public void setReply(String reply) {
		this.reply = reply;
	}
	public int getRrating() {
		return rrating;
	}
	public void setRrating(int rrating) {
		this.rrating = rrating;
	}
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public String getRname() {
		return rname;
	}
	public void setRname(String rname) {
		this.rname = rname;
	}
	
	public String getRcontent() {
		return rcontent;
	}
	public void setRcontent(String rcontent) {
		this.rcontent = rcontent;
	}
	public String getRdate() {
		return rdate;
	}
	public void setRdate(String rdate) {
		this.rdate = rdate;
	}
	public int getSno() {
		return sno;
	}
	public void setSno(int sno) {
		this.sno = sno;
	}
	
	public ReviewDTO() {
		// TODO Auto-generated constructor stub
	}
	
}

package xyz.itwill.dto;

public class QnaDTO {
	
//	QNO      NOT NULL NUMBER(10)     
//	QPNO              NUMBER(30)     
//	QTITLE            VARCHAR2(50)   
//	QWRITER           VARCHAR2(20)   
//	QDATE             DATE           
//	QCONTENT          VARCHAR2(1000) 
//	QIMG              VARCHAR2(500)  
//	QANSWER           VARCHAR2(1000) 
//	QSTATUS           NUMBER(5)

	private int qno;
	private int qpno;
	private String qtitle;
	private String qwriter;
	private String qdate;
	private String qcontent;
	private String qanswer;
	private int qstatus;
	
	public QnaDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getQno() {
		return qno;
	}

	public void setQno(int qno) {
		this.qno = qno;
	}

	public int getQpno() {
		return qpno;
	}

	public void setQpno(int qpno) {
		this.qpno = qpno;
	}

	public String getQtitle() {
		return qtitle;
	}

	public void setQtitle(String qtitle) {
		this.qtitle = qtitle;
	}

	public String getQwriter() {
		return qwriter;
	}

	public void setQwriter(String qwriter) {
		this.qwriter = qwriter;
	}

	public String getQdate() {
		return qdate;
	}

	public void setQdate(String qdate) {
		this.qdate = qdate;
	}

	public String getQcontent() {
		return qcontent;
	}

	public void setQcontent(String qcontent) {
		this.qcontent = qcontent;
	}

	public String getQanswer() {
		return qanswer;
	}

	public void setQanswer(String qanswer) {
		this.qanswer = qanswer;
	}

	public int getQstatus() {
		return qstatus;
	}

	public void setQstatus(int qstatus) {
		this.qstatus = qstatus;
	}
}

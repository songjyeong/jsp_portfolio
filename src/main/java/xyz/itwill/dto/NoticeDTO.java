package xyz.itwill.dto;

public class NoticeDTO {

//	NNO      NOT NULL NUMBER(10)     
//	NTITLE            VARCHAR2(500)  
//	NDATE             DATE           
//	NCONTENT          VARCHAR2(1000) 
//	NIMG              VARCHAR2(500)
	
	private int			nno;
	private String	 	ntitle;
	private String	 	ndate;
	private String	 	ncontent;
	private String	 	nimg;
	
	public NoticeDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getNno() {
		return nno;
	}

	public void setNno(int nno) {
		this.nno = nno;
	}

	public String getNtitle() {
		return ntitle;
	}

	public void setNtitle(String ntitle) {
		this.ntitle = ntitle;
	}

	public String getNdate() {
		return ndate;
	}

	public void setNdate(String ndate) {
		this.ndate = ndate;
	}

	public String getNcontent() {
		return ncontent;
	}

	public void setNcontent(String ncontent) {
		this.ncontent = ncontent;
	}

	public String getNimg() {
		return nimg;
	}

	public void setNimg(String nimg) {
		this.nimg = nimg;
	}
	
}

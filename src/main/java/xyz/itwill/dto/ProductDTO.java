package xyz.itwill.dto;

public class ProductDTO {

//	
//	SNO       NOT NULL NUMBER(10)     
//	SNAME              VARCHAR2(1000) 
//	SIMG               VARCHAR2(1000) 
//	SINFO              VARCHAR2(1000) 
//	SAMOUNT            NUMBER(4)      
//	SPRICE             NUMBER(10)     
//	SOPTION_1          VARCHAR2(10)   
//	SOPTION_2          VARCHAR2(10)
	
	private int sno;
	private String sname;
	private String simg;
	private String sinfo;
	private int sprice;
	private String soptionFirst;
	private String soptionSecond;
	
	public ProductDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getSno() {
		return sno;
	}

	public void setSno(int sno) {
		this.sno = sno;
	}

	public String getSname() {
		return sname;
	}

	public void setSname(String sname) {
		this.sname = sname;
	}

	public String getSimg() {
		return simg;
	}

	public void setSimg(String simg) {
		this.simg = simg;
	}

	public String getSinfo() {
		return sinfo;
	}

	public void setSinfo(String sinfo) {
		this.sinfo = sinfo;
	}

	public int getSprice() {
		return sprice;
	}

	public void setSprice(int sprice) {
		this.sprice = sprice;
	}

	public String getSoptionFirst() {
		return soptionFirst;
	}

	public void setSoptionFirst(String soptionFirst) {
		this.soptionFirst = soptionFirst;
	}

	public String getSoptionSecond() {
		return soptionSecond;
	}

	public void setSoptionSecond(String soptionSecond) {
		this.soptionSecond = soptionSecond;
	}

}

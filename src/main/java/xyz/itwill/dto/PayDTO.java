package xyz.itwill.dto;

public class PayDTO {
//	이름         널?       유형            
//	---------- -------- ------------- 
//	ORD_NO     NOT NULL NUMBER(10)    
//	ORD_DATE            DATE          
//	MEM_ID              VARCHAR2(20)  
//	PRD_NO              NUMBER(10)    
//	ZIPCODE             NUMBER(10)    
//	ADDR1               VARCHAR2(100) 
//	ADDR2               VARCHAR2(100) 
//	PHONE               NUMBER(20)    
//	MESSAGE             VARCHAR2(200) 
//	QNTY                NUMBER(5)     
//	ORD_STATUS NOT NULL NUMBER(1)
	
	private int		ordNo;		
	private String	ordDate;
	private String	memID;
	private int 	prdNO;
	private String 	zipcode;//
	private String	addr1;
	private String	addr2;
	private String	phone;//
	private String	message;
	private int		qnty;
	private int		ordStatus;
	
	public PayDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getOrdNo() {
		return ordNo;
	}

	public void setOrdNo(int ordNo) {
		this.ordNo = ordNo;
	}

	public String getOrdDate() {
		return ordDate;
	}

	public void setOrdDate(String ordDate) {
		this.ordDate = ordDate;
	}

	public String getMemID() {
		return memID;
	}

	public void setMemID(String memID) {
		this.memID = memID;
	}

	public int getPrdNO() {
		return prdNO;
	}

	public void setPrdNO(int prdNO) {
		this.prdNO = prdNO;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getAddr1() {
		return addr1;
	}

	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}

	public String getAddr2() {
		return addr2;
	}

	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public int getQnty() {
		return qnty;
	}

	public void setQnty(int qnty) {
		this.qnty = qnty;
	}

	public int getOrdStatus() {
		return ordStatus;
	}

	public void setOrdStatus(int ordStatus) {
		this.ordStatus = ordStatus;
	}
	

}

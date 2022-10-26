package xyz.itwill.dto;

public class ZipDTO {
	
//	ZIPCODE    VARCHAR2(40)  
//	DONG       VARCHAR2(40)  
//	ADDRESS    VARCHAR2(266) 
	
	public String zipcode;
	public String dong;
	public String address;
	
	public ZipDTO() {
		// TODO Auto-generated constructor stub
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getDong() {
		return dong;
	}

	public void setDong(String dong) {
		this.dong = dong;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	
}

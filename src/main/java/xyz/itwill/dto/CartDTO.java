package xyz.itwill.dto;

public class CartDTO {

/*
이름      널?       유형           
------- -------- ------------ 
CART_NO NOT NULL NUMBER(10)   
MEM_ID           VARCHAR2(20) 
PRD_NO           NUMBER(10)   
QNTY             NUMBER(5)    
*/
	private int cartNo;
	private String memberID;
	private int productNo;
	private int qnty;
	
	public CartDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getCartNo() {
		return cartNo;
	}

	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}

	public String getMemberID() {
		return memberID;
	}

	public void setMemberID(String memberID) {
		this.memberID = memberID;
	}

	public int getProductNo() {
		return productNo;
	}

	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}

	public int getQnty() {
		return qnty;
	}

	public void setQnty(int qnty) {
		this.qnty = qnty;
	}
	
	
	
}

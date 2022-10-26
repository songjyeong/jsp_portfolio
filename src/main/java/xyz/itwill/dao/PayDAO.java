package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.MemberDTO;
import xyz.itwill.dto.PayDTO;

/*
이름         널?       유형            
---------- -------- ------------- 
ORD_NO     NOT NULL NUMBER(10)    
ORD_DATE            DATE          
MEM_ID              VARCHAR2(20)  
PRD_NO              NUMBER(10)    
ZIPCODE             NUMBER(10)    
ADDR1               VARCHAR2(100) 
ADDR2               VARCHAR2(100) 
PHONE               NUMBER(20)    
MESSAGE             VARCHAR2(200) 
DLVFEE              NUMBER(2)     
QNTY                NUMBER(5)     
PAYMETHOD  NOT NULL VARCHAR2(20)  
ORD_STATUS NOT NULL NUMBER(1)     
*/


public class PayDAO extends JdbcDAO {
	
	private static PayDAO _dao;
	
	private PayDAO() {
		
	}
	
	static {
		_dao = new PayDAO();
	}
	
	public static PayDAO getDAO() {
		return _dao;
	}
	
	// cart_add_action을 통해 입력된 CART 테이블의 정보를 PAY 테이블로 삽입
	public int insertPay(PayDTO pay) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con = getConnection();
			
			String sql = "insert into pay values(pay_nextval, sysdate, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, pay.getMemID());
			pstmt.setInt(2, pay.getPrdNO());
			pstmt.setString(3, pay.getZipcode());
			pstmt.setString(4, pay.getAddr1());
			pstmt.setString(5, pay.getAddr2());
			pstmt.setString(6, pay.getPhone());
			pstmt.setString(7, pay.getMessage());
			pstmt.setInt(8, pay.getQnty());
			pstmt.setInt(9, pay.getOrdStatus());
			
		
			rows = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("[에러] insertPay 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
				
	}
	
	// PayNum 1씩 증가
	public int selectNextPayNum() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		int nextNum = 0;
		
		try {
			con=getConnection();
			
			String sql = "select pay_seq.nextval from dual";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				nextNum = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNextNum 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return nextNum;
	}
	
	public List<PayDTO> selectPayMember(String member) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<PayDTO> payList=new ArrayList<PayDTO>();
		try {
			con=getConnection();
			
			String sql="select * from pay where MEM_ID=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, member);
			
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				PayDTO pay=new PayDTO();
				pay.setOrdNo(rs.getInt("ORD_NO"));
				pay.setMemID(rs.getString("MEM_ID"));
				pay.setPrdNO(rs.getInt("PRD_NO"));
				pay.setZipcode(rs.getString("ZIPCODE"));
				pay.setAddr1(rs.getString("ADDR1"));
				pay.setAddr2(rs.getString("ADDR2"));
				pay.setPhone(rs.getString("PHONE"));
				pay.setQnty(rs.getInt("QNTY"));
				pay.setOrdStatus(rs.getInt("ORD_STATUS"));	
				payList.add(pay);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectPayMember 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return payList;
	}
	
	public int cancelPay(String ordNum) {		
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update pay set ORD_STATUS=5 where ORD_NO=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, ordNum);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]cancelPay 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
}


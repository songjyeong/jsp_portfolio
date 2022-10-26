package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import xyz.itwill.dto.CartDTO;
import xyz.itwill.dto.ProductDTO;

/*
이름      널?       유형           
------- -------- ------------ 
CART_NO NOT NULL NUMBER(10)   
MEM_ID           VARCHAR2(20) 
PRD_NO           NUMBER(10)   
QNTY             NUMBER(5)    
*/

public class CartDAO extends JdbcDAO {

   private static CartDAO _dao;
   
   public CartDAO() {
      // TODO Auto-generated constructor stub
   }
   
   static {
      _dao = new CartDAO();
   }
   
   public static CartDAO getDAO() {
      return _dao;
   }

   // 
   public int selectCartCount(String MemberId) {
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      int rows = 0;

      try {
         con = getConnection();

         String sql = "select count(*) from cart where mem_id = ?";
         pstmt = con.prepareStatement(sql);
         pstmt.setString(1, MemberId);
         rs = pstmt.executeQuery();

         if (rs.next()) {
        	 rows = rs.getInt(1);
         }
      } catch (Exception e) {
         System.out.println("[에러] selectCartCount 메소드의 SQL 오류 =  " + e.getMessage());
      } finally {
         close(con, pstmt, rs);
      }
      return rows;
   }
   
   
   // 회원아이디를 입력받아 장바구니에 담겨 있는 상품의 정보를 검색하여 리스트 출력
   public List<CartDTO> selectCartMemberList(String MemberId) {
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      List<CartDTO> cartList = new ArrayList<CartDTO>();

	      try {
	         con = getConnection();

	         String sql = "select * from cart where mem_id = ?";
	         pstmt = con.prepareStatement(sql);
	         pstmt.setString(1, MemberId);
	         rs = pstmt.executeQuery();

	         while (rs.next()) {
	        	CartDTO cart = new CartDTO();
	        	cart.setCartNo(rs.getInt("CART_NO"));
	        	cart.setMemberID(rs.getString("MEM_ID"));
	        	cart.setProductNo(rs.getInt("PRD_NO"));
	        	cart.setQnty(rs.getInt("QNTY"));
	        	
	        	cartList.add(cart);
	         }
	         
	      } catch (Exception e) {
	         System.out.println("[에러] selectCartMemberList 메소드의 SQL 오류 =  " + e.getMessage());
	         
	      } finally {
	         close(con, pstmt, rs);
	      }
	      
	      return cartList;
	   }
   
   // 상품번호를 입력받아 상품 테이블의 모든 컬럼값 검색
   public int selectProductNo(int ProductNo) {
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      int rows = 0;

	      try {
	         con = getConnection();

	         String sql = "select  * from product where sno = ?";
	         pstmt = con.prepareStatement(sql);
	         pstmt.setInt(1, ProductNo);
	         rs = pstmt.executeQuery();

	         if (rs.next()) {
	        	 rows = rs.getInt(1);
	         }
	      } catch (Exception e) {
	         System.out.println("[에러] selectProductNo 메소드의 SQL 오류 =  " + e.getMessage());
	      } finally {
	         close(con, pstmt, rs);
	      }
	      return rows;
	   }
   
   // 장바구니 번호를 입력받아 해당 장바구니 테이블의 모든 컬럼값 검색
   public CartDTO selectCartNum(int CartNum) {
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      CartDTO cart =null;
	      
	      try {
	         con = getConnection();

	         String sql = "select  * from cart where cart_no = ?";
	         pstmt = con.prepareStatement(sql);
	         pstmt.setInt(1, CartNum);
	         rs = pstmt.executeQuery();

	         if (rs.next()) {
	        	 cart= new CartDTO();
	        	 
	        	 cart.setCartNo(rs.getInt("cart_no"));
	        	 cart.setProductNo(rs.getInt("prd_no"));
	        	 cart.setMemberID(rs.getString("mem_id"));
	        	 cart.setQnty(rs.getInt("qnty"));

	         }
	      } catch (Exception e) {
	         System.out.println("[에러] selectCartNum 메소드의 SQL 오류 =  " + e.getMessage());
	      } finally {
	         close(con, pstmt, rs);
	      }
	      return cart;
	   }
   
   
   
   public CartDTO selectCart(int CartNum) {
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      CartDTO cart = null;
	      
	      try {
	         con = getConnection();

	         String sql = "select  * from cart where cart_no = ?";
	         pstmt = con.prepareStatement(sql);
	         pstmt.setInt(1, CartNum);
	         rs = pstmt.executeQuery();

	         if (rs.next()) {
	        	 cart = new CartDTO();
	        	 cart.setCartNo(CartNum);
	        	 cart.setMemberID(sql);
	        	 cart.setProductNo(CartNum);
	        	 cart.setQnty(CartNum);
	         }
	      } catch (Exception e) {
	         System.out.println("[에러] selectCart 메소드의 SQL 오류 =  " + e.getMessage());
	      } finally {
	         close(con, pstmt, rs);
	      }
	      return cart;
	   }
   
   public int deleteCart(String cartno) {
	   Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="delete from cart where cart_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, cartno);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]deleteCart 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		} 
		return rows;

   }
   
}
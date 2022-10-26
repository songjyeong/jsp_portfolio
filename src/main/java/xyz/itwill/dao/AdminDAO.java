package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.PayDTO;
import xyz.itwill.dto.ProductDTO;
import xyz.itwill.dto.QnaDTO;

public class AdminDAO extends JdbcDAO{

	private static AdminDAO _dao;
	
	private AdminDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao = new AdminDAO();
	}
	
	public static AdminDAO getDAO() {
		return _dao;
	}
	
//////////////////////////////////////////////////////////////////////
/////////////////////  product ////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
	
	public List<ProductDTO> selectProductAllList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		try {
			con = getConnection();

			String sql = "select * from product order by sno";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDTO product = new ProductDTO();
				product.setSno(rs.getInt("sno"));
				product.setSname(rs.getString("sname"));
				product.setSimg(rs.getString("simg"));
				product.setSinfo(rs.getString("sinfo"));
				product.setSprice(rs.getInt("sprice"));
				product.setSoptionFirst(rs.getString("soption_1"));
				product.setSoptionSecond(rs.getString("soption_2"));
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductAllList 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;
	}
	public List<ProductDTO> selectProductMainList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		try {
			con = getConnection();

			String sql = "select * from product where soption_1 is null and soption_2 is null order by sno";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDTO product = new ProductDTO();
				product.setSno(rs.getInt("sno"));
				product.setSname(rs.getString("sname"));
				product.setSimg(rs.getString("simg"));
				product.setSinfo(rs.getString("sinfo"));
				product.setSprice(rs.getInt("sprice"));
				product.setSoptionFirst(rs.getString("soption_1"));
				product.setSoptionSecond(rs.getString("soption_2"));
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductMainList 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;
	}
	
	public List<ProductDTO> selectProductOptionList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		try {
			con = getConnection();

			String sql = "select * from product where soption_1 is not null or soption_2 is not null order by sno";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDTO product = new ProductDTO();
				product.setSno(rs.getInt("sno"));
				product.setSname(rs.getString("sname"));
				product.setSimg(rs.getString("simg"));
				product.setSinfo(rs.getString("sinfo"));
				product.setSprice(rs.getInt("sprice"));
				product.setSoptionFirst(rs.getString("soption_1"));
				product.setSoptionSecond(rs.getString("soption_2"));
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductOptionList 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;
	}
	
	public List<ProductDTO> selectProductNameList(String name) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		try {
			con = getConnection();

			String sql = "select * from product where sname=? order by sno";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDTO product = new ProductDTO();
				product.setSno(rs.getInt("sno"));
				product.setSname(rs.getString("sname"));
				product.setSimg(rs.getString("simg"));
				product.setSinfo(rs.getString("sinfo"));
				product.setSprice(rs.getInt("sprice"));
				product.setSoptionFirst(rs.getString("soption_1"));
				product.setSoptionSecond(rs.getString("soption_2"));
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductAllList 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;
	}
	
	public ProductDTO selectProduct(int sno) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProductDTO product = null;
		try {
			con = getConnection();

			String sql = "select * from product where sno=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, sno);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				product = new ProductDTO();
				product.setSno(rs.getInt("sno"));
				product.setSname(rs.getString("sname"));
				product.setSimg(rs.getString("simg"));
				product.setSinfo(rs.getString("sinfo"));
				product.setSprice(rs.getInt("sprice"));
				product.setSoptionFirst(rs.getString("soption_1"));
				product.setSoptionSecond(rs.getString("soption_2"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProduct 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return product;
	}

	
	public int updateProduct(ProductDTO product) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;

		try {
			con = getConnection();

			String sql = "update product set sname=?,simg=?,sinfo=?,sprice=?,"
					+ "soption_1=?, soption_2=? where sno=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, product.getSname());
			pstmt.setString(2, product.getSimg());
			pstmt.setString(3, product.getSinfo());
			pstmt.setInt(4, product.getSprice());
			pstmt.setString(5, product.getSoptionFirst());
			pstmt.setString(6, product.getSoptionSecond());
			pstmt.setInt(7, product.getSno());

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateProduct 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	public int insertProduct(ProductDTO product) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();

			String sql = "insert into product values(product_seq.nextval,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, product.getSname());
			pstmt.setString(2, product.getSimg());
			pstmt.setString(3, product.getSinfo());
			pstmt.setInt(4, product.getSprice());
			pstmt.setString(5, product.getSoptionFirst());
			pstmt.setString(6, product.getSoptionSecond());

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertProduct 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	public int deleteProduct(ProductDTO product) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();

			String sql = "delete from product where sno=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, product.getSno());

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]deleteProduct 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
//////////////////////////////////////////////////////////////////////
/////////////////////  pay ////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
	
	public List<PayDTO> selectPayAllList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<PayDTO> productList = new ArrayList<PayDTO>();
		try {
			con = getConnection();

			String sql = "select * from pay order by ORD_NO";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				PayDTO product = new PayDTO();
				product.setOrdNo(rs.getInt("ORD_NO"));
				product.setOrdDate(rs.getString("ORD_DATE"));
				product.setMemID(rs.getString("MEM_ID"));
				product.setPrdNO(rs.getInt("PRD_NO"));
				product.setZipcode(rs.getString("ZIPCODE"));
				product.setAddr1(rs.getString("ADDR1"));
				product.setAddr2(rs.getString("ADDR2"));
				product.setPhone(rs.getString("PHONE"));
				product.setMessage(rs.getString("MESSAGE"));
				product.setQnty(rs.getInt("QNTY"));
				product.setOrdStatus(rs.getInt("ORD_STATUS"));

				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectPayAllList 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;
	}
	
	public int updatePay(String ordNum, String status) {		
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update pay set ORD_STATUS=? where ORD_NO=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, status);
			pstmt.setString(2, ordNum);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updatePay 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

//////////////////////////////////////////////////////////////////////
/////////////////////  qna ////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
	

	public List<QnaDTO> selectQnaAllList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<QnaDTO> qnaList = new ArrayList<QnaDTO>();
		try {
			con = getConnection();

			String sql = "select * from qna order by sno";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				QnaDTO qna = new QnaDTO();

				qna.setQno(0);
				qna.setQpno(0);
				qna.setQtitle(sql);
				qna.setQwriter(sql);
				qna.setQdate(sql);
				qna.setQcontent(sql);
				qna.setQanswer(sql);
				qna.setQstatus(0);
				
				qnaList.add(qna);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductList 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return qnaList;
	}
	

}

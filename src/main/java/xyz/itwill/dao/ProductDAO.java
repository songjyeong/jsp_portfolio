package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.ProductDTO;
import xyz.itwill.dto.CartDTO;
import xyz.itwill.dto.PayDTO;

public class ProductDAO extends JdbcDAO {
	private static ProductDAO _dao;

	private ProductDAO() {
		// TODO Auto-generated constructor stub
	}

	static {
		_dao = new ProductDAO();
	}

	public static ProductDAO getDAO() {
		return _dao;
	}
	
	public int insertProductPay(PayDTO pay) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();
			
			String sql = "insert into pay values(pay_seq.nextval,sysdate,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, pay.getMemID());
			pstmt.setInt(2, pay.getPrdNO());
			pstmt.setString(3, pay.getZipcode());
			pstmt.setString(4, pay.getAddr1());
			pstmt.setString(5, pay.getAddr2());
			pstmt.setString(6, pay.getPhone());
			pstmt.setString(7, pay.getMessage());
			pstmt.setInt(8, pay.getQnty());
			pstmt.setInt(9, 0);
			
			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertProductPay 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	public ProductDTO selectProductBySoptionSname(String soption_1, String soption_2, String sname) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProductDTO product = null;
		try {
			con = getConnection();

			String sql = "select * from product where soption_1=? and soption_2=? and sname=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, soption_1);
			pstmt.setString(2, soption_2);
			pstmt.setString(3, sname);
			
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
			System.out.println("[에러]selectProductBySoptionSname 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return product;
	}
	
	public int insertProductCart(CartDTO cart) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();
			
			String sql = "insert into cart values(cart_seq.nextval,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cart.getMemberID());
			pstmt.setInt(2, cart.getProductNo());
			pstmt.setInt(3, cart.getQnty());
			
			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertProductCart 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
		
	
	public List<ProductDTO> selectNullProductList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		try {
			con = getConnection();

			String sql = "select * from product where soption_1 is null and "
					+ "soption_2 is null order by sname";
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
			System.out.println("[에러]selectProductList 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;
	}
	
	public List<ProductDTO> selectNullSearchProductList(String search) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		try {
			con = getConnection();

			String sql = "select * from product where soption_1 is null and "
					+ "soption_2 is null and sname like '%'||?||'%' order by sname";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, search);

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
			System.out.println("[에러]selectNullSearchProductList 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;
	}
	
	
	public List<String> selectProductOption1(String sname) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String option1 = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		List<String> option1List = new ArrayList<>();
		try {
			con = getConnection();

			String sql = "select distinct soption_1 from product where sname=? and soption_1 is not null";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, sname);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDTO product = new ProductDTO();
			
				product.setSoptionFirst(rs.getString("soption_1"));
				productList.add(product);
			}
			int i = 0;
			while(i < productList.size()) {
					option1 = productList.get(i).getSoptionFirst();
					option1List.add(option1);
					i++;
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductoptionList1 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return option1List;
	}
	
	public List<String> selectProductOption2(String sname) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String option2 = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		List<String> option2List = new ArrayList<>();
		try {
			con = getConnection();

			String sql = "select distinct soption_2 from product where sname=? and soption_2 is not null";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, sname);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDTO product = new ProductDTO();
			
				product.setSoptionSecond(rs.getString("soption_2"));
				System.out.println("sadfasdfs"+product.getSno());
				productList.add(product);
			}
			int i = 0;
			while(i < productList.size()) {
					option2 = productList.get(i).getSoptionSecond();
					option2List.add(option2);
					System.out.println("asdfsadf"+option2List.get(i));
					i++;
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductoptionList1 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return option2List;
	}
	
	public List<ProductDTO> selectProductList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		try {
			con = getConnection();

			String sql = "select * from product order by sname";
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
			System.out.println("[에러]selectProductList 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;
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
					+ "soptionFirst=?, soptionSecond=? where sno=?";
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
}

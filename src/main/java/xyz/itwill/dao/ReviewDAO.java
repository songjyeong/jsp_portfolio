package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.ReviewDTO;

public class ReviewDAO extends JdbcDAO{
	private static ReviewDAO _dao;

	private ReviewDAO() {
		// TODO Auto-generated constructor stub
	}

	static {
		_dao = new ReviewDAO();
	}

	public static ReviewDAO getDAO() {
		return _dao;
	}
	
	
	public int selectReviewCount (String rsearch, String rkeyword) {
		Connection con = null ;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		
		try {
			con=getConnection();
			
			if(rkeyword.equals("")) {
				String sql ="select count(*) from review";
				pstmt=con.prepareStatement(sql);
			} else {
				String sql="select count(*) from review where sno in (select sno from product "
						+ "where sname like '%'||?||'%') order by rdate desc";
				pstmt=con.prepareStatement(sql);
			
				pstmt.setString(1, rkeyword);
			
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectReviewCount 메서드의 SQL 오류 = " +e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count ;
		
	}
	
	public List<ReviewDTO> selectReviewList(int rstartRow, int rendRow, String rsearch, String rkeyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ReviewDTO> reviewList = new ArrayList<ReviewDTO>();
		
		try {
			con=getConnection();
			
			if(rkeyword.equals("")) {  // 검색 기능 사용안할 때
				// 맞는지 다시 확인
				String sql="select * from (select rownum rn, temp.* from (select * from review order by rdate desc) temp ) where rn between ? and ?";
				
				pstmt=con.prepareStatement(sql);
				
				pstmt.setInt(1, rstartRow);
				pstmt.setInt(2, rendRow);
			
			} else {
				String sql="select * from (select rownum rn, temp.* from (select * from review "
						+ "where sno in (select sno from product where sname like '%'||?||'%') order by rdate desc) temp ) where rn between ? and ? ";
				
				pstmt=con.prepareStatement(sql);
				
				pstmt.setString(1, rkeyword);
				pstmt.setInt(2, rstartRow);
				pstmt.setInt(3, rendRow);
				
			}
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ReviewDTO review = new ReviewDTO();
				review.setRno(rs.getInt("rno"));
				review.setRname(rs.getString("rname"));
				review.setRrating(rs.getInt("rrating"));
				review.setRcontent(rs.getString("rcontent"));
				review.setRdate(rs.getString("rdate"));
				review.setSno(rs.getInt("sno"));
				review.setReply(rs.getString("reply"));
				
				reviewList.add(review);
			}
			
		} catch (SQLException e) {
			System.out.println("[에러] selectReviewList 메서드의 SQL 오류 = " +e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return reviewList ;
		
	}
	
	public int insertReview(ReviewDTO review) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con = getConnection();
			
			String sql="insert into review values(review_seq.nextval,?,?,sysdate,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, review.getRname());
			pstmt.setString(2, review.getRcontent());
			pstmt.setInt(3, review.getSno());
			pstmt.setString(4, review.getReply());
			pstmt.setInt(5, review.getRrating());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertReview 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
				
	}
	
	public ReviewDTO selectReview(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ReviewDTO review=null;
		try {
			con=getConnection();
			
			String sql="select * from review where rno=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				review=new ReviewDTO();
				review.setRno(num);
				review.setRname(rs.getString("rname"));
				review.setRrating(rs.getInt("rrating"));
				review.setRcontent(rs.getString("rcontent"));
				review.setRdate(rs.getString("rdate"));
				review.setSno(rs.getInt("sno"));
				review.setReply(rs.getString("reply"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectreview 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return review;
	}
	
	public List<ReviewDTO> selectReviewBySname(String sname) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ReviewDTO review = null;
		List<ReviewDTO> reviewList = new ArrayList<ReviewDTO>();
		try {
			con=getConnection();
			
			String sql="select * from review where sno in (select sno from product where sname=?) order by rdate";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, sname);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				review=new ReviewDTO();
				review.setSno(rs.getInt("sno"));
				review.setRname(rs.getString("rname"));
				review.setRrating(rs.getInt("rrating"));
				review.setRcontent(rs.getString("rcontent"));
				review.setRdate(rs.getString("rdate"));
				review.setRno(rs.getInt("rno"));
				review.setReply(rs.getString("reply"));
				reviewList.add(review);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectreviewbysname 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return reviewList;
	}
	
	public int updateReview(ReviewDTO review) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update review set rname=?,rrating=?,rcontent=?, rdate=sysdate where rno=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, review.getRname());
			pstmt.setInt(2, review.getRrating());
			pstmt.setString(3, review.getRcontent());
			pstmt.setInt(4, review.getRno());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateReview 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;		
	}
	
	public int deleteReview(ReviewDTO review) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();

			String sql = "delete from review where rno=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, review.getRno());

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]deleteReview 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	public int selectNextNum() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int nextNum=0;
		
		try {
			con=getConnection();
			
			String sql="select review_seq.nextval from dual";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				nextNum=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNextNum 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return nextNum;
	}
}

package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.NoticeDTO;


public class NoticeDAO extends JdbcDAO{

	private static NoticeDAO _dao;
	
	private NoticeDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new NoticeDAO();
	}
	
	public static NoticeDAO getDAO() {
		return _dao;
	}
	
	public int selectNoticeCount(String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			
			if(keyword.equals("")) {//검색 기능을 사용하지 않은 경우
				String sql="select count(*) from notice";
				pstmt=con.prepareStatement(sql);				
			} else {
				String sql="select count(*) from notice where "+search+" like '%'||?||'%'";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNoticeCount 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
	public List<NoticeDTO> selectNoticeList(int startRow, int endRow, String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<NoticeDTO> noticeList=new ArrayList<NoticeDTO>();
		try {
			con=getConnection();
			
			System.out.println("search="+search);
			System.out.println("keyword="+keyword);
			
			if(keyword.equals("")) {
				String sql="select * from (select rownum rn, temp.* from "
						+ "(select * from notice order by nno) temp) "
						+ "where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else {
				String sql="select * from (select rownum rn, temp.* from "
						+ "(select * from notice where "+search
						+" like '%'||?||'%' order by nno) temp) "
						+ "where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
						
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				NoticeDTO notice=new NoticeDTO();
				
				notice.setNno(rs.getInt("NNO"));
				notice.setNtitle(rs.getString("NTITLE"));
				notice.setNdate(rs.getString("NDATE"));
				notice.setNcontent(rs.getString("NCONTENT"));
				notice.setNimg(rs.getString("nimg"));
			
				noticeList.add(notice);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNoticeList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return noticeList;
	}
	
	public int selectNextNum() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int nextNum=0;
		try {
			con=getConnection();
			
			String sql="select notice_seq.nextval from dual";
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
	
	public int insertNotice(NoticeDTO notice) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into notice values(?,?,sysdate,?,null)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, notice.getNno());
			pstmt.setString(2, notice.getNtitle());
			pstmt.setString(3, notice.getNcontent());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertNotice 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
				
	}

	public NoticeDTO selectNotice(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		NoticeDTO notice=null;
		try {
			con=getConnection();
			
			String sql="select * from notice where nno=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				notice=new NoticeDTO();
				notice.setNno(rs.getInt("nno"));
				notice.setNtitle(rs.getString("ntitle"));
				notice.setNcontent(rs.getString("ncontent"));
				notice.setNdate(rs.getString("ndate"));
				notice.setNimg(rs.getString("nimg"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNotice 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return notice;
	}
	
	public int updateNotice(NoticeDTO notice) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update notice set ntitle=?, ncontent=? where nno=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, notice.getNtitle());
			pstmt.setString(2, notice.getNcontent());
			pstmt.setInt(3, notice.getNno());
			
			rows=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("[에러]updateNotice 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	public int deleteNotice(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="delete from notice where nno=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rows=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("[에러]deleteNotice 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
}

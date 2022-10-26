package xyz.itwill.dao;

/*
// 1. 회원정보를 전달받아 MEMBER 테이블에 삽입하고, 삽입행의 개수를 반환하는 메서드
	public int insertMember(MemberDTO member) {

// 2. 아이디를 전달받아 MEMBER 테이블에 저장된 회원정보를 검색하여 반환하는 메서드
	public MemberDTO selectMember(String id) {

// 3. 회원정보를 전달받아 MEMBER 테이블에 저장된 회원정보를 변경하고, 변경행의 개수를 반환하는 메서드
	public int updateMember(MemberDTO member) {

// 4. 아이디와 상태정보를 전달받아 MEMBER 테이블에 저장된 회원의 status를 변경하고 변경행의 개수를 반환하는 메서드
	public int updateStatus(String id, int status) {

// 5. MEMBER 테이블에 저장된 모든 회원정보를 검색하여 반환하는 메서드
	public List<MemberDTO> selectMemberList() {

// 6. 아이디를 전달받아 MEMBER 테이블에 저장된 회원정보를 삭제하고, 삭제행의 개수를 반환하는 메서드
	public int deleteMember(String id) { 
 */

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.MemberDTO;

public class MemberDAO extends JdbcDAO {
	private static MemberDAO _dao;
	
	private MemberDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao = new MemberDAO();
	}
	
	public static MemberDAO getDAO() {
		return _dao;
	}
	
	
	// 1. 회원정보를 전달받아 MEMBER 테이블에 삽입하고, 삽입행의 개수를 반환하는 메서드
	public int insertMember(MemberDTO member) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		
		try {
			con=getConnection();
			
			String sql="insert into member values (?,?,?,null,null,null,?,?,1)";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPw());
			pstmt.setString(3, member.getName());
//			pstmt.setString(4, member.getZipcode());
//			pstmt.setString(5, member.getAddress1());
//			pstmt.setString(6, member.getAddress2());
			pstmt.setString(4, member.getPhone());
			pstmt.setString(5, member.getEmail());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] insertMember 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	
	// 2. 아이디를 전달받아 MEMBER 테이블에 저장된 회원정보를 검색하여 반환하는 메서드
	public MemberDTO selectMember(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		MemberDTO member=null;
		
		try {
			con=getConnection();
			
			String sql="select * from member where id=?";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				member=new MemberDTO();
				member.setId(rs.getString("id"));
				member.setPw(rs.getString("pw"));
				member.setName(rs.getString("name"));
				member.setZipcode(rs.getString("zipcode"));
				member.setAddress1(rs.getString("address1"));
				member.setAddress2(rs.getString("address2"));
				member.setPhone(rs.getString("phone"));
				member.setEmail(rs.getString("email"));
				member.setStatus(rs.getInt("status"));
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectMember 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return member;
	}

	// 3. 회원정보를 전달받아 MEMBER 테이블에 저장된 회원정보를 변경하고, 변경행의 개수를 반환하는 메서드
	public int updateMember(MemberDTO member) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		
		try {
			con=getConnection();
			
			String sql="update member set pw=?, name=?, zipcode=?, address1=?, address2=?, phone=?, email=? where id=?";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setString(1, member.getPw());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getZipcode());
			pstmt.setString(4, member.getAddress1());
			pstmt.setString(5, member.getAddress2());
			pstmt.setString(6, member.getPhone());
			pstmt.setString(7, member.getEmail());
			pstmt.setString(8, member.getId());
			
			rows=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("[에러] updateMember 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	// 4. 아이디와 상태정보를 전달받아 MEMBER 테이블에 저장된 회원의 status를 변경하고 변경행의 개수를 반환하는 메서드
	public int updateStatus(String id, int status) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		
		try {
			con=getConnection();
			
			String sql="update member set status=? where id=?";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, status);
			pstmt.setString(2, id);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] updateStatus 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	// 5. MEMBER 테이블에 저장된 모든 회원정보를 검색하여 반환하는 메서드
	public List<MemberDTO> selectMemberList() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<MemberDTO> memberList = new ArrayList<MemberDTO>();
		
		try {
			con=getConnection();
			
			String sql="select * from member order by id";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				MemberDTO member=new MemberDTO();
				member.setId(rs.getString("id"));
				member.setPw(rs.getString("pw"));
				member.setName(rs.getString("name"));
				member.setZipcode(rs.getString("zipcode"));
				member.setAddress1(rs.getString("address1"));
				member.setAddress2(rs.getString("address2"));
				member.setPhone(rs.getString("phone"));
				member.setEmail(rs.getString("email"));
				member.setStatus(rs.getInt("status"));
				memberList.add(member);
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectMemberList 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return memberList;
	}
	
	// 6. 아이디를 전달받아 MEMBER 테이블에 저장된 회원정보를 삭제하고, 삭제행의 개수를 반환하는 메서드
	public int deleteMember(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		
		try {
			con=getConnection();
			
			String sql="delete from member where id=?";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rows=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("[에러] deleteMember 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	
	//7 - 아이디 검색할 때 사용
	public MemberDTO selectidCategory(String search, String keyword, String name) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		MemberDTO member=null;
		
		try {
			con=getConnection();
			
			
			String sql="select * from member where name=? and "+search+"=?";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setString(1, name);
			pstmt.setString(2, keyword);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				member=new MemberDTO();
				member.setId(rs.getString("id"));
				member.setPw(rs.getString("pw"));
				member.setName(rs.getString("name"));
				member.setZipcode(rs.getString("zipcode"));
				member.setAddress1(rs.getString("address1"));
				member.setAddress2(rs.getString("address2"));
				member.setPhone(rs.getString("phone"));
				member.setEmail(rs.getString("email"));
				member.setStatus(rs.getInt("status"));
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectidCategory 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return member;
	}
	
	
	// 7-3. 비밀번호 검색할 때 사용
	public MemberDTO selectpwCategory(String search, String keyword, String name, String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		MemberDTO member=null;
		
		try {
			con=getConnection();
			
			
			String sql="select * from member where name=? and "+search+"=? and id=?";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setString(1, name);
			pstmt.setString(2, keyword);
			pstmt.setString(3, id);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				member=new MemberDTO();
				member.setId(rs.getString("id"));
				member.setPw(rs.getString("pw"));
				member.setName(rs.getString("name"));
				member.setZipcode(rs.getString("zipcode"));
				member.setAddress1(rs.getString("address1"));
				member.setAddress2(rs.getString("address2"));
				member.setPhone(rs.getString("phone"));
				member.setEmail(rs.getString("email"));
				member.setStatus(rs.getInt("status"));
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectpwCategory 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return member;
	}
	
	
	
	// 8. 임시 비밀번호를 전달받아, MEMBER 테이블에 저장된 회원의 pw를 변경하고, 변경행의 개수를 반환하는 메서드
	public int updatePw(String id, String pw) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		
		try {
			con=getConnection();
			
			String sql="update member set pw=? where id=?";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setString(1, pw);
			pstmt.setString(2, id);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] updatePw 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	public MemberDTO selectCategory(String search, String keyword, String name) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		MemberDTO member=null;
		
		try {
			con=getConnection();
			
			
			String sql="select * from member where name=? and "+search+"=?";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setString(1, name);
			pstmt.setString(2, keyword);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				member=new MemberDTO();
				member.setId(rs.getString("id"));
				member.setPw(rs.getString("pw"));
				member.setName(rs.getString("name"));
				member.setZipcode(rs.getString("zipcode"));
				member.setAddress1(rs.getString("address1"));
				member.setAddress2(rs.getString("address2"));
				member.setPhone(rs.getString("phone"));
				member.setEmail(rs.getString("email"));
				member.setStatus(rs.getInt("status"));
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectCategory 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return member;
	}
	
}

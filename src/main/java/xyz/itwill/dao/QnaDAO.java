package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.ProductDTO;
import xyz.itwill.dto.QnaDTO;

public class QnaDAO extends JdbcDAO {
	private static QnaDAO _dao;
	
	private QnaDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao = new QnaDAO();
	}
	
	public static QnaDAO getDAO() {
		return _dao;
	}
	
	// 1. 검색 관련 값을 전달받아 BOARD 테이블에 저장된 전체 게시글 중 검색컬럼에 검색어가 포함된
	//게시글의 갯수를 검색하여 반환하는 메소드 - 검색 기능 사용
	
	public int selectQnaCount (String search, String keyword) {
		Connection con = null ;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		
		try {
			con=getConnection();
			
			if(keyword.equals("")) { // 검색 기능을 사용하지 않은 경우
				String sql ="select count(*) from qna";
				pstmt=con.prepareStatement(sql);
			} else { // 검색 기능을 사용한 경우
				String sql="select count(*) from qna where "+search+" like '%'||?||'%' and qstatus=1 ";
				pstmt=con.prepareStatement(sql);
			
				pstmt.setString(1, keyword);
			
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectQnaCount 메서드의 SQL 오류 = " +e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count ;
		
	}
	
	
	// 2. 시작 행번호와 종료 행번호를 전달받아 BOARD 테이블에 저장된 게시글에서 시작 행번호부터
	//종료 행번호 사이에 저장된 게시글을 검색하여 반환하는 메소드 - 검색 기능 사용
	 
	public List<QnaDTO> selectQnaList(int startRow, int endRow, String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<QnaDTO> qnaList = new ArrayList<QnaDTO>();
		
		try {
			con=getConnection();
			
			if(keyword.equals("")) {  // 검색 기능 사용안할 때
				// 맞는지 다시 확인
				String sql="select * from (select rownum rn, temp.* from (select * from qna order by qno desc) temp ) where rn between ? and ? ";
				
				pstmt=con.prepareStatement(sql);
				
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			
			} else {
				String sql="select * from (select rownum rn, temp.* from (select * from qna where "+search+" like '%'||?||'%' and qstatus=1 order by qno desc) temp ) where rn between ? and ? ";
				
				pstmt=con.prepareStatement(sql);
				
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
				
			}
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				QnaDTO qna = new QnaDTO();
				qna.setQanswer(rs.getString("qanswer"));
				qna.setQcontent(rs.getString("qcontent"));
				qna.setQdate(rs.getString("qdate"));
				qna.setQno(rs.getInt("qno"));
				qna.setQpno(rs.getInt("qpno"));
				qna.setQstatus(rs.getInt("qstatus"));
				qna.setQtitle(rs.getString("qtitle"));
				qna.setQwriter(rs.getString("qwriter"));
				qnaList.add(qna);
			}
			
		} catch (SQLException e) {
			System.out.println("[에러] selectQnaList 메서드의 SQL 오류 = " +e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return qnaList ;
		
	}
	
	// 3. product가 not null 아닌 것들을 반환받아 저장
	public List<ProductDTO> selectProductnotnullList() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> productlist = new ArrayList<ProductDTO>();
		
		try {
			con=getConnection();
			
			String sql="select * from product where soption_1 is not null and soption_2 is not null";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDTO product = new ProductDTO();
				product.setSno(rs.getInt("sno"));
				product.setSname(rs.getString("sname"));
				product.setSimg(rs.getString("simg"));
				product.setSinfo(rs.getString("sinfo"));
				product.setSprice(rs.getInt("sprice"));
				product.setSoptionFirst(rs.getString("soption_1"));
				product.setSoptionSecond(rs.getString("soption_2"));
				productlist.add(product);
				
			}
			
			
		} catch (SQLException e) {
			System.out.println("[에러] selectProductnotnullList 메서드의 SQL 오류 = " +e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productlist ;
		
	}
	
	// 일반 게시글 추가, 답글X
	// 4. QNA 게시글을 전달받아 QNA테이블에 삽입하고, 삽입행의 개수를 반환하는 메서드
	public int insertQna(QnaDTO qna) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into qna values(?,?,?,?,sysdate,?,null,?)";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, qna.getQno());
			pstmt.setInt(2, qna.getQpno());
			pstmt.setString(3, qna.getQtitle());
			pstmt.setString(4, qna.getQwriter());
			pstmt.setString(5, qna.getQcontent());
			pstmt.setInt(6, qna.getQstatus());
			
			rows=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("[에러] insertQna 메서드의 SQL 오류 = " +e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows ;
	}
		
		
		
		// 5. 글번호를 전달받아 QNA 테이블에 저장된 게시글을 검색하여 반환하는 메서드
		public QnaDTO selectQna(int qno) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			QnaDTO qna=null;
			
			try {
				con=getConnection();
				
				String sql="select * from qna where qno=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, qno);
				
				rs=pstmt.executeQuery();
				
				if(rs.next()) {
					qna = new QnaDTO();
					qna.setQanswer(rs.getString("qanswer"));
					qna.setQcontent(rs.getString("qcontent"));
					qna.setQdate(rs.getString("qdate"));
					qna.setQno(rs.getInt("qno"));
					qna.setQpno(rs.getInt("qpno"));
					qna.setQstatus(rs.getInt("qstatus"));
					qna.setQtitle(rs.getString("qtitle"));
					qna.setQwriter(rs.getString("qwriter"));
				}
				
		} catch (SQLException e) {
			System.out.println("[에러] selectQna 메서드의 SQL 오류 = " +e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return qna ;
		
	}
		
		
		// 6. QNA를 전달받아 QNA 테이블에 저장된 QNA를 변경하고 변경행의 개수를 반환하는 메서드
		public int updateQna(QnaDTO qna) {
			Connection con=null;
			PreparedStatement pstmt=null;
			int rows=0 ;
			
			try {
				con=getConnection();
				
				String sql="update qna set qpno=?, qtitle=?, qcontent=?, qstatus=? where qno=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, qna.getQpno());
				pstmt.setString(2, qna.getQtitle());
				pstmt.setString(3, qna.getQcontent());
				pstmt.setInt(4, qna.getQstatus());
				pstmt.setInt(5, qna.getQno());
			
				rows=pstmt.executeUpdate();
			
			} catch (SQLException e) {
				System.out.println("[에러] updateQna 메서드의 SQL 오류 = " +e.getMessage());
			} finally {
				close(con, pstmt);
			}
			return rows ;
		}
		
		// 7. 글번호를 전달받아 QNA 테이블에 저장된 게시글의 상태를 변경하고 변경행의 개수를 반환하는 메서드
		public int updateStatus(int qno, int qstatus) {
			Connection con=null;
			PreparedStatement pstmt=null;
			int rows=0;
			try {
				con=getConnection();
				
				String sql="update qna set qstatus=? where qno=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, qstatus);
				pstmt.setInt(2, qno);
				
				rows=pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("[에러]updateStatus 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt);
			}
			return rows;		
		}
		
		// 8. QNA_SEQ 시퀀스의 다음값을 검색하여 반환하는 메서드
		public int selectNextNum() {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int nextNum=0;
			
			try {
				con=getConnection();
				
				String sql="select qna_seq.nextval from dual";
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
	
		// 9. 글번호를 전달받아 QNA 테이블에 저장된 게시글의 답변을 등록하고, 변경행의 개수를 반환하는 메서드
				public int updateQanswer(int qno, String qanswer) {
					Connection con=null;
					PreparedStatement pstmt=null;
					int rows=0;
					try {
						con=getConnection();
						
						String sql="update qna set qanswer=? where qno=?";
						pstmt=con.prepareStatement(sql);
						pstmt.setString(1, qanswer);
						pstmt.setInt(2, qno);
						
						rows=pstmt.executeUpdate();
					} catch (SQLException e) {
						System.out.println("[에러]updateQanswer 메소드의 SQL 오류 = "+e.getMessage());
					} finally {
						close(con, pstmt);
					}
					return rows;		
				}	
}

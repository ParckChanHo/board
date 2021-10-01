package model;
import java.sql.*;
import java.util.ArrayList;
import model.BoardBean;

public class BoardDAO {
	Connection conn =null;
	PreparedStatement pstmt =null;
	ResultSet rs;
	
	public void getCon() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/board";
			String dbID = "root";
			String dbPassword = "1004";
			
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 하나의 새로운 게시물이 넘어와서 저장되는 메소드입니다.
	public void insertBoard(BoardBean boardbean) {
		//폼 데이터에서 넘어오지 않은 값들이 있다. 이것들은 지금 null로 초기화가 되었기 때문에 이것들을 모두 초기화시켜
		//주어야 한다!!
		getCon();
		int ref=0; // 글 그룹을 의미한다. 쿼리를 실행시켜서 가장 큰 ref을 가져온 후 +1을 더해주여야 한다.
		int re_step=1; // 새글이라서(부모글이기 떄무에)
		int re_level=1; // 글 레벨. 글을 보여줄 순서를 의미한다.
		
		try {
			//가장 큰 ref값을 읽어오는 쿼리이다.
			//ref값을 1개 늘려주어야 다음 게시물로 인식을 하기 때문이다!!
			String refsql = "select max(ref) from board";
			pstmt = conn.prepareStatement(refsql);
			rs = pstmt.executeQuery();
			if(rs.next()) { //쿼리 결과값이 있다면
				ref = rs.getInt(1)+1; //최대값에 +1을 하여서 글 그룹에 저장을 한다.
			}
			String sql_date="SELECT NOW()";
			sql_date = sql_date.substring(0,11);
			// 2018-01-11 11:21:36  즉 현재의 날짜와 시간을 반환해준다!!
			//The date and time is returned as "YYYY-MM-DD HH-MM-SS" (string) or as YYYYMMDDHHMMSS.uuuuuu (numeric).
			//YYYY(년도)-MM(월 01~12)-DD(일) HH(시, 0시~23시 일반적인 24시간 표시임 ex)오후 2시 >>>> 14시) -MM-SS
			String sql = "insert board(writer,email,subject,password,reg_date,ref,re_step,re_level,readcount,content) values(?,?,?,?,now(),?,?,?,0,?)";
			pstmt = conn.prepareStatement(sql);
			/*
			    num int AUTO_INCREMENT, //이것은 컬럼에 집어넣지 않아도 값이 자동으로 증가가 된다. 즉 새로운 행을 삽입할 때 자동으로 생성이 되며
			    // 기본적으로 1이 증가가 된다.
				writer varchar(20),  
				email varchar(50),  
				subject varchar(20), 
				password varchar(10), 
				reg_date varchar(20), 
				ref int, 
				re_step int, 
				re_level int, 
				readcount int, //0 조회수를 의미한다.
				content varchar(2500),   
			 */		
			pstmt.setString(1, boardbean.getWriter());
			pstmt.setString(2, boardbean.getEmail());
			pstmt.setString(3, boardbean.getSubject());
			pstmt.setString(4, boardbean.getPassword());
			pstmt.setInt(5, ref); //ref = rs.getInt(1)+1;
			pstmt.setInt(6, re_step); // 새로운 게시판이므로 무조건 1이다.
			pstmt.setInt(7, re_level); // 새로운 게시판 글이므로 무조건 1이다.
			pstmt.setString(8, boardbean.getContent());
			
			pstmt.executeUpdate();
			conn.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<BoardBean> getAllBoard(int start , int end){
		//리턴할 컬렉션 객체를 선언한다.
		ArrayList<BoardBean> v = new ArrayList<BoardBean>();
		getCon();
		//asc(default)는 오름차순이다. 그리고 dec는 내림차순이다.
		// 오름차순>>>> 작은 값부터 큰 값 쪽으로 
		// 내림차순 >>> 큰 값 부터 작은 값 쪽으로
		try {
			//오라클 쿼리   String SQL = "select * from (select A.* ,Rownum Rnum from (select *from board order by ref desc ,re_stop asc)A)"
			//		+ "where Rnum >= ? and Rnum <= ?";
			
			// 서브쿼리
			/*  서브쿼리는 SELECT 문의 FROM 절에서도 사용할 수 있습니다.
				이때 서브쿼리에 의해 선택된 결과 집합은 FROM 절에서 하나의 테이블로써 사용된다.
				ex) SELECT ...
					FROM (서브쿼리) [AS] 이름 ==> AS는 생략이 가능하다.
				
				SELECT 문의 FROM 절에서 사용되는 모든 테이블에는 이름이 필요합니다.
				따라서 FROM 절에서 사용되는 서브쿼리는 위의 문법처럼 반드시 이름을 정의해야 합니다.
			  */
			
			
			
			String sql = "select * from ( select A.* , @ROWNUM:=@ROWNUM+1 Rnum " + 
					"   					from ( select *,( SELECT @ROWNUM:=0 ) R from board order by ref desc ,re_step asc,re_level asc) A) r"
						 +  " where Rnum >= ? and Rnum <= ?";
	
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,start);
			pstmt.setInt(2,end);
			
			//쿼리를 실행후 결과를 저장
			rs = pstmt.executeQuery();
			
			//데이터 개수가 몇개인지 모르기에 반복문을 사용하여서 데이터를 추출한다.
			while(rs.next()) {
				//ArrayList인 컬렉션 객체에 BoardBean이라는 각각의 게시물 객체를 담아서 반환을 해준다.
				BoardBean bean = new BoardBean();
				bean.setNum(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getString(6).substring(0,11)); 
				bean.setRef(rs.getInt(7));
				bean.setRe_step(rs.getInt(8));
				bean.setRe_level(rs.getInt(9));
				bean.setReadcount(rs.getInt(10));
				bean.setContent(rs.getString(11));
				//생성한 BoardBean(게시판)객체를 ArrayList객체에 담아서 반환해준다.
				v.add(bean);
			}
			conn.close();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return v;
		
	}
	
	// 선택한 게시물 객체를 리턴하는 메소드이다.
	public BoardBean getOneBoard(int num) {
		
		BoardBean bean = new BoardBean();
		getCon();
		
		try {
			//조회수 증가 쿼리
			String readsql = "update board set readcount = readcount+1 where num=?";
			pstmt = conn.prepareStatement(readsql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			String sql = "select * from board where num =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bean.setNum(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getString(6).substring(0,11)); 
				bean.setRef(rs.getInt(7));
				bean.setRe_step(rs.getInt(8));
				bean.setRe_level(rs.getInt(9));
				bean.setReadcount(rs.getInt(10));
				bean.setContent(rs.getString(11));
			}
			conn.close();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return bean;
	}
	//답변글이 저장되는 메소드 
	public void reWriteBoard(BoardBean bean){
		//부모의 글 그룹과 글레벨 글 스템을 읽어들임
		int ref =bean.getRef(); // 글 그룹 >>> 글 그룹은 무조건 같아야 한다. 부모 글 그룹이 1이면 자식도 1
		int re_step = bean.getRe_step(); //글 스텝 >>>> 부모 글 스텝에 +1을 해주어야 한다.
		int re_level = bean.getRe_level(); // 글 레벨  
		// 1) 같은 글 그룹에 있는 애들 중에서 부모의 글 레벨보다 큰 게시물들에게 +1을 해준다.
		// 2) 부모의 글 레벨에 +1을 해준다. 무조건. 즉 부모가 1이면 자식은 2레벨이다.
		
		getCon();
		
		try {
		/////////////////////핵심 코드 //////////////////////// 
			//부모글 보다 큰 re_level의 값을 전부 1씩 증가시켜줌 
			String  levelsql = "update board set re_level=re_level+1 where ref=? and re_level > ?";
			//쿼리 삽입 객체 선언 
			pstmt = conn.prepareStatement(levelsql);
			pstmt.setInt(1 , ref);
			pstmt.setInt(2 , re_level);
			//쿼리 실행 
			pstmt.executeUpdate();
			//답변글 데이터를 저장
			String sql = "insert board(writer,email,subject,password,reg_date,ref,re_step,re_level,readcount,content) values(?,?,?,?,now(),?,?,?,0,?)";
			pstmt = conn.prepareStatement(sql);
			//?에 값을 대입
			pstmt.setString(1, bean.getWriter());
			pstmt.setString(2, bean.getEmail());
			pstmt.setString(3, bean.getSubject());
			pstmt.setString(4, bean.getPassword());
			pstmt.setInt(5, ref);//부모의 ref 값을 넣어줌 
			pstmt.setInt(6, re_step+1);//답글이기에 부모글 re_stop에 1을 넣어줌 
			pstmt.setInt(7, re_level + 1); // 2) 부모의 글 레벨에 +1을 해준다. 무조건. 즉 부모가 1이면 자식은 2레벨이다.
			pstmt.setString(8, bean.getContent());
			
			//쿼리를 실행하시오
			pstmt.executeUpdate();	
			conn.close();
				
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//BoardUpdate.jsp,BoardDeleteForm.jsp에서 사용할   하나의 게시글을 리턴하는 메소드이다.
	//getOneBoard() 메소드는 조회수를 증가시켜주는 쿼리가 있어서 따로 하나 만든다.!!!!!
	public BoardBean getOneUpdateBoard(int num) {
		
		BoardBean bean = new BoardBean();
		getCon();
		
		try {
			String sql = "select * from board where num =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bean.setNum(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getString(6).substring(0,11)); 
				bean.setRef(rs.getInt(7));
				bean.setRe_step(rs.getInt(8));
				bean.setRe_level(rs.getInt(9));
				bean.setReadcount(rs.getInt(10));
				bean.setContent(rs.getString(11));
			}
			conn.close();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return bean;
	}
	
	//update와 delete때 사용한다. 이 때 필요한 패스워드 값을 리턴해주는 메소드이다.
	public String getPass(int num) {
		String pass="";
		getCon();
		
		try {
			String sql="select password from board where num=?";
			//쿼리 실행할 객체를 선언한다.
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { //select문을 실행한 결과 값이 있다면....
				pass= rs.getString(1);
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return pass;
	}
	
	//하나의 게시글을 수정하는 메소드이다.
	public void updateBoard(BoardBean bean) {
		getCon();
		
		try {
			//쿼리 준비
			String sql = "update board set subject=?, content=? where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bean.getSubject()); // 즉 글 제목괴 글 내용만 수정을 시켜준다!!
			pstmt.setString(2,bean.getContent());
			pstmt.setInt(3, bean.getNum());
			
			pstmt.executeUpdate();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 하나의 게시물을 삭제하는 메소드이다.
	public void deleteBoard(int num) {
		getCon();
		
		try {
			//쿼리 준비
			String sql = "delete from board where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num); // 즉 글 제목괴 글 내용만 수정을 시켜준다!!
			
			pstmt.executeUpdate();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//전체 글의 갯수를 리턴하는 메소드!!!
	public int getAllCount() {
		getCon();
		//게시글 전체 수를 저장하는 변수 선언
		int count = 0;
		
		try {
			String sql = "select count(*) from board";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1); //전체 게시글의 수를 의미한다.
			}
			conn.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
		return count;
	}
}

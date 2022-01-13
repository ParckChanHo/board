package kr.co.softcampus.Sample;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class OracleConnection {
	/*public static String driver = "oracle.jdbc.OracleDriver";
	public static String url = "jdbc:oracle:thin:@localhost:1521:orcl"; // 나의 오라클 주소
	public static String id = "Scott";
	public static String pw = "1234";
	*/
	
	public static void main(String[] args) {
		/*try {
			// JDBC 드라이버 로딩하기
			Class.forName(driver);
			// 접속하기
			Connection db = DriverManager.getConnection(url,id,pw);
			System.out.println("오라클 연결 성공");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		
		// select
        System.out.println("-- before insert --");
		select_sql();
		
		// insert
		insert_sql();
        System.out.println("-- after insert --");
        select_sql();
        
		// update
		// update_sql();
		System.out.println("-- after update --");
		select_sql();
        
		// delete
		delete_sql();
		System.out.println("-- after delete --");
		select_sql();
		
	} // end main()
	
	public static Connection getConnection() {
		Connection conn = null;
		String url = "jdbc:oracle:thin:@localhost:1521:orcl"; // 나의 오라클 주소
		String id = "Scott";
		String pw = "1234";
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, id, pw);
			System.out.println("오라클 연결 성공");
			
			return conn;
		} catch (Exception e) {
			System.out.println("DBUtil.getConnection() : " + e.toString());
		}
		return null;
	}
	
	// select문
	public static void select_sql() {
		PreparedStatement pstmt =null;
		ResultSet rs;
		Connection conn = getConnection();
		String sql = "select * from jdbc_table";
		try {
			pstmt = conn.prepareStatement(sql);
			//쿼리를 실행후 결과를 저장
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int int_data = rs.getInt("INT_DATA");
				String str_data = rs.getString("STR_DATA");
				System.out.printf("int_data: %d\n", int_data);
				System.out.printf("str_data: %s\n", str_data);
				System.out.println("---------------------------------");
			}
			conn.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
	
	// insert문
	public static void insert_sql() {
		PreparedStatement pstmt =null;
		Connection conn = getConnection();
		String sql = "insert into jdbc_table values(?,?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, 500);	
			pstmt.setString(2, "문자열 500");
			
			pstmt.executeUpdate();
			conn.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
	
	// update
	public static void update_sql() {
		PreparedStatement pstmt =null;
		Connection conn = getConnection();
		String sql = "update jdbc_table set str_data = ? where int_data = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "문자열 수정");
			pstmt.setInt(2, 200);	
			
			pstmt.executeUpdate();
			conn.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
	
	// delete
	public static void delete_sql() {
		PreparedStatement pstmt =null;
		Connection conn = getConnection();
		String sql = "delete from jdbc_table where int_data = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, 2);	
			
			pstmt.executeUpdate();
			conn.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
		
} // end class OracleConnection

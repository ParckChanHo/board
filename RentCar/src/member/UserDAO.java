package member;
import member.User;
import java.sql.*;
public class UserDAO {
	
	Connection conn =null;
	PreparedStatement pstmt =null;
	ResultSet rs;
	
	public void getCon() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/RentcarJoin";
			String dbID = "root";
			String dbPassword = "1004";
			
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 하나의 사용자를 입력받을 수 있도록
	public int join(User User) {
		getCon();
		String sql = "insert into rentcarjoin(id,password,email) values(?,?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,User.getUserId());
			pstmt.setString(2,User.getUserPassword());
			pstmt.setString(3,User.getUserEmail());
			return pstmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int getMember(String id,String password) {
		getCon();
		String sql = "select password from rentcarjoin where id=?"; //일단 where절에서 패스워드를 찾았다는 것은 해당 아이디가 존재한다는 뜻!!
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();//rs에는 userPassword라는 1나의 필드밖에 없을 것이다.!!!
			// rs >>>> '123456'
			if(rs.next()) { //아이디가 존재하는 경우
				if(rs.getString(1).equals(password))//비밀번호가 일치함!!!
					return 1; //로그인 성공
				else
					return 0; //비밀번호 불일치
			}
			else
				return -1; //아이디가 없음!!!!
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류!!
	}
	
}

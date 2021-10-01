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
	
	// �ϳ��� ����ڸ� �Է¹��� �� �ֵ���
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
		String sql = "select password from rentcarjoin where id=?"; //�ϴ� where������ �н����带 ã�Ҵٴ� ���� �ش� ���̵� �����Ѵٴ� ��!!
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();//rs���� userPassword��� 1���� �ʵ�ۿ� ���� ���̴�.!!!
			// rs >>>> '123456'
			if(rs.next()) { //���̵� �����ϴ� ���
				if(rs.getString(1).equals(password))//��й�ȣ�� ��ġ��!!!
					return 1; //�α��� ����
				else
					return 0; //��й�ȣ ����ġ
			}
			else
				return -1; //���̵� ����!!!!
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // �����ͺ��̽� ����!!
	}
	
}

package user;
import java.sql.*;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			String dbID = "root";
			String dbPassword = "1004";
			
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// return�� �Ǹ� ������ �Լ��� ���ᰡ �ȴ�!!!!
	public int login(String userID, String userPassword) {
		String sql = "select userPassword from user where userID=?"; //�ϴ� where������ �н����带 ã�Ҵٴ� ���� �ش� ���̵� �����Ѵٴ� ��!!
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setNString(1, userID);
			rs = pstmt.executeQuery();//rs���� userPassword��� 1���� �ʵ�ۿ� ���� ���̴�.!!!
			// rs >>>> '123456'
			if(rs.next()) { //���̵� �����ϴ� ���
				if(rs.getString(1).equals(userPassword))//��й�ȣ�� ��ġ��!!!
					return 1; //�α��� ����
				else
					return 0; //��й�ȣ ����ġ
			}
			else
				return -1; //���̵� ����!!!!
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return -2; // �����ͺ��̽� ����!!
	}
	
	// �ϳ��� ����ڸ� �Է¹��� �� �ֵ���
	public int join(User user) {
		String sql = "insert into user(userID,userPassword,userName,userGender,userEmail) values(?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,user.getUserID());
			pstmt.setString(2,user.getUserPassword());
			pstmt.setString(3,user.getUserName());
			pstmt.setString(4,user.getUserGender());
			pstmt.setString(5,user.getUserEmail());
			return pstmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	public void finish() throws SQLException {
		if(pstmt!=null)
			pstmt.close();
		if(conn!=null)
			conn.close();
	}
}

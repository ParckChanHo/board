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
	
	// �ϳ��� ���ο� �Խù��� �Ѿ�ͼ� ����Ǵ� �޼ҵ��Դϴ�.
	public void insertBoard(BoardBean boardbean) {
		//�� �����Ϳ��� �Ѿ���� ���� ������ �ִ�. �̰͵��� ���� null�� �ʱ�ȭ�� �Ǿ��� ������ �̰͵��� ��� �ʱ�ȭ����
		//�־�� �Ѵ�!!
		getCon();
		int ref=0; // �� �׷��� �ǹ��Ѵ�. ������ ������Ѽ� ���� ū ref�� ������ �� +1�� �����ֿ��� �Ѵ�.
		int re_step=1; // �����̶�(�θ���̱� ������)
		int re_level=1; // �� ����. ���� ������ ������ �ǹ��Ѵ�.
		
		try {
			//���� ū ref���� �о���� �����̴�.
			//ref���� 1�� �÷��־�� ���� �Խù��� �ν��� �ϱ� �����̴�!!
			String refsql = "select max(ref) from board";
			pstmt = conn.prepareStatement(refsql);
			rs = pstmt.executeQuery();
			if(rs.next()) { //���� ������� �ִٸ�
				ref = rs.getInt(1)+1; //�ִ밪�� +1�� �Ͽ��� �� �׷쿡 ������ �Ѵ�.
			}
			String sql_date="SELECT NOW()";
			sql_date = sql_date.substring(0,11);
			// 2018-01-11 11:21:36  �� ������ ��¥�� �ð��� ��ȯ���ش�!!
			//The date and time is returned as "YYYY-MM-DD HH-MM-SS" (string) or as YYYYMMDDHHMMSS.uuuuuu (numeric).
			//YYYY(�⵵)-MM(�� 01~12)-DD(��) HH(��, 0��~23�� �Ϲ����� 24�ð� ǥ���� ex)���� 2�� >>>> 14��) -MM-SS
			String sql = "insert board(writer,email,subject,password,reg_date,ref,re_step,re_level,readcount,content) values(?,?,?,?,now(),?,?,?,0,?)";
			pstmt = conn.prepareStatement(sql);
			/*
			    num int AUTO_INCREMENT, //�̰��� �÷��� ������� �ʾƵ� ���� �ڵ����� ������ �ȴ�. �� ���ο� ���� ������ �� �ڵ����� ������ �Ǹ�
			    // �⺻������ 1�� ������ �ȴ�.
				writer varchar(20),  
				email varchar(50),  
				subject varchar(20), 
				password varchar(10), 
				reg_date varchar(20), 
				ref int, 
				re_step int, 
				re_level int, 
				readcount int, //0 ��ȸ���� �ǹ��Ѵ�.
				content varchar(2500),   
			 */		
			pstmt.setString(1, boardbean.getWriter());
			pstmt.setString(2, boardbean.getEmail());
			pstmt.setString(3, boardbean.getSubject());
			pstmt.setString(4, boardbean.getPassword());
			pstmt.setInt(5, ref); //ref = rs.getInt(1)+1;
			pstmt.setInt(6, re_step); // ���ο� �Խ����̹Ƿ� ������ 1�̴�.
			pstmt.setInt(7, re_level); // ���ο� �Խ��� ���̹Ƿ� ������ 1�̴�.
			pstmt.setString(8, boardbean.getContent());
			
			pstmt.executeUpdate();
			conn.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<BoardBean> getAllBoard(int start , int end){
		//������ �÷��� ��ü�� �����Ѵ�.
		ArrayList<BoardBean> v = new ArrayList<BoardBean>();
		getCon();
		//asc(default)�� ���������̴�. �׸��� dec�� ���������̴�.
		// ��������>>>> ���� ������ ū �� ������ 
		// �������� >>> ū �� ���� ���� �� ������
		try {
			//����Ŭ ����   String SQL = "select * from (select A.* ,Rownum Rnum from (select *from board order by ref desc ,re_stop asc)A)"
			//		+ "where Rnum >= ? and Rnum <= ?";
			
			// ��������
			/*  ���������� SELECT ���� FROM �������� ����� �� �ֽ��ϴ�.
				�̶� ���������� ���� ���õ� ��� ������ FROM ������ �ϳ��� ���̺�ν� ���ȴ�.
				ex) SELECT ...
					FROM (��������) [AS] �̸� ==> AS�� ������ �����ϴ�.
				
				SELECT ���� FROM ������ ���Ǵ� ��� ���̺��� �̸��� �ʿ��մϴ�.
				���� FROM ������ ���Ǵ� ���������� ���� ����ó�� �ݵ�� �̸��� �����ؾ� �մϴ�.
			  */
			
			
			
			String sql = "select * from ( select A.* , @ROWNUM:=@ROWNUM+1 Rnum " + 
					"   					from ( select *,( SELECT @ROWNUM:=0 ) R from board order by ref desc ,re_step asc,re_level asc) A) r"
						 +  " where Rnum >= ? and Rnum <= ?";
	
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,start);
			pstmt.setInt(2,end);
			
			//������ ������ ����� ����
			rs = pstmt.executeQuery();
			
			//������ ������ ����� �𸣱⿡ �ݺ����� ����Ͽ��� �����͸� �����Ѵ�.
			while(rs.next()) {
				//ArrayList�� �÷��� ��ü�� BoardBean�̶�� ������ �Խù� ��ü�� ��Ƽ� ��ȯ�� ���ش�.
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
				//������ BoardBean(�Խ���)��ü�� ArrayList��ü�� ��Ƽ� ��ȯ���ش�.
				v.add(bean);
			}
			conn.close();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return v;
		
	}
	
	// ������ �Խù� ��ü�� �����ϴ� �޼ҵ��̴�.
	public BoardBean getOneBoard(int num) {
		
		BoardBean bean = new BoardBean();
		getCon();
		
		try {
			//��ȸ�� ���� ����
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
	//�亯���� ����Ǵ� �޼ҵ� 
	public void reWriteBoard(BoardBean bean){
		//�θ��� �� �׷�� �۷��� �� ������ �о����
		int ref =bean.getRef(); // �� �׷� >>> �� �׷��� ������ ���ƾ� �Ѵ�. �θ� �� �׷��� 1�̸� �ڽĵ� 1
		int re_step = bean.getRe_step(); //�� ���� >>>> �θ� �� ���ܿ� +1�� ���־�� �Ѵ�.
		int re_level = bean.getRe_level(); // �� ����  
		// 1) ���� �� �׷쿡 �ִ� �ֵ� �߿��� �θ��� �� �������� ū �Խù��鿡�� +1�� ���ش�.
		// 2) �θ��� �� ������ +1�� ���ش�. ������. �� �θ� 1�̸� �ڽ��� 2�����̴�.
		
		getCon();
		
		try {
		/////////////////////�ٽ� �ڵ� //////////////////////// 
			//�θ�� ���� ū re_level�� ���� ���� 1�� ���������� 
			String  levelsql = "update board set re_level=re_level+1 where ref=? and re_level > ?";
			//���� ���� ��ü ���� 
			pstmt = conn.prepareStatement(levelsql);
			pstmt.setInt(1 , ref);
			pstmt.setInt(2 , re_level);
			//���� ���� 
			pstmt.executeUpdate();
			//�亯�� �����͸� ����
			String sql = "insert board(writer,email,subject,password,reg_date,ref,re_step,re_level,readcount,content) values(?,?,?,?,now(),?,?,?,0,?)";
			pstmt = conn.prepareStatement(sql);
			//?�� ���� ����
			pstmt.setString(1, bean.getWriter());
			pstmt.setString(2, bean.getEmail());
			pstmt.setString(3, bean.getSubject());
			pstmt.setString(4, bean.getPassword());
			pstmt.setInt(5, ref);//�θ��� ref ���� �־��� 
			pstmt.setInt(6, re_step+1);//����̱⿡ �θ�� re_stop�� 1�� �־��� 
			pstmt.setInt(7, re_level + 1); // 2) �θ��� �� ������ +1�� ���ش�. ������. �� �θ� 1�̸� �ڽ��� 2�����̴�.
			pstmt.setString(8, bean.getContent());
			
			//������ �����Ͻÿ�
			pstmt.executeUpdate();	
			conn.close();
				
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//BoardUpdate.jsp,BoardDeleteForm.jsp���� �����   �ϳ��� �Խñ��� �����ϴ� �޼ҵ��̴�.
	//getOneBoard() �޼ҵ�� ��ȸ���� ���������ִ� ������ �־ ���� �ϳ� �����.!!!!!
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
	
	//update�� delete�� ����Ѵ�. �� �� �ʿ��� �н����� ���� �������ִ� �޼ҵ��̴�.
	public String getPass(int num) {
		String pass="";
		getCon();
		
		try {
			String sql="select password from board where num=?";
			//���� ������ ��ü�� �����Ѵ�.
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { //select���� ������ ��� ���� �ִٸ�....
				pass= rs.getString(1);
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return pass;
	}
	
	//�ϳ��� �Խñ��� �����ϴ� �޼ҵ��̴�.
	public void updateBoard(BoardBean bean) {
		getCon();
		
		try {
			//���� �غ�
			String sql = "update board set subject=?, content=? where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bean.getSubject()); // �� �� ���� �� ���븸 ������ �����ش�!!
			pstmt.setString(2,bean.getContent());
			pstmt.setInt(3, bean.getNum());
			
			pstmt.executeUpdate();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// �ϳ��� �Խù��� �����ϴ� �޼ҵ��̴�.
	public void deleteBoard(int num) {
		getCon();
		
		try {
			//���� �غ�
			String sql = "delete from board where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num); // �� �� ���� �� ���븸 ������ �����ش�!!
			
			pstmt.executeUpdate();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//��ü ���� ������ �����ϴ� �޼ҵ�!!!
	public int getAllCount() {
		getCon();
		//�Խñ� ��ü ���� �����ϴ� ���� ����
		int count = 0;
		
		try {
			String sql = "select count(*) from board";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1); //��ü �Խñ��� ���� �ǹ��Ѵ�.
			}
			conn.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
		return count;
	}
}

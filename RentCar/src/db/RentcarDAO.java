package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class RentcarDAO {
	
	Connection conn =null;
	PreparedStatement pstmt =null;
	ResultSet rs;
	
	
	public void getCon() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/Rentcar";
			String dbID = "root";
			String dbPassword = "1004";
			
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/*public void getCon_CarReserve() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/CarReserve";
			String dbID = "root";
			String dbPassword = "1004";
			
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}*/
	
	// �ֽż����� 3���� �ڵ����� �������ִ� �޼ҵ��̴�.
	public ArrayList<CarListBean> getSelectCar(){
		ArrayList<CarListBean> v = new ArrayList<CarListBean>();
		getCon();
		
		try {
			String sql = "select * from rentcar order by no desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			int count = 0;
			while(rs.next()) {
				CarListBean bean = new CarListBean();
				bean.setNo(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setCategory(rs.getInt(3));
				bean.setPrice(rs.getInt(4));
				bean.setUsepeople(rs.getInt(5));
				bean.setCompany(rs.getString(6));
				bean.setImg(rs.getString(7));
				bean.setInfo(rs.getString(8));
				
				v.add(bean);
				count++;
				if(count>=3)break; // �ֽż� 3���� �ڵ����� ����ǰ� �ϱ� ���ؼ��̴�.
			}
			conn.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	
	// ī�װ����� �ڵ��� ����Ʈ�� �����ϴ� �޼ҵ��̴�. ������, ������, ������ ����....
	public ArrayList<CarListBean> getCategoryCar(int category){
		ArrayList<CarListBean> v = new ArrayList<CarListBean>();
		getCon();
		//ī�װ� ���� ��ȯ�� �ڵ����� �����Ų��.
		CarListBean bean = null;
		
		try {
			String sql = "select * from rentcar where category=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, category);
			rs = pstmt.executeQuery();
			
			//�ݺ����� ���鼭 �����͸� �����Ѵ�.
			while(rs.next()) {
				bean = new CarListBean();
				bean.setNo(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setCategory(rs.getInt(3));
				bean.setPrice(rs.getInt(4));
				bean.setUsepeople(rs.getInt(5));
				bean.setCompany(rs.getString(6));
				bean.setImg(rs.getString(7));
				bean.setInfo(rs.getString(8));
				
				v.add(bean);
			}
			conn.close();	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	
	//��� ������ �˻��ϴ� �޼ҵ��̴�.
	public ArrayList<CarListBean> getAllCar(){
		ArrayList<CarListBean> v = new ArrayList<CarListBean>();
		getCon();
		//ī�װ� ���� ��ȯ�� �ڵ����� �����Ų��.
		CarListBean bean = null;
		
		try {
			String sql = "select * from rentcar";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			//�ݺ����� ���鼭 �����͸� �����Ѵ�.
			while(rs.next()) {
				bean = new CarListBean();
				bean.setNo(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setCategory(rs.getInt(3));
				bean.setPrice(rs.getInt(4));
				bean.setUsepeople(rs.getInt(5));
				bean.setCompany(rs.getString(6));
				bean.setImg(rs.getString(7));
				bean.setInfo(rs.getString(8));
				
				v.add(bean);
			}
			conn.close();	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	
	//�ϳ��� �ڵ��� ������ �����ϴ� �޼ҵ��̴�.
	public CarListBean getOneCar(int no) { //�������� �� �ҹ��ڸ� �������� �ʴ´�.
		//����Ÿ���� �����Ѵ�.
		CarListBean bean = new CarListBean();
		getCon();
		
		try {
			String sql = "select * from rentcar where no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			//select�� ����� ���Ϲ޴´�.
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bean.setNo(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setCategory(rs.getInt(3));
				bean.setPrice(rs.getInt(4));
				bean.setUsepeople(rs.getInt(5));
				bean.setCompany(rs.getString(6));
				bean.setImg(rs.getString(7));
				bean.setInfo(rs.getString(8));
			}
			conn.close();	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bean;
	}
	
	//�ϳ��� �ڵ����� �����ϴ� �޼ҵ��̴�.
	public void setReserveCar(CarReserveBean rbean) {
		getCon();
		
		try {
			String sql = "insert into CarReserve(id,no,qty,dday,rday,userin,userwifi,userseat,usernavi) values(?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,rbean.getId());
			pstmt.setInt(2, rbean.getNo());
			pstmt.setInt(3, rbean.getQty());
			pstmt.setInt(4, rbean.getDday());
			pstmt.setString(5,rbean.getRday());
			pstmt.setInt(6, rbean.getUsein());
			pstmt.setInt(7, rbean.getUsewifi());
			pstmt.setInt(8, rbean.getUseseat());
			pstmt.setInt(9, rbean.getUsenavi());
			pstmt.executeUpdate();
			
			carReserveNoReArrange();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//������ �ڵ����� ������ �����ϴ� �޼ҵ��̴�.
	public void UpdateReserveCar(CarReserveBean rbean,String reseveno) {
		getCon();
		
		try {
			String sql = "Update CarReserve set id=? no=? qty=? dday=? rday=? userin=? userswifi=? userseat=? usernavi=? where reseveno=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,rbean.getId());
			pstmt.setInt(2, rbean.getNo());
			pstmt.setInt(3, rbean.getQty());
			pstmt.setInt(4, rbean.getDday());
			pstmt.setString(5,rbean.getRday());
			pstmt.setInt(6, rbean.getUsein());
			pstmt.setInt(7, rbean.getUsewifi());
			pstmt.setInt(8, rbean.getUseseat());
			pstmt.setInt(9, rbean.getUsenavi());
			pstmt.setString(10,reseveno);
			pstmt.executeUpdate();
			
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//�α��� �Ǿ��ִ� ���̵� ������ �������� ��ȯ�Ѵ�.!!!!
	public ArrayList<CarViewBean> getAllReserve(String id){//count ==1
		ArrayList<CarViewBean> v =new ArrayList<>();
		CarViewBean bean = null;
		
		getCon();
		
		try {
			String sql = "select * from rentcar , CarReserve " + 
						 " where rentcar.no = CarReserve.no  " + 
						 " and date (now()) < str_to_date(rday,' %Y - %m - %d')" + 
						 " and id= ? "; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				bean = new CarViewBean();
				bean.setNum(rs.getInt(9));//CarReseve ���̺��� ReserveNo�̴�. >>>> 9��
    			bean.setName(rs.getString(2));
    			bean.setPrice(rs.getInt(4));
    			bean.setImg(rs.getString(7));
    			bean.setQty(rs.getInt(12));
    			bean.setDday(rs.getInt(13));
    			bean.setRday(rs.getString(14));
    			bean.setUsein(rs.getInt(15));
    			bean.setUsewifi(rs.getInt(16));
    			bean.setUsenavi(rs.getInt(17));
    			bean.setUseseat(rs.getInt(18));
    			//���Ϳ� �� Ŭ������ ����
    			v.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return v;
	}	
	
	// ������ ������ ��ȯ�ϴ� �޼ҵ��̴�.
	public CarReserveBean SelectOne(int ReserveNO) {
		CarReserveBean bean = new CarReserveBean();
		getCon();
		
		try {
			String sql = "select * from carReserve where ReserveNO=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ReserveNO);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				bean.setReserveno(rs.getInt(1));
				bean.setNo(rs.getInt(2));
				bean.setId(rs.getString(3));
				bean.setQty(rs.getInt(4));
				bean.setDday(rs.getInt(5));
				bean.setRday(rs.getString(6));
				bean.setUsein(rs.getInt(7));
				bean.setUsewifi(rs.getInt(8));
				bean.setUseseat(rs.getInt(9));
				bean.setUsenavi(rs.getInt(10));
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bean;
	}
	
	
	
	
	//���� ������ �����ϴ� �޼ҵ��̴�.
	public void carReserveRemove(int num) {
		getCon();
		
		try {
			String sql = "delete from carReserve where ReserveNO=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			conn.close();
			carReserveNoReArrange();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// ���� ReserveNO�� 1���� �������ϰ� ���� �ε��� ����[������ ���ȣ + 1]�� ���ϴ� ��ɾ��̴�.
	public void carReserveNoReArrange() {
		getCon();
		//"update CarReserve set reserveno = @recount :=@recount+1"
		try {
			String sql = "set @recount = 0;"; 
			pstmt = conn.prepareStatement(sql);
			
			pstmt.executeUpdate();
			
			String sql1 = "update CarReserve set reserveno = @recount :=@recount+1";
			pstmt = conn.prepareStatement(sql1);
			
			pstmt.executeUpdate();
			conn.close();
		}catch (Exception e) {
			e.printStackTrace();
		}	
	}
	
}

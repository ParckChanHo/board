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
	
	// 최신순으로 3대의 자동차를 리턴해주는 메소드이다.
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
				if(count>=3)break; // 최신순 3개의 자동차만 저장되게 하기 위해서이다.
			}
			conn.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	
	// 카테고리별로 자동차 리스트를 저장하는 메소드이다. 소형차, 중형차, 대형차 별로....
	public ArrayList<CarListBean> getCategoryCar(int category){
		ArrayList<CarListBean> v = new ArrayList<CarListBean>();
		getCon();
		//카테고리 별로 반환될 자동차를 저장시킨다.
		CarListBean bean = null;
		
		try {
			String sql = "select * from rentcar where category=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, category);
			rs = pstmt.executeQuery();
			
			//반복문을 돌면서 데이터를 저장한다.
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
	
	//모든 차량을 검색하는 메소드이다.
	public ArrayList<CarListBean> getAllCar(){
		ArrayList<CarListBean> v = new ArrayList<CarListBean>();
		getCon();
		//카테고리 별로 반환될 자동차를 저장시킨다.
		CarListBean bean = null;
		
		try {
			String sql = "select * from rentcar";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			//반복문을 돌면서 데이터를 저장한다.
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
	
	//하나의 자동차 정보를 리턴하는 메소드이다.
	public CarListBean getOneCar(int no) { //쿼리문은 대 소문자를 구분하지 않는다.
		//리턴타입을 선언한다.
		CarListBean bean = new CarListBean();
		getCon();
		
		try {
			String sql = "select * from rentcar where no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			//select문 결과를 리턴받는다.
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
	
	//하나의 자동차를 저장하는 메소드이다.
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
	
	//예약한 자동차의 정보를 수정하는 메소드이다.
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
	
	//로그인 되어있는 아이디가 예약한 차량들을 반환한다.!!!!
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
				bean.setNum(rs.getInt(9));//CarReseve 테이블의 ReserveNo이다. >>>> 9번
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
    			//벡터에 빈 클래스를 저장
    			v.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return v;
	}	
	
	// 선택한 차량을 반환하는 메소드이다.
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
	
	
	
	
	//차량 예약을 삭제하는 메소드이다.
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
	
	// 현재 ReserveNO을 1부터 재조정하고 다음 인덱스 값을[마지막 행번호 + 1]로 정하는 명령어이다.
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

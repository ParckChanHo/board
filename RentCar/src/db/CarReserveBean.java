package db;

public class CarReserveBean {
	
	private int reserveno; // 예약번호
	private String id; //아이디
	private int no; //차량 번호
	private int qty; //빌리는 차량의 수
	private int dday; //차를 빌리는 대여기간
	private String rday; // 차를 빌린 날짜
	private int usein; //보험 적용
	private int usewifi; // wifi를 옵션으로 선택하는지 여부
	private int useseat; // 베이비시트를 옵션으로 선택했는지 여부
	private int usenavi; // 네비게이샨을 옵션으로 선택하는지 여부
	
	public int getReserveno() {
		return reserveno;
	}
	public void setReserveno(int reserveno) {
		this.reserveno = reserveno;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public int getDday() {
		return dday;
	}
	public void setDday(int dday) {
		this.dday = dday;
	}
	public String getRday() {
		return rday;
	}
	public void setRday(String rday) {
		this.rday = rday;
	}
	public int getUsein() {
		return usein;
	}
	public void setUsein(int usein) {
		this.usein = usein;
	}
	public int getUsewifi() {
		return usewifi;
	}
	public void setUsewifi(int usewifi) {
		this.usewifi = usewifi;
	}
	public int getUseseat() {
		return useseat;
	}
	public void setUseseat(int useseat) {
		this.useseat = useseat;
	}
	public int getUsenavi() {
		return usenavi;
	}
	public void setUsenavi(int usenavi) {
		this.usenavi = usenavi;
	}
	
}

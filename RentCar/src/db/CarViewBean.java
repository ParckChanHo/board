package db;

public class CarViewBean { //예약확인
	
	private int num; // 게시물 번호 , CarReserve에 ReserveNO에 해당한다.
	private String name; // 자동차 이름
	private int price; // 자동차 가격
	private String img; // 자동차 이미지
	private int qty; //빌리는 차량의 수 
	private int dday; //차를 빌리는 대여기간
	private String rday; // 차를 빌린 날짜
	private int usein; //보험 적용 여부
	private int usewifi; // wifi를 옵션으로 선택하는지 여부
	private int useseat; // 베이비시트를 옵션으로 선택했는지 여부
	private int usenavi; // 네비게이샨을 옵션으로 선택하는지 여부
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
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

package db;

public class CarListBean {
	private int no;	//자동차 식별자
	private String name; // 자동차 이름
	private int category; // 자동차 구분  소형차>> 1  중형차 >> 2   대형차 >> 3
	private int price; // 자동차 가격
	private int usepeople; // 자동차 사용 가능한 인원
	private String company; //자동차 회사
	private String img; // 자동차 이미지 
	private String info; // 자동차 설명
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getUsepeople() {
		return usepeople;
	}
	public void setUsepeople(int usepeople) {
		this.usepeople = usepeople;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	
	
}

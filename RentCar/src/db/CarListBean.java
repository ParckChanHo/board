package db;

public class CarListBean {
	private int no;	//�ڵ��� �ĺ���
	private String name; // �ڵ��� �̸�
	private int category; // �ڵ��� ����  ������>> 1  ������ >> 2   ������ >> 3
	private int price; // �ڵ��� ����
	private int usepeople; // �ڵ��� ��� ������ �ο�
	private String company; //�ڵ��� ȸ��
	private String img; // �ڵ��� �̹��� 
	private String info; // �ڵ��� ����
	
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

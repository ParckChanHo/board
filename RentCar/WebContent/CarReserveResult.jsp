<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="db.CarListBean"%>
<%@ page import="db.RentcarDAO"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat"%>
<jsp:useBean id="rbean" class="db.CarReserveBean">
	<jsp:setProperty name="rbean" property="*"/>
</jsp:useBean>    
<!DOCTYPE html>
<html>
<head>
</head>
<body>
	<!-- 
	 CarOptionSelect.jsp 에서 CarReserveResult.jsp에 정보를 보내줌
	  1) 대여기간 2) 대여일 3) 보험 적용 4) wifi 적용 5) 네비게이션 적용 6) 베이비 시트 적용 7)차량번호 8) 예약하는 차량의 수량 	
	 
	 2개를 제외하고 모두 rbean객체를 생성하여서 파라미터를 받을 수 있다!!!
	 private int reserveno; // 예약번호 >>>auto_increment로 자동으로 숫자가 증가함!!!
	 private String id; //아이디 >>> rbean객체를 만들어서 저장시켜야함
	 private int no; //차량 번호
	 private int qty; //예약하는 차량의 수
	 private int dday; //차를 빌리는 대여기간
	 private String rday; // 차를 빌린 날짜
	 private int usein; //보험 적용
	 private int usewifi; // wifi를 옵션으로 선택하는지 여부
	 private int useseat; // 베이비시트를 옵션으로 선택했는지 여부
	 private int usenavi; // 네비게이샨을 옵션으로 선택하는지 여부
	 -->
	
	<%
		String id = (String)session.getAttribute("id");//top.jsp에서 넘어온게 아니라 session에서 값을 얻어왔기 때문에
		// if(id.equals("GUEST")) 라고 하면 않된다.
		/*
			Top.jsp에서  //로그인이 되어있지 않다면
			if(id==null){
				id="GUEST";
			}
			이 때 만약 setAttribute(id,"GUEST"); 라고 했다면 여기서 즉 CarReserveResult.jsp에서 if(id.equals("GUEST"))라고 해도 괜찮은데
			String 이라는 객체에 "GUEST"라는 문자열을 집어넣기 떄문에 "GUEST"라는 문자열은 Top.jsp에서만 유효하다!!!
		
		*/
		if(id==null){
	%>
		<script>
			alert("로그인 후 예약이 가능합니다.");
			location.href='RentcarMain.jsp?center=MemberLogin.jsp';
		</script>
	<% 
		}
		//날찌 비교
		Date d1 = new Date();
		Date d2 = new Date();
		//날짜를 2016-04-01 포멧 해주는 클래스 선언		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//2021-01-26
		
		/* 
			  
		// "2007-07-22" 이란 문자열로 2007년 7월 22일의 정보를 갖는 Date객체를 만들어보자
		   String textDate = "2007-07-22";<p></p>
		<p>   
		// 입력할 날짜의 문자열이 yyyy-MM-dd 형식이므로 해당 형식의 포맷을 생성한다.
		   java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd");</p>
		<p>   
		//SimpleDateFormat.parse()메소드를 통해 Date객체를 생성한다.
		   
		//SimpleDateFormat.parse()메소드는 입력한 문자열 형식의 날짜가
		   
		//포맷과 다를경우 java.text.ParseException을 발생한다.
		   java.util.Date date = format.parse(textDate);</p>
		<p>   
		*/
		d1 = sdf.parse(rbean.getRday()); //2021-01-26 즉 yyyy-MM-dd의 포맷형식을 가지고 있다.
		// 크롬에서 날짜를 선택하면 그것이 yyyy-MM-dd의 형식으로 반환이 된다!!!
		//rbean.getRday()은 문자열을 반환하므로 이것을 Date객체로 변환시키기 위해서 사용한다.
		d2 = sdf.parse(sdf.format(d2)); //d2는 현재 날짜를 반환해준다. ex) Tue Dec 17 20:45:50 KST 2013 그러나 sdf.format(d2)
		//을 하면 2013-12-17을 반환해준다!!!
		//날짜 비교 매소드를 사용
		
		// d2가 오늘 날짜고 d1이 선택한 날짜이다. d2-d1이므로 선택한 날짜가 무조건 오늘 날짜보다 커야 하므로 무조건 음수가 나와야 한다.!!
		
		int compare = d1.compareTo(d2);//public int compareTo(Date anotherDate)
		//에약 하려는 날짜보다 현재 날짜가  크다면 0보다 작은 숫자를 반환 (즉 d1과 d2를 비교한다. 즉 d2-d1을 하여서 d1의 날짜가 더 빠르면 0보다 작은 숫자를 반환함 )
		//예약하려는 날짜와 현재 날짜가 같다면 0
		//예약하려는  날짜가 더 크다면 0보다 큰 숫자를 반환(즉 d2(ex 15일)-d1(ex 13일)을 하여서 d2의 날짜가 d1의 날짜 보다 더 늦으면 0보다 큰 숫자를 반환한다.)
	
		if(compare < 0){//오늘보다 이전 날짜 선택시 
	%>
		<script>
			alert("현재 시스템 날짜보다 이전 날짜는 선택할수 없음");
			history.back();
		</script>	
	<% 	
		}
		//결과적으로 아무 문제가 없다면 옵션을 선택한 데이터를 저장한 객체(rbean)를 생성 후 반환한다. 그리고  결과 페이지를 보여준다!!! 
		//아이디 값이 빈클래스에 없기에 
		String id1 = (String)session.getAttribute("id");// 뮤조건 로그인이 된 상태이다!!
		rbean.setId(id1); //id 값을 저장한다.
		
		//데이터 베이스에 빈 클래스를 저장 
		RentcarDAO rdao = new RentcarDAO();
		rdao.setReserveCar(rbean);
		
		//선택한 차량 정보 얻어오기 
		CarListBean cbean = rdao.getOneCar(rbean.getNo());
		
		//차량 총 예약 금액
		int totalcar = cbean.getPrice()*rbean.getQty()*rbean.getDday();//(차량의 가격 X 예약하는 차량의 수  X 차를 빌리는 대여기간)
		// ex) 차량의 가격 : 1000   예약하는 차량의 수 :2개 차를 빌리는 대여기간 총 : 2일  총 가격 : 1000 X 2 X 2 = 4000원
		//옵션 금액
		int usein =  0;
		if(rbean.getUsein()==1){usein=10000;} // 보험 적용
		int usewifi =  0;
		if(rbean.getUsewifi()==1){usewifi=10000;} // 와이파이 적용
		int useseat =  0;
		if(rbean.getUseseat()==1){useseat=10000;}	// 베이비 시트 적용
		int totaloption = (rbean.getQty()*rbean.getDday())*(usein+usewifi+useseat);// (예약하는 차량의 수  X 차를 빌리는 대여기간) X ()
	%>
	
	<div align="center">
		<table width="1000">
			<tr height="100">
				<td align="center">
					<font size="6" color="gray">차량 예약 완료 화면</font>
				</td>
			</tr>
			
			<tr height="100">
				<td align="center">
					<img alt="" src="img/<%=cbean.getImg()%>"  width="470">
				</td>
			</tr>
			
			<tr height="50">
				<td align="center">
					<font size="5" color="red">차량 총 예약 금액<%=totalcar%>원 </font>
				</td>
			</tr>
			
			<tr height="50">
				<td align="center">
					<font size="5" color="red">차량 총 옵션 금액<%=totaloption %>원 </font>
				</td>
			</tr>
			
			<tr height="50">
				<td align="center">
					<font size="5" color="red">차량 총 금액<%=totaloption+totalcar%>원 </font>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="db.CarListBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="db.RentcarDAO" %>    
<!DOCTYPE html>
<html>
<head>
	<title>모든 차 보여주기</title>
</head>
<body>
	<%
		RentcarDAO rdao = new RentcarDAO();
		//카테고리 분류값을 얻어온다. CarReserveMain.jsp의 select문에서 값을 얻어왔다.
		ArrayList<CarListBean> v = rdao.getAllCar();//모든 카를 얻어온다.
	%>
	<div align="center">
		<table width="1000">
			<tr height="100">
				<td align="center" colspan="3">
					<font size="6" color="gray">전체 렌트카 보기</font>
				</td>
			</tr>
			<%
				//tr을 3개씩 보여주고 다시 tr을 시작할 수 있도록 하는 변수를 선언한다.
				int j=0;
				for(int i=0; i<v.size(); i++){
					//컬렉션 객체에 저장되어있는 자동차를 하나씩 추출한다.
					CarListBean bean = v.get(i);
					if(j%3==0){
			%>
				<tr height="220">
				 <% } //end if문%> 
					<td width="333" align="center">
						<a href="RentcarMain.jsp?center=CarReserveInfo.jsp?no=<%=bean.getNo() %>"><!-- 자동차 식별자를 넘겨주었다!!!! -->
							<img alt="이미지가 나오지 않았습니다." src="img/<%=bean.getImg()%>" width="300" height="200">
						</a><p>
						<font size="3" color="gray"><b>차량명 : <%=bean.getName() %></b></font>
					</td>
					<%
						j++; //j값을 증가하여서 하나의 행에 총 3개의 차량정보를 보여주기 위해서 이다.
				}
					%>
				</tr>
		</table>
	</div>
</body>
</html>
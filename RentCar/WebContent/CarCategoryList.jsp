<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="db.CarListBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="db.RentcarDAO" %>
<!DOCTYPE html>
<html>
<head>
	<title>카테고리별로 자동차를뿌려주는 jsp 페이지</title>
</head>
<body>
	<%
		//카테고리 분류값을 받아온다.
		int category = Integer.parseInt(request.getParameter("category"));
		String temp="";	
		if(category==1)
			temp="소형";
		else if(category==2)
			temp="중형";
		else
			temp="대형";
		
		RentcarDAO rdao = new RentcarDAO();
		//카테고리 분류값을 얻어온다. CarReserveMain.jsp의 select문에서 값을 얻어왔다.
		ArrayList<CarListBean> v = rdao.getCategoryCar(category);//소형차 >>1  중형차 >>2  대형차 >>3
	%>
	<div align="center">
		<table width="1000">
			<tr height="100">
				<td align="center" colspan="3">
					<font size="6" color="gray"><%=temp %> 자동차</font>
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
						<a href="RentcarMain.jsp?center=CarReserveInfo.jsp?no=<%=bean.getNo() %>">
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
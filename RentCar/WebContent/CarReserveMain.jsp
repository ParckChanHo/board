<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="db.CarListBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="db.RentcarDAO" %>
<!DOCTYPE html>
<html>
<head>
	<title>최신순 자동차 3대만 뿌려주는 jsp 페이지</title>
</head>
<body>
	<!-- 데이터 베이스에 연결하여서 최신순 자동차를 3대만 뿌려주는 함수를 가져온다. -->
	<%
		RentcarDAO rdao = new RentcarDAO();
		// 컬렉션 객체를 이용하여서 자동차를 저장한다.
		 ArrayList<CarListBean> v = rdao.getSelectCar();
	%>
	<div align="center">
		<table width="1000">
			<tr height="100">
				<td align="center" colspan="3">
					<font size="6" color="gray">최신형 자동차</font>
				</td>
			</tr>
		
			<tr height="240">
			<%
				for(int i=0; i<v.size();i++){
					CarListBean bean = v.get(i);
			%>
				<td width="333" align="center">
					<a href="RentcarMain.jsp?center=CarReserveInfo.jsp?no=<%=bean.getNo()%>">
						<img alt="최신순 자동차 3대 입니다." src="img/<%=bean.getImg()%>" width="300" height="200">
					</a>
					<p>차량명 : <%=bean.getName() %></p>
				</td>
			<%
				}
			%>
			</tr>
		</table>
		
		<p>
			<font size="4" color="gray">차량 검색 하기</font><br><br><br>
			<form action="RentcarMain.jsp?center=CarCategoryList.jsp" method="post"><!-- form action="CarCategoryList.jsp" 비교해보기!!!! -->
				<font size="3" color="gray"><b>차량 검색 하기</b></font>&nbsp;&nbsp;
				<select name="category">
					<option value="1">소형</option>
					<option value="2">중형</option>
					<option value="3">대형</option>
				</select>&nbsp;&nbsp;
				<input type="submit" value="검색">
			</form>
			<span><input type="button" value="전체 검색" onclick="location.href='RentcarMain.jsp?center=CarAllList.jsp'"></span>
	</div>	
</body>
</html>
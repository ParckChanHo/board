<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="db.RentcarDAO" %>
    
<!DOCTYPE html>
<html>
<head>
	<title>차량 예약 삭제하기</title>
</head>
<body>
	<%
		int num = Integer.parseInt(request.getParameter("num"));
	
		RentcarDAO rdao = new RentcarDAO(); 
		out.println("num의 값은 : "+num);
		rdao.carReserveRemove(num); //CarReseve 테이블의 ReserveNo이다. >>>> 9번
		
		response.sendRedirect("RentcarMain.jsp");
	%>
</body>
</html>
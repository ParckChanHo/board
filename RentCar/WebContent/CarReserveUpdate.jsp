<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="db.RentcarDAO" %>   
<%@ page import="java.util.ArrayList" %> 
<%@ page import="db.CarViewBean" %>
<!DOCTYPE html>
<html>
<head>
	<title>차량 예약 수정하기</title>
</head>
<body>
	<%	
		String id = (String)session.getAttribute("id");
		
		int num = Integer.parseInt(request.getParameter("num"));//저장한 차의 예약번호
		String img = request.getParameter("img");//차의 사진
		RentcarDAO rdao = new RentcarDAO();
		ArrayList<CarViewBean> v = rdao.getAllReserve(id);
	%>
	
	<div align="center" height="1000">
	<form action = "RentcarMain.jsp?center=CarReserveUpdateAction.jsp?num=<%=num %>" method="post">
		<table width="1006" height="370">
			<tr height="50">
				<td align="center"colspan="3">
					<font size="6" color="gray">옵션 선택</font>
				</td>
			</tr>
			
			<tr height="30">
				<td rowspan="7" width="450">
					<img alt = "사진이 없습니다." src="img/<%=img%>" width="450">	
				</td>
				
				<td align="center">대여기간</td>
				<td  align="center">
				 	<select name="dday">
				 		<option value = "1" selected>1일</option>
				 		<option value = "2">2일</option>
				 		<option value = "3">3일</option>
				 		<option value = "4">4일</option>
				 		<option value = "5">5일</option>
				 		<option value = "6">6일</option>
				 		<option value = "7">7일</option>
				 	</select>
				</td>
			</tr>	
			
			<tr>
				<td align="center" >차량수량</td>
				<td align="center">
					<select name="qty">
						<option value="1" selected>1</option>
						<option value="2">2</option>
						<option value="3">3</option>
					</select>
				</td>
			</tr>
			
			
			<tr>
			
				<td width="250" align="center">대여일</td>
				<td width="250" align="center">
					<input type="date" name="rday" size ="15"></td>
			</tr>
			
			<tr>
				<td width="250" align="center">보험 적용</td>
				<td width="250" align="center">
				 	<select name="usein">
				 		<option value = "1">적용 (1일 1만원)</option>
				 		<option value = "2" selected>비적용</option>
				 	</select>
				</td>
			</tr>
			
			<tr>
				<td width="250" align="center">Wifi 적용</td>
				<td width="250" align="center">
				 	<select name="usewifi">
				 		<option value = "1">적용 (1일 1만원)</option>
				 		<option value = "2" selected>비적용</option>
				 	</select>
				</td>
			</tr>
			
			<tr>
				<td width="250" align="center">네비게이션 적용</td>
				<td width="250" align="center">
				 	<select name="usenavi">
				 		<option value = "1">적용(무료)</option>
				 		<option value = "2" selected>비적용</option>
				 	</select>
				</td>
			</tr>
			
			<tr>
				<td width="250" align="center">베이비 시트 적용</td>
				<td width="250" align="center">
				 	<select name="useseat">
				 		<option value = "1">적용 (1일 1만원)</option>
				 		<option value = "2" selected>비적용</option>
				 	</select>
				</td>
			</tr>
			
			<tr>
				<td align="right" colspan="4" >
					<input type="submit" value="차량예약하기">
				</td>
			</tr>
		</table>
	</form>
</div>
		
	
</body>
</html>
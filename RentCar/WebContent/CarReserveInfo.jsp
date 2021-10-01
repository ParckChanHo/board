<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="db.CarListBean" %>
<%@ page import="db.RentcarDAO" %>    
<!DOCTYPE html>
<html>
<head>
	<title>클릭한 자동차의 차량정보를 보여준다.</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		int no = Integer.parseInt(request.getParameter("no"));
		
		//데이터베이스에 접근하기
		RentcarDAO rdao = new RentcarDAO();
		//클릭한 렌트카 하나에 대한 정보를 얻어온다.
		CarListBean bean = rdao.getOneCar(no);// 클릭한 렌터카 객체를 반환받는다.
		
		int category = bean.getCategory();// 소형차==1 중형차==2 대형차==3 으로 반환을 받는다.
		String temp="";
		if(category==1)
			temp="소형";
		else if(category==2)
			temp="중형";
		else
			temp="대형";
	%>
	<div align="center">
		<form action="RentcarMain.jsp?center=CarOptionSelect.jsp" method="post">
			<table width="1000">
				<tr height="100">
					<td align="center" colspan="3">
						<font size="6" color="gray"><%=bean.getName() %>차량 선택</font> 
					</td>
				</tr>
				<tr>
					<td rowspan="6" width="500" align="center">
						<img alt="이미지가 없습니다." src="img/<%=bean.getImg()%>" width="450">
					</td>
					<td width="250" align="center">차량이름</td>
					<td width="250" align="center"><%=bean.getName() %></td>
				</tr>
				<tr>
					<td width="250" align="center">차량수량</td>
					<td width="250" align="center">
						<select name="qty">
							<option value="1" selected>1</option>
							<option value="2">2</option>
							<option value="3">3</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="250" align="center">차량분류</td>
					<td width="250" align="center"><%=temp %></td>
				</tr>
				<tr>
					<td width="250" align="center">대여가격</td>
					<td width="250" align="center"><%=bean.getPrice() %></td>
				</tr>
				<tr>
					<td width="250" align="center">제조회사</td>
					<td width="250" align="center"><%=bean.getCompany() %></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="hidden" name="no" value="<%=bean.getNo() %>">
						<input type="hidden" name="img" value="<%=bean.getImg()%>">
						<input type="submit" value="옵션 선택 후 구매하기">
					</td>
				</tr>
			</table>
			<br><br><br>
			<font size="5" color="gray">차량 정보 보기</font>
			<p><%=bean.getInfo() %>
		</form>
	</div>
</body>
</html>
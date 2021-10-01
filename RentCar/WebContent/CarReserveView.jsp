<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="db.RentcarDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="db.CarViewBean" %>
    
<!DOCTYPE html>
<html>
<head>
	<title>예약 확인 하기</title>
</head>
<body>
	<%
		String id = (String)session.getAttribute("id");
		if(id==null){
	%>
		<script>
			alert("로그인을 해주세요");
			location.href='RentcarMain.jsp?center=MemberLogin.jsp';
		</script>
	<%
		}
		//로그인되어있는 아이디를 읽어 온다.
		int count = 1;
		RentcarDAO rdao = new RentcarDAO();
		ArrayList<CarViewBean> v = rdao.getAllReserve(id);
	%>	
	
	<div align="center">
		<table width="1100">
			<tr height="100">
				<td align="center" colspan="11">
					<font size="6" color="gray">차량 예약 완료 화면</font>
				</td>
			</tr>
		</table>
		
		<table width="1200" border="1">
			<tr height="40">
				<td width="60"align="center">번호</td>
				<td width="150"align="center">이미지 </td>
				<td width="100"align="center">이름 </td>
				<td width="100"align="center">대여일</td>
				<td width="180"align="center">대여기간</td>
				<td width="100"align="center">금액</td>
				<td width="60"align="center">수량</td>
				<td width="60"align="center">보험</td>
				<td width="80"align="center">wifi 유무</td>
				<td width="130"align="center">네비게이션 유무</td>
				<td width="130"align="center">베이비시트 유무</td>
				<td width="80"align="center">수정</td>
				<td width="80"align="center">삭제</td>
			</tr>
			
			 <% 
			for(int i =0 ; i< v.size() ; i++){			
				CarViewBean bean = v.get(i);
			%>
			<tr height="60">
				<td width="60"align="center"><%=i+1%></td>
				<td width="150"align="center"><img alt ="사진이 없습니다." src="img/<%=bean.getImg()%>"  width="120" height="70"></td>
				<td width="100"align="center"><%=bean.getName()%></td>
				<td width="100"align="center"><%=bean.getDday()%></td>
				<td width="180"align="center"><%=bean.getRday()%></td>
				<td width="100"align="center"><%=bean.getPrice()%></td>
				<td width="60"align="center"><%=bean.getQty()%></td>
				<td width="80"align="center"><%=bean.getUsein()%></td>
				<td width="130"align="center"><%=bean.getUsewifi()%></td>
				<td width="130"align="center"><%=bean.getUsenavi()%></td>
				<td width="80"align="center"><%=bean.getUseseat()%></td>
				<td width="80"align="center"><button onclick="location.href='RentcarMain.jsp?center=CarReserveUpdate.jsp?num=<%=bean.getNum()%>&img=<%=bean.getImg()%>'">수정</button></td><!--CarReseve 테이블의 ReserveNo이다.  ex) 첫 번째 차 예약이면 1번 이렇게 된다.-->
				<td width="80"align="center"><button onclick="location.href='RentcarMain.jsp?center=CarReserveDel.jsp?num=<%=bean.getNum()%>'">삭제</button></td>
			</tr>
	<% 		
			}
	%>	
		</table>
	</div>	
</body>
</html>
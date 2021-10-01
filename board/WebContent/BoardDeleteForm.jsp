<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="model.BoardBean"%>
<%@ page import="model.BoardDAO"%>
<!DOCTYPE html>
<html>
<head>
	<title>게시물 글 삭제하기</title>
</head>
<body>
	<!-- 글 번호 받기 -->
	<%
		request.setCharacterEncoding("utf-8");
		// 하나의 게시글을 리턴받는다.
		int num = Integer.parseInt(request.getParameter("num"));
		BoardDAO bdao = new BoardDAO();
		BoardBean bean = bdao.getOneUpdateBoard(num); //삭제할 게시글을 리턴받는다.
	%>
	<h2>게시글 삭제하기</h2>
	<form action="BoardDeleteProc.jsp" method="post">
		<table width="600" border="1" bgcolor="skyblue"><!-- 패스워드,num(게시물 번호)만 넘겨준다!!! -->
			<tr height="40">
				<td align="center" width="120">작성자</td>
				<td align="center" width="180"><%=bean.getWriter() %></td>
				<td align="center" width="120">작성일</td>
				<td align="center" width="180"><%=bean.getReg_date() %></td>
			</tr>
			<tr height="40">
				<td align="center" width="120">제목</td>
				<td align="left" colspan="3"><%=bean.getSubject() %></td>
			</tr>
			<tr height="40">
				<td align="center" width="120">패스워드</td>
				<td align="left" colspan="3">&nbsp;<input type="password" name="password" size="60"></td>
			</tr>
			<tr height="40">
				<td align="center" colspan="4">
					<input type="hidden" name="num" value="<%=num %>"><!-- 게시물 번호를 넘겨준다. -->
					<input type="submit" value="글 삭제">&nbsp;&nbsp;
					<input type="button" onclick="location.href='BoardList.jsp'" value="목록보기">
				</td>
			</tr>
		</table>
	</form>	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="model.BoardDAO" %>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="boardbean" class="model.BoardBean" /> 	<!--데이터를 한번에 받아오는 빈클래스를 사용하도록  -->
<jsp:setProperty name="boardbean" property="*"/>

<!DOCTYPE html>
<html>
<head>
	<title>답변쓰기 처리하기</title>
</head>
<body>
	<% 
		//데이터 베이스 객체 생성
		BoardDAO bdao = new BoardDAO();
		bdao.reWriteBoard(boardbean);
		
		response.sendRedirect("BoardList.jsp");
		
	%>
	
</body>
</html>
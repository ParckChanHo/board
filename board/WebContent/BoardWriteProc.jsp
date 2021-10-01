<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="model.BoardDAO" %>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="boardbean" class="model.BoardBean" />
<!--<jsp:setProperty name="boardbean" property="writer" />
<jsp:setProperty name="boardbean" property="subject" />
<jsp:setProperty name="boardbean" property="email" />
<jsp:setProperty name="boardbean" property="password" />
<jsp:setProperty name="boardbean" property="content" />-->

<jsp:setProperty name="boardbean" property="*"/>


<!-- ref,Re_step,Re_level등과 같이
	요청파라미터 값으로 전달받지 못한 것들은 null로 초기화가 된다!!! 나중에 db에서 초기화 시킬 것이다!!-->
<!DOCTYPE html>
<html>
<head>
	<title>게시판 글쓰기</title>
</head>
<body>
	<%
		//데이터 베이스 쪽으로 자바빈즈를 넘겨준다!!!
		BoardDAO bdao = new BoardDAO();
		bdao.insertBoard(boardbean);
		
		//게시글을 저장한 후 전체게시물을 본다.
		response.sendRedirect("BoardList.jsp");
	%>
</body>
</html>
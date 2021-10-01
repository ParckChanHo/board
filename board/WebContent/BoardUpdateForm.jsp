<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="model.BoardBean" %>
<%@ page import="model.BoardDAO"%>
<!DOCTYPE html>
<html>
<head>
	<title>게시글 수정하기</title>
</head>
<body>
	<h2>게시글 수정</h2>
	<%
		//해당 게시글 번호를 통하여서 게시글을 수정한다.
		// BoardInfo.jsp 에서 num값(게시물 번호)을 넘겨주었다. 즉 어떤 글을 수정할지 알기 위하여서 게시물 번호를 넘겨준 것이다.
		int num = Integer.parseInt(request.getParameter("num").trim());
	
		//하나의 게시글에 대한 정보를 리턴한다.
		BoardDAO bdao = new BoardDAO();
		BoardBean bean = bdao.getOneUpdateBoard(num);
	%>
	<form action="BoardUpdateProc.jsp" method="post">
		<table width="600" border="1" bgcolor="skyblue">
			<tr height="40">
				<td align="center" width="120">작성자</td>
				<td align="center" width="180"><%=bean.getWriter() %></td>
				<td align="center" width="120">작성일</td>
				<td align="center" width="180"><%=bean.getReg_date() %></td>
			</tr>
			<tr height="40">
				<td align="center" width="120">제목</td>
				<td width="480" colspan="3">&nbsp;<input type="text" name="subject" value="<%=bean.getSubject() %>" size="60"></td>
			</tr>
			<tr height="40">
				<td align="center" width="120">패스워드</td>
				<td width="480" colspan="3">&nbsp;<input type="password" name="password" size="60"></td>
			</tr>
			<tr height="40">
				<td align="center" width="120">글 내용</td>
				<td width="480" colspan="3"> <textarea rows="10" cols="60" name="content" align="left"><%=bean.getContent() %></textarea></td>
			</tr>
			<tr height="40"><!-- num을 넘겨주는 이유는 어떤 게시물에 답변을 적어주는 것인지 알아야 하기 떄문에 -->
				<td align="center" colspan="4"> 
				<input type="hidden" name="num" value="<%=bean.getNum()%>">
				<input type="submit" value="글 수정">&nbsp;&nbsp;
				<input type="button" value="전체글 보기" onclick="location.href='BoardList.jsp'">
			</tr>
		</table>
	</form>
	
</body>
</html>
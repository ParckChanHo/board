<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="model.BoardBean" %>
<%@ page import="model.BoardDAO"%>
<!DOCTYPE html>
<html>
<head>
	<title>하나의 게시글 보기</title>
</head>
<body>
	<%
		int num = Integer.parseInt(request.getParameter("num").trim()); // 공백을 제거해 준다.
		
		BoardDAO bdao = new BoardDAO(); //데이터베이스를 접근한다.
		BoardBean bean = bdao.getOneBoard(num); // 제목을 클릭하면 그에 해당하는 num(게시물 번호)을 리턴받는데 이에 해당하는 게시물 객체를 받기 위해서
	%>
		
	<h2>게시글 보기</h2>
	<table width="600" border="1" bgcolor="skyblue">
		<tr height="40">
			<td align="center" width="120">글 번호</td>
			<td align="center" width="180"><%=bean.getNum() %></td>
			<td align="center" width="120">조회수</td>
			<td align="center" width="180"><%=bean.getReadcount() %></td>
		</tr>
		<tr height="40">
			<td align="center" width="120">작성자</td>
			<td align="center" width="180"><%=bean.getWriter() %></td>
			<td align="center" width="120">작성일</td>
			<td align="center" width="180"><%=bean.getReg_date() %></td>
		</tr>
		<tr height="40">
			<td align="center" width="120">이메일</td>
			<td align="center" colspan="3"><%=bean.getEmail() %></td>
		</tr>
		<tr height="40">
			<td align="center" width="120">제목</td>
			<td align="center" colspan="3"><%=bean.getSubject() %></td>
		</tr>
		<tr height="80">
			<td align="center" width="120">글 내용</td>
			<td align="center" colspan="3"><%=bean.getContent() %></td>
		</tr>
		<tr height="40"><!-- num을 넘겨주는 이유는 어떤 게시물에 답변을 적어주는 것인지 알아야 하기 떄문에 -->
			<td align="center" colspan="4"> 
			<input type="button" value="답글쓰기" 
				onclick="location.href='BoardReWriteForm.jsp?num=<%=bean.getNum()%>&ref=<%=bean.getRef()%>&re_step=<%=bean.getRe_step()%>&re_level=<%=bean.getRe_level()%>'">   
			<input type="button" value="수정하기" onclick="location.href='BoardUpdateForm.jsp?num=<%=bean.getNum()%>'">
			<input type="button" value="삭제하기" onclick="location.href='BoardDeleteForm.jsp?num=<%=bean.getNum()%>'">
			<input type="button" value="목록보기" onclick="location.href='BoardList.jsp'">
		</tr>
	</table>
</body>
</html>
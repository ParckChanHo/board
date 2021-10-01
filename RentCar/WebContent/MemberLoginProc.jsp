<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="member.UserDAO"%> 
<%@ page import="java.io.PrintWriter"%> <!-- 자바 스크립트를 사용하기 위해서!!! -->
<!DOCTYPE html>
<html>
<head>
	<title>로그인 처리하기</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
	
		String id = request.getParameter("userId");
		String password = request.getParameter("userPassword");
		// 회원 아이디와 패스워드가 일치한지 비교한다.
		UserDAO udao = new UserDAO();
		//해당 회원이 존재하는지 여부를 확인한다.
		int result = udao.getMember(id,password);
		
		if(result==1){ //로그인 성공
			session.setAttribute("id", id);
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'RentcarMain.jsp'");
			script.println("</script>");
		}
		else if(result==0 || result==-1){ // 로그인 실패
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('아이디 또는 비밀번호가 틀렸습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{ // 데이터베이스 오류가 발생함!!!
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('오류가 발생하였습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>
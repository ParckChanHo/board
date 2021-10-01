<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%> <!-- 자바 스크립트를 사용하기 위해서!!! -->
<jsp:useBean id="user" class="user.User" scope="page"/>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:setProperty name="user" property="userID" /><!-- 요청 파라미터 이름과 자바빈즈의 프로퍼티 이름이 일치하는 경우이다. -->
<jsp:setProperty name="user" property="userPassword"/>
<!--  따라서 이 같은 경우는 userID라는 프로퍼티에 폼 페이지에서 요청 파라미터 이름이 userID인  값이 저장이 된다. -->
<html>
<head>
	<title>JSP 계시판 웹 사이트</title>
</head>
<body>
	<%
		//로그인을 한 회원은 회원가입과 로그인을 할 수 없게 만들기!!
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID = (String)session.getAttribute("userID");
		}
		if(userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(),user.getUserPassword());
		if(result == 1){
			session.setAttribute("userID", user.getUserID());//세션의 이름은 userID 이고 세션의 값은 인자로 전달받은 
			// 사용자의 아이디이다.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");//이전 페이지로 사용자를 돌려보낸다!!! 즉 다시 로그인 화면으로 보낸다.
			script.println("</script>");
		}
		else if(result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>

</html>

<!-- 자바에서 alert() 창 띄우기!!!
1)<%@ page import="java.io.PrintWriter"%>를 해준다.

2) 주의점!!!!
	PrintWriter writer = response.getWriter();
	writer.println("<script>alert('Success'); location.href='/helpInfo/update';</script>");
	response 객체는 예민한 객체 이기 떄문에 위와 같이 하면 않되고....
	
	response.setContentType("text/html; charset=UTF-8");
	PrintWriter out = response.getWriter();
	out.println("<script>alert('계정이 등록 되었습니다'); location.href='이동주소';</script>");
	out.flush();
-->
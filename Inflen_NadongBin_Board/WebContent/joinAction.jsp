<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%> <!-- 자바 스크립트를 사용하기 위해서!!! -->
<jsp:useBean id="user" class="user.User" scope="page"/><!-- 현재 이 페이지에서만 유효한 User 객체를 생성함!!! -->
<% request.setCharacterEncoding("utf-8"); %>
<jsp:setProperty name="user" property="userID" /><!-- 요청 파라미터 이름과 자바빈즈의 프로퍼티 이름이 일치하는 경우이다. -->
<jsp:setProperty name="user" property="userPassword"/>
<!--  따라서 이 같은 경우는 userID라는 프로퍼티에 폼 페이지에서 요청 파라미터 이름이 userID인  값이 저장이 된다. -->
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userEmail"/>
<html>
<head>
	<title>회원가입 처리하기</title>
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
		
		if(user.getUserID() == null || user.getUserID().equals("") ||
				user.getUserPassword() == null || user.getUserPassword().equals("")
				|| user.getUserName() == null || user.getUserName().equals("") ||
				user.getUserGender() == null || user.getUserGender().equals("") ||
				user.getUserEmail() == null || user.getUserEmail().equals("")){
				
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
		}
		else{
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			
			PrintWriter script1 = response.getWriter();
			script1.println("<script>");
			script1.println("alert(result)"); //id가 primary key이기 떄문이다.
			script1.println("</script>");
			
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('아이디가 이미 존재합니다.')"); //id가 primary key이기 떄문이다.
				script.println("history.back()");
				script.println("</script>");
			}
			else{
				session.setAttribute("userID", user.getUserID());//세션의 이름은 userID 이고 세션의 값은 인자로 전달받은 
				// 사용자의 아이디이다.
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
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
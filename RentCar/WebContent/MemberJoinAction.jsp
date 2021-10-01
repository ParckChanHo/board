<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="member.UserDAO"%><!-- 데이터베이스를 연결하기 위해서 -->
<%@ page import="java.io.PrintWriter"%> <!-- 자바 스크립트를 사용하기 위해서!!! -->
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="user" class="member.User"> <!-- 새로운 User객체를 생성하기 위해서이다. -->
	<jsp:setProperty name="user" property="*"/>
</jsp:useBean>
<!DOCTYPE html>
<html>
<head>
	<title>회원가입 하기</title>
</head>
<body>
	<%
		if(user.getUserId()==null || user.getUserId().equals("")||
		user.getUserPassword()==null || user.getUserPassword().equals("")||
		user.getUserEmail()==null || user.getUserEmail().equals("")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
			UserDAO userdao = new UserDAO();
			int result= userdao.join(user);
			
			if(result==-1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('아이디가 이미 존재합니다.')"); //id가 primary key이기 떄문이다.
				script.println("history.back()");
				script.println("</script>");
			}
			else{
				session.setAttribute("id", user.getUserId());//세션의 이름은 userID 이고 세션의 값은 인자로 전달받은 
				// 사용자의 아이디이다.
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'RentcarMain.jsp'");
				script.println("</script>");
				
			}
		}
	%>
</body>
</html>
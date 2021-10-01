<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.boardDAO"%>
<%@ page import="java.io.PrintWriter"%> <!-- 자바 스크립트를 사용하기 위해서!!! -->
<jsp:useBean id="bbs" class="board.board" scope="page"/><!-- 현재 이 페이지에서만 유효한 board 객체를 생성함!!! -->
<% request.setCharacterEncoding("utf-8"); %>
<jsp:setProperty name="bbs" property="bbsTitle" /><!-- 요청 파라미터 이름과 자바빈즈의 프로퍼티 이름이 일치하는 경우이다. -->
<jsp:setProperty name="bbs" property="bbsContent"/>

<html>
<head>
	<title>회원가입 처리하기</title>
</head>
<body>
	<!-- writeAction은 글쓰기 버튼을 누르면 실제로 게시물을 작성하기 위해서 만들었다!!! -->
	<%	
		//로그인을 한 회원은 회원가입과 로그인을 할 수 없게 만들기!!
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID = (String)session.getAttribute("userID");
		}
		if(userID == null){ // 즉 세션 값이 없으면
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		else{ //userID가 null이 아니라면 즉 로그인이 되었다면
			if(bbs.getBbsTitle() == null || bbs.getBbsTitle().equals("") ||
					bbs.getBbsContent() == null || bbs.getBbsContent().equals("")){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안 된 사항이 있습니다.')");
					script.println("history.back()");
					script.println("</script>");
			}
			else{
				boardDAO bbsDAO = new boardDAO();
				int result = bbsDAO.write(bbs.getBbsTitle(),userID,bbs.getBbsContent());
				
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패하였습니다.')"); //id가 primary key이기 떄문이다.
					script.println("history.back()");
					script.println("</script>");
				}
				else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'board.jsp'");
					script.println("</script>");
				}
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
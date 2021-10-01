<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.boardDAO"%>
<%@ page import="java.io.PrintWriter"%> <!-- 자바 스크립트를 사용하기 위해서!!! -->
<%@ page import="board.board"%>
<%@ page import="board.boardDAO"%>
<% request.setCharacterEncoding("utf-8"); %>
<html>
<head>
	<title>회원가입 처리하기</title>
</head>
<body>
	<%	
		//로그인을 한 회원은 회원가입과 로그인을 할 수 없게 만들기!!
		String userID = null;
		if((String)session.getAttribute("userID")!=null){
			userID = (String)session.getAttribute("userID");
		}
		if(userID == null){ // 즉 세션 값이 없으면
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		int bbsID = 0;
		if(request.getParameter("bbsID")!=null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID ==0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않는 글 입니다.')");
			script.println("location.href = 'board.jsp'");
			script.println("</script>");
		}
		
		boardDAO instance = new boardDAO();
		board bbs =instance.getBbs(bbsID);//클릭한 게시물 제목에 해당하는 게시물 객체를 반환한다.!!
		if(!userID.equals(bbs.getUserID())){// 로그인한 사람이 쓴 게시물이라면 true를 반환한다!!!
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권항이 없습니다.')");
			script.println("location.href = 'board.jsp'");
			script.println("</script>");
		} else { //userID가 null이 아니라면 즉 로그인이 되었다면
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
				int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"),request.getParameter("bbsContent"));
				
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글수정에 실패하였습니다.')");
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
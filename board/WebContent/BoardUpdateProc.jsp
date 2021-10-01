<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ page import="model.BoardDAO" %>
<jsp:useBean id="boardbean" class="model.BoardBean"><!-- 폼 데이터에서 보내진 제목, 패스워드, 글 내용, 글 번호(num)값을 받는다. -->
	<jsp:setProperty name="boardbean" property="*"/>
	<!-- 이것을 사용하기 위해서는 BoardBean의 변수 이름과 BoardUpdateForm의 이름과 같아야 한다.
		예를 들어서  input type="text" name="subject" ==> String subject; // 글 제목이다. 
		BoardUpdateForm.jsp에서 전달해온 파라미터는 1) subject 2) password 3) content 이다.
		
		boardbean 이라는 객체가 생성이 되고 BoardUpdateForm.jsp에서 넘어온 파라미터들(1) subject 2) password 3) content) 들만 넘어온 값으로
		초기화가 되고 나머지 값들은 모두 null로 초기화가 된다.	
	 -->
</jsp:useBean>
<!DOCTYPE html>
<html>
<head>
	<title>게시판 업데이트 처리</title>
</head>
<body>
	<!-- 제목, 패스워드, 글 내용, 마지막으로 input type="hidden"으로 넘긴 글 번호를 받아야 한다. 이것을 모두 request로 받기보다는 useBean으로 받는 것이 훨씬 편하다.!!! -->
	<!-- 요청된 파라미터가 없으면 null로 초기화가 된다!! 따라서 걱정하지 않아도 된다!! -->
	
	<!-- 수정하기 전에 설정하였던 비밀번호와 폼에서 받았던 비밀번호를 비교한다. 맞으면 수정할 수 있게 하고 틀리면 다시 입력하라고 한다.!!!! -->
	<%
		//데이터 베이스에 연결
		BoardDAO bdao = new BoardDAO();
		//해당 게시물의 패스워드값을 얻어온다.
		String pass = bdao.getPass(boardbean.getNum()); //boardbean.getNum()을 인자로 전달하여서  데이터베이스에 저장되어있던 원래 게시판의 비밀번호와 비교한다.
		
		//기존 패스워드값과 update시 작성했던(폼으로 전달한) password값이 같은지 비교한다.
		if(pass.equals(boardbean.getPassword())){
			//데이터 수정하는 메소드를 호출한다.
			bdao.updateBoard(boardbean);
			//수정이 완료되면 전체 게시글을 본다.
			response.sendRedirect("BoardList.jsp");
		}
		else{ //패스워드가 틀리다면
	%>
		<script type="text/javascript">
			alert("패스워드가 일치 하지 않습니다. 다시 확인 후 수정해 주세요");
			history.back();
		</script>
	<%
		}
	%>	
</body>
</html>
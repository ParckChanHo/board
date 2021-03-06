<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> 
<%@ page import="board.board"%>
<%@ page import="board.boardDAO"%>
<%@ page import="java.util.ArrayList" %> <!-- 게시판의 목록을 보여주기 위해서 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 화면 최적화 -->
<meta name="viewport" content="width-device-width", initial-scale="1">
<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
<link rel="stylesheet" href="css/bootstrap.css"><!-- href="css/bootstrap.min.css"도 동일하다!!-->
<link rel="stylesheet" href="css/custom.css">
<title>게시판</title>
<style type="text/css">
	a, a:hover { 
		color:#000000;
		text-decoration: none;
	}
</style>
 <!-- a>>> a 태그를 전체 선택한다. a:hover는 사용자의 커서(마우스 포인터)가 요소 위에 올라가 있으면 선택된다.-->
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		
		int pageNumber = 1;
		if(request.getParameter("pageNumber")!= null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>

	<nav class="navbar navbar-default"> <!-- 네비게이션 -->
		<div class="navbar-header"> 	<!-- 네비게이션 상단 부분 -->
			<!-- 네비게이션 상단 박스 영역 -->
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<!-- 이 삼줄 버튼은 화면이 좁아지면 우측에 나타난다 -->
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<!-- 상단 바에 제목이 나타나고 클릭하면 main 페이지로 이동한다 -->
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
		</div>
		<!-- 게시판 제목 이름 옆에 나타나는 메뉴 영역 -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li><!-- 현재 접속한페이지가 메인페이지라는 것을 알려주기!!! -->
				<li class="active"><a href="board.jsp">게시판</a></li>
			</ul>
			<!-- 로그인이 되어있지 않은 경우에만 로그인 및 회원가입을 할 수 있도록 한다!! -->
			<%
				if(userID == null){
					
			%>
			<!-- 헤더 우측에 나타나는 드랍다운 영역 -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<!-- 드랍다운 아이템 영역 -->	
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li><!-- active 현재 선택이 되었다는 의미이다. 1개의 홈페이지에 1개만 들어갈 수 있다. -->
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				} else{	
			%>
			<!-- 헤더 우측에 나타나는 드랍다운 영역 -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<!-- 드랍다운 아이템 영역 -->	
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃 </a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border:1px solid #dddddd">
				<thead>
					<tr>
						<th style="backgroud-color: #eeeeee; text-align:center;">번호</th>
						<th style="backgroud-color: #eeeeee; text-align:center;">제목</th>
						<th style="backgroud-color: #eeeeee; text-align:center;">작성자</th>
						<th style="backgroud-color: #eeeeee; text-align:center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						boardDAO boarddao = new boardDAO();
						ArrayList<board> list = boarddao.getList(pageNumber);
						for(int i=0; i < list.size(); i++){
					%>
					<tr>
						<td><%= list.get(i).getBbsID() %></td>
						<td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID() %>"><%=list.get(i).getBbsTitle() %></a></td>
						<td><%=list.get(i).getUserID() %></td>
						<td><%=list.get(i).getBbsDate().substring(0,11)+list.get(i).getBbsDate().substring(11,13)+"시 "+list.get(i).getBbsDate().substring(14,16)+"분" %></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<%
				if(pageNumber != 1){
			%>
			<a href="board.jsp?pageNumber=<%= pageNumber-1 %>" class="btn btn-success btn-arrow-left">이전</a>
			<%
				} if(boarddao.nextPage(pageNumber+1)){
			%>
			<a href="board.jsp?pageNumber=<%= pageNumber+1 %>" class="btn btn-success btn-arrow-right">다음</a>
			<%		
				}
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>	
	</div>
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script><!-- jquery 삽입 -->
	<script src="js/bootstrap.js"></script> <!-- 부트스트랩에서 제공해주는 js파일 삽입 -->
</body>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> 
<%@ page import="board.board"%>
<%@ page import="board.boardDAO"%>
<html>
<head>
	<!-- 화면 최적화 -->
	<meta name="viewport" content="width-device-width", initial-scale="1">
	<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
	<link rel="stylesheet" href="css/bootstrap.css"><!-- href="css/bootstrap.min.css"도 동일하다!!-->
	<link rel="stylesheet" href="css/custom.css">
	<title>게시판</title>
</head>
<body>
	<%	
		request.setCharacterEncoding("utf-8");
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");// 요청 파라미터가 없으면 null을 반환한다.!!!
		}
		int bbsID = 0;
		if(request.getParameter("bbsID")!=null){//a href="view.jsp?bbsID=<%=list.get(i).getBbsID()
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
						<th colspan="3" style="backgroud-color: #eeeeee; text-align:center;">게시판 글보기</th>	
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width:20%;">글 제목</td>
						<td colspan="2"><%=bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%=bbs.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%= bbs.getBbsDate().substring(0,11) + bbs.getBbsDate().substring(11,13)+"시" + bbs.getBbsDate().substring(14,16)+"분"%></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="min-height:200px; text-align:left;"><%=bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
					</tr>
				</tbody>
			</table>
			
			<a href="board.jsp" class="btn btn-primary">목록 </a>
			<!-- userID = (String)session.getAttribute("userID");  로그인을 하였으면 아이디 값으로 세션이 새롭게 만들어졌음
			따라서 만들어진 세션 값을 userID가 받는 것이다!!!-->
			<%
				if(userID != null && userID.equals(bbs.getUserID())){//userID != null >> 로그인을 하였어야 한다!!!
				// bbs.getUserID() >>> bbs라는 레퍼런스 변수는 클릭한 게시물의 모든 것을 가지고 있는 게시물 객체를 참조하고 있다!!!!
				// 즉 게시물을 쓴 사람의 아이디와 로그인 한 사람의 아이디가 일치하다면     즉 로그인한 사람이 쓴 게시물의 글 이라면
			%>
				<a href="update.jsp?bbsID=<%=bbsID %>" class="btn btn-primary">수정</a>
				<a href="deleteAction.jsp?bbsID=<%=bbsID %>" class="btn btn-primary" onclick="return confirm('정말로 삭제하시겠습니까?')">삭제</a>
			<%
				}
			%>
			
			<input type="button" class="btn btn-primary pull-right" value="글쓰기" onclick="location.href='write.jsp?userID=<%=userID%>'"/>
		</div>	
	</div>
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script><!-- jquery 삽입 -->
	<script src="js/bootstrap.js"></script> <!-- 부트스트랩에서 제공해주는 js파일 삽입 -->
</body>
</html>



<!-- 
						<%=bbs.getBbsContent().replaceAll("^","&Hat;").replaceAll("'","&apos;")
						.replaceAll(">","&gt;").replaceAll("<","&lt;").replaceAll(";","&semi;").replaceAll("&","&amp;").replaceAll("#","&num;").replaceAll(" ","&nbsp;")
						.replaceAll("\n","<br>")%></td>
 -->
<!-- 
우리가 게시판에 특수문자를 써서 등록하게 된다면 데이터베이스에 특수문자가 포함되어서 저장이 된다. 
브라우저는  이것을 html 언어로 바꾸는 과정에서 이것들(특수문자들)이 태그인지 단순한 문자인지(단순히 출력할 용도)를 구분하지 못하게 된다. ex) <>
예를 들어서 게시판 내용에 < # 이런 것을 쓰게 된다면 브라우저에게 이것들은 단순히 출력할 용도로 사용하는 것이라고 
알려주기 위해서 replaceAll()함수를 통해서 모두 바꾸어 주어야 한다!!!

<div>는 태그로 이식하는 방면, 치환된 문자인 &lt;div&gt;는 출력 용도인 문자로 인식한다.
HTML에서는 태그로 인식되는 기호를 웹 브라우저에 표현하는 방법이 있는데 바로 &lt;이러한 문자를 사용하는 것이다.

대표적인 특수문자들
1) &lt; >>> <(부등호 꺽쇠)
2) &gt; >>> >(부등호 꺽쇠)
3) $nbsp; >>> 공백(띄어쓰기)
4) &amp; >>> & (앰퍼샌드)
5) &quot; >>> " (큰따옴표 하나) 사용 예시 >>> <a href="javascript:test(&quot;hello&quot;);return false;">
 -->

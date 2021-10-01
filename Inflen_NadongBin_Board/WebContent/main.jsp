<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> 
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 화면 최적화 -->
<meta name="viewport" content="width-device-width", initial-scale="1">
<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
<link rel="stylesheet" href="css/bootstrap.css"><!-- href="css/bootstrap.min.css"도 동일하다!!-->
<link rel="stylesheet" href="css/custom.css">
<title>메인 화면</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
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
				<li class="active"><a href="main.jsp">메인</a></li><!-- 현재 접속한페이지가 메인페이지라는 것을 알려주기!!! -->
				<li><a href="board.jsp">게시판</a></li>
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
		<div class="jumbotron">
			<div class="container">
				<h1>웹 사이트 소개</h1>
				<p>이 웹 사이트는 부트스트랩으로 만든 JSP 웹 사이트 입니다.</p>
				<p><a class="btn btn-primary" href="#" role="button">자세히 알아보기</a></p>
			</div>
		</div>
	</div>
	<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
  	<!-- Indicators -->
 	 <ol class="carousel-indicators">
    	<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
    	<li data-target="#carousel-example-generic" data-slide-to="1"></li>
    	<li data-target="#carousel-example-generic" data-slide-to="2"></li>
    	<li data-target="#carousel-example-generic" data-slide-to="3"></li>
    	<li data-target="#carousel-example-generic" data-slide-to="4"></li>
    	<li data-target="#carousel-example-generic" data-slide-to="5"></li>
    	<li data-target="#carousel-example-generic" data-slide-to="6"></li>
  	 </ol>
	<!-- Wrapper for slides -->
  	<div class="carousel-inner" role="listbox">
    	<div class="item active">
      		<img src="1.png" alt="사진 출력에 오류가 생겼습니다.">
      		<div class="carousel-caption">
        		<h3>1 번째 사진입니다.</h3>
      		</div>
    	</div>
	    <div class="item">
	      <img src="2.png" alt="사진 출력에 오류가 생겼습니다.">
	      <div class="carousel-caption">
	        <h3>2 번째 사진입니다.</h3>
	      </div>
	    </div>
	    <div class="item">
	      <img src="3.png" alt="사진 출력에 오류가 생겼습니다.">
	      <div class="carousel-caption">
	        <h3>3 번째 사진입니다.</h3>
	      </div>
	    </div>
	    <div class="item">
	      <img src="4.png" alt="사진 출력에 오류가 생겼습니다.">
	      <div class="carousel-caption">
	        <h3>4 번째 사진입니다.</h3>
	      </div>
	    </div>
	    <div class="item">
	      <img src="5.png" alt="사진 출력에 오류가 생겼습니다.">
	      <div class="carousel-caption">
	        <h3>5 번째 사진입니다.</h3>
	      </div>
	    </div>
	    <div class="item">
	      <img src="6.png" alt="사진 출력에 오류가 생겼습니다.">
	      <div class="carousel-caption">
	        <h3>6 번째 사진입니다.</h3>
	      </div>
	    </div>
	    <div class="item">
	      <img src="7.png" alt="사진 출력에 오류가 생겼습니다.">
	      <div class="carousel-caption">
	        <h3>7 번째 사진입니다.</h3>
	      </div>
	    </div>
	  </div>
	<!-- Controls -->
  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>
	
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script><!-- jquery 삽입 -->
	<script src="js/bootstrap.js"></script> <!-- 부트스트랩에서 제공해주는 js파일 삽입 -->
</body>

<!--
또 다른 carousel이다. 이미지 슬라이딩!!!!
 
<div class="container">
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
			</ol>
			<div class="carousel-inner">
				<div class="item active">
					<img alt="이미지1" src="images/1.jpg">
				</div>
				<div class="item">
					<img alt="이미지2" src="images/2.jpg">
				</div>
				<div class="item">
					<img alt="이미지3" src="images/3.jpg">
				</div>

			</div>
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span>
			</a> <a class="right carousel-control" href="#myCarousel"
				data-slide="next"> <span
				class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>
	</div>




 -->







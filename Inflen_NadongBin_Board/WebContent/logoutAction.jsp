<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>로그아웃 처리하기</title>
</head>
<body>
	<%
		session.invalidate();
	%>
	<script type="text/javascript">
		location.href = 'main.jsp';
	</script>
</body>
</html>
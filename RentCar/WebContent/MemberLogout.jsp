<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
   
<!DOCTYPE html>
<html>
<head>
	<title>로그아웃 하기</title>
</head>
<body>
	<%
		session.invalidate();
	%>
	<script type="text/javascript">
		location.href = 'RentcarMain.jsp';
	</script>
</body>
</html>
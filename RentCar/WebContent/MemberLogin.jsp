<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8" %>
   
<!DOCTYPE html>
<html>
<head>
	<title>로그인 하기</title>
</head>
<body>
	<form action="MemberLoginProc.jsp" method="post">
		<table width="300"  border = "1" bordercolor="gray">
			<tr height="100">
				<td align="center"colspan="3">
					<font size="6" color="gray">로그인</font>
				</td>
			</tr>
			
			<tr height ="40">
				<td width="120" align ="center">아이디</td>
				<td width="180"><input type="text" name="userId" size="15"></td>
			</tr>
			
			<tr height ="40">
				<td width="120" align ="center">패스워드</td>
				<td width="180"><input type="password" name="userPassword" size="15"></td>
			</tr>
			
			<tr height ="40">
				<td align ="center" colspan ="2"><input type="submit" value="로그인"></td>
			</tr>	
		</table>
	</form>
</body>
</html>
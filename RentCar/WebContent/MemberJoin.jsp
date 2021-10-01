<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>회원가입 하기</title>
</head>
<body>
	<div align="center">
		<h2>회원 가입</h2>
		<form action="MemberJoinAction.jsp">
			<table>
				<tr height="50">
					<td width="150" align="center">아이디 </td>
					<td width="350" align="center">
						<input type="text" name="userId" size="40" placeholder="id를 넣으세요">						
					</td>
				</tr>
				
				<tr height="50">
					<td width="150" align="center">패스워드</td>
					<td width="350" align="center">
						<input type="password" name="userPassword" size="40"
						placeholder="비밀번호를 입력해 주세요">						
					</td>
				</tr>
				
				<tr height="50">
					<td width="150" align="center">이메일</td>
					<td width="350" align="center">
						<input type="email" name="userEmail" size="40">						
					</td>
				</tr>
			
				<tr height="50" align="center">
					<td width="150" colspan="2">
						<input type="submit" value="회원 가입">&nbsp;&nbsp;&nbsp;	
						<input type="reset" value="취소">			
					</td>
				</tr>	
			</table>
		</form>	
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>main</title>
</head>
<body>
	<%
		String center = request.getParameter("center"); //자유게시판 등 메뉴를 눌렀을 때 바뀌어야 하니깐
		// 처음 실행할 때에는 center 값이 넘어오지 않았기에..... null값을 처리한다.
		if(center == null){
			center = "Center.jsp"; // 디폴트 center값을 부여한다.
		}
	%>
	<div align="center">
		<table width="1000">
			<!-- Top 부분이다. -->
			<tr height="140" align="center">
				<td align="center" width="1000"><jsp:include page="Top.jsp"/></td>
			</tr>
			<!-- Center 부분 -->
			<tr height="450" align="center">
				<td align="center" width="1000"><jsp:include page="<%=center %>"/></td>
			</tr>
			<!-- Bottom 부분 -->
			<tr height="100" align="center">
				<td align="center" width="1000"><jsp:include page="Bottom.jsp"/></td>
			</tr>
		</table>
	</div>
	
</body>
</html>
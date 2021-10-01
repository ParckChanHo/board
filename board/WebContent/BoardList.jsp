<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="model.BoardBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.BoardDAO" %>
<!DOCTYPE html>
<html>
<head>
	<title>전체 게시물 보기</title>
</head>
<style>
	a:link {
    color: black;
	}
	a:visited {
	    color: black;
	}
	a:hover {
	    color: red;  
	}
	a:active {
	    color: black;  
	}
	a{text-decoration:none}
</style>
<body>
	<!--게시글 보기에 카운터링을 설정하기 위한 변수들을 선언-->
	<%
		//화면에 보여질 게시글의 개수를 지정 
		int pageSize=10;
		
		//현재 카운터를 클릭한 번호 값을 읽어 옴 
		String pageNum = request.getParameter("pageNum");
		
		//만약 처음  boardlist.jsp를 클릭하거나 수정 삭제 등 다른 게시글에서 이 페이지로 넘어오면 pageNum값이 없기에 null값 처리 
		if(pageNum==null){
			pageNum="1"; //즉 처음 게시물을 보여주어야 한다.!!!
		}
		
		int count = 0; // 전체 글의 갯수를 저장하는 변수 
		int number = 0;//페이지 넘버링 변수
		
		//현재 보고자 하는 페이지 숫자를 지정
		int currentPage = Integer.parseInt(pageNum);
		
		//전체 게시글의 내용을 jsp쪽으로 가져와야 한다.
		BoardDAO bdao = new BoardDAO();
		//전체 게시글의 갯수를 반환해주는 메소드를 호출 
		count = bdao.getAllCount(); // 전체 게시물의 갯수를 알아야 하는 이유는 전체 게시물을 77개라고 가정을 하고 이것을 countering을 하면 [1] ~[8] 까지가 필요할 것이다. 따라서 이런식으로 전체 게시뭉의 갯수에 따라서 countering할 갯수가 달라지기 떄문이다. 
		// 만약 전체 게시물이 70개라면 [1] ~ [7] 까지만 countering을 해주면 된다.
		
		//현재 페이지에 보여줄 시작 번호를 설정  =>데이터 베이스에서 불러올 시작 번호 
		int startRow = (currentPage-1)*pageSize + 1;
		int endRow = currentPage * pageSize;
	
		//최신글 10개의 게시물을 리턴해주는 소스이다.
		ArrayList<BoardBean> vac = bdao.getAllBoard(startRow,endRow);
		//테이블에 표시할 번호 지정
		number = count  - (currentPage-1)*pageSize;
		//out.println("sample 입니다.");
	%>
	
	<h2>전체 게시물 보기</h2>
	<table width="700" border="1" bgcolor="skyblue">
		<tr height="40">
			<td align="right" colspan="5">
				<input type="button" value="글쓰기" onclick="location.href='BoardWriteForm.jsp'">
			</td>
		</tr>
		<tr height="40">
			<td width="50" align="center">번호</td>
			<td width="320" align="center">제목</td>
			<td width="100" align="center">작성자</td>
			<td width="150" align="center">작성일</td>
			<td width="80" align="center">조회수</td>
		</tr>
		<%
			for(int i=0; i<vac.size(); i++){
				BoardBean bean = vac.get(i); //ArrayList에 저장되어 있는 게시판을 하나씩 꺼낸다.		
		%>
				<tr height="40">
					<td width="50" align="center"><%=number--%></td> <!-- getNum()>> 글 번호를 의미한다. -->
					<td width="320" align="left"><a href="BoardInfo.jsp?num=<%=bean.getNum() %>"><!-- 댓글을 구현할 때 들여쓰기 때문이다. -->
					<%
						if(bean.getRe_step()>1){ // 즉 댓글일 때 댓글이 아니면 re_step이 1이다.
							for(int j=0;j<(bean.getRe_step()-1)*3;j++){
					%>&nbsp;<!-- for문 안 이다. 댓글을 달 때마다 3칸씩 덜어진다.-->
					<%
						
						}//for문 end
							} //if문 end
					%>
						<%=bean.getSubject() %></a></td> <!-- getSubject() >> 글 제목을 의미한다. -->
					<td width="100" align="center"><%=bean.getWriter() %></td><!-- 작성자 -->
					<td width="150" align="center"><%=bean.getReg_date() %></td> <!-- 작성일 -->
					<td width="80" align="center"><%=bean.getReadcount() %></td> <!-- 조회수 -->
				</tr>
	<%} %>
	</table>
	
	<p>
		<!-- 페이지 카운터링 소스를   -->
		<% 
			if(count > 0){
				int pageCount = count /pageSize + (count%pageSize == 0 ? 0 : 1 );//카운터링 숫자를 얼마까지 보여줄껀지 결정 
				
				//시작 페이지 숫자를 설정 
				int startPage = 1;
				if(currentPage%10 !=0){
					startPage = ((int)(currentPage/10))*10+1;
				}else{
					startPage = ((int)(currentPage/10)-1)*10+1;	
				}
				
				int pageBlock=10;//카운터링 처리 숫자 
				int endPage = startPage+pageBlock-1;//화면에 보여질 페이지의 마지막 숫자 
				
				 if(endPage > pageCount) endPage = pageCount;
				
				//이전이라는 링크를 만들건지 파악 	 
				if(startPage > 10){
		%>				
					<a href="BoardList.jsp?pageNum=<%=startPage-10%>">[이전]</a>
		<%			
				}	 
				//페이징 처리 
				for(int i=startPage;i<=endPage;i++){
		%>			
					<a href="BoardList.jsp?pageNum=<%=i%>">[<%=i %>]</a>
		<% 			
				}
				//다음이라는 링크를 만들건지 파악
				if(endPage < pageCount){
		%>		
				<a href="BoardList.jsp?pageNum=<%=startPage+10%>">[다음]</a>	
		<% 
				}	
			}
		%>
		</p>
</body>
</html>
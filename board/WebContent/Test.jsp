<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="model.BoardBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.BoardDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
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
		for(int i=0; i<vac.size(); i++){
			BoardBean bean = vac.get(i); //ArrayList에 저장되어 있는 게시판을 하나씩 꺼낸다.
			out.println("sample 입니다.");
			out.println(bean.getSubject()+" ");// 화면에 출력시키기
		}
		
		//테이블에 표시할 번호 지정
		number = count  - (currentPage-1)*pageSize;
	%>
</body>
</html>
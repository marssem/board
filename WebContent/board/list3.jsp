<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="test.Connector"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String[] searchs = request.getParameterValues("search");

Connection con = Connector.getConnection();
String sql = "select num, title, content, credat, creusr from board 1=1";
if(searchs!=null){
for(String search:searchs){
	sql += " and "+ search + " like concat('%',?,'%')";
}
}
PreparedStatement ps = con.prepareStatement(sql);
String searchStr = request.getParameter("searchStr");

for(int i=0;i<searchs.length;i++){
	ps.setString((i+1),searchs[i]);//database는 1부터 시작, i+1
}
ResultSet rs = ps.executeQuery();
%>
<form>
		<label for="title">제목</label><input type="checkbox" id="title" name="search"value="title">
		<label for="content">내용</label><input type="checkbox" id="content"name="search"value="content">
		<label for="creusr">유저</label><input type="checkbox" id="creusr"name="search"value="creusr">
		<input type="text" name="searchStr">
	<button>검색</button>
</form>
<table border="1">
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>내용</th>
		<th>작성일</th>
		<th>작성자</th>
	</tr>
	<%
	while(rs.next()){
	%>
	<tr>
		<td><%=rs.getInt("num") %></td>
		<td><%=rs.getString("title") %></td>
		<td><%=rs.getString("content") %></td>
		<td><%=rs.getString("credat") %></td>
		<td><%=rs.getString("creusr") %></td>
	</tr>
	<%
	}
	%>
	</table>
</body>
</html>
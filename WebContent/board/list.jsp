
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="test.Connector"%>
<%@page import="java.sql.Statement"%>
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
		String search = request.getParameter("search");
	String searchStr = request.getParameter("searchStr");

	Connection con = Connector.getConnection();

	String sql = "select num, title, content, credat, cretim, creusr  from board ";

	if (search != null && !"".equals(search)) {
		sql += " where ";
		if ("1".equals(search)) {
			sql += " num like concat('%',?,'%') ";
		} else if ("2".equals(search)) {
			sql += " title like concat('%',?,'%') ";
		} else if ("3".equals(search)) {
			sql += " title like concat('%',?,'%') ";
			sql += " or content like concat('%',?,'%') ";
		} else if ("4".equals(search)) {
			sql += " credat like concat('%',?,'%') ";
		} else if ("5".equals(search)) {
			sql += " creusr like concat('%',?,'%') ";
		}

	}
	PreparedStatement ps = con.prepareStatement(sql); //???
	if (search != null && !"".equals(search)) {
		ps.setString(1, searchStr);
		if ("3".equals(search)) {
			ps.setString(2, searchStr);
		}
	}
	ResultSet rs = ps.executeQuery();
	%>
	<form>
		<select name="search">
			<option value="1">번호</option>
			<option value="2">제목</option>
			<option value="3">제목+내용</option>
			<option value="4">등록일</option>
			<option value="5">작성자</option>
		</select> <input type="text" name="searchStr">
		<button>검색</button>
	</form>


	<table border="1">
		<tr>
			<th>번호</th>
			<th>content</th>
			<th>date</th>
			<th>time</th>
			<th>user</th>
		</tr>
		<%
			while (rs.next()) {//title, content, credat, cretim, creusr
		%>
		<tr>
			<td><%=rs.getString("num")%></td>
			<td><%=rs.getString("title")%></td>
			<td><%=rs.getString("credat")%></td>
			<td><%=rs.getString("cretim")%></td>
			<td><%=rs.getString("creusr")%></td>
		</tr>
		<%
			}
		%>
	</table>


</body>
</html>
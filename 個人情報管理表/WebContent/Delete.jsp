<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="ServletGroup.Common"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h4>下記住所を削除します。よろしいですか？</h4>
	<%
		String id = request.getParameter("id");
	%>
	<p>
		名前：<%
		out.println(request.getParameter("name"));
	%><br> 住所：<%
		out.println(request.getParameter("address"));
	%><br> 電話番号：<%
		out.println(request.getParameter("tel"));
	%><br> カテゴリ：<%
		out.println(request.getParameter("categoryname"));
	%>
	</p>

	<form>
		<input type="hidden" name="id" value="<%=id%>">
		<ul>
			<li style="list-style: none; display: inline-block;"><input
				formaction="http://localhost:8080/個人情報管理表/DeleteCommitBL"
				type="submit" name="send" value="OK"
				style="width: 100px; height: 25px"></li>
			<li
				style="list-style: none; display: inline-block; padding-left: 10px;"><input
				formaction="http://localhost:8080/個人情報管理表/ListBL" type="submit"
				name="send" value="キャンセル" style="width: 100px; height: 25px"></li>
		</ul>
	</form>
</body>
</html>
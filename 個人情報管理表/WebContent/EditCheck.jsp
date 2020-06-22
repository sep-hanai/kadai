<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="ServletGroup.Common"%>
<%@ page import="java.sql.SQLException"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h4>住所録管理システム：住所録編集</h4>
	<!-- ここからフォーム画面 -->
	<form method="POST">

		<!-- AddBLから受け取り -->
		<%
			String id = (String) request.getAttribute("id");
		%>
		<%
			String name = (String) request.getAttribute("name");
		%>
		<%
			String address = (String) request.getAttribute("address");
		%>
		<%
			String tel = (String) request.getAttribute("tel");
		%>
		<%
			String categoryid = (String) request.getAttribute("categoryid");
		String categoryname="";

//		CommonからgetCategorynameを呼び出し
		Common cmn = new Common();
		ResultSet rs = cmn.getCategoryname(categoryid);
		try {
			rs.next();
			categoryname = rs.getString("categoryname");
			System.out.println(categoryname);

		} catch (SQLException e) {
			System.out.println("Connection Err. : " + e.toString());
		}

		%>


		<p>
			名前：<%
			out.println(name);
		%><br> 住所：<%
			out.println(address);
		%><br>
			電話番号：<%
			out.println(tel);
		%><br>
		カテゴリ：<%out.println(categoryname);%>
		</p>

		<input type="hidden" name="id" value="<%=id%>"> <input
			type="hidden" name="name" value="<%=name%>"> <input
			type="hidden" name="address" value="<%=address%>"> <input
			type="hidden" name="tel" value="<%=tel%>"> <input
			type="hidden" name="categoryid" value="<%=categoryid%>">
		<ul>
			<li style="list-style: none; display: inline-block;"><input
				formaction="http://localhost:8080/個人情報管理表/EditCommitBL"
				type="submit" name="send" value="編集"
				style="width: 100px; height: 25px"></li>
			<li
				style="list-style: none; display: inline-block; padding-left: 10px;"><input
				formaction="http://localhost:8080/個人情報管理表/ListBL" type="submit"
				name="send" value="戻る" style="width: 100px; height: 25px"></li>
		</ul>
	</form>

</body>
</html>
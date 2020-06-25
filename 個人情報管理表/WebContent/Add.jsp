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
	<h4>住所録管理システム：住所録登録</h4>

	<!-- ここからフォーム画面 -->
	<form method="POST">
		<ul>
			<li style="list-style: none;"><label for="1">名前＊：</label><input
				type="text" name="name" id="1"></li>
			<li style="list-style: none;"><label for="2">住所＊：</label><input
				style="width: 300px;" type="text" name="address" id="2"></li>
			<li style="list-style: none;"><label for="3">電話番号：</label><input
				type="text" name="tel" id="3"></li>
			<li style="list-style: none;"><label for="4">カテゴリ：</label><select
				name="categoryid" id="4">
					<!-- ドロップダウン -->
					<!-- CommonのgetCategoryAllを呼び出す -->
					<%
						Common cmn = new Common();
						ResultSet rs = cmn.getCategoryAll();
						while (rs.next()) {
							String categoryid = rs.getString("categoryid");
							String categoryname = rs.getString("categoryname");
					%>
					<option value="<%=categoryid%>">
						<%
							out.println(categoryid + categoryname);
						%>
					</option>
					<%
						}
					%>
			</select></li>

			<li style="list-style: none; display: inline-block;"><input
				formaction="./AddBL" type="submit"
				name="send" value="確認" style="width: 100px; height: 25px"></li>
			<li
				style="list-style: none; display: inline-block; padding-left: 10px;"><input
				formaction="./ListBL" type="submit"
				name="send" value="戻る" style="width: 100px; height: 25px"></li>
		</ul>
	</form>

	<!-- エラー文受け取り -->
	<%
		String returnVal = (String) request.getAttribute("returnVal");
	%>
	<%
		if (returnVal != null) {
	%>
	<p>エラーメッセージ</p>
	<div
		style="padding: 10px; margin-bottom: 10px; border: 5px double #333333;">
		<%
			{
					out.println(returnVal);
				}
		%><br>
	</div>
	<%
		}
	%>

</body>
</html>
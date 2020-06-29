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
	<h4>住所録管理システム：住所録編集</h4>

	<!-- ここからフォーム画面 -->
	<%
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		String tel = request.getParameter("tel");
		String categoryname = request.getParameter("categoryname");
		String errmsg = request.getParameter("errmsg");
		//EditBLから来た時用
		String categoryid1 = request.getParameter("categoryid");
	%>
	<form>
		<input type="hidden" name="id" value="<%=id%>">
		<ul>
			<li style="list-style: none;"><label for="1">名前＊：</label><input
				style="width: 350px;" type="text" name="name" id="1"
				value="<%=name%>"></li>
			<li style="list-style: none;"><label for="2">住所＊：</label><input
				style="width: 500px;" type="text" name="address" id="2"
				value="<%=address%>"></li>
			<li style="list-style: none;"><label for="3">電話番号：</label><input
				type="text" name="tel" id="3" value="<%=tel%>"></li>
			<li style="list-style: none;"><label for="4">カテゴリ：</label><select
				name="categoryid" id="4">

					<!-- ドロップダウン -->
					<!-- CommonのgetCategoryAllを呼び出す -->
					<%
						Common cmn = new Common();
						ResultSet rs = cmn.getCategoryAll();
						while (rs.next()) {
							String categoryid = rs.getString("categoryid");
							String categoryname2 = rs.getString("categoryname");
							//初期値の判定
							//EditBLから戻ってきたとき（＝エラーがあったとき）
							if (categoryname == null) {
								if (categoryid1.equals(categoryid)) {
					%>
					<option selected value="<%=categoryid%>"><%=categoryid + categoryname2%></option>
					<%
						} else {
					%>
					<option value="<%=categoryid%>">
						<%=categoryid + categoryname2%>
					</option>
					<%
						}
							} else {
								//List.jspから来た時
								if (categoryname.equals(categoryname2)) {
					%>
					<option selected value="<%=categoryid%>"><%=categoryid + categoryname2%></option>
					<%
						} else {
					%>
					<option value="<%=categoryid%>">
						<%=categoryid + categoryname2%>
					</option>
					<%
						}
							}
						}
					%>
			</select></li>

			<li style="list-style: none; display: inline-block;"><input
				formaction="./EditBL" type="submit" name="send" value="確認"
				style="width: 100px; height: 25px"></li>
			<li
				style="list-style: none; display: inline-block; padding-left: 10px;"><input
				formaction="./ListBL" type="submit" name="send" value="戻る"
				style="width: 100px; height: 25px"></li>
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
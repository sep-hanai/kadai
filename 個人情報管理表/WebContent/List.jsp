<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="ServletGroup.Common"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!--スポンシブデザイン-->

</head>

<body>
	<%
		String nowPage = (String) request.getAttribute("nowPage");
		int listCnt = (int) request.getAttribute("listCnt");
		int maxPage = (listCnt / 10);
		if (listCnt % 10 != 0) {
			maxPage++;
		}
		ResultSet rs = (ResultSet) request.getAttribute("Result");
	%>

	<h4>住所録管理システム：住所録一覧</h4>

	<!-- ここからフォーム画面 -->
	<!-- 新規登録 -->
	<form>
		<input formaction="http://localhost:8080/個人情報管理表/Add.jsp"
			type="submit" name="send" value="新規登録"
			style="width: 100px; height: 25px">
	</form>

	<!-- 検索欄 -->
	<form>
		<div style="float: right">
			<table border="1" style="width: 40px; border-collapse: collapse;">
				<tr>
					<td><input style="outline: 0; border: 0px;" type="text"
						name="Serchname"></td>
				</tr>
				<tr>
					<td><input
						style="width: 100%; background: transparent; maxlength =100; outline: 0; border: 0px;"
						type="submit" value="検索"></td>
				</tr>
			</table>
		</div>
		<p style="float: right">住所：</p>
	</form>

	<!-- ページ選択 -->
	<!-- <ul>
 <li style="display:inline;">
  <a href="#">&lt;&lt;</a>
 </li>
 <li style="display:inline;">
  <a href="#">&lt;</a>
 </li>
 <li style="display:inline;">
  <a href="?page -0&size6">1</a>
 </li>
 <li style="display:inline;">
  <a href="?page=1&size6">2</a>
 </li>
  <li style="display:inline;">
  <a href="?page=2&size6">3</a>
 </li>
 <li style="display:inline;">
  <a href="?page=3&size6">4</a>
 </li>
  <li style="display:inline;">
  <a href="?page=4&size6">5</a>
 </li>
 <li style="display:inline;">
  <a href="#">&gt;</a>
 </li>
 <li style="display:inline;">
  <a href="#">&gt;&gt;</a>
 </li>
</ul>-->
	<!-- ページネーション -->
	<ul>
		<li style="display: inline;"><a href="#">&lt;&lt;</a></li>
		<li style="display: inline;"><a href="#">&lt;</a></li>
		<%

			//maxPageまでPageにナンバリング
					for (int Page = 1; Page <= maxPage; Page++) {
		%>
		<li style="display: inline;"><a href="ListBL?Page=<%=Page%>"><%=Page%></a></li>
		<%
					}
		%><li style="display: inline;"><a href="#">&gt;</a></li>
		<li style="display: inline;"><a href="#">&gt;&gt;</a></li>
	</ul>

	<!-- DB表示 -->
	<table border="1"
		style="border-collapse: collapse; margin: 0 auto; width: 90%">
		<tr align="center" style="background-color: #6699FF;">
			<!-- 一覧表示 -->
			<th style="width: 5%">No.</th>
			<th style="width: 18%">名前</th>
			<th style="width: 30%">住所</th>
			<th style="width: 17%">電話番号</th>
			<th style="width: 15%">カテゴリ</th>
			<th colspan="2" style="width: 15%">&nbsp;</th>
		</tr>
		<%
			while (rs.next()) {
				String id = rs.getString("id");
				String name = rs.getString("name");
				String address = rs.getString("address");
				String categoryname = rs.getString("categoryname");
				//ハイフン
				String tel1 = rs.getString("tel");
				//CommonからgetCategorynameを呼び出し
				Common cmn = new Common();
				String tel = cmn.telHyphen(tel1);
		%>


		<Form name=<%=id%>>
			<tr align="center">
				<td>
					<%
						out.println(id);
					%>
				</td>
				<td>
					<%
						out.println(name);
					%>
				</td>
				<td>
					<%
						out.println(address);
					%>
				</td>
				<td>
					<%
						out.println(tel);
					%>
				</td>
				<td>
					<%
						out.println(categoryname);
					%>
				</td>
				<!-- POSTする -->
				<td><input formaction="http://localhost:8080/個人情報管理表/Edit.jsp"
					name="edit"
					style="width: 100%; background-color: #ffdab9; maxlength =100; outline: 0; border: 0px;"
					type="submit" value="編集"></td>
				<td><input
					formaction="http://localhost:8080/個人情報管理表/Delete.jsp" name="delete"
					style="width: 100%; background-color: #87cefa; maxlength =100; outline: 0; border: 0px;"
					type="submit" value="削除"></td>
			</tr>
			<input type="hidden" name="id" value="<%=id%>"> <input
				type="hidden" name="name" value="<%=name%>"> <input
				type="hidden" name="address" value="<%=address%>"> <input
				type="hidden" name="tel" value="<%=tel%>"> <input
				type="hidden" name="categoryname" value="<%=categoryname%>">
		</form>
		<%
			}
		%>

	</table>


	<!-- 新規登録 -->
	<form method="POST" action="/個人情報管理表/Add.jsp">
		<div>
			<input formaction="http://localhost:8080/個人情報管理表/Add.jsp"
				type="submit" value="新規登録" style="width: 100px; height: 25px">
		</div>
	</form>
</body>
</html>
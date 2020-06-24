<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="ServletGroup.Common"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/個人情報管理表/css/sample.css">
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
		<input formaction="http://localhost:8080/./Add.jsp"
			type="submit" name="send" value="新規登録"
			style="width: 100px; height: 25px">
	</form>


	<!-- 住所検索欄 -->
	<form>
		<div style="float: right">
			<table style="border-collapse: collapse;">
				<tr>
					<td class="jyusyo">住所：</td>
					<td class="border"><input
						style="width: 150px; outline: 0; border: 0px; maxlength: 100;"
						type="text" name="Serchname"></td>
				</tr>
				<tr>
					<td class="jyusyo"></td>
					<td class="border"><input
						style="width: 100%; background: transparent; outline: 0; border: 0px;"
						type="submit" value="検索"></td>
				</tr>
			</table>
		</div>
	</form>

<!-- ページネーション -->
	<ul>
		<%
			//nowPageをint型に置換
			int centerPage = (Integer.parseInt(nowPage));

			//最初のページ、一つ前のページへ
			if (centerPage == 1) {
		%>
		<li style="display: inline;">&lt;&lt;</li>
		<li style="display: inline;">&lt;</li>
		<%
			} else {
		%>
		<li style="display: inline;"><a
			href="http://localhost:8080/./ListBL?Page=1">&lt;&lt;</a></li>
		<li style="display: inline;"><a
			href="ListBL?Page=<%=centerPage - 1%>">&lt;</a></li>
		<%
			}
		%>

		<%

			//nowPageが3以下の場合、1-5を表示
			if (centerPage <= 3) {
				for (int Page = 1; Page <= 5; Page++) {

					//現在ページの不非活性化
					if (centerPage == Page) {
		%>
		<li style="display: inline;"><%=centerPage%></li>
		<%
			} else {
		%>
		<li style="display: inline;"><a href="ListBL?Page=<%=Page%>"><%=Page%></a></li>
		<%
			}
				}
				//nowPageがmaxPage-2より大きい場合、maxPage-4を表示
			} else if (centerPage > (maxPage - 2)) {
				for (int Page = (maxPage - 4); Page <= maxPage; Page++) {

					//現在ページの不非活性化
					if (centerPage == Page) {
		%><li style="display: inline;"><%=centerPage%></li>
		<%
			} else {
		%>
		<li style="display: inline;"><a href="ListBL?Page=<%=Page%>"><%=Page%></a></li>
		<%
			}
				}
				//それ以外の場合、nowPageを中心に+-2ページを表示
			} else {
				for (int Page = (centerPage - 2); Page <= (centerPage + 2); Page++) {

					//現在ページの不非活性化
					if (centerPage == Page) {
		%><li style="display: inline;"><%=centerPage%></li>
		<%
			} else {
		%>
		<li style="display: inline;"><a href="ListBL?Page=<%=Page%>"><%=Page%></a></li>
		<%
			}
				}
			}

			//最後のページ、最後から一つ前のページへ
			if (centerPage == maxPage) {
		%>
		<li style="display: inline;">&gt;</li>
		<li style="display: inline;">&gt;&gt;</li>
		<%
			} else {
		%>
		<li style="display: inline;"><a
			href="ListBL?Page=<%=centerPage + 1%>">&gt;</a></li>
		<li style="display: inline;"><a
			href="http://localhost:8080/./ListBL?Page=<%=maxPage%>">&gt;&gt;</a></li>
		<%
			}
		%>
	</ul>


	<!-- DB表示 -->
	<table class="table" border="1"
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
				String addressAll = rs.getString("address");
		%>


		<Form name=<%=id%>>
			<tr align="center">
				<td><%=id%></td>
				<td><%=name%></td>

				<%
					if (address.length() > 13) {
							address = (address.substring(0, 13)) + "…";
				%>
				<td><div class="address"><%=address%><p class="text"><%=addressAll%></p>
					</div></td>
				<%
					} else {
				%>
				<td><%=address%></td>
				<%
					}
				%>
				<td><%=tel%></td>
				<td><%=categoryname%></td>
				<!-- POSTする -->
				<td><input formaction="http://localhost:8080/./Edit.jsp"
					name="edit"
					style="width: 100%; background-color: #ffdab9; maxlength =100; outline: 0; border: 0px;"
					type="submit" value="編集"></td>
				<td><input
					formaction="http://localhost:8080/./Delete.jsp" name="delete"
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

	<!-- ページネーション -->
	<ul>
		<%

			//最初のページ、一つ前のページへ
			if (centerPage == 1) {
		%>
		<li style="display: inline;">&lt;&lt;</li>
		<li style="display: inline;">&lt;</li>
		<%
			} else {
		%>
		<li style="display: inline;"><a
			href="http://localhost:8080/./ListBL?Page=1">&lt;&lt;</a></li>
		<li style="display: inline;"><a
			href="ListBL?Page=<%=centerPage - 1%>">&lt;</a></li>
		<%
			}
		%>

		<%

			//nowPageが3以下の場合、1-5を表示
			if (centerPage <= 3) {
				for (int Page = 1; Page <= 5; Page++) {

					//現在ページの不非活性化
					if (centerPage == Page) {
		%>
		<li style="display: inline;"><%=centerPage%></li>
		<%
			} else {
		%>
		<li style="display: inline;"><a href="ListBL?Page=<%=Page%>"><%=Page%></a></li>
		<%
			}
				}
				//nowPageがmaxPage-2より大きい場合、maxPage-4を表示
			} else if (centerPage > (maxPage - 2)) {
				for (int Page = (maxPage - 4); Page <= maxPage; Page++) {

					//現在ページの不非活性化
					if (centerPage == Page) {
		%><li style="display: inline;"><%=centerPage%></li>
		<%
			} else {
		%>
		<li style="display: inline;"><a href="ListBL?Page=<%=Page%>"><%=Page%></a></li>
		<%
			}
				}
				//それ以外の場合、nowPageを中心に+-2ページを表示
			} else {
				for (int Page = (centerPage - 2); Page <= (centerPage + 2); Page++) {

					//現在ページの不非活性化
					if (centerPage == Page) {
		%><li style="display: inline;"><%=centerPage%></li>
		<%
			} else {
		%>
		<li style="display: inline;"><a href="ListBL?Page=<%=Page%>"><%=Page%></a></li>
		<%
			}
				}
			}

			//最後のページ、最後から一つ前のページへ
			if (centerPage == maxPage) {
		%>
		<li style="display: inline;">&gt;</li>
		<li style="display: inline;">&gt;&gt;</li>
		<%
			} else {
		%>
		<li style="display: inline;"><a
			href="ListBL?Page=<%=centerPage + 1%>">&gt;</a></li>
		<li style="display: inline;"><a
			href="http://localhost:8080/./ListBL?Page=<%=maxPage%>">&gt;&gt;</a></li>
		<%
			}
		%>
	</ul>


	<!-- 新規登録 -->
	<form method="POST" action="/./Add.jsp">
		<input formaction="http://localhost:8080/./Add.jsp"
			type="submit" value="新規登録" style="width: 100px; height: 25px">
	</form>
</body>
</html>
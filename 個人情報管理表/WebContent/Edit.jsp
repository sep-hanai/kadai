<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h4>住所録管理システム：住所録編集</h4>

<!-- ここからフォーム画面 -->
<% String name = request.getParameter("name");
String address = request.getParameter("address");
String tel = request.getParameter("tel");
String categoryid = request.getParameter("category");%>
<form>
 <ul>
  <li style="list-style: none;">
   <label for="1">名前＊：</label><input type="text" name="name" id="1" value="<%=name%>"></li>
  <li style="list-style: none;">
   <label for="2">住所＊：</label><input style="width:300px;" type="text" name="address" id="2" value="<%=address%>"></li>
  <li style="list-style: none;">
   <label for="3">電話番号：</label><input type="text" name="tel" id="3"value="<%=tel%>"></li>
  <li style="list-style: none;">
   <label for="4">カテゴリ：</label><select name="category" id="4">
 <!-- ドロップダウン -->
 <!-- jspからDBに接続 -->
   <option value=""></option>
   </select></li>
  <li style="list-style: none; display: inline-block;"><input type="submit" name="send" value="確認" style="width:100px;height:25px"></li>
  <li style="list-style: none; display: inline-block; padding-left:10px;"><input type="submit" name="send" value="戻る" style="width:100px;height:25px"></li>
 </ul>
</form>
</body>
</html>
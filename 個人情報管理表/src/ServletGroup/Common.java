package ServletGroup;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Common {
	public String getErr(String name, String address, String tel) {
		String returnVal = "";

		try {
			if (name.getBytes("Shift_JIS").length > 40) {
				returnVal += "名前は全角20文字以内で入力してください" + "<BR>";
			}
			if (name.getBytes("Shift_JIS").length == 0) {
				returnVal += "名前は必須項目です" + "<BR>";
			}
			if (address.getBytes("Shift_JIS").length > 80) {
				returnVal += "住所は全角40文字以内で入力してください" + "<BR>";
			}
			if (address.getBytes("Shift_JIS").length == 0) {
				returnVal += "住所は必須項目です" + "<BR>";
			}
			//電話番号、文字数制限
			int t = tel.getBytes("Shift_JIS").length;
			if (tel == "") {
			}else if (tel.matches(".*^0[0-9]{2}-[0-9]{4}-[0-9]{4}.*") != true || 13 < t || (1 <= t && 13 > t)) {
				returnVal += "電話番号は「000-0000-0000」の形式で入力してください" + "<BR>";
			}
		} catch (UnsupportedEncodingException e) {
			// TODO 自動生成された catch ブロック
			e.printStackTrace();
		}

		return returnVal;
	}

	//DB接続
	public ResultSet getCategoryAll() {
		//接続準備
		String user = "root";
		String password = "";
		String url = "jdbc:mysql://localhost:3306/hanai?characterEncoding=UTF-8&serverTimezone=JST";
		Connection connect = null;
		Statement stmt = null;
		ResultSet rs = null;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connect = DriverManager.getConnection(url, user, password);
			stmt = connect.createStatement();
			String getQuery = "SELECT * FROM category ORDER BY categoryid ASC";
			rs = stmt.executeQuery(getQuery);

		} catch (SQLException e) {
		} catch (ClassNotFoundException e) {
		}

		return rs;
	}

	//DB接続
	public ResultSet getCategoryname(String categoryid) {
		//接続準備
		String user = "root";
		String password = "";
		String url = "jdbc:mysql://localhost:3306/hanai?characterEncoding=UTF-8&serverTimezone=JST";
		Connection connect = null;
		ResultSet rs = null;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connect = (Connection) DriverManager.getConnection(url, user, password);

			String getQuery = "SELECT categoryid, categoryname FROM category WHERE categoryid = ?";
			PreparedStatement ps = connect.prepareStatement(getQuery);
			ps.setString(1, categoryid);
			rs = ps.executeQuery();

		} catch (SQLException e) {
		} catch (ClassNotFoundException e) {
		}

		return rs;
	}

	public String telHyphen(String tel1) {
		//ハイフン入れるメソッド
		String tel = "";
		if (tel1.length() == 11) {
			Pattern p = Pattern.compile("(\\d{3})(\\d{4})(\\d{4})");
			Matcher m = p.matcher(tel1);
			tel = m.replaceAll("$1-$2-$3");
		} else if (tel1.length() == 10) {
			Pattern p = Pattern.compile("(\\d{2})(\\d{4})(\\d{4})");
			Matcher m = p.matcher(tel1);
			tel = m.replaceAll("$1-$2-$3");
		}
		return tel;
	}
}

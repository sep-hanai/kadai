package ServletGroup;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Common {
	public String getErr(String name, String address, String tel) {
		String returnVal = "";
		if (name.length() > 20) {returnVal = "名前は全角20文字以内で入力してください";}
		else if (name.length() == 0) {returnVal = "名前は必須項目です";}
		else if (address.length() > 40) {returnVal = "住所は全角40文字以内で入力してください";}
		else if (address.length() == 0) {returnVal = "住所は必須項目です";}
		else if (tel.matches(".*^0[0-9]{2}-[0-9]{4}-[0-9]{4}.*")!=true && tel.matches(".*^0[0-9]-[0-9]{4}-[0-9]{4}.*") != true && tel.matches(".*^0[0-9]{2}-[0-9]{3}-[0-9]{4}.*")!=true) {returnVal = "電話番号は「000-0000-0000」の形式で入力してください";}


		return returnVal;
	}


////DB接続
//	public ResultSet getArray(String date){
//	//接続準備
//	String servername = "localhost";
//	String databasename ="住所録";
//	String user ="root";
//	String password = "";
//	String serverencoding = "UTF-8";
//	String url = "jdbc:mysql://localhost:3306/住所録?characterEncoding=UTF-8&serverTimezone=JST";
//	Connection connect=null;
//	Statement stmt=null;
//    ResultSet rs = null;
//
//		try {
//			Class.forName("com.mysql.cj.jdbc.Driver");
//			connect = DriverManager.getConnection(url, user, password);
//			System.out.println("Connected....");
//
//			stmt= connect.createStatement();
//			String getQuery = "SELECT * FROM jyusyoroku";
//			rs = stmt.executeQuery(getQuery);
//
//			rs.close();
//		    stmt.close();
//			connect.close();
//		}
//		catch(SQLException e) {
//			System.out.println("Connection Failed. : " + e.toString());
//		}catch (ClassNotFoundException e) {
//			System.out.println("ドライバを読み込めませんでした" + e);
//		}
//		finally {
//			try {
//				if(connect != null) {
//					connect.close();
//				}
//			}
//			catch(Exception e) {
//				System.out.println("Exception2! :" + e.toString());
//			}
//		}
//		return rs;
// }
	//DB接続
		public ResultSet getCategoryAll(){
		//接続準備
		String servername = "localhost";
		String databasename ="住所録";
		String user ="root";
		String password = "";
		String serverencoding = "UTF-8";
		String url = "jdbc:mysql://localhost:3306/住所録?characterEncoding=UTF-8&serverTimezone=JST";
		Connection connect=null;
		Statement stmt=null;
	    ResultSet rs = null;

			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				connect = DriverManager.getConnection(url, user, password);
				System.out.println("Connected....");

				stmt= connect.createStatement();
				String getQuery = "SELECT * FROM category ORDER BY categoryid ASC";
				rs = stmt.executeQuery(getQuery);


			}
			catch(SQLException e) {
				System.out.println("Connection Failed. : " + e.toString());
			}catch (ClassNotFoundException e) {
				System.out.println("ドライバを読み込めませんでした" + e);
			}

			return rs;
	 }
		//DB接続
				public ResultSet getCategoryname(String categoryid){
				//接続準備
				String servername = "localhost";
				String databasename ="住所録";
				String user ="root";
				String password = "";
				String serverencoding = "UTF-8";
				String url = "jdbc:mysql://localhost:3306/住所録?characterEncoding=UTF-8&serverTimezone=JST";
				Connection connect=null;
			    ResultSet rs = null;
//			    String categoryid = null;

					try {
						Class.forName("com.mysql.cj.jdbc.Driver");
						connect = (Connection)DriverManager.getConnection(url, user, password);
						System.out.println("Connected....");

						String getQuery = "SELECT categoryid, categoryname FROM category WHERE categoryid = ?";
						PreparedStatement ps = connect.prepareStatement(getQuery);
						ps.setString(1, categoryid);
                        rs = ps.executeQuery();

					}
					catch(SQLException e) {
						System.out.println("Connection Failed. : " + e.toString());
					}catch (ClassNotFoundException e) {
						System.out.println("ドライバを読み込めませんでした" + e);
					}

					return rs;
			 }
}


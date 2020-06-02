package ServletGroup;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AddCommitBL
 */
@WebServlet("/AddCommitBL")
public class AddCommitBL extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddCommitBL() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");

        //AddCheck.jspからform受け取り
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		String tel = request.getParameter("tel");
		String categoryid = request.getParameter("categoryid");
//        System.out.println(name + address + tel + categoryid);

//		CommonからgetCategorynameを呼び出し
		Common cmn = new Common();
		ResultSet rs =  cmn.getCategoryname(categoryid);
		try {
	    rs.next();
//	    categoryid = rs.getString("categoryid");
		String categoryname = rs.getString("categoryname");
		System.out.println(categoryname);

		}catch(SQLException e) {
			System.out.println("Connection Err. : " + e.toString());
		}

//		TELのハイフンを抜く、正規表現の置換
		tel.replaceAll("-", "");

//		requestセットしてINSERT
		request.setAttribute("name", name);
		request.setAttribute("address", address);
		request.setAttribute("tel", tel);
		request.setAttribute("categoryid", categoryid);


		String servername = "localhost";
		String databasename ="住所録";
		String user ="root";
		String password = "";
		String serverencoding = "UTF-8";
		String url = "jdbc:mysql://localhost:3306/住所録?characterEncoding=UTF-8&serverTimezone=JST";
		Connection connect=null;
	    ResultSet result = null;
//	    String categoryid = null;

			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				connect = DriverManager.getConnection(url, user, password);
				System.out.println("Connected....");

				String InsQuery = "INSERT INTO jyusyoroku (name, address, tel, categoryid, delete_flg) VALUE (?, ?, ?, ?, '0')";
				PreparedStatement ps = connect.prepareStatement(InsQuery);
				ps.setString(1, name);
				ps.setString(2, address);
				ps.setString(3, tel);
				ps.setString(4, categoryid);
				int num = ps.executeUpdate();
			}
			catch(SQLException e) {
				System.out.println("Connection Failed.INSERT失敗 : " + e.toString());
			}catch (ClassNotFoundException e) {
				System.out.println("ドライバを読み込めませんでした" + e);
			}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

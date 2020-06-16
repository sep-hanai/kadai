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
 * Servlet implementation class EditCommitBL
 */
@WebServlet("/EditCommitBL")
public class EditCommitBL extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EditCommitBL() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		//		response.getWriter().append("Served at: ").append(request.getContextPath());
		request.setCharacterEncoding("UTF-8");

		//EditCheck.jspから受け取り
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		String tel = request.getParameter("tel");
		String categoryid = request.getParameter("categoryid");
		System.out.println(id);

		//		TELのハイフンを抜く、正規表現の置換
		String tel1 = tel.replaceAll("-", "");

		String servername = "localhost";
		String databasename = "hanai";
		String user = "root";
		String password = "";
		String serverencoding = "UTF-8";
		String url = "jdbc:mysql://localhost:3306/hanai?characterEncoding=UTF-8&serverTimezone=JST";
		Connection connect = null;
		ResultSet result = null;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connect = DriverManager.getConnection(url, user, password);
			System.out.println("UPDATE.Connected....");

			String UpdQuery = "UPDATE jyusyoroku SET name=?, address=?, tel=?, categoryid=?, delete_flg=0 WHERE id=?";
			PreparedStatement ps = connect.prepareStatement(UpdQuery);
			ps.setString(1, name);
			ps.setString(2, address);
			ps.setString(3, tel1);
			ps.setString(4, categoryid);
			ps.setString(5, id);
			int num = ps.executeUpdate();
			//			connect.commit();
		} catch (SQLException e) {
			System.out.println("Connection Failed.UPDATE失敗 : " + e.toString());
		} catch (ClassNotFoundException e) {
			System.out.println("ドライバを読み込めませんでした" + e);
		}
		getServletContext().getRequestDispatcher("/ListBL").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

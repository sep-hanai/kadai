package ServletGroup;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DeleteCommitBL
 */
@WebServlet("/DeleteCommitBL")
public class DeleteCommitBL extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DeleteCommitBL() {
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
		String id = request.getParameter("id");
		//		System.out.println(id);

		String servername = "localhost";
		String databasename = "hanai";
		String user = "root";
		String password = "";
		String serverencoding = "UTF-8";
		String url = "jdbc:mysql://localhost:3306/hanai?characterEncoding=UTF-8&serverTimezone=JST";
		Connection connect = null;

		//	    String categoryid = null;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connect = DriverManager.getConnection(url, user, password);
			System.out.println("UPDATE.Connected....");

			String UpdQuery = "UPDATE jyusyoroku SET delete_flg=1 WHERE id=?";
			PreparedStatement ps = connect.prepareStatement(UpdQuery);
			ps.setString(1, id);
			int num = ps.executeUpdate();
			connect.commit();
		} catch (SQLException e) {
			System.out.println("Connection Failed.DELETE失敗 : " + e.toString());
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

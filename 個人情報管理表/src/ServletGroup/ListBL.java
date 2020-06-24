package ServletGroup;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ListBL
 */
@WebServlet("/ListBL")
public class ListBL extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String nowPage = "";

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ListBL() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	//DBにアクセス
	@SuppressWarnings("resource")
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		//接続準備
		String user = "root";
		String password = "";
		String url = "jdbc:mysql://localhost:3306/hanai?characterEncoding=UTF-8&serverTimezone=JST";
		//変数の宣言
		Connection connect = null;
		Statement stmt = null;
		ResultSet rs = null;
		int listCnt = 0;
		String SelectQuery = null;
		String CntQuery = null;
		String nowPage = "";

		String Page = request.getParameter("Page");
		if (Page == null) {
			nowPage = "1";

		} else {
			nowPage = Page;
		}
		int limitSta = (Integer.parseInt(nowPage) - 1) * 10;
		//DB接続して取得対象全件数を取得
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connect = DriverManager.getConnection(url, user, password);

			stmt = connect.createStatement();
			CntQuery = "SELECT COUNT(*) FROM jyusyoroku";
			rs = stmt.executeQuery(CntQuery);
			try {
				rs.next();
				listCnt = rs.getInt(1);

			} catch (SQLException e) {
			}

		} catch (SQLException e) {
		} catch (ClassNotFoundException e) {
		}

		String Serchname = request.getParameter("Serchname");

		if (Serchname == null) {
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				connect = DriverManager.getConnection(url, user, password);
				SelectQuery = "SELECT id, name, address, tel, categoryname FROM jyusyoroku JOIN category ON jyusyoroku.categoryid = category.categoryid WHERE delete_flg = '0' LIMIT 10 OFFSET ?";
				PreparedStatement ps = connect.prepareStatement(SelectQuery);
				ps.setInt(1, limitSta);
				rs = ps.executeQuery();

			} catch (SQLException e) {
			} catch (ClassNotFoundException e) {
			}
		} else {
			request.setAttribute("SerchName", Serchname);
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				connect = DriverManager.getConnection(url, user, password);

				SelectQuery = "SELECT id, name, address, tel, categoryname FROM jyusyoroku JOIN category "
						+ "ON jyusyoroku.categoryid = category.categoryid WHERE delete_flg = '0' AND address LIKE ? LIMIT ?, 10";
				PreparedStatement ps = connect.prepareStatement(SelectQuery);
				ps.setString(1, Serchname + "%");
				ps.setInt(2, limitSta);
				rs = ps.executeQuery();

			} catch (SQLException e) {
			} catch (ClassNotFoundException e) {
			}
		}
		request.setAttribute("listCnt", listCnt);
		request.setAttribute("Result", rs);
		request.setAttribute("nowPage", nowPage);
		getServletContext().getRequestDispatcher("/List.jsp").forward(request, response);

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

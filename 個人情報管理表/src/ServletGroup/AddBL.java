package ServletGroup;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AddBL
 */
@WebServlet("/AddBL")
public class AddBL extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddBL() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @param name
	 * @param address
	 * @param tel
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");

		//Add.jspからform受け取り
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		String tel = request.getParameter("tel");
		String categoryid = request.getParameter("categoryid");
		//        System.out.println(name + address + tel);
		//	    エラー文受け取り
		Common cmn = new Common();
		String returnVal = "";
		returnVal = cmn.getErr(name, address, tel);
		//       ここの（）内は"name"ではない、Addからのname
		if (returnVal == "") {
			request.setAttribute("name", name);
			request.setAttribute("address", address);
			request.setAttribute("tel", tel);
			request.setAttribute("categoryid", categoryid);
			getServletContext().getRequestDispatcher("/AddCheck.jsp").forward(request, response);
		} else {
			request.setAttribute("returnVal", returnVal);
			getServletContext().getRequestDispatcher("/Add.jsp").forward(request, response);
		}
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

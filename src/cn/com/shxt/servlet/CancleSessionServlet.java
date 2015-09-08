package cn.com.shxt.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CancleSessionServlet extends HttpServlet {

	private static final long serialVersionUID = 202359277494229165L;

	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.getSession().removeAttribute("user");
		request.getSession().removeAttribute("psw");
		request.getSession().removeAttribute("status");
		response.sendRedirect(request.getContextPath()+"/login.jsp");
	}

}

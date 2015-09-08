package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.util.JdbcUtil;

public class ConsumerModifyPswServlet extends HttpServlet {

	private static final long serialVersionUID = -3160273451793829985L;

	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String userPsw = request.getParameter("userPsw");
		String userAccount = request.getParameter("userAccount");
		
		String sql = "update consumer set c_psw='"+userPsw+"' where c_account='"+userAccount+"'";
		JdbcUtil db = new JdbcUtil();
		db.update(sql);
		request.getSession().removeAttribute("user");
		request.getSession().removeAttribute("psw");
		request.getSession().removeAttribute("status");
		response.sendRedirect(request.getContextPath()+"/login.jsp");
		//response.setHeader("refresh","1;url=request.getContextPath()+'/login.jsp'");
	}

}

package cn.com.shxt.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.util.JdbcUtil;

public class UserAccountValidateServlet extends HttpServlet {

	
	private static final long serialVersionUID = 1L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String userAccount = request.getParameter("userAccount").toString();
		
		JdbcUtil db = new JdbcUtil();
		PrintWriter out = response.getWriter();
		String sql = "select * from consumer where c_account='"+userAccount+"'";
		List<Map<String,Object>> list = db.query(sql);
		if(list.size()>0){
			out.print("1");
		}else{
			out.print("2");
		}
		
	}

}

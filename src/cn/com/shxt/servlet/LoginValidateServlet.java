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

public class LoginValidateServlet extends HttpServlet {


	private static final long serialVersionUID = 6497185040304907761L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String userAccount = request.getParameter("userAccount").toString();
		String userPsw = request.getParameter("userPsw").toString();
		//System.out.println(userAccount);
		JdbcUtil db = new JdbcUtil();
		PrintWriter out = response.getWriter();
		String sql = "select * from consumer where c_account='"+userAccount+"' and c_psw='"+userPsw+"'";
		List<Map<String,Object>> list = db.query(sql);
		//System.out.println(list.size());
		if(list.size()>0){
			out.print("1");
		}else{
			out.print("2");
		}
		out.flush();
		out.close();
	}

}

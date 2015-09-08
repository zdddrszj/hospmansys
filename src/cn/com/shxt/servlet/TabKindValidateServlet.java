package cn.com.shxt.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.service.TabletKindService;

public class TabKindValidateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String tabKindName = request.getParameter("tabKindName");
		TabletKindService tabletKindService = new TabletKindService();
		int result = tabletKindService.tabKindIsExist(tabKindName);
		
		PrintWriter out = response.getWriter();
		if(result>0){
			out.print("1");
		}else{
			out.print("2");
		}
		
	}

}

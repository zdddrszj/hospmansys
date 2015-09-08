package cn.com.shxt.servlet;

import java.io.IOException;
import java.io.PrintWriter;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.service.OfficeService;

public class OfficeValidateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String officeName = request.getParameter("officeName").toString();
		OfficeService officeService = new OfficeService();
		int result = officeService.officeIsExist(officeName);
		
		PrintWriter out = response.getWriter();
		if(result>0){
			out.print("1");
		}else{
			out.print("2");
		}
		
	}

}

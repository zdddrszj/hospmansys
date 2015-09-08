package cn.com.shxt.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.service.FactoryService;


public class FactoryValidateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String factoryName = request.getParameter("factoryName").toString();
		//int factoryId = Integer.parseInt(request.getParameter("factoryId").toString());
		
		FactoryService factoryService = new FactoryService();
		int result = factoryService.factoryIsExist(factoryName);
		
		PrintWriter out = response.getWriter();
		if(result>0){
			out.print("1");
		}else{
			out.print("2");
		}
	}

}

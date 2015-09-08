package cn.com.shxt.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.service.FactoryService;

public class GetFactorysServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
		
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		List<Map<String, Object>> list = new FactoryService().getAllFactory();
		
		response.setContentType("text/xml;charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		out.print("<root>");
		for(Map<String,Object> map : list){
			out.print("<factory>");
			out.print("<f_id>"+map.get("F_ID")+"</f_id>");
			out.print("<f_name>"+map.get("F_NAME")+"</f_name>");
			out.print("</factory>");
		}
		out.print("</root>");
		out.flush();
		out.close();
	}



}

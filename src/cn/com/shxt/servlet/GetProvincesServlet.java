package cn.com.shxt.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.service.ProvincesService;

@SuppressWarnings("serial")
public class GetProvincesServlet extends HttpServlet {

	
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
		
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		List<Map<String, Object>> list = new ProvincesService().getAllProvinces();
		
		response.setContentType("text/xml;charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		out.print("<root>");
		for(Map<String,Object> map : list){
			out.print("<province>");
			out.print("<p_id>"+map.get("P_ID")+"</p_id>");
			out.print("<p_name>"+map.get("P_NAME")+"</p_name>");
			out.print("</province>");
		}
		out.print("</root>");
	}

	
}

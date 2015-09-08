package cn.com.shxt.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.service.CitysService;;

public class GetCitysServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
		
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		int proId = Integer.parseInt(request.getParameter("proId").toString());
		List<Map<String, Object>> list = new CitysService().getAllCitys(proId);
		
		response.setContentType("text/xml;charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		out.print("<root>");
		for(Map<String,Object> map : list){
			out.print("<city>");
			out.print("<c_id>"+map.get("C_ID")+"</c_id>");
			out.print("<c_name>"+map.get("C_NAME")+"</c_name>");
			out.print("</city>");
		}
		out.print("</root>");
	}



}

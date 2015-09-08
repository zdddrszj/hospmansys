package cn.com.shxt.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.service.OfficeService;

public class GetOfficesServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
		
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		List<Map<String, Object>> list = new OfficeService().getAllOffice();
		
		response.setContentType("text/xml;charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		out.print("<root>");
		for(Map<String,Object> map : list){
			out.print("<office>");
			out.print("<o_id>"+map.get("O_ID")+"</o_id>");
			out.print("<o_name>"+map.get("O_NAME")+"</o_name>");
			out.print("</office>");
		}
		out.print("</root>");
	}



}

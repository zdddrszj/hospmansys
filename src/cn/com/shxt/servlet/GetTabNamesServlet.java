package cn.com.shxt.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.service.TabletStoreService;

public class GetTabNamesServlet extends HttpServlet {

	private static final long serialVersionUID = 1905635441854246518L;

	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<Map<String, Object>> list = new TabletStoreService().getAllTabNames();
		response.setContentType("text/xml;charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		out.print("<root>");
		for(Map<String,Object> map : list){
			out.print("<tablet>");
				out.print("<t_s_id>"+map.get("T_S_ID")+"</t_s_id>");
				out.print("<tab_name>"+map.get("T_S_NAME")+"</tab_name>");
			out.print("</tablet>");
		}
		out.print("</root>");
		out.flush();
		out.close();
	}

}

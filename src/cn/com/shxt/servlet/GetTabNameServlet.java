package cn.com.shxt.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.service.TabletKindService;
import cn.com.shxt.service.TabletStoreService;

public class GetTabNameServlet extends HttpServlet {

	private static final long serialVersionUID = 5601010875252933272L;

	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		int tabletKindId = Integer.parseInt(request.getParameter("tabletKind"));
		//System.out.println(tabletKindId);
		List<Map<String, Object>> list = new TabletStoreService().getAllTabName(tabletKindId);
		if(list.size()>0){
			response.setContentType("text/xml;charset=UTF-8");
			
			PrintWriter out = response.getWriter();
			
			out.print("<root>");
			for(Map<String,Object> map : list){
				out.print("<tab>");
					out.print("<t_s_id>"+map.get("T_S_ID")+"</t_s_id>");
					out.print("<tab_name>"+map.get("T_S_NAME")+"</tab_name>");
				out.print("</tab>");
			}
			out.print("</root>");
			out.flush();
			out.close();
		}else{
			System.out.println("Ò©Æ·Ãû³ÆÎª¿Õ£¡");
		}
	}
}

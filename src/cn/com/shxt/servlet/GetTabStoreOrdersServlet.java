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

public class GetTabStoreOrdersServlet extends HttpServlet {


	private static final long serialVersionUID = 7366269371706513452L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<Map<String, Object>> list = new TabletStoreService().getAllOrders();
		response.setContentType("text/xml;charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		out.print("<root>");
		for(Map<String,Object> map : list){
			out.print("<order>");
				out.print("<order_id>"+map.get("T_S_ID")+"</order_id>");
				out.print("<order_name>"+map.get("T_S_ORDER")+"</order_name>");
			out.print("</order>");
		}
		out.print("</root>");
		out.flush();
		out.close();
	}

}

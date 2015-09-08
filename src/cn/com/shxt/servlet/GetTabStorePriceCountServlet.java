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

public class GetTabStorePriceCountServlet extends HttpServlet {

	private static final long serialVersionUID = 8301868100585347942L;

	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int tabletStoreId = Integer.parseInt(request.getParameter("tabletStoreId"));
		//System.out.println(tabletStoreId);
		List<Map<String, Object>> list = new TabletStoreService().getAllTabPriceCount(tabletStoreId);
		if(list.size()>0){
			response.setContentType("text/xml;charset=UTF-8");
			
			PrintWriter out = response.getWriter();
			
			out.print("<root>");
			for(Map<String,Object> map : list){
				out.print("<tab>");
					out.print("<t_s_outprice>"+map.get("T_S_OUTPRICE")+"</t_s_outprice>");
					out.print("<t_s_unit>"+map.get("T_S_UNIT")+"</t_s_unit>");
					out.print("<t_s_count>"+map.get("T_S_COUNT")+"</t_s_count>");
				out.print("</tab>");
			}
			out.print("</root>");
			out.flush();
			out.close();
		}else{
			System.out.println("register表里药品名称为空！");
		}
	}

}

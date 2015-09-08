package cn.com.shxt.servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import cn.com.shxt.service.TabletStoreService;

public class TabStoreDetailServlet extends HttpServlet {


	private static final long serialVersionUID = -871651152018367933L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int tabStoreId = Integer.parseInt(request.getParameter("tabStoreId").toString());
		List<Map<String, Object>> list = new TabletStoreService().getTabStore(tabStoreId);
		//System.out.println("list.size()"+list.size());
		if(list.size()>0){
			request.setAttribute("oneTabStore", list);
			request.getRequestDispatcher("/tabRoomFunction/tabStoreModify.jsp").forward(request, response);
		}else{
			request.getRequestDispatcher("/tabRoomFunction/tabStoreModifyFailure.jsp").forward(request, response);
		}
	}
}

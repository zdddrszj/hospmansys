package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.TabletStore;
import cn.com.shxt.service.TabletStoreService;

public class TabStoreModifyCount extends HttpServlet {
	private static final long serialVersionUID = 8705369539463208609L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		TabletStore tabletStore = new TabletStore();
		
		String tabStoreCount = request.getParameter("tabStoreCount");
		String client = request.getParameter("client");
		String tabStoreId = request.getParameter("tabStoreId");
		
		tabletStore.setCount(Integer.parseInt(tabStoreCount)-Integer.parseInt(client));
		tabletStore.setId(Integer.parseInt(tabStoreId));
		TabletStoreService tabletStoreService = new TabletStoreService();
		
		Float money = tabletStoreService.getMoney(tabletStore,Integer.parseInt(client));
		int result = tabletStoreService.modify(tabletStore, Integer.parseInt(client));
		
		request.setAttribute("money", money);
		request.setAttribute("result", result);
		request.getRequestDispatcher("/tabRoomFunction/tabStoreDeleteResult.jsp").forward(request, response);
	}

}

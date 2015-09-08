package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.service.TabletStoreService;

public class TabStoreDeleteServlet extends HttpServlet {

	private static final long serialVersionUID = -9016289355619209086L;

	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String tabStoreId = request.getParameter("tabStoreId");
		request.setAttribute("oneTabStore", new TabletStoreService().getOne(Integer.parseInt(tabStoreId)));
		request.getRequestDispatcher("/tabRoomFunction/tabStoreCount.jsp").forward(request, response);
	}
}

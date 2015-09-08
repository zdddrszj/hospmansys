package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.TabletKind;
import cn.com.shxt.service.TabletKindService;

public class TabKindAddServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String tabKindName = request.getParameter("tabKindName");
		TabletKind tabletKind = new TabletKind();
		tabletKind.setName(tabKindName);
		
		TabletKindService tabletKindService = new TabletKindService();
		int result = tabletKindService.addTabKind(tabletKind);
		request.setAttribute("result", result);
		
		request.getRequestDispatcher("/tabRoomFunction/tabKindAddResult.jsp").forward(request, response);
	}
}

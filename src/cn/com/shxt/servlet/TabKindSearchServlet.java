package cn.com.shxt.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.service.TabletKindService;

public class TabKindSearchServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String currentPage = request.getParameter("currentPage");
		String sql = "select * from tablet_kind where T_K_STATUS='Õý³£' order by T_K_ID ";
		
		TabletKindService tabletKindService = new TabletKindService();
		
		PageBean pageBean = tabletKindService.pageList(sql, currentPage);
		
		request.setAttribute("pageBean", pageBean);
		request.getRequestDispatcher("/tabRoomFunction/tabKindSearch.jsp").forward(request, response);
	}

}

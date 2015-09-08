package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.model.TabletKind;
import cn.com.shxt.service.TabletKindService;

public class TabKindModifyServlet extends HttpServlet {

	private static final long serialVersionUID = -4384147208819333777L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String tabKindName = request.getParameter("tabKindName");
		String tabKindId = request.getParameter("tabKindId");
		tabKindName = new String(tabKindName.getBytes("iso-8859-1"),"UTF-8");

		TabletKind tabletKind = new TabletKind();
		tabletKind.setId(Integer.parseInt(tabKindId));
		tabletKind.setName(tabKindName);
		tabletKind.setStatus("正常");
		
		TabletKindService tabletKindService = new TabletKindService();
		int result = tabletKindService.modifyTabKind(tabletKind);
		if(result > 0){
			String currentPage = request.getParameter("currentPage");
			String sql = "select * from tablet_kind where T_K_STATUS='正常' order by T_K_ID ";
			
			PageBean pageBean = tabletKindService.pageList(sql, currentPage);
			
			request.setAttribute("pageBean", pageBean);
			request.getRequestDispatcher("/tabRoomFunction/tabKindSearch.jsp").forward(request, response);
		}else{
			request.getRequestDispatcher("/tabRoomFunction/tabKindModifyFailure.jsp").forward(request, response);
		}
	}

}

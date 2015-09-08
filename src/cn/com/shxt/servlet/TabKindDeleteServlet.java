package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.service.TabletKindService;

public class TabKindDeleteServlet extends HttpServlet {


	private static final long serialVersionUID = 5243394386094018185L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String ids = request.getParameter("ids");
		String consumerIds = ids.substring(0,ids.length()-1);
		
		TabletKindService tabletKindService = new TabletKindService();
		int result = tabletKindService.deleteTabKind(consumerIds);
		
		if(result>0){
			String sql = "select * from tablet_kind where t_k_status = 'Õý³£' order by t_k_id";
			PageBean pageBean = tabletKindService.pageList(sql,"1");
			request.setAttribute("pageBean", pageBean);
			request.getRequestDispatcher("/tabRoomFunction/tabKindSearch.jsp").forward(request, response);
		}else{
			request.getRequestDispatcher("/tabRoomFunction/tabKindDeleteFailure.jsp").forward(request, response);
		}
	}
	
}

package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.service.FactoryService;

public class FactoryDeleteServlet extends HttpServlet {

	
	private static final long serialVersionUID = 1L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String ids = request.getParameter("ids");
		String factoryIds = ids.substring(0,ids.length()-1);
		
		FactoryService factoryService = new FactoryService();
		int i = factoryService.deleteFactorys(factoryIds);
		
		if(i>0){
			String sql = "select * from factory order by f_id";
			PageBean pageBean = factoryService.pageList(sql,"1");
			request.setAttribute("pageBean", pageBean);
			request.getRequestDispatcher("/tabRoomFunction/factorySearch.jsp").forward(request, response);
		}else{
			response.sendRedirect(request.getServletPath()+"/tabRoomFunction/factoryDeleteFailure.jsp");
		}
	}
}

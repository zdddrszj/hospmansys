package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.service.FactoryService;

public class FactorySearchServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		FactoryService factoryService = new FactoryService();
		String sql = "select * from factory order by f_id ";
		String currentPage = request.getParameter("currentPage");
		PageBean pageBean = factoryService.pageList(sql, currentPage);
		
		request.setAttribute("pageBean", pageBean);
		request.getRequestDispatcher("/tabRoomFunction/factorySearch.jsp").forward(request, response);
	}
}

package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.service.OfficeService;

public class StatisticsOfTabletServlet extends HttpServlet {

	private static final long serialVersionUID = 6250593834109659194L;

	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		
		String currentPage = request.getParameter("currentPage");
		String sql = "select * from tablet_store where 1=1 ";
		if(startDate==null || endDate==null || startDate=="" || endDate == ""){
			
		}else {
			sql += "and t_s_indate between to_date('"+startDate+"','YYYY-MM-DD') and to_date('"+endDate+"','YYYY-MM-DD') ";
			
		}
		sql += "order by t_s_id";
		//System.out.println(sql);
		OfficeService officeService = new OfficeService();
		PageBean pageBean = officeService.pageList(sql, currentPage);
		request.setAttribute("startDate", startDate);
		request.setAttribute("endDate", endDate);
		request.setAttribute("pageBean", pageBean);
		request.getRequestDispatcher("/manfunction/tabletStatistics.jsp").forward(request, response);
	}
}

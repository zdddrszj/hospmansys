package cn.com.shxt.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.service.OfficeService;

public class OfficeSearchServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String currentPage = request.getParameter("currentPage");
		String sql = "select * from office where o_id not in (1) order by O_ID ";
		OfficeService officeService = new OfficeService();
		
		PageBean pageBean = officeService.pageList(sql, currentPage);
		
		request.setAttribute("pageBean", pageBean);
		request.getRequestDispatcher("/manfunction/officeSearch.jsp").forward(request, response);
	}

}

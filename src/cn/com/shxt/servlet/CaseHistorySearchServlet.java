package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.service.CaseHistoryService;

public class CaseHistorySearchServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		CaseHistoryService caseHistoryService = new CaseHistoryService();
		String sql = "select * from case_history where c_h_status = 'Õý³£' order by c_h_id ";
		String currentPage = request.getParameter("currentPage");
		PageBean pageBean = caseHistoryService.pageList(sql, currentPage);
		
		request.setAttribute("pageBean", pageBean);
		request.getRequestDispatcher("/registerFunction/caseHistorySearch.jsp").forward(request, response);
	}
}

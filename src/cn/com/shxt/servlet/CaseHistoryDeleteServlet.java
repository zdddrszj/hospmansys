package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.service.CaseHistoryService;

public class CaseHistoryDeleteServlet extends HttpServlet {

	
	private static final long serialVersionUID = 1L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String ids = request.getParameter("ids");
		String caseHisIds = ids.substring(0,ids.length()-1);
		
		CaseHistoryService caseHistoryService = new CaseHistoryService();
		int i = caseHistoryService.deleteCaseHistorys(caseHisIds);
		
		if(i>0){
			String sql = "select * from case_history where c_h_status = 'Õý³£' order by c_h_id ";
			PageBean pageBean = caseHistoryService.pageList(sql,"1");
			request.setAttribute("pageBean", pageBean);
			request.getRequestDispatcher("/registerFunction/caseHistorySearch.jsp").forward(request, response);
		}else{
			response.sendRedirect(request.getServletPath()+"/registerFunction/caseHistoryDeleteFailure.jsp");
		}
	}
}

package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.service.OfficeService;

public class OfficeDeleteServlet extends HttpServlet {


	private static final long serialVersionUID = 5243394386094018185L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String ids = request.getParameter("ids");
		String officeIds = ids.substring(0,ids.length()-1);
		
		OfficeService officeService = new OfficeService();
		int result = officeService.deleteOffice(officeIds);

		if(result>0){
			String sql = "select * from office where o_id not in (1) order by o_id";
			PageBean pageBean = officeService.pageList(sql,"1");
			request.setAttribute("pageBean", pageBean);
			request.getRequestDispatcher("/manfunction/officeSearch.jsp").forward(request, response);
		}else{
			request.getRequestDispatcher("/manfunction/officeDeleteFailure.jsp").forward(request, response);
		}
	}
	
}

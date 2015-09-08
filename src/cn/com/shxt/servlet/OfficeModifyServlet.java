package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.Office;
import cn.com.shxt.model.PageBean;
import cn.com.shxt.service.OfficeService;

public class OfficeModifyServlet extends HttpServlet {

	private static final long serialVersionUID = -4384147208819333777L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String o_name = request.getParameter("o_name");
		String officeId = request.getParameter("o_id");
		o_name = new String(o_name.getBytes("iso-8859-1"),"UTF-8");
		
		Office office = new Office();
		office.setName(o_name);
		office.setId(Integer.parseInt(officeId));
		
		OfficeService officeService = new OfficeService();
		int result = officeService.modifyOffice(office);
		if(result > 0){
			String currentPage = request.getParameter("currentPage");
			String sql = "select * from office where o_id not in (1) order by O_ID ";
			PageBean pageBean = officeService.pageList(sql, currentPage);
			request.setAttribute("pageBean", pageBean);
			request.getRequestDispatcher("/manfunction/officeSearch.jsp").forward(request, response);
		}else{
			request.getRequestDispatcher("/manfunction/officeModifyFailure.jsp").forward(request, response);
		}
	}

}

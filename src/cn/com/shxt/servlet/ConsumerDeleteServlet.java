package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.service.ConsumerService;

public class ConsumerDeleteServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String ids = request.getParameter("ids");
		String consumerIds = ids.substring(0,ids.length()-1);
		ConsumerService consumerService = new ConsumerService();
		int i = consumerService.deleteConsumers(consumerIds);
		
		if(i>0){
			String sql = "select * from consumer where c_status = 'Õý³£' order by c_id";
			PageBean pageBean = consumerService.pageList(sql,"1");
			request.setAttribute("pageBean", pageBean);
			request.getRequestDispatcher("/manfunction/consumerSearWithoutCond.jsp").forward(request, response);
		}else{
			response.sendRedirect(request.getServletPath()+"/manfunction/consumerDeleteFailure.jsp");
		}
	}
}

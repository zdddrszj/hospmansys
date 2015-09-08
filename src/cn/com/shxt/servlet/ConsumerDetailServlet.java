package cn.com.shxt.servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.service.ConsumerService;

public class ConsumerDetailServlet extends HttpServlet {

	
	private static final long serialVersionUID = 1L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int consumerId = Integer.parseInt(request.getParameter("consumerId").toString());
		List<Map<String, Object>> list = new ConsumerService().getConsumer(consumerId);
	
		if(list.size()>0){
			request.setAttribute("oneConsumer", list);
			request.getRequestDispatcher("/manfunction/consumerModify.jsp").forward(request, response);
		}else{
			request.getRequestDispatcher("/manfunction/consumerModifyFailure.jsp").forward(request, response);
		}
	}

}

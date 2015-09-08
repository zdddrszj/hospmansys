package cn.com.shxt.servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.service.ConsumerService;

public class ConsumerOneDetailServlet extends HttpServlet {


	private static final long serialVersionUID = 5358193457113519021L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String userAccount = request.getParameter("userAccount");
		ConsumerService consumerService = new ConsumerService();
		List<Map<String, Object>> list = consumerService.getInfo(userAccount);
		request.setAttribute("oneInfoList", list);
		request.getRequestDispatcher("/manfunction/ConsumeroneInfo.jsp").forward(request, response);
	}

}

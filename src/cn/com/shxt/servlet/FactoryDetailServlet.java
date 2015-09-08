package cn.com.shxt.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.service.FactoryService;

public class FactoryDetailServlet extends HttpServlet {


	private static final long serialVersionUID = 9065124039694572241L;

	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String facId = request.getParameter("facId");
		request.setAttribute("oneFactory", new FactoryService().getOne(facId));
		request.getRequestDispatcher("/tabRoomFunction/factoryModify.jsp").forward(request, response);
	}

}

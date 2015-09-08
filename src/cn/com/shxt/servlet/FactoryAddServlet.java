package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.Factory;
import cn.com.shxt.service.FactoryService;

public class FactoryAddServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String factoryName = request.getParameter("factoryName");
		String provinceId = request.getParameter("provinces");
		String cityId = request.getParameter("citys");

		Factory factory = new Factory();
		factory.setName(factoryName);
		factory.setProvinceId(Integer.parseInt(provinceId));
		factory.setCityId(Integer.parseInt(cityId));
		
		int result = new FactoryService().addFactory(factory);
		request.setAttribute("result", result);
		request.getRequestDispatcher("/tabRoomFunction/factoryAddResult.jsp").forward(request, response);
		}
	}


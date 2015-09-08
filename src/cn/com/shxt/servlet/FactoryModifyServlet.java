package cn.com.shxt.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.Factory;
import cn.com.shxt.service.FactoryService;

public class FactoryModifyServlet extends HttpServlet {

	
	private static final long serialVersionUID = 3818379120316671249L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
		
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String factoryId = request.getParameter("facId");
		String factoryName = request.getParameter("factoryName");
		String proId = request.getParameter("provinces");
		String cityId = request.getParameter("citys");
		
		Factory factory = new Factory();
		factory.setId(Integer.parseInt(factoryId));
		factory.setName(factoryName);
		factory.setProvinceId(Integer.parseInt(proId));
		factory.setCityId(Integer.parseInt(cityId));
		//修改
		FactoryService factoryService = new FactoryService();
		int result = factoryService.modifyFactory(factory);
		//在factoryModifyResult.jsp页面进行修改成功失败的判断，最后都返回到查询页面
		request.setAttribute("result", result);
		request.getRequestDispatcher("/tabRoomFunction/factoryModifyResult.jsp").forward(request, response);
	}

}

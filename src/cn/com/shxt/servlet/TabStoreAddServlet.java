package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.model.TabletStore;
import cn.com.shxt.service.TabletStoreService;

public class TabStoreAddServlet extends HttpServlet {


	private static final long serialVersionUID = 5227289999772843770L;

	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String tabKindId = request.getParameter("tabKind");
		String tabName = request.getParameter("tabName");
		String proDate = request.getParameter("proDate");
		String overDate = request.getParameter("overDate");
		String count = request.getParameter("count");
		String unit = request.getParameter("unit");
		String inprice = request.getParameter("inprice");
		String outprice = request.getParameter("outprice");
		String factoryId = request.getParameter("factory");
		
		TabletStore tabletStore = new TabletStore();
		tabletStore.setTabKindId(Integer.parseInt(tabKindId));
		tabletStore.setTabName(tabName);
		tabletStore.setProDate(proDate);
		tabletStore.setOverDate(overDate);
		tabletStore.setCount(Integer.parseInt(count));
		tabletStore.setUnit(unit);
		tabletStore.setInprice(Float.parseFloat(inprice));
		tabletStore.setOutprice(Float.parseFloat(outprice));
		tabletStore.setFactoryId(Integer.parseInt(factoryId));
		
		TabletStoreService tabStoreService = new TabletStoreService();
		int result = tabStoreService.addTabStore(tabletStore);
		if(result > 0){
			String currentPage = request.getParameter("currentPage");
			String sql = "select * from tablet_store where t_s_status='Õý³£' order by t_s_id ";
			PageBean pageBean = tabStoreService.pageList(sql, currentPage);
			request.setAttribute("pageBean", pageBean);
			request.getRequestDispatcher("/tabRoomFunction/tabStoreSearch.jsp").forward(request, response);
		}else{
			response.sendRedirect(request.getContextPath()+"/tabRoomFunction/tabStoreAddFailure.jsp");
		} 
		
	}

}

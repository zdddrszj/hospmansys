package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.service.TabletStoreService;

public class TabStoreSearchServlet extends HttpServlet {

	private static final long serialVersionUID = -6085169041553233583L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
		
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		TabletStoreService tabletStoreService = new TabletStoreService();
		String kind = request.getParameter("kind"); //查询条件
		String choice = request.getParameter("choice"); //查询值
		String sql = "";
		if(kind==null||choice==null){
			sql = "select * from tablet_store where t_s_status='正常' order by t_s_id ";
			String currentPage = request.getParameter("currentPage");
			PageBean pageBean = tabletStoreService.pageList(sql, currentPage);
			request.setAttribute("pageBean", pageBean);
			request.getRequestDispatcher("/tabRoomFunction/tabStoreSearch.jsp").forward(request, response);
		}else{
			if(kind.equals("按批次号退药")){
				sql = "select * from tablet_store where t_s_id='"+choice+"' and t_s_status='正常' order by t_s_id ";
			}
			if(kind.equals("按药品种类退药")){
				sql = "select * from tablet_store where t_k_id='"+choice+"' and t_s_status='正常' order by t_s_id ";
			}
			if(kind.equals("按药品名称退药")){
				sql = "select * from tablet_store where t_s_id='"+choice+"' and t_s_status='正常' order by t_s_id ";
			}
			String currentPage = request.getParameter("currentPage");
			PageBean pageBean = tabletStoreService.pageList(sql, currentPage);
			request.setAttribute("kind", kind);
			request.setAttribute("choice", choice);
			request.setAttribute("pageBean", pageBean);
			request.getRequestDispatcher("/tabRoomFunction/tabStoreDelete.jsp").forward(request, response);
		}
	}
}

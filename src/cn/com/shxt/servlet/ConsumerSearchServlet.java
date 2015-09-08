package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.service.ConsumerService;

public class ConsumerSearchServlet extends HttpServlet {

	
	private static final long serialVersionUID = 1L;

	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String currentPage = request.getParameter("currentPage");
		String tiaoValue = request.getParameter("tiaoValue");
		String sql = "select * from consumer where c_status='正常' ";
		String flag = request.getParameter("f");
		
		if(flag != null){
			if(flag.equals("yes")){
				String require = request.getParameter("require");
				request.setAttribute("req", require);
				
				if(require.equals("角色")){
					String r1 = request.getParameter("r1");
					request.setAttribute("requireValue", r1);
					
					sql += "and c_role = '"+r1+"' ";
				}else if(require.equals("状态")){
					String r = request.getParameter("r");
					request.setAttribute("requireValue", r);
					
					sql = "select * from consumer where c_status='"+r+"'";
				}else {
					String r2 = request.getParameter("r2");
					request.setAttribute("requireValue", r2);
					
					if(require.equals("账号")){
						sql += "and c_account = '"+r2+"' ";
					}else if(require.equals("身份证")){
						sql += "and c_identity = '"+r2+"' ";
					}						 
				}
			}
		}
		
		sql += "order by c_id";
		
		ConsumerService consumerService = new ConsumerService();
		PageBean pageBean = consumerService.pageList(sql, currentPage);
		request.setAttribute("tiaoValue", tiaoValue);
		request.setAttribute("pageBean", pageBean);
		request.getRequestDispatcher("/manfunction/consumerSearWithoutCond.jsp").forward(request, response);
		
	}

}

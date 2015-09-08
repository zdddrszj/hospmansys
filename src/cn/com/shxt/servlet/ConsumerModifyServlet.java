package cn.com.shxt.servlet;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.Consumer;
import cn.com.shxt.model.PageBean;
import cn.com.shxt.service.ConsumerService;
import cn.com.shxt.util.UploadImage;

public class ConsumerModifyServlet extends HttpServlet {


	private static final long serialVersionUID = -2038158552824735723L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Map<String, Object> map = UploadImage.getUpload(request);
		String account = map.get("acc").toString();
		String identity = map.get("identity").toString();
		String psw = map.get("psw").toString();
		String mail = map.get("mail").toString();
		String mailAt = map.get("mailAt").toString();
		String userName = map.get("userName").toString();
		String provinceId = map.get("provinces").toString();//省Id
		String cityId = map.get("citys").toString();//市Id
		String sex = map.get("sex").toString();		
		String role = map.get("role").toString();
		String phone = map.get("phone").toString();
		String saveName = map.get("saveName").toString();
		
		Consumer consumer = new Consumer();
		if(role.equals("医生")){//不是医生的话，offices无值，取的话有空指针异常
			String officeId = map.get("offices").toString();//科室Id
			consumer.setOffiId(Integer.parseInt(officeId));
		}
		consumer.setAccount(account);
		consumer.setIdentify(identity);
		consumer.setPsw(psw);
		consumer.setMail(mail+mailAt);
		consumer.setName(userName);
		consumer.setProvinceId(Integer.parseInt(provinceId));
		consumer.setCityId(Integer.parseInt(cityId));
		consumer.setSex(sex);		
		consumer.setRole(role);
		consumer.setPhone(phone);
		consumer.setSaveName(saveName);
		
		
		ConsumerService cs = new ConsumerService();
		int result = cs.modifyConsumer(consumer);
		
		if(result > 0){
			String currentPage = request.getParameter("currentPage");
			String sql = "select * from consumer where c_status='正常' order by c_id ";
			PageBean pageBean = cs.pageList(sql, currentPage);
			request.setAttribute("pageBean", pageBean);
			request.getRequestDispatcher("/manfunction/consumerSearWithoutCond.jsp").forward(request, response);
		}else{
			response.sendRedirect(request.getContextPath()+"/manfunction/consumerAddFailure.jsp");
		} 
		
	}
}

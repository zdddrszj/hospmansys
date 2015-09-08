package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.Register;
import cn.com.shxt.service.RegisterService;

public class RegisterAddServlet extends HttpServlet {

	private static final long serialVersionUID = 5567694544216454763L;

	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//得到属性值
		String caseId = request.getParameter("caseId");
		String officeId = request.getParameter("offices");
		String type = request.getParameter("type");
		String regDate = request.getParameter("regDate");
		String doctorId = request.getParameter("doctors");
		String dealerId = request.getParameter("dealer");
		
		Register register = new Register();
		
		if(doctorId==null||doctorId==""){
			
		}else{
			register.setDoctorId(Integer.parseInt(doctorId));
		}
		if(caseId==null||caseId==""){
			
		}else{
			register.setCaseId(Integer.parseInt(caseId));
		}
		register.setOfficeId(Integer.parseInt(officeId));
		register.setType(type);
		register.setDate(regDate);
		register.setDealerId(dealerId);
		
		RegisterService registerService = new RegisterService();
		int result = registerService.addRegister(register);
		if(result > 0){
			request.setAttribute("flag", "true");
			request.getRequestDispatcher("/registerFunction/registerAdd.jsp").forward(request, response);
		}else {
			request.getRequestDispatcher("/registerFunction/registerAddFailure.jsp").forward(request, response);
		}
	}

}

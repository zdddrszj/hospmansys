package cn.com.shxt.servlet;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.CaseHistory;
import cn.com.shxt.service.CaseHistoryService;
import cn.com.shxt.service.RegisterService;
import cn.com.shxt.util.UploadImage;

public class CaseHistoryAddServlet extends HttpServlet {

	private static final long serialVersionUID = 6393341497701341350L;

	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Map<String, Object> map = UploadImage.getUpload(request);
		String name = map.get("name").toString();
		String sex = map.get("sex").toString();
		String age = map.get("age").toString();
		String phone = map.get("phone").toString();
		String provinceId = map.get("provinces").toString();//Ê¡Id
		String cityId = map.get("citys").toString();//ÊÐId
		String saveName = map.get("saveName").toString();
		
		CaseHistory caseHistory = new CaseHistory();
		caseHistory.setName(name);
		caseHistory.setSex(sex);
		caseHistory.setPhone(phone);
		caseHistory.setPhoto(saveName);
		caseHistory.setAge(Integer.parseInt(age));
		caseHistory.setProvinceId(Integer.parseInt(provinceId));
		caseHistory.setCityId(Integer.parseInt(cityId));
		
		CaseHistoryService caseHistoryService = new CaseHistoryService();
		int res = caseHistoryService.addCaseHistory(caseHistory);
		
		if(res>0){
			String registerId = map.get("registerId").toString();
			RegisterService registerService = new RegisterService();
			int result = registerService.resetRegister(registerId);
			if(result > 0){
				request.getRequestDispatcher("/diagnoseFunction/caseHistoryAddResult.jsp?result="+result).forward(request, response);
			}
		}else{
			request.getRequestDispatcher("/diagnoseFunction/caseHistoryAddResult.jsp?result=0").forward(request, response);
		}
		
		
	}

}

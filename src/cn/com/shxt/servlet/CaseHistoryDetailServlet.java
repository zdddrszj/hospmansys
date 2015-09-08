package cn.com.shxt.servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.service.CaseHistoryService;
import cn.com.shxt.service.RegisterService;

public class CaseHistoryDetailServlet extends HttpServlet {

	
	private static final long serialVersionUID = 1L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//首先知道挂号单
		int registerId = Integer.parseInt(request.getParameter("registerId").toString());
		//根据挂号单id把诊断表中的挂号中改成诊断中
		RegisterService registerService = new RegisterService();
		int result = registerService.modifyDiagnoseSituation(registerId);
		if(result > 0){//已改成诊断中
			//根据挂号单是否有病例编号进行选择跳到不同的诊断页面
			List<Map<String, Object>> list = registerService.getCaseId(registerId);
			if(list.size()>0){//说明该挂号单有病例号，然后根据病历号查询病例基本信息
				CaseHistoryService caseHistoryService = new CaseHistoryService();
				List<Map<String, Object>> list1 = caseHistoryService.getAllInfo(Integer.parseInt(list.get(0).get("R_CASE_ID").toString()));
				request.setAttribute("registerId", registerId);
				request.setAttribute("oneCaseHistory", list1);
				request.getRequestDispatcher("/diagnoseFunction/diagnoseAddSecond.jsp").forward(request, response);
			
			}else{//挂号单上无病历号也可看病
			}
		}else{
			request.getRequestDispatcher("/diagnoseFunction/diagnoseAddFailure.jsp").forward(request, response);
		}
	}
}

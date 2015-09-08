package cn.com.shxt.servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.service.StatisticService;
import cn.com.shxt.util.GetBarJPEG;

public class StatisticsOfDiagCountServlet extends HttpServlet {

	private static final long serialVersionUID = -6146779272662053759L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		/*创建柱形图需要的数据集*/
		StatisticService statisticService = new StatisticService();
		List<Map<String, Object>> office = statisticService.getOffice();
		int length = office.size();
		String []arr=new String[length];
		int i = 0;
		for(Map<String,Object> map: office){
			if(Integer.parseInt(map.get("O_ID").toString())==1){
				continue;
			}
			if(startDate==null||startDate==""||endDate==null||endDate==""){
				List<Map<String, Object>> count = statisticService.getCount(Integer.parseInt(map.get("O_ID").toString()));
				arr[i]=""+Integer.parseInt(count.get(0).get("NUM").toString())+","+map.get("O_NAME").toString()+","+map.get("O_NAME").toString()+"";
				i ++;
			}else{
				List<Map<String, Object>> count = statisticService.getCountWithDate(Integer.parseInt(map.get("O_ID").toString()),startDate,endDate);
				arr[i]=""+Integer.parseInt(count.get(0).get("NUM").toString())+","+map.get("O_NAME").toString()+","+map.get("O_NAME").toString()+"";
				i ++;
			}
		}
		
		try {
			GetBarJPEG.getBar("科室处理数量情况", GetBarJPEG.createDataset(arr), request, "科室名称", "诊断数量(个)");
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("chart", "bar.jpg");
		request.setAttribute("startDate", startDate);
		request.setAttribute("endDate", endDate);
		request.getRequestDispatcher("/manfunction/diagCountStatistics.jsp").forward(request, response);
	}
}

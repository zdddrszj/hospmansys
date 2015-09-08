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

public class StatisticsOfDiagCostServlet extends HttpServlet {

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
		float price = 0.0f;
		int length = office.size();
		String []arr=new String[length];
		int i = 0 ;
		
		for(Map<String,Object> map: office){
			
			if(startDate==null||startDate==""||endDate==null||endDate==""){
				//查出 药品库存id 和相应的 售出数量
				List<Map<String, Object>> tabletCount = statisticService.getTabletCount(Integer.parseInt(map.get("O_ID").toString()));
				if(tabletCount.size()>0){
					for(Map<String,Object> map1: tabletCount){
						//药品个数乘上售价
						List<Map<String, Object>> outprice = statisticService.getTabletOutPrice(Integer.parseInt(map1.get("T_STORE_ID").toString()));
						price=Integer.parseInt(map1.get("NUM").toString())*Float.parseFloat(outprice.get(0).get("T_S_OUTPRICE").toString());
					}
					//根据科室id查询othercost
					List<Map<String, Object>> othercost = statisticService.getOthercost(Integer.parseInt(map.get("O_ID").toString()));
					price += Float.parseFloat(othercost.get(0).get("OTHERCOST").toString());
				}else{
					price = 0.0f;
				}
			}else{
				//查出 药品库存id 和相应的 售出数量
				List<Map<String, Object>> tabletCount = statisticService.getTabletCountWithDate(Integer.parseInt(map.get("O_ID").toString()),startDate,endDate);
				if(tabletCount.size()>0){
					for(Map<String,Object> map1: tabletCount){
						
						List<Map<String, Object>> outprice = statisticService.getTabletOutPrice(Integer.parseInt(map1.get("T_STORE_ID").toString()));
						price = Integer.parseInt(map1.get("NUM").toString())*Float.parseFloat(outprice.get(0).get("T_S_OUTPRICE").toString());
					}
					//根据科室id查询othercost
					List<Map<String, Object>> othercost = statisticService.getOthercost(Integer.parseInt(map.get("O_ID").toString()),startDate,endDate);
					price += Float.parseFloat(othercost.get(0).get("OTHERCOST").toString());
				}else{
					price = 0.0f;
				}
			}
			arr[i]= ""+Math.round(price)+","+map.get("O_NAME").toString()+","+map.get("O_NAME").toString()+"";
			i ++;
		}
		
		try {
			GetBarJPEG.getBar("科室诊断收费情况", GetBarJPEG.createDataset(arr), request, "科室名称", "收费金额(元)");
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("chart", "bar.jpg");
		request.setAttribute("startDate", startDate);
		request.setAttribute("endDate", endDate);
		request.getRequestDispatcher("/manfunction/diagCostStatistics.jsp").forward(request, response);
	}
}

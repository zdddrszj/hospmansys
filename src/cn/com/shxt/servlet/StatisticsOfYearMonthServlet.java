package cn.com.shxt.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.service.StatisticService;
import cn.com.shxt.util.GetPieJPEG;

public class StatisticsOfYearMonthServlet extends HttpServlet {


	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String year = request.getParameter("year");
		StatisticService statisticService = new StatisticService();
		List<Map<String, Object>> list = statisticService.getTabletStoreIdAndTime(year);
		//判断该年份是否有售出记录
		if(list.size()>0){
			for(Map<String, Object> map:list){
				List<Map<String, Object>> list1 = statisticService.getPrice(map.get("T_STORE_ID").toString());
				if(list1.size()>0){
					double profit = Integer.parseInt(map.get("NUM").toString())*Double.parseDouble(list1.get(0).get("PROFIT").toString());
					String month = map.get("T_S_DATE").toString().split("-")[1];
					Map<String,Double> map1 = new HashMap<String,Double>();
					if(month.equals("01")){
						double othercost = Double.parseDouble(statisticService.getOthercost(year, "01").get(0).get("OTHERCOST").toString());
						map1.put("1月份", profit+othercost);
					}else{
						map1.put("1月份", 0.0);
					}
					if(month.equals("02")){
						double othercost = Double.parseDouble(statisticService.getOthercost(year, "02").get(0).get("OTHERCOST").toString());
						map1.put("2月份", profit+othercost);
					}else{
						map1.put("2月份", 0.0);
					}
					if(month.equals("03")){
						double othercost = Double.parseDouble(statisticService.getOthercost(year, "03").get(0).get("OTHERCOST").toString());
						map1.put("3月份", profit+othercost);
					}else{
						map1.put("3月份", 0.0);
					}
					if(month.equals("04")){
						double othercost = Double.parseDouble(statisticService.getOthercost(year, "04").get(0).get("OTHERCOST").toString());
						map1.put("4月份", profit+othercost);
					}else{
						map1.put("4月份", 0.0);
					}
					if(month.equals("05")){
						double othercost = Double.parseDouble(statisticService.getOthercost(year, "05").get(0).get("OTHERCOST").toString());
						map1.put("5月份", profit+othercost);
					}else{
						map1.put("5月份", 0.0);
					}
					if(month.equals("06")){
						double othercost = Double.parseDouble(statisticService.getOthercost(year, "06").get(0).get("OTHERCOST").toString());
						map1.put("6月份", profit+othercost);
					}else{
						map.put("6月份", 0.0);
					}
					if(month.equals("07")){
						double othercost = Double.parseDouble(statisticService.getOthercost(year, "07").get(0).get("OTHERCOST").toString());
						map1.put("7月份", profit+othercost);
					}else{
						map1.put("7月份", 0.0);
					}
					if(month.equals("08")){
						double othercost = Double.parseDouble(statisticService.getOthercost(year, "08").get(0).get("OTHERCOST").toString());
						map1.put("8月份", profit+othercost);
					}else{
						map1.put("8月份", 0.0);
					}
					if(month.equals("09")){
						double othercost = Double.parseDouble(statisticService.getOthercost(year, "09").get(0).get("OTHERCOST").toString());
						map1.put("9月份", profit+othercost);
					}else{
						map1.put("9月份", 0.0);
					}
					if(month.equals("10")){
						double othercost = Double.parseDouble(statisticService.getOthercost(year, "10").get(0).get("OTHERCOST").toString());
						map1.put("10月份", profit+othercost);
					}else{
						map1.put("10月份", 0.0);
					}
					if(month.equals("11")){
						double othercost = Double.parseDouble(statisticService.getOthercost(year, "11").get(0).get("OTHERCOST").toString());
						map1.put("11月份", profit+othercost);
					}else{
						map1.put("11月份", 0.0);
					}
					if(month.equals("12")){
						double othercost = Double.parseDouble(statisticService.getOthercost(year, "12").get(0).get("OTHERCOST").toString());
						map1.put("12月份", profit+othercost);
					}else{
						map1.put("12月份", 0.0);
					}
					try {
						GetPieJPEG.getPie("新华医院月份收入比例", GetPieJPEG.getDataset(map1),request);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
			request.setAttribute("chart", "pie.jpg");
		}else{
			request.setAttribute("chart", "xin.gif");
		}
		
		request.getRequestDispatcher("/manfunction/yearMonthPieStatistics.jsp").forward(request, response);
	}

}

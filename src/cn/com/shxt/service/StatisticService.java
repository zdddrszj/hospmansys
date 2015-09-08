package cn.com.shxt.service;

import java.util.List;
import java.util.Map;

import cn.com.shxt.util.JdbcUtil;

public class StatisticService {
	JdbcUtil db = new JdbcUtil();
	
	//查询科室
	public List<Map<String, Object>> getOffice(){
		String sql = "select * from office where o_id not in (1)";
		return db.query(sql);
	}
	
	//查询科室诊断个数
	public List<Map<String, Object>> getCount(int officeId){
		String sql = "select count(*) num  from register where r_status='诊断结束'and r_office_id="+officeId+"";
		return db.query(sql);
	}
	//查询药品卖的个数（根据药房分组）
	public List<Map<String, Object>> getTabletCount(int officeId) {
		String sql = "select t_store_id,sum(t_s_count) num from tablet_sale where t_office_id="+officeId+" group by t_store_id";
		return db.query(sql);
	}
	//查询othercost
	public List<Map<String, Object>> getOthercost(int officeId){
		return db.query("select sum(r_othercost) othercost from register where r_status='诊断结束' and r_office_id="+officeId+"");
	}
	//根据药品库存id 查出药品售价
	public List<Map<String, Object>> getTabletOutPrice(int storeId) {
		String sql = "select t_s_outprice from tablet_store where t_s_id = "+storeId+"";
		return db.query(sql);
	}
	//查询科室诊断个数
	public List<Map<String, Object>> getCountWithDate(int officeId,
			String startDate, String endDate) {
		String sql = "select count(*) num  from register where r_status='诊断结束' and r_office_id="+officeId+" and (r_date between to_date('"+startDate+"','YYYY-MM-DD') and to_date('"+endDate+"','YYYY-MM-DD'))";
		//System.out.println(sql);
		return db.query(sql);
	}
	//查询药品卖的个数（根据药房分组）
	public List<Map<String, Object>> getTabletCountWithDate(int officeId,
			String startDate, String endDate) {
		String sql = "select t_store_id,sum(t_s_count) num from tablet_sale where t_office_id="+officeId+" and (t_s_date between to_date('"+startDate+"','YYYY-MM-DD') and to_date('"+endDate+"','YYYY-MM-DD')) group by t_store_id";
		return db.query(sql);
	}
	//查询othercost
	public List<Map<String, Object>> getOthercost(int officeId,String startDate, String endDate){
		String sql = "select sum(r_othercost) othercost from register where r_status='诊断结束' and r_office_id="+officeId+" and (r_date between to_date('"+startDate+"','YYYY-MM-DD') and to_date('"+endDate+"','YYYY-MM-DD'))";
		//System.out.println(sql);
		return db.query(sql);
	}
	
	//年月统计 饼状图
	//查询 药品卖出个数 按照药品库存Id,买药时间 分组
	public List<Map<String, Object>> getTabletStoreIdAndTime(String year){
		String sql = "select t_store_id,t_s_date,sum(t_s_count) num from tablet_sale where t_s_date between to_date('"+year+"-01-01','YYYY-MM-DD') and to_date('"+year+"-12-31','YYYY-MM-DD') group by t_store_id,t_s_date";
		//System.out.println(sql);
		return db.query(sql);
	}
	//查询othercost
	public  List<Map<String, Object>> getOthercost(String year,String month){
		String sql = "select r_date,sum(r_othercost) othercost from register where r_status='诊断结束' and r_date between to_date('"+year+"-"+month+"-01','YYYY-MM-DD') and to_date('"+year+"-"+month+"-31','YYYY-MM-DD') group by r_date";
		return db.query(sql);
	}
	
	//根据上个方法查到了库存id，根据id查进价和售价的差额
	public List<Map<String, Object>> getPrice(String tabletStoreId) {
		String sql = "select t_s_outprice-t_s_inprice profit from tablet_store where t_s_id="+Integer.parseInt(tabletStoreId)+"";
		//System.out.println(sql);
		return db.query(sql);
	}
}

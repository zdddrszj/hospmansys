package cn.com.shxt.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.com.shxt.model.CaseHistory;
import cn.com.shxt.model.PageBean;
import cn.com.shxt.util.JdbcUtil;

public class CaseHistoryService {
	JdbcUtil db = new JdbcUtil();

	//添加病人
	public int addCaseHistory(CaseHistory caseHistory) {
		String sql = "insert into case_history values (case_history_seq.nextval,'"+caseHistory.getName()+"'," +
				"'"+caseHistory.getSex()+"',"+caseHistory.getAge()+",'"+caseHistory.getPhoto()+"'," +
						"'"+caseHistory.getPhone()+"',"+caseHistory.getProvinceId()+","+caseHistory.getCityId()+"," +
				  	"to_date('"+new Date().toLocaleString().split(" ")[0]+"','YYYY_MM_DD'),'正常')";
		//System.out.println(sql);
		return db.update(sql);
	}

	public PageBean pageList(String sql, String currentPage) {
		PageBean page = new PageBean();
		if (currentPage != null) {
			page.setCurrentPage(Integer.parseInt(currentPage));//设置当前页码
		}
		page.setSql(sql);//传递基础查询，在pageBean对象中拼接分页查询
		page.setPageList(db.query(page.getSql()));//获得分页查询后的结果集
		page.setTotalPage(db.getCount(sql));//传递总条数，在pageBean中获取总页数
		return page;
	}
	// 根据id查地址
	public String getAddrName(String pId , String cId){
		String proId = db.query("select * from province where p_id="+Integer.parseInt(pId)+"").get(0).get("P_NAME").toString();
		String cityId = db.query("select * from city where c_id="+Integer.parseInt(cId)+"").get(0).get("C_NAME").toString();
		return proId+","+cityId;
	}
	//删除病例 把状态设为已删除
	public int deleteCaseHistorys(String caseHisIds) {
		String sql = "update case_history set c_h_status = '已删除' where c_h_id in ("+caseHisIds+")";
		return db.update(sql);
	}
	//根据id查出挂号时间
	public List<Map<String, Object>> getCaseDate(int caseId){
		String sql = "select C_H_DATE from case_history where c_h_id="+caseId+"";
		return db.query(sql);
	}
	//根据病历号查询所有病例信息
	public List<Map<String, Object>> getAllInfo(int r_case_id) {
		String sql = "select * from case_history where c_h_id = "+r_case_id+"";
		return db.query(sql);
	}
}

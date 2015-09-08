package cn.com.shxt.service;

import java.util.List;
import java.util.Map;

import cn.com.shxt.model.Office;
import cn.com.shxt.model.PageBean;
import cn.com.shxt.util.JdbcUtil;

public class OfficeService {
	JdbcUtil db = new JdbcUtil();
	
	//添加科室信息
	public int addOffice(Office office){
		return db.update("insert into office values(office_seq.nextval,'"+office.getName()+"')");
	}
	//判断科室存在不存在
	public int officeIsExist(String officeName){
		List<Map<String, Object>>  list = db.query("select * from office where o_name='"+officeName+"'");
		return list.size();
	}
	//删除科室信息	
	public int deleteOffice(String condition) {
		String sql = "select * from consumer where c_role='医生' and c_o_id in ("+condition+")";
		if(db.query(sql).size()>0){
			String sql1 = "update consumer set c_o_id = 1 where c_role='医生' and c_o_id in ("+condition+")";
			db.update(sql1);
		}
		return db.update("delete from office where o_id in ("+condition+")");
	}
	//修改科室
	public int modifyOffice(Office office){
		//System.out.println("update office set o_name='"+office.getName()+"' where o_id="+office.getId()+"");
		return db.update("update office set o_name='"+office.getName()+"' where o_id="+office.getId()+"");
	}
	//查询所有科室
	public PageBean pageList(String sql,String currentPage){
		PageBean page = new PageBean();
		if (currentPage != null) {
			page.setCurrentPage(Integer.parseInt(currentPage));//设置当前页码
		}
		page.setSql(sql);//传递基础查询，在pageBean对象中拼接分页查询
		page.setPageList(db.query(page.getSql()));//获得分页查询后的结果集
		page.setTotalPage(db.getCount(sql));//传递总条数，在pageBean中获取总页数
		return page;
	}
	public List<Map<String, Object>> getAllOffice() {
		return db.query("select * from office ");
	}
}

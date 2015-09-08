package cn.com.shxt.service;

import java.util.List;
import java.util.Map;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.model.TabletKind;
import cn.com.shxt.util.JdbcUtil;

public class TabletKindService {
	JdbcUtil db = new JdbcUtil();
	
	//判断药品种类是否存在
	public int tabKindIsExist(String tabKindName) {
		List<Map<String, Object>> list = db.query("select * from tablet_kind where t_k_name='"+tabKindName+"' and t_k_status='正常'");
		return list.size();
	}
	//添加药品种类
	public int addTabKind(TabletKind tabletKind) {
		String sql = "insert into tablet_kind values (tablet_kind_seq.nextval,'"+tabletKind.getName()+"','正常')";
		return db.update(sql);
	}
	//修改种类
	public int modifyTabKind(TabletKind tabletKind){
		String sql = "update tablet_kind set t_k_name='"+tabletKind.getName()+"',t_k_status='"+tabletKind.getStatus()+"' where t_k_id="+tabletKind.getId()+"";
		return db.update(sql);
	}
	//删除药品种类  
	public int deleteTabKind(String condition) {
		String sql = "update tablet_kind set t_k_status='已删除' where t_k_id in ("+condition+")";
		return db.update(sql);
	}
	//查询所有种类
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
	public List<Map<String, Object>> getAllKinds() {
		return db.query("select * from tablet_kind where t_k_status = '正常' ");
	}
	//根据id查询药品名称
	public String getTabKindName(int tabKindId){
		String sql = "select T_K_NAME from tablet_kind where T_K_ID="+tabKindId+"";
		//System.out.println(sql);
		return db.query(sql).get(0).get("T_K_NAME").toString();
	}
}

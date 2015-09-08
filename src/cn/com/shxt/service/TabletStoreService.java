package cn.com.shxt.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.model.TabletStore;
import cn.com.shxt.util.JdbcUtil;

public class TabletStoreService {
	JdbcUtil db = new JdbcUtil();

	public int addTabStore(TabletStore tabletStore) {
		String sql = "insert into tablet_store values(tablet_store_seq.nextval,"+tabletStore.getTabKindId()+"," +
				"'"+tabletStore.getTabName()+"',"+tabletStore.getFactoryId()+",to_date('"+tabletStore.getProDate()+"','YYYY-MM-DD')," +
				"to_date('"+tabletStore.getOverDate()+"','YYYY-MM-DD'),'"+new Date().getTime()+"',"+tabletStore.getCount()+"," +
				"'"+tabletStore.getUnit()+"','"+tabletStore.getInprice()+"','"+tabletStore.getOutprice()+"',to_date('"+new Date().toLocaleString().split(" ")[0]+"','YYYY-MM-DD'),'正常',0)";
		return db.update(sql);
	}

	//查询药品库存
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
	//修改时根据id在detail里查到所有信息
	public List<Map<String, Object>> getTabStore(int tabStoreId) {
		String sql = "select * from tablet_store where t_s_id="+tabStoreId+" ";
		return db.query(sql);
	}
	//更新药品库存信息
	public int modifyTabStore(TabletStore tabletStore) {
		String sql = "update tablet_store set t_k_id="+tabletStore.getTabKindId()+"," +
		"t_s_name='"+tabletStore.getTabName()+"',t_s_factory="+tabletStore.getFactoryId()+",t_s_prodate=to_date('"+tabletStore.getProDate()+"','YYYY-MM-DD')," +
		"t_s_overdate=to_date('"+tabletStore.getOverDate()+"','YYYY-MM-DD'),t_s_count="+tabletStore.getCount()+"," +
		"t_s_unit='"+tabletStore.getUnit()+"',t_s_inprice='"+tabletStore.getInprice()+"',t_s_outprice='"+tabletStore.getOutprice()+"',t_s_indate=to_date('"+new Date().toLocaleString().split(" ")[0]+"','YYYY-MM-DD') where t_s_id="+tabletStore.getId()+"";
		//System.out.println(sql);
		return db.update(sql);
	}
	//得到所有药品库存的批次号
	public List<Map<String, Object>> getAllOrders() {
		String sql = "select t_s_id,T_S_ORDER from tablet_store where t_s_status='正常'";
		return db.query(sql);
	}
	//得到药品名称
	public List<Map<String, Object>> getAllTabNames() {
		String sql = "select t_s_id,T_S_NAME from tablet_store where t_s_status='正常'";
		return db.query(sql);
	}
	//退药
	public List<Map<String, Object>> getOne(int tabStoreId) {
		String sql = "select t_s_id,t_s_count,t_s_sale from tablet_store where t_s_id="+tabStoreId+"";
		return db.query(sql);
	}
	//修改库存数量（退货时）
	public int modify(TabletStore tabletStore,int client) {
		String sql = "";
		if(tabletStore.getCount()==0){
			sql = "update tablet_store set t_s_count=0,t_s_status='已删除' where t_s_id="+tabletStore.getId()+" ";
		}else {
			sql = "update tablet_store set t_s_count="+tabletStore.getCount()+" where t_s_id="+tabletStore.getId()+"";
		}
		return db.update(sql);
	}
	//退药 返回的钱
	public Float getMoney(TabletStore tabletStore,int count) {
		String sql = "select t_s_inprice from tablet_store where t_s_id="+tabletStore.getId()+"";
		float inprice = Float.parseFloat(db.query(sql).get(0).get("T_S_INPRICE").toString());
		return inprice*count;
	}
	//修改库存数量（买药后）
	public int modifySaleCount(TabletStore tabletStore){
		String sql = "update tablet_store set t_s_count=t_s_count-"+tabletStore.getCount()+",t_s_sale=t_s_sale+"+tabletStore.getCount()+" where t_s_id="+tabletStore.getId()+"";
		//System.out.println(sql);
		return db.update(sql);
	}
	//根据药品种类id得到药品名称
	public List<Map<String, Object>> getAllTabName(int tabletKindId) {
		String sql = "select t_s_id,t_s_name from tablet_store where t_k_id ="+tabletKindId+"";
		//System.out.println(sql);
		return db.query(sql);
	}
	//根据register表id查询 价格和库存
	public List<Map<String, Object>> getAllTabPriceCount(int tabletStoreId) {
		String sql = "select * from tablet_store where t_s_id="+tabletStoreId+"";
		//System.out.println(sql);
		return db.query(sql);
	}
	
}

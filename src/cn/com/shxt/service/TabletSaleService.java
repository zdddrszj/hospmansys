package cn.com.shxt.service;

import java.util.Date;

import cn.com.shxt.model.TabletSale;
import cn.com.shxt.util.JdbcUtil;

public class TabletSaleService {
	JdbcUtil db = new JdbcUtil();

	//添加销售记录
	public int addTabSale(TabletSale tabletSale) {
		
		String sql = "insert into tablet_sale values (tablet_sale_seq.nextval,"+tabletSale.getCount()+",to_date('"+new Date().toLocaleString().split(" ")[0]+"','YYYY-MM-DD'),"+tabletSale.getRegisterId()+","+tabletSale.getStoreId()+","+tabletSale.getOfficeid()+")";
		//System.out.println(sql);
		return db.update(sql);
	}
	
}

package cn.com.shxt.service;

import java.util.List;
import java.util.Map;

import cn.com.shxt.util.JdbcUtil;

public class CitysService {
	JdbcUtil db = new JdbcUtil();
	
	public List<Map<String,Object>> getAllCitys(int proId){
		return db.query("select * from city where p_id = "+proId);
	}

}

package cn.com.shxt.service;

import java.util.List;
import java.util.Map;

import cn.com.shxt.util.JdbcUtil;

public class ProvincesService {
	JdbcUtil db = new JdbcUtil();
	
	public List<Map<String,Object>> getAllProvinces(){
		return db.query("select * from province ");
	}
	
}
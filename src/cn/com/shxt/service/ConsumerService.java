package cn.com.shxt.service;

import java.util.List;
import java.util.Map;

import cn.com.shxt.model.Consumer;
import cn.com.shxt.model.PageBean;
import cn.com.shxt.util.JdbcUtil;

public class ConsumerService {
	JdbcUtil db = new JdbcUtil();
	
	//添加用户
	public int addConsumers(Consumer consumer){
		String sql = "";
		if(consumer.getRole().equals("医生")){
			sql = "insert into consumer values(consume_seq.nextval,'"+consumer.getAccount()+"','"+consumer.getPsw()+"','"+consumer.getName()+"','"+consumer.getSex()+"'," +
			""+consumer.getIdentify()+",'"+consumer.getMail()+"','"+consumer.getPhone()+"',"+consumer.getCityId()+",'"+consumer.getRole()+"',"+consumer.getOffiId()+"," +
					"'"+consumer.getSaveName()+"','正常',"+consumer.getProvinceId()+")";
		}else{
			sql = "insert into consumer values" +
					"(consume_seq.nextval,'"+consumer.getAccount()+"','"+consumer.getPsw()+"','"+consumer.getName()+"','"+consumer.getSex()+"'," +
			""+consumer.getIdentify()+",'"+consumer.getMail()+"','"+consumer.getPhone()+"',"+consumer.getCityId()+",'"+consumer.getRole()+"',1,'"+consumer.getSaveName()+"','正常',"+consumer.getProvinceId()+")";
		}	
		//System.out.println(sql);
		return db.update(sql);
	}
	
	//查询所有用户
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
	//查询用户省市 科室 的名称
	public String getName(int pro_id , int city_id , int off_id){
		String proName = db.query("select * from province where p_id = '"+pro_id+"'").get(0).get("P_NAME").toString();
		String cityName = db.query("select * from city where c_id = '"+city_id+"'").get(0).get("C_NAME").toString();
		if(off_id == 0){
			return proName+","+cityName+","+"无";
		}else {
			String offName = db.query("select * from office where o_id = '"+off_id+"'").get(0).get("O_NAME").toString();
			return proName+","+cityName+","+offName;
		}
	}
	//查询单个用户
	public List<Map<String,Object>> getConsumer(int id){
		return db.query("select * from consumer where c_id='"+id+"'");
	}
	//查询用户 科室名
	public List<Map<String,Object>> getConsumerOffice(int id){
		return db.query("select o_name from office where o_id='"+id+"'");
	}
	
	//删除  多行用户
	public int deleteConsumers(String consumerIds){
		return db.update("update consumer set c_status='已删除' where c_id in ("+consumerIds+")");
	}

	public int modifyConsumer(Consumer consumer) {
		String sql = "";
		if(consumer.getSaveName()==""||consumer.getSaveName()==null){
			if(consumer.getRole().equals("医生")){
				sql = "update consumer set c_name='"+consumer.getName()+"',c_psw='"+consumer.getPsw()+"',c_sex='"+consumer.getSex()+"',c_identity='"+consumer.getIdentify()+"',c_mail='"+consumer.getMail()+"'," +
	    		" c_phone='"+consumer.getPhone()+"',c_city="+consumer.getCityId()+",c_role='"+consumer.getRole()+"',c_o_id="+consumer.getOffiId()+",c_status='正常',c_province='"+consumer.getProvinceId()+"' " +
	    		"where c_account='"+consumer.getAccount()+"'";
			}else{
				sql = "update consumer set c_name='"+consumer.getName()+"',c_psw='"+consumer.getPsw()+"',c_sex='"+consumer.getSex()+"',c_identity='"+consumer.getIdentify()+"',c_mail='"+consumer.getMail()+"'," +
	    		" c_phone='"+consumer.getPhone()+"',c_city="+consumer.getCityId()+",c_role='"+consumer.getRole()+"',c_o_id=1,c_status='正常',c_province='"+consumer.getProvinceId()+"' " +
	    		"where c_account='"+consumer.getAccount()+"'";
			}
		}else{
			if(consumer.getRole().equals("医生")){
				sql = "update consumer set c_name='"+consumer.getName()+"',c_psw='"+consumer.getPsw()+"',c_sex='"+consumer.getSex()+"',c_identity='"+consumer.getIdentify()+"',c_mail='"+consumer.getMail()+"'," +
		    	" c_phone='"+consumer.getPhone()+"',c_city="+consumer.getCityId()+",c_role='"+consumer.getRole()+"',c_o_id="+consumer.getOffiId()+",c_photo='"+consumer.getSaveName()+"',c_status='正常',c_province='"+consumer.getProvinceId()+"' " +
				"where c_account='"+consumer.getAccount()+"'";
			}else{
				sql = "update consumer set c_name='"+consumer.getName()+"',c_psw='"+consumer.getPsw()+"',c_sex='"+consumer.getSex()+"',c_identity='"+consumer.getIdentify()+"',c_mail='"+consumer.getMail()+"'," +
		    	" c_phone='"+consumer.getPhone()+"',c_city="+consumer.getCityId()+",c_role='"+consumer.getRole()+"',c_o_id=1,c_photo='"+consumer.getSaveName()+"',c_status='正常',c_province='"+consumer.getProvinceId()+"' " +
				"where c_account='"+consumer.getAccount()+"'";
			}
		}
		return db.update(sql);
	}

	public List<Map<String, Object>> getConsumerId(String doctorAccount) {
		String sql = "select c_id from consumer where c_account='"+doctorAccount+"'";
		return db.query(sql);
	}
	public List<Map<String, Object>> getConsumerName(String doctorId) {
		String sql = "select c_name from consumer where c_id='"+Integer.parseInt(doctorId)+"'";
		//System.out.println(sql);
		return db.query(sql);
	}
	//查询个人信息
	public List<Map<String,Object>> getInfo(String userAccount){
		return db.query("select * from consumer where c_account='"+userAccount+"'");
	}
}

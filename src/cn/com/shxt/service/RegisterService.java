package cn.com.shxt.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.model.Register;
import cn.com.shxt.util.JdbcUtil;

public class RegisterService {
	JdbcUtil db = new JdbcUtil();
	//根据科室Id查询该科室医生
	public List<Map<String, Object>> getAllDoctors(int officeId,String date) {
		String sql = "select c_id,r_doctor_id,c_name,count(*) as num from consumer,register where r_office_id="+officeId+"  and c_o_id="+officeId+" and r_status='挂号中' and r_date=to_date('"+date+"','YYYY-MM-DD') having c_id=r_doctor_id group by c_id,r_doctor_id,c_name order by count(*) desc";
		//System.out.println(sql);
		return db.query(sql);
	}
	public List<Map<String, Object>> getAllDoctorsWithoutDate(int officeId) {
		String sql = "select c_id,r_doctor_id,c_name,count(*) as num from consumer,register where r_office_id="+officeId+"  and c_o_id="+officeId+" and r_status='挂号中' having c_id=r_doctor_id group by c_id,r_doctor_id,c_name order by count(*) desc";
		//System.out.println(sql);
		return db.query(sql);
	}
	public List<Map<String, Object>> getAllDoctor(int officeId) {
		String sql = "select c_id,c_name from consumer where c_o_id = "+officeId+"";
		//System.out.println(sql);
		return db.query(sql);
	}
	//得到所有病例号
	public List<Map<String, Object>> getAllCaseIds() {
		String sql = "select c_h_id,c_h_date from case_history where c_h_status='正常' order by c_h_id desc";
		return db.query(sql);
	}
	//添加挂号（诊断）单
	public int addRegister(Register register) {
		String sql = "";
		if(register.getCaseId()>0&&register.getDoctorId()>0){
			sql = "insert into register (r_id,r_case_id,r_dealer_id,r_doctor_id,r_office_id,r_status,r_date,r_type) " +
			"values (register_seq.nextval,"+register.getCaseId()+",'"+register.getDealerId()+"',"+register.getDoctorId()+","+register.getOfficeId()+",'挂号中'," +
					"to_date('"+new Date().toLocaleString().split(" ")[0]+"','YYYY-MM-DD'),'"+register.getType()+"')";
		}else if(register.getCaseId()==0&&register.getDoctorId()>0){
			sql = "insert into register (r_id,r_dealer_id,r_doctor_id,r_office_id,r_status,r_date,r_type) " +
			"values (register_seq.nextval,'"+register.getDealerId()+"',"+register.getDoctorId()+","+register.getOfficeId()+",'挂号中',to_date('"+new Date().toLocaleString().split(" ")[0]+"','YYYY-MM-DD'),'"+register.getType()+"')";
		}else if(register.getCaseId()>0&&register.getDoctorId()==0){
			sql = "insert into register (r_id,r_case_id,r_dealer_id,r_office_id,r_status,r_date,r_type) " +
			"values (register_seq.nextval,"+register.getCaseId()+",'"+register.getDealerId()+"',"+register.getOfficeId()+",'挂号中',to_date('"+new Date().toLocaleString().split(" ")[0]+"','YYYY-MM-DD'),'"+register.getType()+"')";
		}else {
			sql = "insert into register (r_id,r_dealer_id,r_office_id,r_status,r_date,r_type) " +
			"values (register_seq.nextval,'"+register.getDealerId()+"',"+register.getOfficeId()+",'挂号中',to_date('"+new Date().toLocaleString().split(" ")[0]+"','YYYY-MM-DD'),'"+register.getType()+"')";
		}
		//System.out.println(sql);
		
		return db.update(sql);
	}
	//诊断时查出挂号的病人信息
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
	//原来无病历号的挂号单 添加挂号编号
	public int resetRegister(String registerId) {
		String sql = "select max(c_h_id) as id from case_history ";
		String c_h_id = db.query(sql).get(0).get("ID").toString();
		String sql1 = "update register set r_case_id="+Integer.parseInt(c_h_id)+" where r_id="+Integer.parseInt(registerId)+"";
		//System.out.println(sql1);
		return db.update(sql1);
	}
	//根据挂号Id查询病例号
	public List<Map<String, Object>> getCaseId(int registerId) {
		String sql = "select r_case_id from register where r_id = "+registerId+"";
		return db.query(sql);
	}
	//根据挂号Id查询所有信息
	public List<Map<String, Object>> getAllPastInfo(int c_h_Id){
		String sql = "select * from register where r_case_id = "+c_h_Id+" and r_status='诊断结束'";
		//System.out.println(sql);
		return db.query(sql);
	}
	//当病历号存在时 第一次进入诊断状态  把挂号中改成诊断中
	public int modifyDiagnoseSituation(int registerId) {
		String sql = "update register set r_status = '诊断中' where r_id="+registerId+"";
		return db.update(sql);
	}
	//添加诊断信息 第二次设置register表（description）
	public int addRegisterSecond(Register register) {
		String sql = "update register set r_status='诊断结束',r_description='"+register.getDescription()+"',r_result='"+register.getResult()+"',r_measure='"+register.getMeasure()+"',r_tablet='"+register.getTablet()+"',r_cost="+register.getCost()+",r_otheritem='"+register.getOtherItem()+"',r_othercost='"+register.getOtherCost()+"',r_date=to_date('"+new Date().toLocaleString().split(" ")[0]+"','YYYY-MM-DD') where r_id="+register.getId()+"";
		//System.out.println(sql);
		return db.update(sql);
	}
	//根据挂号表的id查询科室id
	public List<Map<String, Object>> getOfficeId(int registerId) {
		String sql = "select r_office_id from register where r_id="+registerId+"";
		return db.query(sql);
	}
	
}

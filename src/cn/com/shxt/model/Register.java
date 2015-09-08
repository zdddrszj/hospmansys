package cn.com.shxt.model;

public class Register {
	private int id ; 
	private int caseId=0 ; //病例主键
	private String dealerId ; //挂号经手人账号 也是唯一的
	private int doctorId=0 ; //主治医生主键
	private int officeId ; //科室主键
	private String type ; //类型 医保 普通
	private String status ; //状态 挂号 诊断 中 诊断结束
	private String description ; //诊断描述
	private String result ; //诊断结果
	private String measure ; //治疗方案
	private String tablet ; //药品单
	private float cost ; //药品金额
	private String otherItem ; //其它收费项目
	private float otherCost ; // 其它收费金额
	private String date ; //诊断时间
	
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCaseId() {
		return caseId;
	}
	public void setCaseId(int caseId) {
		this.caseId = caseId;
	}
	public String getDealerId() {
		return dealerId;
	}
	public void setDealerId(String dealerId) {
		this.dealerId = dealerId;
	}
	public int getDoctorId() {
		return doctorId;
	}
	public void setDoctorId(int doctorId) {
		this.doctorId = doctorId;
	}
	public int getOfficeId() {
		return officeId;
	}
	public void setOfficeId(int officeId) {
		this.officeId = officeId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public String getMeasure() {
		return measure;
	}
	public void setMeasure(String measure) {
		this.measure = measure;
	}
	public String getTablet() {
		return tablet;
	}
	public void setTablet(String tablet) {
		this.tablet = tablet;
	}
	public float getCost() {
		return cost;
	}
	public void setCost(float cost) {
		this.cost = cost;
	}
	public String getOtherItem() {
		return otherItem;
	}
	public void setOtherItem(String otherItem) {
		this.otherItem = otherItem;
	}
	public float getOtherCost() {
		return otherCost;
	}
	public void setOtherCost(float otherCost) {
		this.otherCost = otherCost;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	
}

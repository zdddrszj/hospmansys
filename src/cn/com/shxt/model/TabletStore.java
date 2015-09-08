package cn.com.shxt.model;

public class TabletStore {
	private int id;
	private int tabKindId;
	private String tabName;
	private int factoryId;
	private String proDate;
	private String overDate;
	private String order;
	private int count;
	private String unit;
	private float inprice;
	private float outprice;
	private String inDate;
	private String status ;
	private int saleCount ; 
	
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getSaleCount() {
		return saleCount;
	}
	public void setSaleCount(int saleCount) {
		this.saleCount = saleCount;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getTabKindId() {
		return tabKindId;
	}
	public void setTabKindId(int tabKindId) {
		this.tabKindId = tabKindId;
	}
	public String getTabName() {
		return tabName;
	}
	public void setTabName(String tabName) {
		this.tabName = tabName;
	}
	public int getFactoryId() {
		return factoryId;
	}
	public void setFactoryId(int factoryId) {
		this.factoryId = factoryId;
	}
	public String getProDate() {
		return proDate;
	}
	public void setProDate(String proDate) {
		this.proDate = proDate;
	}
	public String getOverDate() {
		return overDate;
	}
	public void setOverDate(String overDate) {
		this.overDate = overDate;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public float getInprice() {
		return inprice;
	}
	public void setInprice(float inprice) {
		this.inprice = inprice;
	}
	public float getOutprice() {
		return outprice;
	}
	public void setOutprice(float outprice) {
		this.outprice = outprice;
	}
	public String getInDate() {
		return inDate;
	}
	public void setInDate(String inDate) {
		this.inDate = inDate;
	}
	
	
	
}

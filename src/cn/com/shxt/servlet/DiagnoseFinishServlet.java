package cn.com.shxt.servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.Register;
import cn.com.shxt.model.TabletSale;
import cn.com.shxt.model.TabletStore;
import cn.com.shxt.service.RegisterService;
import cn.com.shxt.service.TabletSaleService;
import cn.com.shxt.service.TabletStoreService;

public class DiagnoseFinishServlet extends HttpServlet {

	private static final long serialVersionUID = -3453679891376791261L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String description = request.getParameter("description");
		String result = request.getParameter("result");
		String measure = request.getParameter("measure");
		String otherItem = request.getParameter("otherItem");
		String otherCost = request.getParameter("otherCost");
		String registerId = request.getParameter("registerId");
		String type = request.getParameter("type");
		
		
		Register register = new Register();
		register.setId(Integer.parseInt(registerId));
		register.setDescription(description);
		register.setResult(result);
		register.setMeasure(measure);
		register.setOtherItem(otherItem);
		register.setOtherCost(Float.parseFloat(otherCost));
		
		String tabletList = "";
		if(!(request.getParameter("hid")=="")){ 
			tabletList = request.getParameter("hid");//11@头孢克亏x1=12.9#82@速效丸x1=24#   //|,* 分割符不好使   11为该药品库存编号
			String r_tablet = "";
			float r_cost = 0.0f;
			String []tablet = tabletList.split("#"); //11@头孢克亏x1=12.9
			for(int i = 0 ; i < tablet.length ; i ++){
				String[] tab = tablet[i].split("=");  //11@头孢克亏x1
				r_tablet += tab[0].split("@")[1]+"#";
				r_cost += Float.parseFloat(tab[1].toString());
			}
			register.setTablet(r_tablet);
			register.setCost(r_cost);
			//修改诊断表
			RegisterService registerService = new RegisterService();
			registerService.addRegisterSecond(register);
			//修改库存表
			TabletStore tabletStore = new TabletStore();
			TabletStoreService tabletStoreService = new TabletStoreService();
			for(int i = 0 ; i < tablet.length ; i ++){
				String[] tab = tablet[i].split("=")[0].split("@");  //11(tablet_store)  头孢克亏x1 
				int t_s_id = Integer.parseInt(tab[0]);
				int t_s_count = Integer.parseInt(tab[1].split("x")[1]);
				tabletStore.setId(t_s_id);
				tabletStore.setCount(t_s_count);
				tabletStoreService.modifySaleCount(tabletStore);
			}
			//添加售药表
			TabletSale tabletSale = new TabletSale();
			TabletSaleService tabletSaleService = new TabletSaleService();
			for(int i = 0 ; i < tablet.length ; i ++){
				String[] tab = tablet[i].split("=")[0].split("@");  //11@头孢克亏x1=12.9
				int t_s_id = Integer.parseInt(tab[0]);
				int t_s_count = Integer.parseInt(tab[1].split("x")[1]);
				tabletSale.setStoreId(t_s_id);
				tabletSale.setCount(t_s_count);
				tabletSale.setRegisterId(Integer.parseInt(registerId));
				tabletSale.setOfficeid(1);
				List<Map<String, Object>> list = registerService.getOfficeId(Integer.parseInt(registerId));
				if(list.size()>0){
					tabletSale.setOfficeid(Integer.parseInt(list.get(0).get("R_OFFICE_ID").toString()));
				}
				tabletSaleService.addTabSale(tabletSale);
			}
		}else{
			register.setTablet("无");
			register.setCost(0.0f);
			//修改诊断表
			RegisterService registerService = new RegisterService();
			registerService.addRegisterSecond(register);
		}
		request.getRequestDispatcher("/diagnoseFunction/diagnoseFinish.jsp?tabletList="+tabletList+"&type="+type).forward(request, response);
	}
}

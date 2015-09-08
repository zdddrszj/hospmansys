package cn.com.shxt.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.service.RegisterService;

public class GetDoctorServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
		
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int officeId = Integer.parseInt(request.getParameter("officeId").toString());
		List<Map<String, Object>> list = new RegisterService().getAllDoctorsWithoutDate(officeId);
		//所有的
		List<Map<String, Object>> list1 = new RegisterService().getAllDoctor(officeId);
		response.setContentType("text/xml;charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		out.print("<root>");
		if(list.size()==0){
			for(Map<String,Object> map1 : list1){
				out.print("<doctor>");
				out.print("<c_id>"+map1.get("C_ID")+"</c_id>");
				out.print("<c_name>"+map1.get("C_NAME")+"</c_name>");//医生姓名
				out.print("<c_count>"+"0"+"</c_count>");
				out.print("</doctor>");
			}
		}else{
			if(list.size()==list1.size()){
				for(Map<String,Object> map : list){
					out.print("<doctor>");
					out.print("<c_id>"+map.get("C_ID")+"</c_id>");
					out.print("<c_name>"+map.get("C_NAME")+"</c_name>");//医生姓名
					out.print("<c_count>"+map.get("NUM")+"</c_count>");
					out.print("</doctor>");
				}
			}else{
				for(Map<String,Object> map1 : list1){//所有的
					for(Map<String,Object> map : list){
						if(map1.get("C_NAME").toString().equals(map.get("C_NAME").toString())){
							out.print("<doctor>");
							out.print("<c_id>"+map.get("C_ID")+"</c_id>");
							out.print("<c_name>"+map.get("C_NAME")+"</c_name>");//医生姓名
							out.print("<c_count>"+map.get("NUM")+"</c_count>");
							out.print("</doctor>");
						}else{
							out.print("<doctor>");
							out.print("<c_id>"+map1.get("C_ID")+"</c_id>");
							out.print("<c_name>"+map1.get("C_NAME")+"</c_name>");//医生姓名
							out.print("<c_count>"+"0"+"</c_count>");
							out.print("</doctor>");
						}
					}
				}
			}
		}
		out.print("</root>");
	}
}

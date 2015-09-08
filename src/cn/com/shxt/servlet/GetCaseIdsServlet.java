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

public class GetCaseIdsServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		List<Map<String, Object>> list = new RegisterService().getAllCaseIds();
		
		response.setContentType("text/xml;charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		out.print("<root>");
		for(Map<String,Object> map : list){
			out.print("<case>");
			out.print("<ch_id>"+map.get("C_H_ID")+"</ch_id>");
			out.print("<case_id>"+map.get("C_H_DATE")+"/"+map.get("C_H_ID")+"</case_id>");//Ò½ÉúÐÕÃû
			out.print("</case>");
		}
		out.print("</root>");
	}



}

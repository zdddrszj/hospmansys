<%@ page language="java" import="java.util.*,cn.com.shxt.model.*,cn.com.shxt.service.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'diagnose.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=path %>/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=path %>/js/pageList.js"></script>
	<style type="text/css">
		td { text-align:center; border-color:#0000FF;}
		tr { height: 40px;}
	</style>
	<script type="text/javascript">
		//无病历号的 创建病例
		function caseHistoryAdd(registerId){
			var result = window.showModalDialog("<%=path %>/diagnoseFunction/caseHistoryAdd.jsp?registerId="+registerId,"","");
				if(result > 0){
					$("#fm").submit();
			}
		}
		function showDetail(registerId){
		
			var result = window.showModalDialog("servlet/CaseHistoryDetailServlet?registerId="+registerId,"","dialogWidth:1100px");
			if(result > 0){
				$("#fm").submit();
			}
		}
	
	</script>
	<%
		PageBean pageBean = (PageBean)request.getAttribute("pageBean");
	%>
  </head>
  
  <body>
   <center>
		<form id="fm" action="servlet/DiagnoseAddServlet" method="post">
			<table border="1" cellspacing="0" width="80%">
				<caption><font color="blue" size="5px"><b>等待诊断用户</b></font></caption>
				<tr>
					<th width="300px">挂号编号</th>
					<th width="300px">病例号</th>
					<th>诊断</th>
				</tr>
				<%
					String caseDate = "";//C_H_DATE
   					for (Map<String,Object> map: pageBean.getPageList()) {
   						
   						if(map.get("R_CASE_ID")==null||map.get("R_CASE_ID")==""){
   							caseDate = "null";
   						}else{
   							List<Map<String, Object>> list = new CaseHistoryService().getCaseDate(Integer.parseInt(map.get("R_CASE_ID").toString()));
   							if(list.size()>0){
   								caseDate = list.get(0).get("C_H_DATE").toString();
   								
   							}
   						}
   						%>
   							<tr>
   								<td><%=map.get("R_ID") %></td>
   								<td><%=caseDate %>/<%=map.get("R_CASE_ID") %></td>
   								<td><a <%if(caseDate=="null"){%> onclick="caseHistoryAdd(<%=map.get("R_ID") %>)" <%}else{%>onclick="showDetail(<%=map.get("R_ID") %>)"<%} %>>诊断</a></td>
   							</tr>
   						<%
   					}
   				%>
   						
			</table>
			<br /><br /><br />
   			当前是第<%=pageBean.getCurrentPage() %>/<%=pageBean.getTotalPage() %>页&nbsp;&nbsp;&nbsp;&nbsp;
	    	 <a id="firstPage" href="javascript:void(0)">首&nbsp;&nbsp;页</a>&nbsp;&nbsp;&nbsp;&nbsp;
	    	 <a id="prevPage" href="javascript:void(0)">上一页</a>&nbsp;&nbsp;&nbsp;&nbsp;
	    	 <a id="nextPage" href="javascript:void(0)">下一页</a>&nbsp;&nbsp;&nbsp;&nbsp;
	   		 <a id="lastPage" href="javascript:void(0)">尾&nbsp;&nbsp;页</a>&nbsp;&nbsp;
	   		 <input type="hidden" name="currentPage" id="currentPage" value="<%=pageBean.getCurrentPage() %>" />
	   		 <input type="hidden" name="totalPage" id="totalPage" value="<%=pageBean.getTotalPage() %>" />
		</form>
   </center>
  </body>
</html>

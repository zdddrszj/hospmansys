<%@ page language="java" import="java.util.*,cn.com.shxt.model.*,cn.com.shxt.service.*,java.text.SimpleDateFormat" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'tabStoreSearch.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

	<script type="text/javascript" src="<%=path %>/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=path %>/js/pageList.js"></script>
	<style type="text/css">
		.td1 { text-align:center; border-color:#0000FF;}
		tr { height: 40px;}
	</style>
	<%
		PageBean pageBean = (PageBean)request.getAttribute("pageBean");
	%>
  </head>
  
  <body>
  <center>
    <form id="fm" action="servlet/TabStoreSearchServlet" method="post">
    	<table width="100%" border="1px" cellspacing="0">
    		<caption><font color="blue" size="5px"><b>药品库存查询</b></font></caption>
    		<tr>
    			<th>药品种类</th>
    			<th>药品名称</th>
    			<th>生产日期</th>
    			<th>过期日期</th>
    			<th>数量</th>
    			<th>单位</th>
    			<th>进货单价</th>
    			<th>销售单价</th>
    			<th>厂家</th>
    			<th>进药日期</th>
    			<th>已过期</th>
    		</tr>
    		<%
    			for (Map<String,Object> map: pageBean.getPageList()) {
    				String date = map.get("T_S_OVERDATE").toString();
    				if(new SimpleDateFormat("yyyy-mm-dd").parse(date).compareTo(new SimpleDateFormat("yyyy-mm-dd").parse(new Date().toLocaleString().split(" ")[0]))<=0){
    					int tabKindId = Integer.parseInt(map.get("T_K_ID").toString());
        				//查询药品种类名称
        				String tabKindName = new TabletKindService().getTabKindName(tabKindId);
        				//查询药品厂家名称
        				int factoryId = Integer.parseInt(map.get("T_S_FACTORY").toString());
        				String factoryName = new FactoryService().getFactoryName(factoryId);
        				
    					%>
    					<tr>
    						<td class="td1"><%=tabKindName %></td>
    						<td class="td1"><%=map.get("T_S_NAME") %></td>
    						<td class="td1"><%=map.get("T_S_PRODATE") %></td>
    						<td class="td1"><%=map.get("T_S_OVERDATE") %></td>
    						<td class="td1"><%=map.get("T_S_COUNT") %></td>
    						<td class="td1"><%=map.get("T_S_UNIT") %></td>
    						<td class="td1"><%=map.get("T_S_INPRICE") %></td>
    						<td class="td1"><%=map.get("T_S_OUTPRICE") %></td>
    						<td class="td1"><%=factoryName %></td>
    						<td class="td1"><%=map.get("T_S_INDATE") %></td>
    						<td class="td1">已过期</td>
    					</tr>
    				<%
    				}
    			}
    		%>
    	</table><br /><br />
    	<table width="100%" border="1px" cellspacing="0">
    		<tr>
    			<th>药品种类</th>
    			<th>药品名称</th>
    			<th>生产日期</th>
    			<th>过期日期</th>
    			<th>数量</th>
    			<th>单位</th>
    			<th>进货单价</th>
    			<th>销售单价</th>
    			<th>厂家</th>
    			<th>进药日期</th>
    			<th>修改</th>
    		</tr>
    		<%
    			for (Map<String,Object> map: pageBean.getPageList()) {
    				int tabKindId = Integer.parseInt(map.get("T_K_ID").toString());
    				//查询药品种类名称
    				String tabKindName = new TabletKindService().getTabKindName(tabKindId);
    				//查询药品厂家名称
    				int factoryId = Integer.parseInt(map.get("T_S_FACTORY").toString());
    				String factoryName = new FactoryService().getFactoryName(factoryId);
    				String date = map.get("T_S_OVERDATE").toString();
    				if(new SimpleDateFormat("yyyy-mm-dd").parse(date).compareTo(new SimpleDateFormat("yyyy-mm-dd").parse(new Date().toLocaleString().split(" ")[0]))>0){
    					%>
    					<tr>
    						<td class="td1"><%=tabKindName %></td>
    						<td class="td1"><%=map.get("T_S_NAME") %></td>
    						<td class="td1"><%=map.get("T_S_PRODATE") %></td>
    						<td class="td1"><%=map.get("T_S_OVERDATE") %></td>
    						<td class="td1"><%=map.get("T_S_COUNT") %></td>
    						<td class="td1"><%=map.get("T_S_UNIT") %></td>
    						<td class="td1"><%=map.get("T_S_INPRICE") %></td>
    						<td class="td1"><%=map.get("T_S_OUTPRICE") %></td>
    						<td class="td1"><%=factoryName %></td>
    						<td class="td1"><%=map.get("T_S_INDATE") %></td>
    						<td class="td1"><a href="servlet/TabStoreDetailServlet?tabStoreId=<%=map.get("T_S_ID") %>">修改</a></td>
    					</tr>
    				<%
    				}
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

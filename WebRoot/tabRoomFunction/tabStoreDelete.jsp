<%@ page language="java" import="java.util.*,cn.com.shxt.model.*,cn.com.shxt.service.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'tabStoreDelete.jsp' starting page</title>
    
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
		$(function(){
			
			$("#kind").change(function (){
				//按批次号退药
				if($("#kind").attr("value")=="按批次号退药"){
					$("#choice").children().remove();
					$.ajax({
						type:"post",
						url:"servlet/GetTabStoreOrdersServlet",
						success:function(xml){
							$(xml).find("order").each(function(){
								if($("#choiceValue").attr("value")==$(this).children("order_id").text()){
									$("#choice").append("<option selected='selected' value="+$(this).children("order_id").text()+">"+$(this).children("order_name").text()+"</option>");
								}else {
									$("#choice").append("<option value="+$(this).children("order_id").text()+">"+$(this).children("order_name").text()+"</option>");
								}
							});
						},
						dataType:"xml"
					});
				}
				
				//药品种类
				if($("#kind").attr("value")=="按药品种类退药"){
					$("#choice").children().remove();
					$.ajax({
						type:"post",
						url:"servlet/GetTabKindsServlet",
						success:function(xml){
							$(xml).find("tab").each(function(){
								if($("#choiceValue").attr("value")==$(this).children("t_k_id").text()){
									$("#choice").append("<option selected='selected' value="+$(this).children("t_k_id").text()+">"+$(this).children("t_k_name").text()+"</option>");
								}else {
									$("#choice").append("<option value="+$(this).children("t_k_id").text()+">"+$(this).children("t_k_name").text()+"</option>");
								}
							});
						},
						dataType:"xml"
					});
				}
				//药品名称
				if($("#kind").attr("value")=="按药品名称退药"){
					$("#choice").children().remove();
					$.ajax({
						type:"post",
						url:"servlet/GetTabNamesServlet",
						success:function(xml){
							$(xml).find("tablet").each(function(){
								if($("#choiceValue").attr("value")==$(this).children("t_s_id").text()){
									$("#choice").append("<option selected='selected' value="+$(this).children("t_s_id").text()+">"+$(this).children("tab_name").text()+"</option>");
								}else {
									$("#choice").append("<option value="+$(this).children("t_s_id").text()+">"+$(this).children("tab_name").text()+"</option>");
								}
							});
						},
						dataType:"xml"
					});
				}
			});
			//按批次号退药先自动加载
			$("#kind").change();
			//查询
			$("#search").click(function (){
				
				$("#currentPage").attr("value",1);				
				$("#fm").submit();
			});
		});
		function showDeleteCount(tabStoreId){
			var result = window.showModalDialog("servlet/TabStoreDeleteServlet?tabStoreId="+tabStoreId,"","dialogWidth:400px;dialogHeight:150px;dialogLeft:400px;dialogTop:200px");
			if(result > 0){
				$("#fm").submit();
			}
		}
	</script>
	<%	
		String kind = "";
		String choice = "";
		if(request.getAttribute("kind")!=null){
			kind = (String)request.getAttribute("kind");
		}
		if(request.getAttribute("choice")!=null){
			choice = (String)request.getAttribute("choice");
		}
	%>
  </head>
  
  <body>
    <form id="fm" action="servlet/TabStoreSearchServlet" method="post">
    	<center>
    		<table width="100%" border="1px" cellspacing="0">
    			<caption><font color="blue" size="5"><b>退药</b></font></caption>
    			<tr>
    				<td width="400px">
    					<select id="kind" name="kind">
    						<option <%if(kind.equals("按批次号退药")){%>selected="selected"<%} %> value="按批次号退药">按批次号退药</option>
    						<option <%if(kind.equals("按药品种类退药")){%>selected="selected"<%} %> value="按药品种类退药">按药品种类退药</option>
    						<option <%if(kind.equals("按药品名称退药")){%>selected="selected"<%} %> value="按药品名称退药">按药品名称退药</option>
    					</select>
    				</td>
    				<td width="400px">
    					<select id="choice" name="choice"></select>
    				</td>
    				<td width="400px"><input type="button" value="查询" id="search" name="search" /></td>
    			</tr>
    		</table>
    		<br /><br /><br />
    		<div id="div1">
    			<%
    				if(request.getAttribute("pageBean")!=null){
	    				PageBean pageBean = (PageBean)request.getAttribute("pageBean");
    			%>
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
			    						<td class="td1"><a style="text-decoration: none" onclick="showDeleteCount(<%=map.get("T_S_ID") %>)">退药</a></td>
			    					</tr>
			    				<%
			    			}
		    				%>
		    					</table><br /><br /><br />
		    					当前是第<%=pageBean.getCurrentPage() %>/<%=pageBean.getTotalPage() %>页&nbsp;&nbsp;&nbsp;&nbsp;
							     <a id="firstPage" href="javascript:void(0)">首&nbsp;&nbsp;页</a>&nbsp;&nbsp;&nbsp;&nbsp;
							     <a id="prevPage" href="javascript:void(0)">上一页</a>&nbsp;&nbsp;&nbsp;&nbsp;
							     <a id="nextPage" href="javascript:void(0)">下一页</a>&nbsp;&nbsp;&nbsp;&nbsp;
							     <a id="lastPage" href="javascript:void(0)">尾&nbsp;&nbsp;页</a>&nbsp;&nbsp;&nbsp;&nbsp;
							     <input type="hidden" name="currentPage" id="currentPage" value="<%=pageBean.getCurrentPage() %>" />
							     <input type="hidden" name="totalPage" id="totalPage" value="<%=pageBean.getTotalPage() %>" />
		    					<input type="hidden" name="choiceValue" id="choiceValue" value="<%=choice %>" />
		    				<%
		    			}
		    		%>
    		 </div>
    	</center>
    </form>
  </body>
</html>
 
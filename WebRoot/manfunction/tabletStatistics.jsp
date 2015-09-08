<%@ page language="java" import="java.util.*,cn.com.shxt.model.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'tabletStatistics.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=path %>/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=path %>/js/validate.js"></script>
	<script type="text/javascript" src="<%=path %>/js/pageList.js"></script>
	<script type="text/javascript" src="<%=path %>/js/My97DatePicker/WdatePicker.js"></script>
	
	<script type="text/javascript">
		$(function (){
			$("#b2").click(function (){
				$("#currentPage").attr("value","1");
				$("#startDate").attr("value","");
				$("#endDate").attr("value","");
				$("#fm").submit();
			});
			$("#but").click(function (){
				//$("#f").attr("value","yes");
				if($("#startDate").attr("value")==null||$("#startDate").attr("value")==""){
					alert("起始时间为空！");
				}else if($("#endDate").attr("value")==null||$("#endDate").attr("value")==""){
					alert("终止时间为空！");
				}else if($("#startDate").attr("value")>$("#endDate").attr("value")){
					alert("请检查时间！");
				}else{
					//$("#f").attr("value","yes");
					$("#fm").submit();
				}
			});
		});
	</script>
	<style type="text/css">
		td { text-align:center; border-color:#0000FF;}
		tr { height: 60px;}
	</style>
  </head>
  <%
  		PageBean pageBean = (PageBean)request.getAttribute("pageBean");
 		String startDate = (String)request.getAttribute("startDate");
		String endDate = (String)request.getAttribute("endDate");
		if(startDate == null) {
			startDate = "";
		}
		if(endDate == null){
			endDate = "";
		}
  %>
  <body>
   	<center>
   		<form id="fm" action="servlet/StatisticsOfTabletServlet" method="post">
   			<table width="100%" >
   				<caption><font size="5px" color="blue"><b>药品进货情况</b></font></caption>
   				<tr>
   					<td width="450px">起始日期：<input value="<%=startDate %>" id="startDate" name="startDate" class="Wdate" type="text" onclick="WdatePicker()"></td>
   					<td width="450px">截止日期：<input value="<%=endDate %>" id="endDate" name="endDate"  class="Wdate" type="text" onclick="WdatePicker()"></td>
   					<td><input id="but" value="查询" type="button"></td>
   				</tr>
   			</table>
   			<table width="100%" border="1" cellspacing="0">
   				<tr>
					<th>药品名称</th>
					<th>批次号</th>
		    		<th>数量</th>
		    		<th>总价</th>
		    		<th>进药日期</th>
		    	</tr>
		    	<%
		    	for (Map<String,Object> map: pageBean.getPageList()) {
		    		float price = Float.parseFloat(map.get("T_S_INPRICE").toString())*Integer.parseInt(map.get("T_S_COUNT").toString());
		    		price = Math.round(price);
				%>
				<tr>
		    		<td class="td1"><%=map.get("T_S_NAME") %></td>
		    		<td class="td1"><%=map.get("T_S_ORDER") %></td>
		    		<td class="td1"><%=map.get("T_S_COUNT") %></td>
		    		<td class="td1"><%=price %></td>
		    		<td class="td1"><%=map.get("T_S_INDATE") %></td>
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
		     <input id="b2" type="button" value="无条件查询" />
		     <input type="hidden" name="currentPage" id="currentPage" value="<%=pageBean.getCurrentPage() %>" />
		     <input type="hidden" name="totalPage" id="totalPage" value="<%=pageBean.getTotalPage() %>" />
		     
   		</form>
   	</center>
  </body>
</html>

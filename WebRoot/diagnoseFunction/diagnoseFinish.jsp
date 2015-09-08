<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'diagnoseFinish.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=path %>/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=path %>/js/validate.js"></script>
	<script type="text/javascript">
		function closeWindow(){
			window.returnValue = 1;
			window.close();
		}
		function getBack(){
			if(!$("#real").attr("value").validateSignlessDecimal()){
				alert("请检查实收!");
			}else {
				$("#back").attr("value",parseInt($("#real").attr("value"))-parseInt($("#a").attr("value")));
			}
			
		}
	</script>
	<%
		String tabletList = request.getParameter("tabletList");
		String type = request.getParameter("type");
		//System.out.println(tabletList);
		//System.out.println(type);
	%>
	<style type="text/css">
		td { text-align:center; border-color:#0000FF;}
		tr { height: 40px;}
	</style>
	
  </head>
  
  <body>
  <center>
  <br /><br />
    <%
    	if(tabletList.equals("")||tabletList==null){
    		%>
    			<font color="blue" size="5px">无药品单！</font><br /><br />  <br /><br />
    			<input type="button" value="关闭窗口" onclick="closeWindow()" />
    		<%
    	}else{//11@头孢克亏x1=12.9#82@速效丸x1=24#
    		%>
    			<table width="80%" border="1" cellspacing="0" id="table">
			    	<caption><font color="blue" size="5px"><b>药品单</b></font></caption>
			    	<tr>
			    		<th>药品</th>
			    		<th>数量</th>
			    		<th>总价</th>
			    	</tr>
			    	<%
			    		for(int i = 0 ; i < tabletList.split("#").length ; i ++){
			    			String a = tabletList.split("#")[i].split("@")[1];//头孢克亏x1=12.9
			    			%>
			    				<tr>
			    					<td><%=a.split("x")[0] %></td>
			    					<td><%=a.split("x")[1].split("=")[0] %></td>
			    					<td><%=a.split("=")[1] %></td>
			    				</tr>
			    			<%
			    		}
			    	%> 
			    	
			    		<%
			    			if(type.equals("普通")){
			    				float value = 0.0f;
			    				for(int i = 0 ; i < tabletList.split("#").length ; i ++){
					    			String a = tabletList.split("#")[i].split("@")[1];//头孢克亏x1=12.9
					    			value += Float.parseFloat(a.split("=")[1]);
					    		}
			    				%>
			    				<tr>
			    					<td colspan="3">
						    		合计：<%=Math.round(value*100)/100 %>
						    		<input id="a" type="hidden" value="<%=Math.round(value*100)/100 %>"/>
						    		</td>
						    	</tr>
			    				<%
			    			}else{
			    				float value = 0.0f;
			    				for(int i = 0 ; i < tabletList.split("#").length ; i ++){
					    			String a = tabletList.split("#")[i].split("@")[1];//头孢克亏x1=12.9
					    			value += Float.parseFloat(a.split("=")[1]);
					    		}
			    				%>
			    				<tr>
			    					
						    		<td colspan="3">
						    		合计：<%=Math.round(value*100)/100 %>*0.8=<%=Math.round(value*0.8*100)/100 %>
						    		<input id="a" type="hidden" value="<%=Math.round(value*0.8*100)/100 %>" />
						    		</td>
						    	</tr>
			    				<%
			    			}
			    		%>
			    	
			    </table>
			    <br /><br />
			    <div align="right">
			    	<img alt="" src="<%=path %>/images/total.gif" width="170px" height="150px">
			    </div>
    			
    			<table>
    				<tr>
    					<td>实收：<input type="text" id="real" /></td>
    					<td>找零：<input id="back" type="text" readonly="readonly" onfocus="getBack();" /></td>
    				</tr>
    			</table>
    			<br />
    			<input type="button" value="关闭窗口" onclick="closeWindow()" />
    		<%
    	}
    %>
    </center>
  </body>
</html>

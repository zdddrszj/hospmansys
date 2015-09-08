<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'ConsumeroneInfo.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
			td { text-align:center; border-color:#0000FF;}
			tr { height:60px;}
	</style>
  </head>
  <%
  	List<Map<String,Object>> list = (List<Map<String,Object>>)request.getAttribute("oneInfoList");
  	Map<String,Object> map = list.get(0);
  %>
  <body>
    <center>
    	<table>
    		<tr>
    			<th>姓名：</th>
    			<th><input type="text" value=<%=map.get("C_NAME") %> /></th>
    			<th>性别：</th>
    			<th><input type="text" value=<%=map.get("C_SEX") %> /></th>
    		</tr>
    		<tr>
    			<th>身份证：</th>
    			<th><input type="text" value=<%=map.get("C_IDENTITY") %> /></th>
    			<th>邮箱：</th>
    			<th><input type="text" value=<%=map.get("C_MAIL") %> /></th>
    		</tr>
    		<tr>
    			<th>电话：</th>
    			<th><input type="text" value=<%=map.get("C_PHONE") %> /></th>
    			<th>角色：</th>
    			<th><input type="text" value=<%=map.get("C_ROLE") %> /></th>
    		</tr>
    		<tr></tr>
    		<tr></tr>
    		<tr></tr>
    	</table>
    </center>
  </body>
</html>

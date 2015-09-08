<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'factoryAddResult.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  <%
  	String result = request.getAttribute("result").toString();
  %>
  <body>
   <%
   	if(result != null || result != ""){
   		if(Integer.parseInt(result)>0){
   			%>
   				<center><font color="green" size="5px"><b>添加成功！</b></font></center>
   			<%
   		}else{
   			%>
   				<center><font color="red" size="5px"><b>添加失败！！！</b></font></center>
   			<%
   		}
   	}else {
   		%>
   			<center><font color="red" size="5px"><b>添加失败！！！</b></font></center>
   		<%
   	}
   %>
  </body>
</html>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'mainOfTabRoom.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
    <frameset rows="127,*,11" frameborder="no" border="0" framespacing="0">
		<frame src="<%=path %>/top.jsp" name="topFrame" scrolling="No"
			noresize="noresize" id="topFrame" />
		<frame src="<%=path %>/main/centerOfMan.jsp" name="mainFrame" id="mainFrame" />
		<frame src="<%=path %>/down.jsp" name="bottomFrame" scrolling="No"
			noresize="noresize" id="bottomFrame" />
	</frameset>
<noframes>
<body>
</body>
</noframes>
 
</html>

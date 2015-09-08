<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'failure.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<script type="text/javascript">
		var count = 5 ;
		function b(){
			if(count >= 0){
				document.getElementsByTagName("div")[0].innerHTML="<center><font color='red' size='10px'>"+count+"</font></center>";
				count -- ;
				if(count == -1){
					window.location="http://localhost:8080/hospitalManagementSystem/login.jsp";
				}
			}
		}
		setInterval("b()",1000);
	</script>
  </head>
  
  <body>
  	<center>
  		<font size="5px"><b>登录失败！！！</b></font>
  		<div></div>
  		
  	</center>
  </body>
</html>

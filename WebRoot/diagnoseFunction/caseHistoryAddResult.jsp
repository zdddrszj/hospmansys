<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'caseAddResult.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%
		int result = 0 ;
		if(request.getParameter("result")!=null){
			result = Integer.parseInt(request.getParameter("result"));
		}
	%>
	<script type="text/javascript">
		function closeWindow(){
			
			var result = document.getElementById("result").value;
			window.returnValue = result;
			window.close();
		}
	</script>
  </head>
  
  <body onload="test();">
    <%
    	if(result > 0 ){
    		
    		%>
    			<font color="green" size="4px" >病例添加成功！！！</font>
    		<%
    	}else {
    		%>
    			<font color="red" size="4px">病例添加失败！！！</font>
    		<%
    	}
    %>
    <input type="button" value="关闭窗口" onclick="closeWindow()" />
    <input type="hidden" id="result" value="<%=result %>" />
  </body>
</html>

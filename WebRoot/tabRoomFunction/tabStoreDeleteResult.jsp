<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'tabStoreDeleteResult.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
		<script type="text/javascript">
		function closeWindow(){
			var result = document.getElementById("result").value;
			window.returnValue = result;
			window.close();
		}
	</script>
  </head>
  
  <body>
    <%
    	int result = Integer.parseInt(request.getAttribute("result").toString());
    	Float money = Float.parseFloat(request.getAttribute("money").toString());
    	int trueMoney = Math.round(money);
    	if(result > 0){
    		%>
    			退药成功！
    			退药金额：<input readonly="readonly" value=<%=trueMoney %> /> &nbsp;元
    		<%
    	}else{
    		%>
				退药失败！
			<%
    	}
    	
    %>
    <br/>
    <input type="button" value="关闭窗口" onclick="closeWindow()" />
    <input type="hidden" id="result" value="<%=result %>" />
  </body>
</html>

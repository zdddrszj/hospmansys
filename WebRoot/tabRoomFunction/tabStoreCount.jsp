<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'tabStoreCount.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=path %>/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=path %>/js/validate.js"></script>
	<script type="text/javascript">
		$(function (){
			$("#client").focus(function (){
				
				$("#span1").html("");
				//alert($("#span1").attr("value"));
			});
		});
		function validate(){
			var tabStoreCount = document.getElementById("tabStoreCount");
			var client = document.getElementById("client");
			var span1 = document.getElementById("span1");
			
			if(client.value==null||client.value==""){
				span1.innerHTML="<font color='red' size='4px'>请输入退药数量！</font>";
				return false;
			}else if(!client.value.validateSignlessIntegral()){
				span1.innerHTML="<font color='red' size='4px'>退药数量为整数！</font>";
				return false;
			}else if(parseInt(client.value)>parseInt(tabStoreCount.value)){
				span1.innerHTML="<font color='red' size='4px'>请正确填写退药数量！</font>";
				return false;
			}
			return true;
		}
	</script>
  </head>
  <%
	List<Map<String,Object>> list = (List<Map<String,Object>>)request.getAttribute("oneTabStore");
 	int count = Integer.parseInt(list.get(0).get("T_S_COUNT").toString())-Integer.parseInt(list.get(0).get("T_S_SALE").toString());
  %>
  <body>
    <center>
    	<form id="fm" action="servlet/TabStoreModifyCount" method="post" onsubmit="return validate();">
	    	<font color="blue" size="5px">库存药品数量</font>
	    	<input type="text" readonly="readonly" value="<%=count %>" id="tabStoreCount" name="tabStoreCount" /><br />
	    	<font color="blue" size="5px">请输入退药数量</font>
	    	<input type="text" id="client" name="client" /><br />
	    	
	    	<span id="span1"></span>
	    	<input type="submit" value="提交"  />
	    	<input type="hidden" value=<%=list.get(0).get("T_S_ID") %> name="tabStoreId" />
    	</form>
    </center>
  </body>
</html>

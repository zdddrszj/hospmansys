<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'officeAdd.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript">
	var flag=false;
	var xmlhttp;
	function createXMLHttpRequest(){
		if(window.XMLHttpRequest){
			xmlhttp = new XMLHttpRequest();
		}else if(window.ActiveXObject){
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");	
		}
		return xmlhttp;
	}
	
	function getTabKind(){
		xmlhttp = createXMLHttpRequest();
		
		xmlhttp.onreadystatechange = getTabKindCallBack ;
		
		xmlhttp.open("post","servlet/GetTabKindsServlet",true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send(null);		
	}
	
	function getTabKindCallBack(){
		
		if(xmlhttp.readyState == 4){
			if(xmlhttp.status == 200){
				var root = xmlhttp.responseXML;
				var tab = root.getElementsByTagName("tab");
				var tabkindExist = document.getElementById("tabkindExist");
				tabkindExist.length = 0;
				for(var i = 0; i < tab.length ; i ++){
					var option = document.createElement("option");
					option.value = tab[i].firstChild.firstChild.data;
					option.text = tab[i].lastChild.firstChild.data;
					tabkindExist.appendChild(option);
				}				
			}
		}
	}
	
	//验证 药品种类是否存在
	function tabKindValidate(){
		/*1.创建XMLHttpRequest对象*/
			xmlhttp = createXMLHttpRequest();			
			/*2.注册Ajax回调方法*/
			xmlhttp.onreadystatechange = callback;		
			//post方式
			//3.设置和服务器端交互的参数
			var tabKindName = document.getElementById("tabKindName").value;			
			xmlhttp.open("post","servlet/TabKindValidateServlet",true);
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");			
			//4.设置向服务器端发送的数据，启动和服务器端的交互
			xmlhttp.send("tabKindName="+tabKindName);
			
	}
		function callback(){
			if(xmlhttp.readyState == 4){ //服务器端处理结束，返回给页面
				if(xmlhttp.status == 200){
					var message = xmlhttp.responseText;
					if(message == "1"){
						document.getElementById("judge").innerHTML="<font color='red'>该种类已存在</font>";
						flag=false;
					}else if(message == "2"){
						document.getElementById("judge").innerHTML="<font color='green'>该种类可用</font>";
						flag=true;
					}
				}
			}
		}
		
		function validate(){
			var tabKindName = document.getElementById("tabKindName");
			var judge = document.getElementById("judge");
			if(tabKindName.value==""||tabKindName.value==null){
				judge.innerHTML="<font color='red'>种类名称不能为空</font>";
				return false;
			}else{
				tabKindValidate();
				return flag;
			}
		}
		function tabkindFocus(){
			var judge = document.getElementById("judge");
			judge.innerHTML="";
		}
	</script>

  </head>
  
  <body onload="getTabKind();">
  	<center>
	  <form action="servlet/TabKindAddServlet" method="post" onsubmit="return validate();">
	   	<table>
	   		<caption>药品种类添加</caption>
	   		<tr>
	   			<td>药品种类名称：</td>
	   			<td><input type="text" name="tabKindName" id="tabKindName" onfocus="tabkindFocus();" onblur="validate();" /></td>
	   			<td><select id="tabkindExist"></select></td>
	   			<td>&nbsp;</td>
	   		</tr>
	   		<tr>
	   			<td>&nbsp;</td>
	   			<td id="judge">&nbsp;</td>
	   			<td><input type="submit" value="添加"  /></td>
	   			<td>&nbsp;</td>
	   		</tr>
	   	</table>
	   </form>
	  </center>
  </body>
</html>

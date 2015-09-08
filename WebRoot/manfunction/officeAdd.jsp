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
	<script type="text/javascript" src="<%=path %>/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript">
	var xmlhttp;
	function createXMLHttpRequest(){
		if(window.XMLHttpRequest){
			xmlhttp = new XMLHttpRequest();
		}else if(window.ActiveXObject){
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");	
		}
		return xmlhttp;
	}
	
	function getOffice(){
		xmlhttp = createXMLHttpRequest();
		
		xmlhttp.onreadystatechange = getOfficeCallBack ;
		
		xmlhttp.open("post","servlet/GetOfficesServlet",true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send(null);		
	}
	
	function getOfficeCallBack(){
		
		if(xmlhttp.readyState == 4){
			if(xmlhttp.status == 200){
				var root = xmlhttp.responseXML;
				var office = root.getElementsByTagName("office");
				var offselect = document.getElementById("officeExist");
				offselect.length = 0;
				for(var i = 0; i < office.length ; i ++){
					var option = document.createElement("option");
					option.value = office[i].firstChild.firstChild.data;
					option.text = office[i].lastChild.firstChild.data;
					if(option.value!=1){
							offselect.appendChild(option);//不加载角色 无					
					}
				}				
			}
		}
	}
	
	//验证科室是否存在
	var flag=false;
	function officeValidate(){
		/*1.创建XMLHttpRequest对象*/
			xmlhttp = createXMLHttpRequest();			
			/*2.注册Ajax回调方法*/
			xmlhttp.onreadystatechange = callback;		
			//post方式
			//3.设置和服务器端交互的参数
			var officeName = document.getElementById("officeName").value;			
			xmlhttp.open("post","servlet/OfficeValidateServlet",true);
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");			
			//4.设置向服务器端发送的数据，启动和服务器端的交互
			xmlhttp.send("officeName="+officeName);
			
	}
		function callback(){
			if(xmlhttp.readyState == 4){ //服务器端处理结束，返回给页面
				if(xmlhttp.status == 200){
					var message = xmlhttp.responseText;
					if(message == "1"){
						document.getElementById("judge").innerHTML="<font color='red'>该科室已存在</font>";
						flag=false;
					}else if(message == "2"){
						document.getElementById("judge").innerHTML="<font color='green'>科室可用</font>";
						flag=true;
					}
				}
			}
		}
		
		function validate(){
			var officeName = document.getElementById("officeName");
			var judge = document.getElementById("judge");
			if(officeName.value==""||officeName.value==null){
				judge.innerHTML="<font color='red'>科室名称不能为空</font>";
				return false;
			}else{
				officeValidate();
				return flag;
			}
		}
		function officeFocus(){
			var judge = document.getElementById("judge");
			judge.innerHTML="";
		}
	</script>

  </head>
  
  <body onload="getOffice();">
  	<center>
	  <form action="servlet/OfficeAddServlet" method="post" onsubmit="return validate();">
	   	<table>
	   		<caption><font size="5px" color="blue"><b>科室添加</b></font></caption>
	   		<tr>
	   			<td>科室名称：</td>
	   			<td><input type="text" name="officeName" id="officeName" onfocus="officeFocus();" onblur="validate();" /></td>
	   			<td><select id="officeExist"></select></td>
	   		</tr>
	   		<tr>
	   			<td>&nbsp;</td>
	   			<td id="judge">&nbsp;</td>
	   			<td><input type="submit" value="添加"  /></td>
	   		</tr>
	   	</table>
	   </form>
   	</center>
  </body>
</html>

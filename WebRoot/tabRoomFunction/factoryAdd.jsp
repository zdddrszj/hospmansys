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
	var xmlhttp;
	function createXMLHttpRequest(){
		if(window.XMLHttpRequest){
			xmlhttp = new XMLHttpRequest();
		}else if(window.ActiveXObject){
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");	
		}
		return xmlhttp;
	}
	
	function getFactory(){
		xmlhttp = createXMLHttpRequest();
		
		xmlhttp.onreadystatechange = getFactoryCallBack ;
		
		xmlhttp.open("post","servlet/GetFactorysServlet",true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send(null);		
	}
	
	function getFactoryCallBack(){
		
		if(xmlhttp.readyState == 4){
			if(xmlhttp.status == 200){
				var root = xmlhttp.responseXML;
				var factory = root.getElementsByTagName("factory");
				var factoryExist = document.getElementById("factoryExist");
				factoryExist.length = 0;
				for(var i = 0; i < factory.length ; i ++){
					var option = document.createElement("option");
					option.value = factory[i].firstChild.firstChild.data;
					option.text = factory[i].lastChild.firstChild.data;
					factoryExist.appendChild(option);		
				}
				getProvinces();
			}
		}
	}
		function getProvinces(){
			xmlhttp = createXMLHttpRequest();		
			xmlhttp.onreadystatechange = getProvincesCallBack ;		
			xmlhttp.open("post","servlet/GetProvincesServlet",true);
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			xmlhttp.send(null);		
		}
		
		function getProvincesCallBack(){		
			if(xmlhttp.readyState == 4){
				if(xmlhttp.status == 200){
					var root = xmlhttp.responseXML;
					var provinces = root.getElementsByTagName("province");
					var proselect = document.getElementById("provinces");
					proselect.length = 0;
					for(var i = 0; i < provinces.length ; i ++){
						var option = document.createElement("option");
						option.value = provinces[i].firstChild.firstChild.data;
						option.text = provinces[i].lastChild.firstChild.data;
						proselect.appendChild(option);
					}
					getCitys(document.getElementById("provinces"));					
				}
			}
		}
		
		function getCitys(pro){
			/*1.创建XMLHttpRequest对象*/
			xmlhttp = createXMLHttpRequest();
			/*2.注册回调函数*/
			xmlhttp.onreadystatechange = getCitysCallBack ;
			/*3.设置参数*/
			xmlhttp.open("post","servlet/GetCitysServlet",true);
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			/*设置传递参数，发起服务器访问*/
			xmlhttp.send("proId="+pro.value);
		}
		
		function getCitysCallBack(){
			if(xmlhttp.readyState == 4){
				if(xmlhttp.status == 200){
					var root = xmlhttp.responseXML;
					var citys = root.getElementsByTagName("city");
					var citySelect = document.getElementById("citys");
					citySelect.length = 0;
					for (var i = 0 ; i < citys.length ; i++) {
						var option = document.createElement("option");
						option.value = citys[i].firstChild.firstChild.data;
						option.text = citys[i].lastChild.firstChild.data;
						citySelect.appendChild(option);
					}
				}
			}
		}
	
	//验证 药厂是否存在
	var flag=false;
	function factoryValidate(){
		/*1.创建XMLHttpRequest对象*/
			xmlhttp = createXMLHttpRequest();			
			/*2.注册Ajax回调方法*/
			xmlhttp.onreadystatechange = callback;		
			//post方式
			//3.设置和服务器端交互的参数
			var factoryName = document.getElementById("factoryName").value;			
			xmlhttp.open("post","servlet/FactoryValidateServlet",true);
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");			
			//4.设置向服务器端发送的数据，启动和服务器端的交互
			xmlhttp.send("factoryName="+factoryName);
			
	}
		function callback(){
			if(xmlhttp.readyState == 4){ //服务器端处理结束，返回给页面
				if(xmlhttp.status == 200){
					var message = xmlhttp.responseText;
					if(message == "1"){
						document.getElementById("judge").innerHTML="<font color='red'>该药厂已存在</font>";
						flag=false;
					}else if(message == "2"){
						document.getElementById("judge").innerHTML="<font color='green'>药厂名称可用</font>";
						flag=true;
					}
				}
			}
		}
		
		function validate(){
			var factoryName = document.getElementById("factoryName");
			var judge = document.getElementById("judge");
			if(factoryName.value==""||factoryName.value==null){
				judge.innerHTML="<font color='red'>药厂名称不能为空</font>";
				return false;
			}else{
				factoryValidate();
				return flag;
			}
		}
		function factoryFocus(){
			var judge = document.getElementById("judge");
			judge.innerHTML="";
		}
	</script>

  </head>
  
  <body onload="getFactory();">
   	<center>
   		<form action="servlet/FactoryAddServlet" method="post" onsubmit="return validate();">
   			<table>
   				<tr>
   					<td width="120px">药厂名称：</td>
   					<td width="200px"><input type="text" id="factoryName" name="factoryName" onfocus="factoryFocus();" onblur="validate();" /></td>
   					<td width="200px">
   						<select id="factoryExist"></select>
   					</td>
   					<td width="200px" id="judge">&nbsp;</td>
   				</tr>
   				<tr>
   					<td>药厂地址：</td>
   					<td>省选择：<select id="provinces" name="provinces" onchange="getCitys(this);"></select></td>
   					<td>市选择：<select id="citys" name="citys"></select></td>
   					<td>&nbsp;</td>
   				</tr>
   				<tr>
   					<td>&nbsp;</td>
   					<td>&nbsp;</td>
   					<td align="left"><input type="submit" value="药厂添加"  /></td>
   					<td>&nbsp;</td>
   				</tr>
   			</table>
   		</form>
   	</center>
  </body>
</html>

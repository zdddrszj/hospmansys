<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'consumerAdd.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=path %>/js/upload.js"></script>
	<script type="text/javascript" src="<%=path %>/js/validate.js"></script>
	<script type="text/javascript" src="<%=path %>/js/jquery-1.7.2.min.js"></script>
	<!-- 省市ajax事件 -->
	<script type="text/javascript">
		var flag = false;
		var xmlhttp;
		function createXMLHttpRequest(){
			if(window.XMLHttpRequest){
				xmlhttp = new XMLHttpRequest();
			}else if(window.ActiveXObject){
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");	
			}
			return xmlhttp;
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
					getOffices();
				}
			}
		}
		//科室Ajax事件
		function getOffices(){
			/*1.创建XMLHttpRequest对象*/
			xmlhttp = createXMLHttpRequest();
			/*2.注册回调函数*/
			xmlhttp.onreadystatechange = getOfficesCallBack ;
			/*3.设置参数*/
			xmlhttp.open("post","servlet/GetOfficesServlet",true);
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			/*设置传递参数，发起服务器访问*/
			xmlhttp.send(null);
		}
		function getOfficesCallBack(){
			if(xmlhttp.readyState == 4){
				if(xmlhttp.status == 200){
					var root = xmlhttp.responseXML;
					var office = root.getElementsByTagName("office");
					var offices = document.getElementById("offices");					
					offices.length = 0;
					for (var i = 0 ; i < office.length ; i++) {
						var option = document.createElement("option");
						option.value = office[i].firstChild.firstChild.data;
						option.text = office[i].lastChild.firstChild.data;
						if(option.value!=1){
							offices.appendChild(option);//不加载角色 无					
						}
					}
				}
			}
		}
		
		function userAccountValidate(){
			
			/*1.创建XMLHttpRequest对象*/
			xmlhttp = createXMLHttpRequest();			
			/*2.注册Ajax回调方法*/
			xmlhttp.onreadystatechange = callback;					
			//post方式
			//3.设置和服务器端交互的参数
			var userAccount = document.getElementById("account").value;		
						
			xmlhttp.open("post","servlet/UserAccountValidateServlet",true);		
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			//4.设置向服务器端发送的数据，启动和服务器端的交互
			xmlhttp.send("userAccount="+userAccount);						
		}
		
		function callback(){
			if(xmlhttp.readyState == 4){ //服务器端处理结束，返回给页面
				if(xmlhttp.status == 200){			
					var message = xmlhttp.responseText;
					if(message == "1"){						
						document.getElementById("accountId").innerHTML="<font color='red' size='-1'>&otimes;用户名已存在</font>";
						flag=false;
					}else if(message == "2"){						
						document.getElementById("accountId").innerHTML="<font color='green' size='-1'>&radic;用户名可用</font>";
						flag=true;
					}
				}
			}
		}
		
	</script>
	<script type="text/javascript">
		//用户账号验证
		function accountBlur(){
			var account = document.getElementById("account").value;
			var accountId = document.getElementById("accountId");
			if(account==""||account==null){
				accountId.innerHTML="<font color='red' size='-1'>&otimes;用户名不能为空</font>";
				return false;
			}
			if(!isRegisterUserName(account)){
				accountId.innerHTML="<font color='red' size='-2'>&otimes;用户名由数字、字母、下划线组成，字母开头，长度6-16之间</font>";
				return false;
			}		
			userAccountValidate();//验证账号是否存在			
			if(!flag){
				return false;
			}
			//accountId.innerHTML="<font color='green'>&radic;用户名正确</font>";//ajax验证存在还是可用
			return true;
		}
		function accountFocus(){
			document.getElementById("accountId").innerHTML="<font color='green' size='-2'>用户名由数字、字母、下划线组成，字母开头，长度6-16之间</font>";		
		}
		/*$(function(){
			$("#account").focus(function(){
				$("#accountId").html("<font color='green' size='-2'>用户名由数字、字母、下划线组成，字母开头，长度6-16之间</font>");
			});
		});*/
		//身份证验证
		function idenFocus(){
			document.getElementById("identityId").innerHTML="";
		}
		function idenBlur(){
			var iden = document.getElementById("identity");
			var idenId = document.getElementById("identityId");
			if(iden.value==""||iden.value==null){
				idenId.innerHTML="<font color='red' size='-1'>&otimes;身份证号不能为空！</font>";
				return false;
			}		
			if((checkIdcard(iden.value)==true)){		
				return true;
			}else{
				var result = checkIdcard(iden.value);
				idenId.innerHTML="<font color='red' size='-1'>"+result+"</font>";//字符串拼接
				return false;
			}
			document.getElementById("identityId").innerHTML="<font color='green' size='-1'>&radic;</font>";
			return true;
		}
		//密码验证
		function pswFocus(){
			document.getElementById("pswId").innerHTML="";		
		}
		//提交时防止出现两次中强弱提示
		function pswBlur_1(){
			var psw = document.getElementById("psw");
			var pswId = document.getElementById("pswId");
			if(psw.value==""||psw.value==null){
				pswId.innerHTML="<font color='red' size='-1'>&otimes;密码不能为空！！！</font>";
				return false;
			}
			if(psw.value.length<6||psw.value.length>15){
					pswId.innerHTML="<font color='red' size='-1'>&otimes;密码不能少于6位，最多不能超过15位</font>";
					return false;
			}
			return true;
		}
		function pswBlur(){
			var psw = document.getElementById("psw");
			var pswId = document.getElementById("pswId");
			if(psw.value==""||psw.value==null){
				pswId.innerHTML="<font color='red' size='-1'>&otimes;密码不能为空！！！</font>";
				return false;
			}
			//<table cellspacing="0" width='120px'><tr><td id="td1" bgcolor='#FFEC8B'>&nbsp;</td><td id="td2" bgcolor='#FFC125'>&nbsp;</td><td id="td3" bgcolor='#FF7F00'>&nbsp;</td></tr></table>
			if(psw.value.length<6||psw.value.length>15){
					pswId.innerHTML="<font color='red' size='-1'>&otimes;密码不能少于6位，最多不能超过15位</font>";
					return false;
			}else {
				var table = document.createElement("table");
				table.width="120px";
				table.cellSpacing="0";
				var tr = document.createElement("tr");
				var td1 = document.createElement("td");
				var td2 = document.createElement("td");
				var td3 = document.createElement("td");	
				td1.width="40px";
				td2.width="40px";
				td3.width="40px";
				td1.bgColor="#FFEC8B";
				td2.bgColor="#FFC125";
				td3.bgColor="#FF7F00";				
				tr.appendChild(td1);
				tr.appendChild(td2);
				tr.appendChild(td3);
				table.appendChild(tr);
				pswId.appendChild(table);
				
				if(psw.value.length<=8){			
					td1.innerHTML="<font><center>弱</center></font>";
					return true;
				}
				if(psw.value.length>8&&psw.value.length<=12){
					td2.innerHTML="<font><center>中</center></font>";
					return true;
				}
				if(psw.value.length>12&&psw.value.length<=15){
					td3.innerHTML="<font><center>强</center></font>";
					return true;
				}
			} 							
			//psw.innerHTML="<font color='green'>&radic;密码正确</font>";//用中强弱代替
			return true;
		}
		//邮箱验证
		function mailFocus(){
			document.getElementById("spa").innerHTML="";
		}
		function mailBlur(){
			//alert(444);
			var mail = document.getElementById("mail");
			var mailAt = document.getElementById("mailAt");
			var spa = document.getElementById("spa");
			if(mail.value==""||mail.value==null){
				spa.innerHTML="<font color='red' size='-2'>&nbsp;&otimes;邮箱不能为空!!!</font>"
				return false;
			}					
			//alert(mail.value+mailAt.value);
			if(!(mail.value+mailAt.value).validateEmail()){
				spa.innerHTML="<font color='red' size='-2'>&nbsp;&otimes;邮箱格式不正确!!!</font>";
				return false;
			}			
			return true;
		}
		//确认密码验证
		function pswQFocus(){
			document.getElementById("pswQId").innerHTML="";
		}
		function pswQBlur(){
			var psw = document.getElementById("psw");
			var pswQ = document.getElementById("pswQ");
			var pswQId = document.getElementById("pswQId");
			if(psw.value==""||psw.value==null){
				pswQId.innerHTML = "<font color='red' size='-1'>&otimes;确认密码不能为空！！！</font>";
				return false;
			}
			if(pswQ.value != psw.value){
				pswQId.innerHTML = "<font color='red' size='-1'>&otimes;确认密码不正确！！！</font>";
				return false;
			}
			pswQId.innerHTML = "<font color='green'>&radic;</font>";
			return true;
		}
		//电话验证
		function phoneFocus(){
			document.getElementById("phoneId").innerHTML="";
		}
		function phoneBlur(){
			var phone = document.getElementById("phone");
			var phoneId = document.getElementById("phoneId");
			if(phone.value==""||phone.value==null){
				phoneId.innerHTML="<font color='red' size='-1'>&otimes;电话不能为空！！！</font>";
				return false;
			}
			if(!(phone.value.isMobile())){
				phoneId.innerHTML="<font color='red' size='-1'>&otimes;电话号码不正确！！！</font>";
				return false;
			}
			phoneId.innerHTML="<font color='green' size='-1'>&radic;</font>";
			return true;
		}
		//姓名验证
		function userNameFocus(){
			document.getElementById("userNameId").innerHTML="";
		}
		function userNameBlur(){
			var userName = document.getElementById("userName");
			var userNameId = document.getElementById("userNameId");
			if(userName.value==""||userName.value==null){
				userNameId.innerHTML="<font color='red' size='-1'>&otimes;姓名不能为空！！！</font>";
				return false;
			}
			if(!(userName.value.isChinese())){
				userNameId.innerHTML="<font color='red' size='-1'>&otimes;姓名只能为汉字！！！</font>";
				return false;
			}
			userNameId.innerHTML="<font color='green' size='-1'>&radic;</font>";
			return true;
		}
		//角色  改变科室可读性
		function getChange(t){
			var offices=document.getElementById("offices");
			if(t.value == "医生"){
				offices.removeAttribute("disabled");//删除属性
			}else {
				offices.setAttribute("disabled","disabled");//添加属性
			}
		}
		//校验所有控件是否合法
		function validateAll(){
			var imgHeadPhoto = document.getElementById("imgHeadPhoto");
			var photoExist = document.getElementById("photoExist");
			if(imgHeadPhoto.src == ""||imgHeadPhoto.src==null){
				photoExist.innerHTML="<font color='red' >&otimes;请选择照片！！！</font>";
				return false;
			}else{
				photoExist.innerHTML="";
				return accountBlur()&&idenBlur()&&pswBlur_1()&&pswQBlur()&&mailBlur()&&phoneBlur()&&userNameBlur();
			}
		}
	</script>
  </head>
  
  <body onload="getProvinces();">
  	<form action="servlet/ConsumerAddServlet" method="post" onsubmit="return validateAll();" enctype="multipart/form-data">
  		<center>
    <table height="340px">
    	<caption><font size="5px" color="blue"><b>用户添加</b></font></caption>
    	<tr>
    		<td  width="80px" rowspan="3" align="center">
    			<div id="divPreview">
		    		<img id="imgHeadPhoto" style="width: 120px; height: 130px;" alt="" />
		    	</div>
		    </td>
    		<td width="100px">账号：</td>
    		<td width="150px"><input type="text" name="account" id="account" onfocus="accountFocus();" onblur="accountBlur();" /></td><td id="accountId" width="120px">&nbsp;</td>
    		<td width="100px">身份证号：</td>
    		<td width="150px"><input type="text" name="identity" id="identity" onfocus="idenFocus();" onblur="idenBlur();" ></td><td id="identityId" width="100px">&nbsp;</td>
    	</tr>
    	<tr height="45px">
    		<td>密码:</td>
    		<td><input name="psw" id="psw" type="password" onfocus="pswFocus();" onblur="pswBlur();" /></td><td id="pswId">&nbsp;</td>
    		<td>mail：</td>
    		<td><input name="mail" id="mail" type="text" onfocus="mailFocus();" onBlur="mailBlur();" /></td><td><select id="mailAt" name="mailAt"><option value="@qq.com">@qq.com</option><option value="@163.com">@163.com</option><option value="@126.com">@126.com</option><option value="@yaho.com">@yaho.com</option><option value="@sina.com">@sina.com</option></select><span id="spa">&nbsp;</span></td>   		
    	</tr>
    	<tr height="45px">
    		<td>确认密码：</td>
    		<td><input type="password" name="pswQ" id="pswQ" onfocus="pswQFocus();" onblur="pswQBlur();" /></td><td id="pswQId">&nbsp;</td>
    		<td>phone：</td>
    		<td><input type="text" name="phone" id="phone" onfocus="phoneFocus();" onBlur="phoneBlur();" /></td><td id="phoneId">&nbsp;</td>  		
    	</tr>
    	<tr height="45px">
    		<td><input type="file" name="photo" onchange="PreviewImage(this,'imgHeadPhoto','divPreview');" /></td>
    		<td>姓名：</td>
    		<td><input type="text" name="userName" id="userName" onfocus="userNameFocus();" onblur="userNameBlur();" /></td><td id="userNameId">&nbsp;</td>
    		<td>家庭住址：</td>
    		<td><select name="provinces" id="provinces" onchange="getCitys(this);"></select></td>
    		<td><select name="citys" id="citys"></select></td>
    	</tr>
    	<tr height="45px">  		
    		<td id="photoExist">&nbsp;</td>
    		<td>性别：</td>
    		<td>男<input type="radio" name="sex" id="sex" value="男" checked="checked" />&nbsp;&nbsp;&nbsp;女<input type="radio" name="sex" id="sex" value="女" /></td><td id="sexId">&nbsp;</td>
    		<td>科室：</td>
    		<td><select name="offices" id="offices" disabled="disabled" ></select></td><td>&nbsp;</td>
    	</tr>
    	<tr height="45px">
    		<td>&nbsp;</td>
    		<td>角色：</td>
    		<td><select name="role" id="role" onchange="getChange(this);"><option>管理员</option><option>挂号</option><option>医生</option><option>药房管理</option></select></td><td>&nbsp;</td>
    		<td>&nbsp;</td>
    		<td>&nbsp;</td><td>&nbsp;</td>
    	</tr>
    	<tr height="45px">
    		<td>&nbsp;</td>
    		<td>&nbsp;</td>
    		<td><input type="submit" value="确认添加"></td>
    		<td id="add">&nbsp;</td><td>&nbsp;</td>
    		<td><input type="reset" value="重置"></td>
    		<td>&nbsp;</td>
    	</tr>
    </table>
    <center>
  	
    </form>
  </body>
</html>

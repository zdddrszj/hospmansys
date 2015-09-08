<%@ page language="java" import="java.util.*,cn.com.shxt.model.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'officeSearch.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=path %>/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=path %>/js/pageList.js"></script>
	<style type="text/css">
		.td1 { text-align:center; border-color:#0000FF;}
		tr { height: 40px;}
	</style>	
	<script type="text/javascript">
		var flag ;
		var xmlhttp;
		function createXMLHttpRequest(){
			if(window.XMLHttpRequest){
				xmlhttp = new XMLHttpRequest();
			}else if(window.ActiveXObject){
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");	
			}
			return xmlhttp;
		}
		function officeValidate(){
		/*1.创建XMLHttpRequest对象*/
			xmlhttp = createXMLHttpRequest();			
			/*2.注册Ajax回调方法*/
			xmlhttp.onreadystatechange = callback;		
			//post方式
			//3.设置和服务器端交互的参数
			var officeName = document.getElementById("officeName").value;			
			xmlhttp.open("post","servlet/OfficeValidateServlet",false);
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");			
			//4.设置向服务器端发送的数据，启动和服务器端的交互
			xmlhttp.send("officeName="+officeName);
		}
		function callback(){
			if(xmlhttp.readyState == 4){ //服务器端处理结束，返回给页面
				if(xmlhttp.status == 200){
					var message = xmlhttp.responseText;
					if(message == "1"){
						//document.getElementById("officeName").innerHTML="<font color='red'>该科室已存在</font>";
						flag=false;
					}else if(message == "2"){
						//document.getElementById("input").innerHTML="<font color='green'>科室可用</font>";
						flag=true;
					}
				}
			}
		}
		function getSelect(){
			var obj = document.getElementById("allChoice");
			var obj_1 = document.getElementsByName("officeChoice");
			for(var i = 0 ; i < obj_1.length ; i ++){
				obj_1[i].checked=obj.checked;
			}
		}
		
		function isDelete(){
			var ids = "";
			var obj = document.getElementsByName("officeChoice")
			for(var i = 0 ; i < obj.length ; i ++){
				if(obj[i].checked){
					ids += obj[i].value+",";
				}
			}
			for(var i = 0 ; i < obj.length ; i ++){
				if(obj[i].checked){
					var flag = window.confirm("确定删除吗？");
					if(flag){
						location.href="servlet/OfficeDeleteServlet?ids="+ids;
						return;
					}
				}else{
					continue;
				}
			}
			window.confirm("请选择删除项!");
		} 
		// 修改
		$(function(){
			var officeId;
			$("#div1").hide();
			$(".modify").click(function(){
				$("#div1").show();
				officeId = $(this).attr("id");
			});
			$("#officeName").focus(function(){
				$("#officeName").attr("value","");
			});
			$(":button").click(function(){
				var o_name = $("#officeName").attr("value");
				if(o_name==""||o_name==null){
					$("#officeName").attr("value","请填写");
				}else {
					officeValidate();
					if(flag==true){
						
						location.href="servlet/OfficeModifyServlet?o_name="+o_name+"&o_id="+officeId;
					}else if(flag==false){
						$("#officeName").attr("value",o_name+"/已存在");
					}
				}
			});
		});	
	</script>

	<%
		PageBean pageBean = (PageBean)request.getAttribute("pageBean");
	%>
  </head>
  <body>
  	<center>
		<form id="fm" action="servlet/OfficeSearchServlet" method="post">
			<table width="100%" border="1px" cellspacing="0">
				<caption><font color="blue" size="5px"><b>科室列表</b></font></caption>
				<tr>
					<th>科室名称</th>
					<th>全选<input type="checkbox" id="allChoice" onclick="getSelect();" /></th>
		    		<th>是否修改</th>
		    	</tr>
		    	<%
		    	for (Map<String,Object> map: pageBean.getPageList()) {
		    			if(Integer.parseInt(map.get("O_ID").toString())==1){continue;}
				%>
				<tr>
		    		<td class="td1"><%=map.get("O_NAME") %></td>
		    		<td class="td1"><input type="checkbox" name="officeChoice" value="<%=map.get("O_ID") %>" /></td>
		    		<td class="td1"><a class="modify" id="<%=map.get("O_ID") %>" href="javascript:void(0)" >修改</a></td>
		    	</tr>
				<%
		    		}
				%>
			</table>
			<br /><br /> <br /> 
				当前是第<%=pageBean.getCurrentPage() %>/<%=pageBean.getTotalPage() %>页&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="isDelete();" >删除</a>&nbsp;&nbsp;&nbsp;&nbsp;
			     <a id="firstPage" href="javascript:void(0)">首&nbsp;&nbsp;页</a>&nbsp;&nbsp;&nbsp;&nbsp;
			     <a id="prevPage" href="javascript:void(0)">上一页</a>&nbsp;&nbsp;&nbsp;&nbsp;
			     <a id="nextPage" href="javascript:void(0)">下一页</a>&nbsp;&nbsp;&nbsp;&nbsp;
			     <a id="lastPage" href="javascript:void(0)">尾&nbsp;&nbsp;页</a>&nbsp;&nbsp;<br />
			     <input type="hidden" name="currentPage" id="currentPage" value="<%=pageBean.getCurrentPage() %>" />
		   		 <input type="hidden" name="totalPage" id="totalPage" value="<%=pageBean.getTotalPage() %>" />
		   		 <br /><br />
				<div id="div1" style="background:blue;width:210;height:25">
					<input id="officeName" type="text" name="officeName" /><input class="button" type="button" value="修改" />
				</div>
	</form>
	</center>
  </body>
</html>
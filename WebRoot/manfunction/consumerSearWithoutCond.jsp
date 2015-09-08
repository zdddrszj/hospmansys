<%@ page language="java" import="java.util.*,cn.com.shxt.model.*,cn.com.shxt.service.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'consumerSearWithoutCond.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=path %>/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=path %>/js/validate.js"></script>	
	<script type="text/javascript">
		$(function(){
			//跳页
			$("#tiao").click(function (){
				if($("#tiaoValue").attr("value")==null||$("#tiaoValue").attr("value")==""){
					alert("请填写页面数!");
				}else if(!$("#tiaoValue").attr("value").validateSignlessIntegral()){
					alert("页面数为正整数!");
				}else if(parseInt($("#tiaoValue").attr("value"))>parseInt($("#totalPage").val())){
					alert("该页不存在!");
				}else{
					$("#currentPage").attr("value",parseInt($("#tiaoValue").attr("value")));
					$("#f").attr("value","yes");
					$("#fm").submit();//提交表单
				}
			});
			/*首页*/
			$("#firstPage").click(function(){
				if ($("#currentPage").attr("value") == 1) {
					alert("已经是第一页！！");
				} else {
					$("#currentPage").attr("value",1);
					$("#f").attr("value","yes");
					$("#fm").submit();//提交表单
				}
			});
			
			/*上一页*/
			$("#prevPage").click(function(){
				if ($("#currentPage").attr("value") == 1) {
					alert("已经是第一页！！");
				} else {
					$("#currentPage").attr("value",(Number)($("#currentPage").attr("value")) - 1);
					$("#f").attr("value","yes");
					$("#fm").submit();//提交表单
				}
			});
			
			/*下一页*/
			$("#nextPage").click(function(){
				
				if ($("#currentPage").attr("value") == $("#totalPage").attr("value")) {
					alert("已经是最后一页！！");
				} else {
					$("#currentPage").attr("value",(Number)($("#currentPage").attr("value")) + 1);
					$("#f").attr("value","yes");//页面跳转的时候flag默认是no，所以提交表单获取不到条件，所以修改flag的值
					$("#fm").submit();//提交表单
				}
			});
			
			/*尾页*/
			$("#lastPage").click(function(){
				if ($("#currentPage").attr("value") == $("#totalPage").attr("value")) {
					alert("已经是最后一页！！");
				} else {
					$("#currentPage").attr("value", $("#totalPage").attr("value"));
					$("#f").attr("value","yes");
					$("#fm").submit();//提交表单
				}
			});
			
			//全选事件
			/*$("#choice").click(function(){
				$("#consumerChoice :checkbox").attr("checked",$("#choice").attr("checked"));
			});*/
		
			//隐藏 无条件查询
			$("#b2").click(function(){
				$("div").hide(2000);
				$("#f").attr("value","no");
				$("#currentPage").attr("value","1");
				$("#fm").submit();
			});
			
			//选择不同条件事件
			$("#require").change(function(){
				$("#div2").contents().remove();//删除第div2的子元素
				if($("#require").attr("value")=="角色"){
					$("#div2").append("<select name='r1'><option>管理员</option><option>医生</option><option>挂号</option><option>药房管理</option></select>");
				}else if($("#require").attr("value")=="状态"){
					$("#div2").append("<select name='r'><option>正常</option><option>已删除</option></select>");
				}else {
					$("#div2").append("<input name='r2' type='text' />");
				}
				$("#div2").append("<input id='search' type='button' value='条件查询' onclick='search();' />");
			});
		});
		
		
	</script>
	<script type="text/javascript">
		//条件查询
		function search(){
				$("#currentPage").attr("value",1);
				if($("#div2").children().attr("value")!=""&&$("#div2").children().attr("value")!=null){
						$("#f").attr("value","yes");
						//alert($("#f").attr("value"));
						$("#fm").submit();
				}
		}
		function search_1(){
			search();
		}
		function getSelect(){
			var obj = document.getElementById("choice");
			var obj_1 = document.getElementsByName("consumerChoice");
			for(var i = 0 ; i < obj_1.length ; i ++){
				obj_1[i].checked=obj.checked;
			}
		}
		function isDelete(){
			var ids = "";
			var obj = document.getElementsByName("consumerChoice")
			for(var i = 0 ; i < obj.length ; i ++){
				if(obj[i].checked){
					ids += obj[i].value+",";
				}
			}
			for(var i = 0 ; i < obj.length ; i ++){
				if(obj[i].checked){
					var flag = window.confirm("确定删除吗？");
					if(flag){
						location.href="servlet/ConsumerDeleteServlet?ids="+ids;
						return;
					}
				}else{
					continue;
				}
			}
			window.confirm("请选择删除项!");
		} 
	</script>
	<style type="text/css">
		.td1 { text-align:center; border-color:#0000FF;}
		tr { height: 60px;}
	</style>
	<%
		String req = "";
		String reqValue = ""; 
		String tiaoValue = "";
  		PageBean pageBean = (PageBean)request.getAttribute("pageBean");
		if(request.getAttribute("req")!=null){
			req = request.getAttribute("req").toString();
		}
		if(request.getAttribute("requireValue")!=null){
			reqValue = request.getAttribute("requireValue").toString();
		}
		if(request.getAttribute("tiaoValue")!=null){
			tiaoValue = request.getAttribute("tiaoValue").toString();
		}
  	%>

  </head>
  
  <body>
  <center>
    <form id="fm" action="servlet/ConsumerSearchServlet" method="post">
    	<div id="div1" style="float:left;width:100;height:50">
    		<select id="require" name="require" >
    			<option value=""></option>
   				<option value="账号" <%if(req.equals("账号")){%> selected="selected" <%} %>>账号</option>
   				<option value="身份证" <%if(req.equals("身份证")){%> selected="selected" <%} %>>身份证</option>
   				<option value="角色" <%if(req.equals("角色")){%> selected="selected" <%} %>>角色</option>
   				<option value="状态" <%if(req.equals("状态")){%> selected="selected" <%} %>>状态</option>
  		 	</select>
		</div>
    	<div id="div2" style="float:left;width:160;height:50">
    	<%
    		if(req.equals("账号")||req.equals("身份证")){
    			%>
    			<input name="r2" type="text" value=<%=reqValue %> />
    			<input id="search" type="button" value="条件查询" onclick="search_1();" />
    			<%
    		}else if(req.equals("角色")){
    			%>
    				<select name="r1">
    					<option <%if(reqValue.equals("管理员")){%> selected="selected" <%} %>>管理员</option>
    					<option <%if(reqValue.equals("医生")){%> selected="selected" <%} %>>医生</option>
    					<option <%if(reqValue.equals("挂号")){%> selected="selected" <%} %>>挂号</option>
    					<option <%if(reqValue.equals("药房管理")){%> selected="selected" <%} %>>药房管理</option>
    				</select>
    				<input id="search" type="button" value="条件查询" onclick="search_1();" />
    			<%
    		}else if(req.equals("状态")){
    			%>
    				<select name='r'>
    					<option <%if(reqValue.equals("正常")){%> selected="selected" <%} %>>正常</option>
    					<option <%if(reqValue.equals("已删除")){%> selected="selected" <%} %>>已删除</option>
    				</select>
    				<input id="search" type="button" value="条件查询" onclick="search_1();" />
    			<%
    		}
    	%>
    	</div><br />
   		
   		<input id="f" type="hidden" name="f" value="no" /><br />
    	<table border="2px" cellspacing="0px" width="100%">
    		<caption><font size="5px" color="blue"><b>用户信息列表</b></font></caption>
    		<tr>
	    		<th>用户账号</th>
	    		<th>用户密码</th>
	    		<th>真实姓名</th>
	    		<th>性别</th>
	    		<th>照片</th>
	    		<th>身份证</th>
	    		<th>邮箱</th>
	    		<th>电话</th>
	    		<th>所在省</th>
	    		<th>所在市</th>
	    		<th>权限</th>
	    		<th>科室</th>
	    		<th>全选<input type="checkbox" id="choice" onclick="getSelect();" /></th>
	    		<th>修改</th>
	    	</tr>
    		
    		<%
    			String name="";
    			for (Map<String,Object> map: pageBean.getPageList()) {
    				ConsumerService consumerService=new ConsumerService();
    				if(map.get("C_ROLE").toString().equals("医生")){
	    				name = consumerService.getName(Integer.parseInt(map.get("C_PROVINCE").toString()),Integer.parseInt(map.get("C_CITY").toString()),Integer.parseInt(map.get("C_O_ID").toString()));
    				} else {
    					name = consumerService.getName(Integer.parseInt(map.get("C_PROVINCE").toString()),Integer.parseInt(map.get("C_CITY").toString()),0);
    				}
    		%>
    				<tr>
    					<td class="td1"><%=map.get("C_ACCOUNT") %></td>
    					<td class="td1"><%=map.get("C_PSW") %></td>
		    			<td class="td1"><%=map.get("C_NAME") %></td>
		    			<td class="td1"><%=map.get("C_SEX") %></td>
		    			<td class="td1"><img src="<%=path %>/upload/<%=map.get("C_PHOTO").toString() %>" width="50px" height="50px" /></td>		   
		    			<td class="td1"><%=map.get("C_IDENTITY") %></td>
		    			<td class="td1"><%=map.get("C_MAIL") %></td>
		    			<td class="td1"><%=map.get("C_PHONE") %></td>
		    			<td class="td1"><%=name.split(",")[0] %></td>
		    			<td class="td1"><%=name.split(",")[1] %></td>
		    			<td class="td1"><%=map.get("C_ROLE") %></td>
		   				<td class="td1"><%=name.split(",")[2] %></td>
		   				<td class="td1"><input type="checkbox"  name="consumerChoice" value="<%=map.get("C_ID") %>" /></td>
		   				<td class="td1"><a style="text-decoration: none" href="servlet/ConsumerDetailServlet?consumerId=<%=map.get("C_ID") %>" >修改</a></td>
    				</tr>		
    		<% 
    			}
    		%>
    	</table><br /><br /><br />
    	<a id="delete" href="javascript:void(0)" onclick="isDelete();" >删除</a>&nbsp;&nbsp;&nbsp;&nbsp;
    	当前是第<%=pageBean.getCurrentPage() %>/<%=pageBean.getTotalPage() %>页&nbsp;&nbsp;&nbsp;&nbsp;
    	跳到第<input type="text" id="tiaoValue" name="tiaoValue" size="6px">页 &nbsp;&nbsp;
    	<input id="tiao" type="button" value="跳转" value="<%=tiaoValue %>"/>&nbsp;&nbsp;&nbsp;&nbsp;
	     <a id="firstPage" href="javascript:void(0)">首&nbsp;&nbsp;页</a>&nbsp;&nbsp;&nbsp;&nbsp;
	     <a id="prevPage" href="javascript:void(0)">上一页</a>&nbsp;&nbsp;&nbsp;&nbsp;
	     <a id="nextPage" href="javascript:void(0)">下一页</a>&nbsp;&nbsp;&nbsp;&nbsp;
	     <a id="lastPage" href="javascript:void(0)">尾&nbsp;&nbsp;页</a>&nbsp;&nbsp;&nbsp;&nbsp;
	     <input id="b2" type="button" value="无条件查询" />
	     <input type="hidden" name="currentPage" id="currentPage" value="<%=pageBean.getCurrentPage() %>" />
	     <input type="hidden" name="totalPage" id="totalPage" value="<%=pageBean.getTotalPage() %>" />
	     
    </form>
    </center>
  </body>
</html>

<%@ page language="java" import="java.util.*,cn.com.shxt.service.*,cn.com.shxt.model.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'factorySearch.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=path %>/js/jquery-1.7.2.min.js"></script>
	<style type="text/css">
		.td1 { text-align:center; border-color:#0000FF;}
		tr { height: 40px;}
	</style>
	<script type="text/javascript">
		$(function(){
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
		});
		//删除选择
		function getSelect(){
			var obj = document.getElementById("allChoice");
			var obj_1 = document.getElementsByName("factoryChoice");
			for(var i = 0 ; i < obj_1.length ; i ++){
				obj_1[i].checked=obj.checked;
			}
		}
		//删除
		function isDelete(){
			var ids = "";
			var obj = document.getElementsByName("factoryChoice")
			for(var i = 0 ; i < obj.length ; i ++){
				if(obj[i].checked){
					ids += obj[i].value+",";
				}
			}
			for(var i = 0 ; i < obj.length ; i ++){
				if(obj[i].checked){
					var flag = window.confirm("确定删除吗？");
					if(flag){
						location.href="servlet/FactoryDeleteServlet?ids="+ids;
						return;
					}
				}else{
					continue;
				}
			}
			window.confirm("请选择删除项!");
		} 
		//模态修改
		function showDetail(facId){
			//alert(facId);
			var result = window.showModalDialog("servlet/FactoryDetailServlet?facId="+facId,"","dialogWidth:620px;dialogHeight:150px;dialogLeft:400px;dialogTop:200px");
			if(result > 0){
				$("#fm").submit();
			}
		}
	</script>
 </head>
  <%
  	PageBean pageBean = (PageBean)request.getAttribute("pageBean");
  %>
  
  <body>
   <center>
   		<form id="fm" action="servlet/FactorySearchServlet" method="post">
   			<table width="100%" border="1px" cellspacing="0">
   				<caption><font size="5px" color="blue"><b>药厂信息详情</b></font></caption>
   				<tr>
   					<th width="300px">药厂名称</th>
   					<th>所在省</th>
   					<th>所在市</th>
   					<th>全选<input type="checkbox" id="allChoice" onclick="getSelect();" /></th>
   					<th>修改</th>
   				</tr>
   				<%
   					for (Map<String,Object> map: pageBean.getPageList()) {
   						String addrName = new FactoryService().getAddrName(map.get("F_PROVINCE").toString(),map.get("F_CITY").toString());
   						%>
   							<tr>
   								<td class="td1"><%=map.get("F_NAME") %></td>
   								<TD class="td1"><%=addrName.split(",")[0] %></TD>
   								<td class="td1"><%=addrName.split(",")[1] %></td>
   								<td class="td1"><input type="checkbox" name="factoryChoice" value="<%=map.get("F_ID") %>" /></td>
   								<td class="td1"><a style="text-decoration: none" onclick="showDetail(<%=map.get("F_ID") %>)">修改</a></td>
   							</tr>
   						<%
   					}
   				%>
   			</table>
   			<br /><br /><br />
   			当前是第<%=pageBean.getCurrentPage() %>/<%=pageBean.getTotalPage() %>页&nbsp;&nbsp;&nbsp;&nbsp;
   			<a id="delete" href="javascript:void(0)" onclick="isDelete();" >删除</a>&nbsp;&nbsp;&nbsp;&nbsp;
	    	 <a id="firstPage" href="javascript:void(0)">首&nbsp;&nbsp;页</a>&nbsp;&nbsp;&nbsp;&nbsp;
	    	 <a id="prevPage" href="javascript:void(0)">上一页</a>&nbsp;&nbsp;&nbsp;&nbsp;
	    	 <a id="nextPage" href="javascript:void(0)">下一页</a>&nbsp;&nbsp;&nbsp;&nbsp;
	   		 <a id="lastPage" href="javascript:void(0)">尾&nbsp;&nbsp;页</a>&nbsp;&nbsp;
	   		 <input type="hidden" name="currentPage" id="currentPage" value="<%=pageBean.getCurrentPage() %>" />
	   		 <input type="hidden" name="totalPage" id="totalPage" value="<%=pageBean.getTotalPage() %>" />
   		</form>
   	</center>
  </body>
</html>

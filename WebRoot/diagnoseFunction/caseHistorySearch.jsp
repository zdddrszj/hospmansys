<%@ page language="java" import="java.util.*,cn.com.shxt.model.*,cn.com.shxt.service.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'caseHistorySearch.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=path %>/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=path %>/js/pageList.js"></script>
	<style type="text/css">
		.td1 { text-align:center; border-color:#0000FF;}
		tr { height: 60px;}
	</style>
	<script type="text/javascript">
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
			var obj = document.getElementsByName("caseHisChoice")
			for(var i = 0 ; i < obj.length ; i ++){
				if(obj[i].checked){
					ids += obj[i].value+",";
				}
			}
			for(var i = 0 ; i < obj.length ; i ++){
				if(obj[i].checked){
					var flag = window.confirm("确定删除吗？");
					if(flag){
						location.href="servlet/CaseHistoryDeleteServlet?ids="+ids;
						return;
					}
				}else{
					continue;
				}
			}
			window.confirm("请选择删除项!");
		} 
		//模态修改
		function showDetail(caseId){
			//alert(facId);
			var result = window.showModalDialog("servlet/CaseHistoryDetailServlet?caseId="+caseId,"","dialogWidth:620px;dialogHeight:150px;dialogLeft:400px;dialogTop:200px");
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
    	<form id="fm" action="servlet/CaseHistorySearchServlet" method="post">
    		<table border="1" cellspacing="0" width="100%">
    			<caption><font size="5px" color="blue"><b>案例信息</b></font></caption>
    			<tr>
    				<th>病历号</th>
    				<th>姓名</th>
    				<th>性别</th>
    				<th>照片</th>
    				<th>年龄</th>
    				<th>电话</th>
    				<th>所在省</th>
    				<th>所在市</th>
    				<th>注册日期</th>
    				<TH>全选<input type="checkbox" id="allChoice" onclick="getSelect();" /></TH>
    				<th>查看诊断</th>
    				<th>修改</th>
    			</tr>
    			<%
   					for (Map<String,Object> map: pageBean.getPageList()) {
   						String addrName = new CaseHistoryService().getAddrName(map.get("C_H_PROVINCE").toString(),map.get("C_H_CITY").toString());
   						%>
   							<tr>
   								<td class="td1"><%=map.get("C_H_DATE") %>/<%=map.get("C_H_ID") %></td>
   								<td class="td1"><%=map.get("C_H_NAME") %></td>
   								<td class="td1"><%=map.get("C_H_SEX") %></td>
   								<td class="td1"><img src="<%=path %>/upload/<%=map.get("C_H_PHOTO").toString() %>" width="50px" height="50px" /></td>
   								<td class="td1"><%=map.get("C_H_AGE") %></td>
   								<td class="td1"><%=map.get("C_H_PHONE") %></td>
   								<td class="td1"><%=addrName.split(",")[0] %></td>
   								<TD class="td1"><%=addrName.split(",")[1] %></TD>
   								<td class="td1"><%=map.get("C_H_DATE") %></td>
   								<td class="td1"><input type="checkbox" name="caseHisChoice" value="<%=map.get("C_H_ID") %>" /></td>
   								<td class="td1"><a style="text-decoration: none" onclick="showDetail(<%=map.get("C_H_ID") %>)">查看</a></td>
   								<td class="td1"><a style="text-decoration: none" href="servlet/CaseHistoryDetailServlet?caseId=<%=map.get("C_H_ID") %>" >修改</a></td>
   							</tr>
   						<%
   					}
   				%>
   			</table>
   			<br /><br /><br />
   			当前是第<%=pageBean.getCurrentPage() %>/<%=pageBean.getTotalPage() %>页&nbsp;&nbsp;&nbsp;&nbsp;
   			<a id="delete" href="javascript:void(0)" onclick="isDelete();" >注销</a>&nbsp;&nbsp;&nbsp;&nbsp;
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

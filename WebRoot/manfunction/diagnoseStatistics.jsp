<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'diagnoseStatistics.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=path %>/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=path %>/js/validate.js"></script>
	<script type="text/javascript" src="<%=path %>/js/pageList.js"></script>
	<script type="text/javascript" src="<%=path %>/js/My97DatePicker/WdatePicker.js"></script>
	
	<script type="text/javascript">
		$(function (){
			
			$("#a").click(function (){
				if($("#startDate").attr("value")>$("#endDate").attr("value")){
					alert("请检查时间！");
				}else{
					location.href="servlet/StatisticsOfDiagCountServlet?startDate="+$("#startDate").val()+"&endDate="+$("#endDate").val();
				}
			});
			
			$("#b").click(function (){
				if($("#startDate").attr("value")>$("#endDate").attr("value")){
					alert("请检查时间！");
				}else{
					location.href="servlet/StatisticsOfDiagCostServlet?startDate="+$("#startDate").val()+"&endDate="+$("#endDate").val();
				}
			});
		});
	</script>
	<style type="text/css">
		td { text-align:center; border-color:#0000FF;}
		tr { height: 60px;}
	</style>
	<script type="text/javascript">
		function over(){
			document.getElementById("a").style.color="#ff0000";
		}
		function over1(){
			document.getElementById("b").style.color="#ff0000";
		}
		function out(){
			document.getElementById("a").style.color="blue";
		}
		function out1(){
			document.getElementById("b").style.color="blue";
		}
	</script>
  </head>
  <%
 	String startDate = (String)request.getAttribute("startDate");
	String endDate = (String)request.getAttribute("endDate");
	if(startDate == null) {
		startDate = "";
	}
	if(endDate == null){
		endDate = "";
	}
  %>
  <body>
  	<center>
  		<table width="80%" >
   				<caption><font size="5px" color="blue"><b>科室诊断情况</b></font></caption>
   				<tr>
   					<td width="450px">起始日期：<input value="<%=startDate %>" id="startDate" name="startDate" class="Wdate" type="text" onclick="WdatePicker()"></td>
   					<td width="450px">截止日期：<input value="<%=endDate %>" id="endDate" name="endDate"  class="Wdate" type="text" onclick="WdatePicker()"></td>
   				</tr>
   		</table>
   		<br /><br /><br />
  	 <a href="javascript:void(0)" style="text-decoration: none" onmouseover="over();" onmouseout="out();"><font id="a" color="blue" size="5px"><b>诊断数量柱状图查看</b></font></a><br/><br />
   	 <a href="javascript:void(0)" style="text-decoration: none" onmouseover="over1();" onmouseout="out1();"><font id="b" color="blue" size="5px"><b>收费总额柱状图查看</b></font></a><br/>
 	</center>
  </body>
</html>

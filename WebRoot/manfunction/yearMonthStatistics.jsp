<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'yearMonthStatistics.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=path %>/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript">
		$(function (){
			$("#a").click(function (){
				//alert($("#year").val());
				location.href="servlet/StatisticsOfYearMonthServlet?year="+$("#year").val();
			});
		});
		function over(){
			document.getElementById("a").style.color="#ff0000";
		}
		function out(){
			document.getElementById("a").style.color="blue";
		}
	</script>
	<style type="text/css">
		td { text-align:center; border-color:#0000FF;}
		tr { height: 60px;}
	</style>

  </head>
  <%
 	
  %>
  <body>
    <center>
    <br /><br />
  		<table width="80%" >
   				<caption><font size="5px" color="blue"><b>按年份查看月份收入情况</b></font></caption>
   				<tr>
   					<td width="450px">请选择年份：
   						<select id="year">
   							<option value="2010">2010</option>
   							<option value="2011">2011</option>
   							<option value="2012">2012</option>
   							<option selected="selected" value="2013">2013</option>
   							<option value="2014">2014</option>
   							<option value="2015">2015</option>
   							<option value="2016">2016</option>
   							<option value="2017">2017</option>
   							<option value="2018">2018</option>
   							<option value="2019">2019</option>
   							<option value="2020">2020</option>
   						</select>
   						&nbsp;年
   					</td>
   				</tr>
   				<tr>
   					<td>
   					<a href="javascript:void(0)" style="text-decoration: none" onmouseover="over();" onmouseout="out();"><font id="a" color="blue" size="5px"><b>收入饼状图查看</b></font></a>
 					</td>
 				</tr>
   		</table>
   		<br /><br /><br />
  	 </center>
  </body>
</html>

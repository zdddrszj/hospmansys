<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'queueOfOffice.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
		<script type="text/javascript" src="<%=path %>/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=path %>/js/validate.js"></script>
	<script type="text/javascript" src="<%=path %>/js/My97DatePicker/WdatePicker.js"></script>
	<style type="text/css">
		td { text-align:center; border-color:#0000FF;}
		tr { height: 40px;}
	</style>
	
	<script type="text/javascript">
		$(function(){
			
			//科室
			$.ajax({
					type:"post",
					async:false,//同步，这样才能得到科室的第一个子元素
					url:"servlet/GetOfficesServlet",
					success:function(xml){
						$(xml).find("office").each(function(){
							if($(this).children("o_id").text()!=1){
								$("#offices").append("<option value="+$(this).children("o_id").text()+">"+$(this).children("o_name").text()+"</option>");
							}
						});
					},
					dataType:"xml"
			});
			$.ajax({
						type:"post",
						url:"servlet/GetDoctorServlet?officeId="+$("#offices > option").val(),
						success:function(xml){
							$("#tab").children().remove();
							$("#tab").append("<caption><font color='blue' size='5px'>科室挂号人数细览</font></caption>");
							
							$("#tab").append("<tr><th>医生</th><th>挂号人数</th></tr>");
							$(xml).find("doctor").each(function(){
								if($(this).children("o_id").text()!=1){
									$("#tab").append("<tr><td>"+$(this).children("c_name").text()+"</td><td>"+$(this).children("c_count").text()+"</td></tr>");
								}
							});
						},
						dataType:"xml"
			});
			//科室的onchange事件
			$("#offices").change(function (){
					$.ajax({
						type:"post",
						url:"servlet/GetDoctorServlet?officeId="+$(this).val(),
						success:function(xml){
							$("#tab").children().remove();
							$("#tab").append("<caption><font color='blue' size='5px'>科室挂号人数细览</font></caption>");
							$("#tab").append("<tr><th>医生</th><th>挂号人数</th></tr>");
							$(xml).find("doctor").each(function(){
								if($(this).children("o_id").text()!=1){
									$("#tab").append("<tr><td>"+$(this).children("c_name").text()+"</td><td>"+$(this).children("c_count").text()+"</td></tr>");
								}
							});
						},
						dataType:"xml"
					});
			});
		});
	</script>

  </head>
  
  <body>
    <center>
		<form action="servlet/RegisterCountSearchServlet" method="post">
			<select id="offices" name="offices"></select>
			<table width="80%" border="1px" cellspacing="0" id="tab">
				
			</table>
		</form>
    </center>
  </body>
</html>

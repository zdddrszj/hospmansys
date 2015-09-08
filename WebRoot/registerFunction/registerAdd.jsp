<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'registerAdd.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=path %>/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=path %>/js/validate.js"></script>
	<script type="text/javascript" src="<%=path %>/js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="<%=path %>/js/jquery.artDialog.js?skin=default"></script>
	<script type="text/javascript">
		
		$(function(){
			function a(){
				if($("#h").attr("value")=="true"){
					alert("挂号成功!");
				}
			}
			a();
			//病历号加载
			$.ajax({
					type:"post",
					//async:false,//同步，这样才能得到科室的第一个子元素
					url:"servlet/GetCaseIdsServlet",
					success:function(xml){
						$(xml).find("case").each(function(){
							$("#caseId").append("<option value="+$(this).children("ch_id").text()+">"+$(this).children("case_id").text()+"</option>");
						});
					},
					dataType:"xml"
			});
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
			//医生
			$.ajax({
					type:"post",
					url:"servlet/GetDoctorsServlet?officeId="+$("#offices > option").val()+"&date="+$("#regDate").val(),
					success:function(xml){
						$(xml).find("doctor").each(function(){
							if($(this).children("o_id").text()!=1){
								$("#doctors").append("<option value="+$(this).children("c_id").text()+">"+$(this).children("c_name").text()+"/"+$(this).children("c_count").text()+"</option>");
							}
						});
					},
					dataType:"xml"
			});
			//科室的onchange事件
			$("#offices").change(function (){
					$("#doctors").children().remove();
					$.ajax({
						type:"post",
						url:"servlet/GetDoctorsServlet?officeId="+$(this).val()+"&date="+$("#regDate").val(),
						success:function(xml){
							$(xml).find("doctor").each(function(){
								if($(this).children("o_id").text()!=1){
									$("#doctors").append("<option value="+$(this).children("c_id").text()+">"+$(this).children("c_name").text()+"/"+$(this).children("c_count").text()+"</option>");
								}
							});
						},
						dataType:"xml"
					});
			});
			//时间change
			$("#regDate").focus(function (){
				//alert($("#regDate").val());
					$("#doctors").children().remove();
					$.ajax({
						type:"post",
						url:"servlet/GetDoctorsServlet?date="+$(this).val()+"&officeId="+$("#offices").val(),
						success:function(xml){
							$(xml).find("doctor").each(function(){
								if($(this).children("o_id").text()!=1){
									$("#doctors").append("<option value="+$(this).children("c_id").text()+">"+$(this).children("c_name").text()+"/"+$(this).children("c_count").text()+"</option>");
								}
							});
						},
						dataType:"xml"
					});
			});
			//医保 普通 挂号费
			$("#type").change(function (){
					if($("#type").attr("value")=="普通"){
						$("#regMoney").attr("value","￥5元");
					}
					if($("#type").attr("value")=="医保"){
						$("#regMoney").attr("value","￥2元");
					}
			});
			//提交判断
			$("#sub").click(function (){
				
				if($("#doctors").children().size()==0){
					$("#judge").html("<font color='red' size='4px'>不能挂号！</font>");
				}else if($("#regDate").attr("value")==null || $("#regDate").attr("value")==""){
					$("#judge").html("<font color='red' size='4px'>请填写时间！</font>");
				}else if($("#dealer").attr("value")=="null"||$("#user").attr("value")==""){
					window.alert("您已经离线，请重新登录！");
					return;
				}else {
					$("#judge").html("");
					$("#fm").submit();
				}
				
			});
		});
	</script>
	<style type="text/css">
		
		tr { height: 60px;}
	</style>
  </head>
  
  <body>
    <center>
			<form id="fm" action="servlet/RegisterAddServlet" method="post">
              <table>
            	<caption><font color="#0000FF" size="5px">挂号信息填写</font></caption>
            	<tr>
                	<td width="200px">病&nbsp;历&nbsp;号：</td>
                    <td width="200px"><select id="caseId" name="caseId"><option value=""></option></select></td>
                </tr>
                <tr>
                	<td width="200px">科&nbsp;&nbsp;&nbsp;&nbsp;室：</td>
                    <td width="200px"><select id="offices" name="offices"></select></td>
                </tr>
                <tr>
                	<td>类&nbsp;&nbsp;&nbsp;&nbsp;型：</td>
                    <td><select id="type" name="type">
                    		<option value="普通">普通</option>
                            <option value="医保">医保</option>
                    	</select>
                    </td>
                </tr>
                <tr>
                	<td>挂号时间：</td>
                    <td><input value=<%=new Date().toLocaleString().split(" ")[0] %> class="Wdate" id="regDate" name="regDate" type="text" onfocus="WdatePicker({minDate:'%y-%M-{%d}',maxDate:'%y-%M-{%d+2}'})"/></td>
                </tr>
                <tr>
                	<td>诊断医生:</td>
                    <td><select id="doctors" name="doctors"></select></td>
                </tr>
                <tr>
                	<td>挂&nbsp;号&nbsp;费：</td>
                    <td><input id="regMoney" name="regMoney" value="￥5元" readonly="readonly" />
                    </td>
                </tr>
                <tr>
                	<td id="judge">&nbsp;</td>
                    <td><input id="sub" type="button" value="提交" /></td>
                </tr>
               </table>
               <input type="hidden" id="dealer" name="dealer" value=<%=request.getSession().getAttribute("user") %> />
            </form>
		<center>
		<input type="hidden" id="h" value="<%=request.getAttribute("flag") %>" />
  </body>
</html>

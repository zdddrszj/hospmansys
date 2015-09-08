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
	<script type="text/javascript" src="<%=path %>/js/upload.js"></script>
	<script type="text/javascript" src="<%=path %>/js/validate.js"></script>
	<script type="text/javascript" src="<%=path %>/js/jquery-1.7.2.min.js"></script>
	<style type="text/css">
			td { text-align:center; border-color:#0000FF;}
			tr { height:60px;}
	</style>
	<script type="text/javascript">
		$(function(){
				//省 
				$.ajax({
						type:"post",
						async:false,//同步，这样才能得到省的第一个子元素
						url:"servlet/GetProvincesServlet",
						success:function(xml){
							$(xml).find("province").each(function(){
								//alert($(this).children("t_k_id").text());
								//alert($(this).children("t_k_name").text())
								$("#provinces").append("<option value="+$(this).children("p_id").text()+">"+$(this).children("p_name").text()+"</option>");
							});
						},
						dataType:"xml"
				});
				//加载第一个省份对应的市
				$.ajax({
						type:"post",
						url:"servlet/GetCitysServlet?proId="+$("#provinces > option").val(),
						success:function(xml){
							$(xml).find("city").each(function(){
								$("#citys").append("<option value="+$(this).children("c_id").text()+">"+$(this).children("c_name").text()+"</option>");
							});
						},
						dataType:"xml"
				});
				//省的onchange事件
				$("#provinces").change(function (){
					$("#citys").children().remove();
					$.ajax({
						type:"post",
						url:"servlet/GetCitysServlet?proId="+$(this).val(),
						success:function(xml){
							$(xml).find("city").each(function(){
								$("#citys").append("<option value="+$(this).children("c_id").text()+">"+$(this).children("c_name").text()+"</option>");
							});
						},
						dataType:"xml"
					});
				});
				
			//姓名 年龄 验证和电话号码验证
			$("#sub").click(function (){
				if($("#imgHeadPhoto").attr("src")==null||$("#imgHeadPhoto").attr("src")==""){
					$("#imgId").html("<font color='red' size='3px'>&otimes;请选择照片！</font>");
				}else if($("#name").attr("value")==null||$("#name").attr("value")==""){
					$("#imgId").html("");
					$("#nameId").html("<font color='red' size='3px'>&otimes;姓名不能为空！</font>");
				}else if($("#age").attr("value")==null||$("#age").attr("value")==""){
					$("#imgId").html("");
					$("#ageId").html("<font color='red' size='3px'>&otimes;年龄不能为空！</font>");
				}else if($("#age").attr("value")<=0||$("#age").attr("value")>=150){
					$("#imgId").html("");
					$("#ageId").html("<font color='red' size='3px'>&otimes;请检查年龄信息！</font>");
				}else if($("#phone").attr("value")==null||$("#phone").attr("value")==""){
					$("#imgId").html("");
					$("#phoneId").html("<font color='red' size='3px'>&otimes;电话不能为空！</font>");
				}else if(!$("#phone").attr("value").isMobile()){
					$("#imgId").html("");
					$("#phoneId").html("<font color='red' size='3px'>&otimes;电话号码不正确！</font>");
				}else {
					$("#imgId").html("");
					$("#fm").submit();
				}
			});
			
			//鼠标聚焦事件
			$("#name").focus(function (){
				$("#nameId").html("");
			});
			$("#age").focus(function (){
				$("#ageId").html("");
			});
			$("#phone").focus(function (){
				$("#phoneId").html("");
			});
		});
	</script>
		
  </head>
  <%
  	String registerId = request.getParameter("registerId");
  
  %>
  <body>
    <center>
    		<form id="fm" action="servlet/CaseHistoryAddServlet" method="post" enctype="multipart/form-data">
            	<table  width="65%">
            		<caption><font color="blue" size="5px"><b>创建病例信息</b></font></caption>
            			<tr>
            				<td width="160px" rowspan="3">
            					<div id="divPreview">
		    						<img id="imgHeadPhoto" style="width: 120px; height: 130px;" alt="" />
		    					</div>
							</td>
            				<td width="170px">姓名：</td>
            				<td width="170px"><input type="text" name="name" id="name" /></td>
            				<td id="nameId">&nbsp;</td>            				
            			</tr>
            			<tr>
            				<td>性别：</td>
            				<td>男：<input type="radio" value="男" name="sex" checked="checked" />
            					女：<input type="radio" value="女" name="sex" />
            				</td>
            				<td>&nbsp;</td>            				
            			</tr>
            			<tr>
            				<td>年龄：</td>
            				<td><input type="text" id="age" name="age" /></td>
            				<td id="ageId">&nbsp;</td>            				
            			</tr>
            			<tr>
            				<td><input type="file" name="photo" onchange="PreviewImage(this,'imgHeadPhoto','divPreview');" /></td>
            				<td>电话：</td>
            				<td><input type="text" id="phone" name="phone" /></td>
            				<td id="phoneId">&nbsp;</td>            				
            			</tr>
            			<tr>
            				<td id="imgId">&nbsp;</td>
            				<td>住址：</td>
            				<td><select id="provinces" name="provinces"></select>
            					<select id="citys" name="citys"></select>
            				</td>
            				<td>&nbsp;</td>            				
            			</tr>
            			<tr>
            				<td>&nbsp;</td>
            				<td>&nbsp;</td>
            				<td><input id="sub" type="button" value="提交" /></td>
            				<td>&nbsp;</td>            				
            			</tr>
                </table>
                <input type="hidden" value=<%=registerId %> name="registerId" />
            </form>
    	</center>
  </body>
</html>

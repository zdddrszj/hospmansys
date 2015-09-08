<%@ page language="java" import="java.util.*,cn.com.shxt.service.*,cn.com.shxt.model.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'diagnoseAddSecond.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=path %>/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=path %>/js/validate.js"></script>
	<script type="text/javascript">
		$(function(){
			//药品种类
			$.ajax({
					type:"post",
					async:false,
					url:"servlet/GetTabKindsServlet",
					success:function(xml){
						$(xml).find("tab").each(function(){
							//alert($(this).children("t_k_id").text());
							//alert($(this).children("t_k_name").text())
							$("#tabletKind").append("<option value="+$(this).children("t_k_id").text()+">"+$(this).children("t_k_name").text()+"</option>");
						});
					},
					dataType:"xml"
			});
			//药品名称
			$.ajax({
					type:"post",
					async:false,
					url:"servlet/GetTabNameServlet?tabletKind="+$("#tabletKind").val(),
					success:function(xml){
						$(xml).find("tab").each(function(){
							$("#tabletName").append("<option value="+$(this).children("t_s_id").text()+">"+$(this).children("tab_name").text()+"</option>");
						});
					},
					dataType:"xml"
			});
			//根据药品种类Id动态加载出药品名称
			$("#tabletKind").change(function (){
				$("#tabletName").children().remove();
				$.ajax({
					type:"post",
					async:false,
					url:"servlet/GetTabNameServlet?tabletKind="+$("#tabletKind").val(),
					success:function(xml){
						$(xml).find("tab").each(function(){
							$("#tabletName").append("<option value="+$(this).children("t_s_id").text()+">"+$(this).children("tab_name").text()+"</option>");
						});
					},
					dataType:"xml"
				});
				$.ajax({
					type:"post",
					async:false,
					url:"servlet/GetTabStorePriceCountServlet?tabletStoreId="+$("#tabletName").val(),
					success:function(xml){
						$(xml).find("tab").each(function(){
							$("#tabletTotal").attr("value",$(this).children("t_s_count").text());
							$("#tabletUnit").attr("value",$(this).children("t_s_unit").text());
							$("#tabletPrice").attr("value",$(this).children("t_s_outprice").text());
						});
					},
					dataType:"xml"
				});
			});
			
			//根据药品名称 （挂号表里的id）动态加载出药品库存和售价
			$.ajax({
					type:"post",
					async:false,
					url:"servlet/GetTabStorePriceCountServlet?tabletStoreId="+$("#tabletName").val(),
					success:function(xml){
						$(xml).find("tab").each(function(){
							$("#tabletTotal").attr("value",$(this).children("t_s_count").text());
							$("#tabletUnit").attr("value",$(this).children("t_s_unit").text());
							$("#tabletPrice").attr("value",$(this).children("t_s_outprice").text());
						});
					},
					dataType:"xml"
			});
			
			//根据药品名称 动态加载药品 库存和售价
			$("#tabletName").change(function (){
				$.ajax({
					type:"post",
					async:false,
					url:"servlet/GetTabStorePriceCountServlet?tabletStoreId="+$("#tabletName").val(),
					success:function(xml){
						$(xml).find("tab").each(function(){
							$("#tabletTotal").attr("value",$(this).children("t_s_count").text());
							$("#tabletUnit").attr("value",$(this).children("t_s_unit").text());
							$("#tabletPrice").attr("value",$(this).children("t_s_outprice").text());
						});
					},
					dataType:"xml"
				});
			});
			//添加药品  添加价格
			$("#add").click(function (){
				//先判断购买量是否大于库存
				//alert(typeof $("#tabletCount").attr("value"));
				if($("#tabletCount").attr("value")==0){
					window.alert("请选择药品数量");
					return ;
				}else if(!$("#tabletCount").attr("value").validateSignlessIntegral()){
					window.alert("数量填写错误！");
					return ;
				}else if(parseInt($("#tabletCount").attr("value"))>parseInt($("#tabletTotal").attr("value"))){
					window.alert("库存不足");
					return ;
				}else{
					var price = $("#tabletPrice").val()*$("#tabletCount").val();
					$("#table").append("<tr><td align='center' name="+$("#tabletName").attr("value")+">"+$("#tabletName :selected").text()+"</td><td align='center'>"+$("#tabletCount").val()+"</td><td align='center'>"+parseInt(price*100)/100+"</td><td align='center'><a href='javascript:void(0)' onclick='deleteTab(this);'>删除</a></td></tr>");
					$("#tabletTotal").attr("value",$("#tabletTotal").attr("value")-$("#tabletCount").attr("value"));
				}
			});
		});
		function deleteTab(obj){
			//var table = document.getElementById("table");
			$(obj).parent().parent().remove();
			//table.removeChild(obj.parentNode.parentNode);
		}
	</script>
	<script type="text/javascript">
		$(function(){
			//确诊
			$("#diagnose").click(function (){
				if($("#description").attr("value")==null||$("#description").attr("value")==""){
					alert("病症描述字数不能少于2个字节！");
				}else if($("#result").attr("value")==null||$("#result").attr("value")==""){
					alert("诊断结果字数不能少于2个字节！");
				}else if($("#measure").attr("value")==null||$("#measure").attr("value")==""){
					alert("治疗方案字数不能少于2个字节！");
				}else if($("#otherItem").attr("value")==null||$("#otherItem").attr("value")==""){
					alert("其它项目字数不能少于2个字节！");
				}else if($("#otherCost").attr("value")==null||$("#otherCost").attr("value")==""){
					alert("没有其他费用请添0！");
				}else if(!($("#otherCost").attr("value")>=0)){
					alert("费用填写不合法！");
				}else{
					$("#table tr").each(function(index){
						if(index > 0){
						    //alert($(this).children("td").eq(0).text());
							//alert($(this).children("td").eq(1).text());
							//alert($(this).children("td").eq(2).text());
							var value = $("#hid").attr("value");
							$("#hid").attr("value",value+$(this).children("td").eq(0).attr("name")+"@"+$(this).children("td").eq(0).text()+"x"+$(this).children("td").eq(1).text()+"="+$(this).children("td").eq(2).text()+"#");
						}
					});
					
					$("#fm").submit();
				}
			});
		});
		
	</script>
	
	
	<style type="text/css">
		.td1 { text-align:center; border-color:#0000FF;}
		.tr1 { height: 40px;}
	</style>
  </head>
  <%
  	List<Map<String,Object>> list = (List<Map<String,Object>>)request.getAttribute("oneCaseHistory");
  	int registerId = Integer.parseInt(request.getAttribute("registerId").toString());//当前挂号id
  	//根据病例id查到地址
  	CaseHistoryService caseHistoryService = new CaseHistoryService();
  	String addr = caseHistoryService.getAddrName(list.get(0).get("C_H_PROVINCE").toString(),list.get(0).get("C_H_CITY").toString());
  	
  	//根据病例id查到所有过去诊断信息
  	RegisterService registerService = new RegisterService();
  	List<Map<String, Object>> list1 = registerService.getAllPastInfo(Integer.parseInt(list.get(0).get("C_H_ID").toString()));
  %>
  <body>
    <center>
    	<form id="fm" action="servlet/DiagnoseFinishServlet" method="post">
    		<table width="100%" border="1" cellspacing="0">
    			<caption><font color="blue" size="5px"><b>病例基本信息</b></font></caption>
    			<tr class="tr1">
    				<th>姓名</th>
    				<th>性别</th>
    				<th>年龄</th>
    				<th>照片</th>
    				<th>电话</th>
    				<th>省</th>
    				<th>市</th>
    			</tr>
    			<%
    				for(Map<String,Object> map : list){
    					%>
    						<tr class="tr1">
    							<td class="td1"><%=map.get("C_H_NAME") %></td>
    							<td class="td1"><%=map.get("C_H_SEX") %></td>
    							<td class="td1"><%=map.get("C_H_AGE") %></td>
    							<td class="td1"><img <%if(map.get("C_H_PHOTO")==null||map.get("C_H_PHOTO")==""){%>src=""<%}else{%>src="<%=path %>/upload/<%=map.get("C_H_PHOTO") %>"<%} %>  width="50px" height="50px" /></td>
    							<td class="td1"><%=map.get("C_H_PHONE") %></td>
    							<td class="td1"><%=addr.split(",")[0] %></td>
    							<td class="td1"><%=addr.split(",")[1] %></td>
    						</tr>
    					<%
    				}
    			%>
    		</table>
    		<br /><br />
    		<table width="100%">
    			<tr class="tr1">
    				<th>病症描述</th>
    				<th>诊断结果</th>
    				<th>治疗方案</th>
    				<th>药品选择</th>
    				<th>药品单</th>
    				<th>其它项目</th>
    				<th>其他费用</th>
    			</tr>
    			<tr class="tr1">
    				<td class="td1"><textarea id="description" name="description" rows="8" cols="10"></textarea></td>
    				<td class="td1"><textarea id="result" name="result" rows="8" cols="10"></textarea></td>
    				<td class="td1"><textarea id="measure" name="measure" rows="8" cols="10"></textarea></td>
    				<td align="left">
    					药品种类：<select name="tabletKind" id="tabletKind" ></select><br /> 
    					药品名称：<select name="tabletName" id="tabletName"></select><br />
    					购&nbsp;买&nbsp;量：<input name="tabletCount" id="tabletCount" size="13px"/><br />
    					库&nbsp;&nbsp;&nbsp;&nbsp;存：<input name="tabletTotal" id="tabletTotal" size="13px" readonly="readonly"/><br />
    					单&nbsp;&nbsp;&nbsp;&nbsp;位：<input name="tabletUnit" id="tabletUnit" size="13px" readonly="readonly" /><br />
    					单&nbsp;&nbsp;&nbsp;&nbsp;价：<input name="tabletPrice" id="tabletPrice" size="13px" readonly="readonly" /><br />
    					<input id="add" type="button" value="添加"  />
    				</td>
    				<td width="250px" valign="top" align="center">
    					<table id="table" width="250px">
    						<tr>
    							<th>药名</th>
    							<th>数量</th>
    							<th>总价</th>
    							<th>删除</th>
    						</tr>
    					</table>
					</td>
    				<td class="td1"><textarea id="otherItem" name="otherItem" id="otherItem" rows="8" cols="6"></textarea></td>
    				<td class="td1"><textarea id="otherCost" name="otherCost" id="otherCost" rows="8" cols="6" ></textarea></td>
    				
    			</tr>
    		</table>
    		<input type="hidden" id="hid" name="hid" value="" />
    		<input type="hidden" id="registerId" name="registerId" value=<%=registerId %> />
    		<div ><input id="diagnose" type="button" value="确诊" /></div>
    		<br /><br />
    		<table width="100%" border="1" cellspacing="0">
    			<caption><font color="blue" size="5px"><b>诊断信息</b></font></caption>
    			<tr class="tr1">
    				<th>挂号人</th>
    				<th>科室</th>
    				<th>医生</th>
    				<th width="150px">病症描述</th>
    				<th>诊断结果</th>
    				<th>治疗方案</th>
    				<th>药品单</th>
    				<th>药费</th>
    				<th>其它项目</th>
    				<th>其他费用</th>
    				<th>类型</th>
    				<th>诊断时间</th>
    			</tr>
    			<%	
	    			for(Map<String,Object> map : list1){
						ConsumerService consumerService = new ConsumerService();
						List<Map<String, Object>> officeList = consumerService.getConsumerOffice(Integer.parseInt(map.get("R_OFFICE_ID").toString()));
						String officeName = officeList.get(0).get("O_NAME").toString();
						List<Map<String, Object>> doctorList = consumerService.getConsumerName(map.get("R_DOCTOR_ID").toString());
						String doctorName = doctorList.get(0).get("C_NAME").toString();
						%>
							<tr class="tr1">
								<td class="td1"><%=map.get("R_DEALER_ID") %></td>
								<td class="td1"><%=officeName %></td>
								<td class="td1"><%=doctorName %></td>
								<td class="td1"><%=map.get("R_DESCRIPTION") %></td>
								<td class="td1"><%=map.get("R_RESULT") %></td>
								<td class="td1"><%=map.get("R_MEASURE") %></td>
								<td class="td1"><%=map.get("R_TABLET") %></td>
								<td class="td1"><%=map.get("R_COST") %></td>
								<td class="td1"><%=map.get("R_OTHERITEM") %></td>
								<td class="td1"><%=map.get("R_OTHERCOST") %></td>
								<td class="td1"><%=map.get("R_TYPE") %><input type="hidden" name="type" value="<%=map.get("R_TYPE") %>" /></td>
								<td class="td1"><%=map.get("R_DATE") %></td>
							</tr>
						<%
					}	
    			%>
    		</table>
    	</form>
    </center>
  </body>
</html>

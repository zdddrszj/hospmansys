<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'left.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript" src="js/chili-1.7.pack.js"></script>
	<script type="text/javascript" src="js/jquery.easing.js"></script>
	<script type="text/javascript" src="js/jquery.dimensions.js"></script>
	<script type="text/javascript" src="js/jquery.accordion.js"></script>
	<script language="javascript">
	jQuery().ready(function(){
		jQuery('#navigation').accordion({
			header: '.head',
			navigation1: true, 
			event: 'click',
			fillSpace: true,
			animated: 'bounceslide'
		});
	});
</script>
<style type="text/css">
<!--
body {
	margin:0px;
	padding:0px;
	font-size: 12px;
}
#navigation {
	margin:0px;
	padding:0px;
	width:147px;
}
#navigation a.head {
	cursor:pointer;
	background:url(images/main_34.gif) no-repeat scroll;
	display:block;
	font-weight:bold;
	margin:0px;
	padding:5px 0 5px;
	text-align:center;
	font-size:12px;
	text-decoration:none;
}
#navigation ul {
	border-width:0px;
	margin:0px;
	padding:0px;
	text-indent:0px;
}
#navigation li {
	list-style:none; display:inline;
}
#navigation li li a {
	display:block;
	font-size:12px;
	text-decoration: none;
	text-align:center;
	padding:3px;
}
#navigation li li a:hover {
	background:url(images/tab_bg.gif) repeat-x;
		border:solid 1px #adb9c2;
}
-->
</style>
</head>
<body>
<div  style="height:100%;">
  <ul id="navigation">
    <li> <a class="head">药品种类管理</a>
      <ul>
        <li><a href="<%=path %>/tabRoomFunction/tabKindAdd.jsp" target="rightFrame">种类添加</a></li>
        <li><a href="servlet/TabKindSearchServlet" target="rightFrame">查看/修改/删除</a></li>
      </ul>
    </li>
    <li> <a class="head">药品库存管理</a>
      <ul>
        <li><a href="<%=path %>/tabRoomFunction/tabStoreAdd.jsp" target="rightFrame">进药</a></li>
        <li><a href="servlet/TabStoreSearchServlet" target="rightFrame">药品库存查询/修改</a></li>
        <li><a href="<%=path %>/tabRoomFunction/tabStoreDelete.jsp" target="rightFrame">退药</a></li>
      </ul>
    </li>
    <li> <a class="head">药厂管理</a>
      <ul>
        <li><a href="<%=path %>/tabRoomFunction/factoryAdd.jsp" target="rightFrame">药厂添加</a></li>
        <li><a href="servlet/FactorySearchServlet" target="rightFrame">查看/修改/删除</a></li>
      </ul>
    </li>
    <li> <a class="head">友情链接</a>
      <ul>
        <li><a href="http://www.baidu.com" target="rightFrame">百度友情链接</a></li>
        <li><a href="http://www.baidu.com" target="rightFrame">谷歌友情链接</a></li>
      </ul>
    </li>
    <li> <a class="head">版本信息</a>
      <ul>
        <li><a href="http://Www.865171.cn" target="_blank">by Jessica(865171.cn)</a></li>
      </ul>
    </li>
  </ul>
</div>
</body>
</html>

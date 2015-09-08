<%@ page language="java" import="java.util.*,cn.com.shxt.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'loginService.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
  </head>
  
  <body>
    <%
  		String userAccount = request.getParameter("textfield");
  		String userPsw = request.getParameter("textfield2");
  		//连接数据库
  		JdbcUtil db = new JdbcUtil();
  		List<Map<String, Object>> list = db.query("select * from consumer where c_account='"+userAccount+"' and c_psw='"+userPsw+"' and c_status='正常' ");
  		
  		if(list.size()>0){
  			String role=list.get(0).get("C_ROLE").toString();
  			if(role.equals("管理员")){
  				session.setAttribute("user",userAccount);
  				session.setAttribute("psw",userPsw);
  				session.setAttribute("status",false);
  	  			response.sendRedirect(path+"/main/mainOfMan.jsp");
  			}else if(role.equals("药房管理")){
  				session.setAttribute("user",userAccount);
  				session.setAttribute("psw",userPsw);
  				session.setAttribute("status",false);
  	  			response.sendRedirect(path+"/main/mainOfTabRoom.jsp");
  			}else if(role.equals("挂号")){
  				session.setAttribute("user",userAccount);
  				session.setAttribute("psw",userPsw);
  				session.setAttribute("status",false);
  	  			response.sendRedirect(path+"/main/mainOfRegister.jsp");
  			}else if(role.equals("医生")){
  				session.setAttribute("user",userAccount);
  				session.setAttribute("psw",userPsw);
  				session.setAttribute("status",false);
  	  			response.sendRedirect(path+"/main/mainOfDiagnose.jsp");
  			}
  		}else {
  			request.getRequestDispatcher("/failure.jsp").forward(request,response);
  		}
  		
  	%>
    
  </body>
</html>

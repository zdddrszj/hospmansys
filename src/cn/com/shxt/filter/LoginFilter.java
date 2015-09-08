package cn.com.shxt.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginFilter implements Filter {

	public void destroy() {

	}

	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest)arg0;
		HttpServletResponse response = (HttpServletResponse)arg1;
		HttpSession session = request.getSession();
		
		if(request.getServletPath().endsWith("login.jsp")||request.getServletPath().endsWith("loginService.jsp")||
				request.getServletPath().endsWith(".gif")||request.getServletPath().endsWith("failure.jsp")||
				request.getServletPath().endsWith(".png")||request.getServletPath().endsWith(".jpg")||
				request.getServletPath().endsWith("LoginValidateServlet")
				){
			chain.doFilter(arg0, arg1);
		}else{
			if(session.getAttribute("user") == null){
				response.sendRedirect(request.getContextPath()+"/failure.jsp");
			}else{
				chain.doFilter(arg0, arg1);
			}
		}
	}

	public void init(FilterConfig arg0) throws ServletException {

	}

}

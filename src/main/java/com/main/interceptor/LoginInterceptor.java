package com.main.interceptor;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginInterceptor implements HandlerInterceptor {

	private static List<String> urls = Arrays.asList(new String[] { 
			"js/", "css/", "img/", "jsp/", "/doLogin", "/login" ,"/register" ,"/doRegister"
			});
	
	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean preHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2) throws Exception {
		// TODO Auto-generated method stub
		HttpSession session=arg0.getSession();
		//获取当前请求的uri
		String uri=arg0.getRequestURI();
		if(isIegalUrl(uri)) {
			return true;
		}
		// 如果当前session中存储了用户信息则直接访问，否则跳转到登录页面
		if (StringUtils.isEmpty(session.getAttribute("currentUser"))) {
			arg1.sendRedirect("login");
			return false;
		} 
		return true;
	}
	
	private boolean isIegalUrl(String uri) {
		for(String string : urls) {
			//如果当前请求包括这些静态资源文件，则不处理
			if(uri.indexOf(string)>-1) {
				return true;
			}
		}
		return false;
	}
}

package com.haohuimin.cms.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.haohuimin.cms.domain.Settings;

public class AdminInterceptor implements HandlerInterceptor{

	private static long preCurrentTimeMillis;
	//拦截目标之前执行
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		Settings user = (Settings) session.getAttribute("adminUser");
		preCurrentTimeMillis= System.currentTimeMillis();
		if(user!=null) {
			return true;
		}else {
			response.sendRedirect("/login");
		}
		return false;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		
	}

	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		long currentTimeMillis = System.currentTimeMillis();
		long time=currentTimeMillis-preCurrentTimeMillis;
		System.out.println("管理员登录需要时间："+time+"毫秒");
	}

}

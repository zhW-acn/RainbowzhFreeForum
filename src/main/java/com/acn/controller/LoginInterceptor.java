package com.acn.controller;

import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @Description: 拦截未登录请求
 * @Author: acn
 * @Date: 2023/12/05/8:20
 */
public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (request.getSession().getAttribute("user") == null){
            System.out.println("没有登录");
            response.sendRedirect("/login");
            return false;
        }
        return true;
    }

}

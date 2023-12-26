package com.acn.controller;

import com.acn.bean.User;
import com.acn.constant.Constant;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @Description: 拦截不是admin的请求
 * @Author: acn
 * @Date: 2023/12/19/19:57
 */
public class AdminInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        User user = (User)request.getSession().getAttribute("user");

        if (Integer.parseInt(user.getBanTime()) != Constant.USER_ADMIN){// 没有权限
            response.sendRedirect("/");
            return false;
        }
        return true;
    }
}

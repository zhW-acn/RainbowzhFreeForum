package com.acn.controller;

import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Description: 处理全局异常切面
 * @Author: acn
 * @Date: 2023/12/03/19:58
 */
@Aspect
@Component
@Slf4j
public class GlobalExceptionHandler {
    @AfterThrowing(
            pointcut = "execution(* com.acn..*.*(..))",
            throwing = "ex")
    public ModelAndView catchException(Exception ex) {
        log.error(ex.getMessage());
        // 跳转到指定页面500
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("ex",ex);
        modelAndView.setViewName("error");
        return modelAndView;
    }
}

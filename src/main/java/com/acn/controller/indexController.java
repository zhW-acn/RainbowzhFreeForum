package com.acn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

/**
 * @Description: 主页的controller
 * @Author: acn
 * @Date: 2023/11/25/14:34
 */
@Controller
public class indexController {

    /**
     * 查询5条帖子，没有登录不能查看帖子和【加载更多】
     */
    @GetMapping("/")
    public String index(
            HttpSession session,
            Model model
    ) {

        // 按最新时间查询五个帖子，用model返回



        return "index";
    }
}

package com.acn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * @Description: 登录的controller
 * @Author: acn
 * @Date: 2023/11/25/16:22
 */
@Controller
public class LoginController {

    @GetMapping("/login")
    public String toLogin() {
        return "login";
    }

    @PostMapping("/login")
    public String doLogin(
            @RequestParam("username") String username,
            @RequestParam("password") String password
    ) {


        return "index";
    }
}

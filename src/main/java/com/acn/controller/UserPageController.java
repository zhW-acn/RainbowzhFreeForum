package com.acn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

/**
 * @Description: 用户主页
 * @Author: acn
 * @Date: 2023/12/01/10:42
 */
@Controller
public class UserPageController {
    @GetMapping("/user/{userId}")
    public String toUserPage(@PathVariable("userId")int userid) {

        return "/user/userHomePage";
    }
}

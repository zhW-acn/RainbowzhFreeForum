package com.acn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * @Description: 用于测试的
 * @Author: acn
 * @Date: 2023/12/01/1:47
 */
@Controller
public class TestController {
    @GetMapping("/1")
    public String test1(){
        return "user/userHomePage";
    }
}

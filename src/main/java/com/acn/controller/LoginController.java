package com.acn.controller;

import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.Set;

/**
 * @Description: 登录的controller
 * @Author: acn
 * @Date: 2023/11/25/16:22
 */
@Controller
public class LoginController {

    @GetMapping("/login")
    public String toLogin(Model model) {
        /**
         * 属性说明：
         * action：提交地址
         * name：表单头部显示名
         * leftLocation：左边按钮跳转地址
         * leftButton：左边按钮名
         * rightButton：右边按钮名
         */
        HashMap<String, String> hashMap = new HashMap<>();
        hashMap.put("action","login");
        hashMap.put("name", "登录");
        hashMap.put("leftLocation","register");
        hashMap.put("leftButton","注册");
        hashMap.put("rightButton","登录");
        setModel(hashMap,model);
        return "login";
    }

    @PostMapping("/login")
    public String doLogin(
            @RequestParam("username") String username,
            @RequestParam("password") String password
    ) {
        if ("admin".equals(username) && "123".equals(password)) {
            return "forward:admin.jsp";
        } else {
            return "/login";
        }

    }

    @GetMapping("/register")
    public String toRegister(Model model){
        HashMap<String, String> hashMap = new HashMap<>();
        hashMap.put("action","register");
        hashMap.put("name", "注册");
        hashMap.put("leftLocation","login");
        hashMap.put("leftButton","返回登录");
        hashMap.put("rightButton","注册");
        setModel(hashMap,model);
        return "login";
    }

    @PostMapping("/register")
    public String doRegister(Model model){

        return "index";
    }

    public static void setModel(HashMap<String, String> hashMap,Model model){
        for (String attr : hashMap.keySet()) {
            model.addAttribute(attr,hashMap.get(attr));
        }
    }

}

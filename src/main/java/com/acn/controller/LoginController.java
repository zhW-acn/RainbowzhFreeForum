package com.acn.controller;

import com.acn.bean.User;
import com.acn.service.UserService;
import com.acn.utils.JSONConstructor;
import com.sun.deploy.net.HttpResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;

/**
 * @Description: 登录和注册的controller
 * @Author: acn
 * @Date: 2023/11/25/16:22
 */
@Controller
public class LoginController {

    @Autowired
    UserService userService;

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
        hashMap.put("action", "login");
        hashMap.put("name", "登录");
        hashMap.put("leftLocation", "register");
        hashMap.put("leftButton", "注册");
        hashMap.put("rightButton", "登录");
        setModel(hashMap, model);
        return "login";
    }

    @PostMapping("/login")
    @ResponseBody
    public String doLogin(
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            HttpSession session,
            Model model,
            HttpServletResponse response
    ) throws IOException {
        // 用户验证
        HashMap<String, Object> hashMap = new HashMap<>();
        hashMap.put("username", username);
        hashMap.put("password", password);
        User user = userService.selectUserByCond(hashMap);

        // 存在用户，登录；不存在，
        if (user != null) {
            session.setAttribute("user", user);
//            model.addAttribute("user",user);

            return new JSONConstructor(0, "成功", "success").toString();
        } else {
            return new JSONConstructor(0, "失败", "false").toString();
        }
    }

    @GetMapping("/register")
    public String toRegister(Model model, HttpServletRequest request) {
        HashMap<String, String> hashMap = new HashMap<>();
        hashMap.put("action", "register");
        hashMap.put("name", "注册");
        hashMap.put("leftLocation", "login");
        hashMap.put("leftButton", "返回登录");
        hashMap.put("rightButton", "注册");
        request.setAttribute("action", "register");
        setModel(hashMap, model);
        return "login";
    }

    @PostMapping("/register")
    public String doRegister(Model model) {

        return "index";
    }

    public static void setModel(HashMap<String, String> hashMap, Model model) {
        for (String attr : hashMap.keySet()) {
            model.addAttribute(attr, hashMap.get(attr));
        }
    }

}

package com.acn.controller;

import com.acn.bean.User;
import com.acn.constant.Constant;
import com.acn.service.UserService;
import com.acn.utils.FileUpload;
import com.acn.utils.JSONConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
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

    /**
     * 请求登录页面
     */
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

    /**
     * 请求登录
     */
    @PostMapping("/login")
    @ResponseBody
    public String doLogin(@RequestParam("username") String username, @RequestParam("password") String password,
                          HttpSession session) {
        // 用户验证
        HashMap<String, Object> hashMap = new HashMap<>();
        hashMap.put("username", username);
        hashMap.put("password", password);
        User user = userService.selectUserByCond(hashMap);

        // 存在用户且不为注销用户，登录；不存在，重新登陆
        if (user != null) {
            if(Integer.parseInt(user.getBanTime()) == Constant.USER_Unregistered){
                return new JSONConstructor(-2, "成功", "success").toString();
            }
            if(Integer.parseInt(user.getBanTime()) == Constant.USER_Ban){
                return new JSONConstructor(-3, "成功", "success").toString();
            }

            session.setAttribute("user", user);

            return new JSONConstructor(0, "成功", "success").toString();
        } else {
            return new JSONConstructor(0, "失败", "false").toString();
        }
    }

    /**
     * 请求注册页面
     */
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

    /**
     * 请求注册
     */
    @PostMapping("/register")
    @ResponseBody
    public String doRegister(@RequestParam("username") String username, @RequestParam("password") String password,
                             @RequestParam("birthday") String birthday,
                             @RequestParam("avatarFile") CommonsMultipartFile avatarFile) {
        // 是否存在重名
        if (userService.isExist(username) != 0) {
            return new JSONConstructor(0, "重名", "exist").toString();
        }

        // 数据库中存放avatar的路径
        String avatar =
                File.separator + FileUpload.URL_PATH + File.separator + username + File.separator + "avatar" + File.separator + avatarFile.getOriginalFilename();
        User user = new User(username, password, birthday, avatar);
        // 上传头像
        FileUpload.avatarUpload(username, avatarFile);

        // 注册
        if (1 == userService.insertUser(user)) {
            return new JSONConstructor(0, "成功", "success").toString();
        } else {
            return new JSONConstructor(0, "失败", "false").toString();
        }
    }

    /**
     * 登出
     */
    @GetMapping("/logout")
    public String cleanSession(HttpSession session) {
        session.removeAttribute("user");
        return "redirect:/";
    }

    /**
     * 切换登录和注册
     */
    public static void setModel(HashMap<String, String> hashMap, Model model) {
        for (String attr : hashMap.keySet()) {
            model.addAttribute(attr, hashMap.get(attr));
        }
    }

}

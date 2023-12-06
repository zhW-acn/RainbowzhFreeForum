package com.acn.controller;

import com.acn.bean.User;
import com.acn.bean.view.UserUpdateForm;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @Description: 用户设置
 * @Author: acn
 * @Date: 2023/12/06/20:41
 */
@Controller
public class UserSettingController {

    @GetMapping("/setting")
    public String toUserSetting(){
        return "user/setting";
    }

    @PostMapping("/setting")
    @ResponseBody
    public String updateUserInfo(@ModelAttribute UserUpdateForm formData){
        System.out.println(formData);
        return "";
    }
}

package com.acn.controller;

import com.acn.bean.User;
import com.acn.bean.view.UserUpdateForm;
import com.acn.service.UserService;
import com.acn.utils.FileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.HashMap;
import java.util.Objects;

/**
 * @Description: 用户设置
 * @Author: acn
 * @Date: 2023/12/06/20:41
 */
@Controller
public class UserSettingController {

    @Autowired
    UserService userService;

    @GetMapping("/setting")
    public String toUserSetting() {
        return "user/setting";
    }

    @PostMapping("/setting")
    @ResponseBody
    public String updateUserInfo(UserUpdateForm userUpdateForm, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (!Objects.equals(user.getPassword(), userUpdateForm.getOldPassword())) {
            // 匹配密码
            return "falsePassword";
        }

        HashMap<String, Object> hashMap = new HashMap<>();
        hashMap.put("username",userUpdateForm.getUsername());
        hashMap.put("birthday",userUpdateForm.getBirthday());
        hashMap.put("id",user.getId());

        // 用户更新了头像
        if (userUpdateForm.getAvatar() != null) {
            FileUpload.avatarUpload(userUpdateForm.getUsername(), userUpdateForm.getAvatar());
            hashMap.put("avatar",
                    File.separator + FileUpload.URL_PATH + File.separator + userUpdateForm.getUsername() + File.separator +
                    "avatar" + File.separator + userUpdateForm.getAvatar().getOriginalFilename());
        }

        // 用户更新了密码
        if(userUpdateForm.getNewPassword()!=null){
            hashMap.put("password",userUpdateForm.getNewPassword());
        }

        int i = userService.updateUser(hashMap);

        // 更改session
        session.setAttribute("user",userService.selectUserById(user.getId()));
        return i == 1 ? "success" : "fail";
    }
}

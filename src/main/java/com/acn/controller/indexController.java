package com.acn.controller;

import com.acn.bean.User;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

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
            HttpServletRequest request,
            Model model
    ) {
        return "index";
    }
    @GetMapping("/ajax")
    @ResponseBody
    public String ajaxList(
            HttpServletRequest request,
            @RequestParam(name = "page") int page
    ) {
        // 模拟通过分页查到的列表
        List<User> list = new ArrayList<>();
        list.add(new User(1,"username","password","birthday","banTime",11));
        list.add(new User(2,"username2","password","birthday","banTime",11));
        list.add(new User(3,"username3","password","birthday","banTime",11));
        /**
         * 参数说明：
         * avatar：用户头像地址
         * username：用户名
         * title：标题
         * content：正文
         * replyNum：回帖人数
         * collectionNum：收藏人数
         * postTime：发帖时间
         */
        String listString = JSONArray.toJSONString(list);
        System.out.println(listString);
        return listString;
    }
}

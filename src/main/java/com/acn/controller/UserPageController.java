package com.acn.controller;

import com.acn.bean.User;
import com.acn.bean.view.Post;
import com.acn.service.PostService;
import com.acn.service.UserService;
import com.alibaba.fastjson.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @Description: 用户主页
 * @Author: acn
 * @Date: 2023/12/01/10:42
 */
@Controller
public class UserPageController {
    @Autowired
    PostService postService;

    @Autowired
    UserService userService;

    @GetMapping("/user/{userId}")
    public String toUserPage(@PathVariable("userId") int userid, Model model, HttpServletRequest request) {
        int postCount = postService.postsCountByUser(userid);
        model.addAttribute("postCount",postCount);

        // 给前端判断是否是自己的主页
        User userOwner = userService.selectUserById(userid);
        request.setAttribute("userOwner",userOwner);
        return "/user/userHomePage";
    }


    @GetMapping("/user/{userId}/ajax")
    @ResponseBody
    public String ajax(@PathVariable("userId") int userid) {
        // 查找用户创建的所有帖子，不分页
        List<Post> posts = postService.selectAllPosts(userid);
        return JSONArray.toJSONString(posts);
    }
}
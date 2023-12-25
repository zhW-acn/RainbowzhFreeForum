package com.acn.controller;

import com.acn.bean.User;
import com.acn.bean.view.Post;
import com.acn.service.PostService;
import com.acn.service.UserService;
import com.acn.utils.JSONConstructor;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

/**
 * @Description: 普通搜索
 * @Author: acn
 * @Date: 2023/12/05/14:13
 */
@Controller
@RequestMapping("/search")
public class SearchController {

    @Autowired
    UserService userService;

    @Autowired
    PostService postService;

    @GetMapping("")
    public String toView() {
        return "search";
    }

    @PostMapping("/")
    @ResponseBody
    public String getPostList(String searchType, String text) {
        switch (searchType) {
            case "username":
                List<User> users = userService.selectUserByName(text);
                return new JSONConstructor(0, "users", JSONObject.toJSONString(users)).toString();
            case "post":
                List<Post> posts = postService.selectPostByLike(text);
                return new JSONConstructor(1, "posts", JSONObject.toJSONString(posts)).toString();
            default:
                return "error";
        }
    }

    @GetMapping("/{text}")
    public String topicRequest(@PathVariable String text, RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("text", text);
        return "redirect:/search";
    }
}

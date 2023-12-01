package com.acn.controller;

import com.acn.bean.view.Post;
import com.acn.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

/**
 * @Description: 帖子详情
 * @Author: acn
 * @Date: 2023/12/01/11:42
 */
@Controller
public class PostController {

    @Autowired
    PostService postService;

    @GetMapping("/post/{id}")
    public String toPostDetails(@PathVariable("id") int id, Model model) {

        Post post = postService.selectPostById(id);
        System.out.println(post);
        model.addAttribute("post", post);

        return "postDetails";
    }
}

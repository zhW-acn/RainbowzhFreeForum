package com.acn.controller;

import com.acn.bean.view.Comment;
import com.acn.bean.view.Post;
import com.acn.service.CommentService;
import com.acn.service.PostService;
import com.acn.utils.JSONConstructor;
import com.alibaba.fastjson.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Description: 帖子详情
 * @Author: acn
 * @Date: 2023/12/01/11:42
 */
@Controller
public class PostController {
    // 分页大小
    static final int PAGE_SIZE = 4;

    @Autowired
    PostService postService;

    @Autowired
    CommentService commentService;

    @GetMapping("/post/{id}")
    public String toPostDetails(@PathVariable("id") int id, Model model) {
        Post post = postService.selectPostById(id);
        model.addAttribute("post", post);
        // 加载评论数
        // 总页数
        int count = commentService.commentsCount() % PAGE_SIZE != 0 ?
                (commentService.commentsCount() / PAGE_SIZE + 1) : commentService.commentsCount() / PAGE_SIZE;
        model.addAttribute("count", count);
        model.addAttribute("count", count);
        return "postDetails";
    }

    @PostMapping("/post/{id}")
    @ResponseBody
    public String loadComments(@PathVariable int id,
                               @RequestParam("page") int page, Model model) {
        int start = (page - 1) * PAGE_SIZE;

        List<Comment> comments = commentService.selectCommentByPaging(id, start, PAGE_SIZE);
        System.out.println(JSONArray.toJSONString(comments));
        return JSONArray.toJSONString(comments);
    }
}

package com.acn.controller;

import com.acn.bean.view.Comment;
import com.acn.bean.view.Post;
import com.acn.service.CommentService;
import com.acn.service.PostService;
import com.alibaba.fastjson.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * @Description: 帖子详情
 * @Author: acn
 * @Date: 2023/12/01/11:42
 */
@Controller
@RequestMapping("/post/{id}")
public class PostController {
    // 分页大小
    static final int PAGE_SIZE = 4;

    @Autowired
    PostService postService;

    @Autowired
    CommentService commentService;

    @GetMapping("")
    public String toPostDetails(@PathVariable("id") int id, Model model) {
        // 加载帖子
        Post post = postService.selectPostById(id);
        model.addAttribute("post", post);
        // 加载评论数
        // 总页数
        int count = commentService.commentsCountByPost(id) % PAGE_SIZE != 0 ?
                (commentService.commentsCountByPost(id) / PAGE_SIZE + 1) :
                commentService.commentsCountByPost(id) / PAGE_SIZE;
        model.addAttribute("count", count);
        return "postDetails";
    }

    @PostMapping("")
    @ResponseBody
    public String loadComments(@PathVariable int id,
                               @RequestParam("page") int page, Model model) {
        int start = (page - 1) * PAGE_SIZE;

        List<Comment> comments = commentService.selectCommentByPaging(id, start, PAGE_SIZE);
        System.out.println(JSONArray.toJSONString(comments));
        return JSONArray.toJSONString(comments);
    }

    //  评论
    @PostMapping("/addComment")
    @ResponseBody
    public String doComment(
            @RequestParam("commentText") String commentText,
            @RequestParam("postId") int postId,
            @RequestParam("userId") int userId) {

        commentService.addComment(new com.acn.bean.Comment(commentText, postId, userId,
                new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()), 1));
        return "success";
    }

    // 普通删除帖子
    @PostMapping("/delete/{id}")
    @ResponseBody
    public String deletePost(@PathVariable int id) {
        int i = postService.changeFlag(id, 0);
        return i == 1 ? "success" : "fail";
    }

    // 普通删除帖子评论
    @PostMapping("/deleteComment/{commentId}")
    @ResponseBody
    public String deleteComment(@PathVariable("id") int postId, @PathVariable int commentId) {
        int i = commentService.changeFlag(0, postId, commentId);
        return i == 1 ? "success" : "fail";
    }
}
